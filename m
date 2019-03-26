Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0898C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0FE2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfCZJNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:13:46 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:55111 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCZJNp (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 26 Mar 2019 05:13:45 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 26 Mar 2019 10:13:44 +0100
Received: from [192.168.0.30] (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 26 Mar 2019 09:13:34 +0000
Message-ID: <a32c8b1d7866ee3b074b1d674b40e03e51dbd54a.camel@suse.com>
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        luca abeni <luca.abeni@santannapisa.it>
Cc:     thibodux@gmail.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, oleksandr_andrushchenko@epam.com,
        tglx@linutronix.de, jgross@suse.com, ryan.thibodeaux@starlab.io
Date:   Tue, 26 Mar 2019 10:13:32 +0100
In-Reply-To: <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
         <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
         <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
         <20190323114151.5cebf31b@sweethome> <20190325130530.56603806@luca64>
         <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ySIvEmEZ+N1iVOye3K9P"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ySIvEmEZ+N1iVOye3K9P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-03-25 at 09:43 -0400, Boris Ostrovsky wrote:
> On 3/25/19 8:05 AM, luca abeni wrote:
> >=20
> > The picture shows the latencies measured with an unpatched guest
> > kernel
> > and with a guest kernel having TIMER_SLOP set to 1000 (arbitrary
> > small
> > value :).
> > All the experiments have been performed booting the hypervisor with
> > a
> > small timer_slop (the hypervisor's one) value. So, they show that
> > decreasing the hypervisor's timer_slop is not enough to measure low
> > latencies with cyclictest.
>=20
> I have a couple of questions:
> * Does it make sense to make this a tunable for other clockevent
> devices
> as well?
>
So, AFAIUI, the thing is as follows. In clockevents_program_event(), we
keep the delta between now and the next timer event within
dev->max_delta_ns and dev->min_delta_ns:

  delta =3D min(delta, (int64_t) dev->max_delta_ns);
  delta =3D max(delta, (int64_t) dev->min_delta_ns);

For Xen (well, for the Xen clock) we have:

  .max_delta_ns =3D 0xffffffff,
  .min_delta_ns =3D TIMER_SLOP,

which means a guest can't ask for a timer to fire earlier than 100us
ahead, which is a bit too coarse, especially on contemporary hardware.

For "lapic_deadline" (which was what was in use in KVM guests, in our
experiments) we have:

  lapic_clockevent.max_delta_ns =3D clockevent_delta2ns(0x7FFFFF, &lapic_cl=
ockevent);
  lapic_clockevent.min_delta_ns =3D clockevent_delta2ns(0xF, &lapic_clockev=
ent);

Which means max is 0x7FFFFF device ticks, and min is 0xF.
clockevent_delta2ns() does the conversion from ticks to ns, basing on
the results of the APIC calibration process. It calls cev_delta2ns()
which does some scaling, shifting, divs, etc, and, at the very end,
this:

  /* Deltas less than 1usec are pointless noise */
  return clc > 1000 ? clc : 1000;

So, as Ryan is also saying, the actual minimum, in this case, depends
on hardware, with a sanity check of "never below 1us" (which is quite
smaller than 100us!)

Of course, the actual granularity depends on hardware in the Xen case
as well, but that is handled in Xen itself. And we have mechanisms in
place in there to avoid timer interrupt storms (like, ahem, the Xen's
'timer_slop' boot parameter... :-P)

And this is basically why I was also thinking we can/should lower the
default value of TIMER_SLOP, here in the Xen clock implementation in
Linux.

> * This patch adjusts min value. Could max value (ever) need a similar
> adjustment?
>=20
Well, for Xen, it's already 0xffffffff. I don't see use cases when one
would want a smaller max. Wanting an higher max *might* be of some
interest,  e.g., for power management, if the first timer event is 1min
ahead, and you don't want to be woken up every (if my math is right) 4
secs.

But we'd have to see if that actually works, not to mention that 4 secs
is already large enough, IMHO, that it's unlikely we'll be really
sleeping for that much time without having to wake up for one reason or
another. :-)

Regards,
Dario
--=20
<<This happens because I choose it to happen!>> (Raistlin Majere)
-----------------------------------------------------------------
Dario Faggioli, Ph.D, http://about.me/dario.faggioli
Software Engineer @ SUSE https://www.suse.com/

--=-ySIvEmEZ+N1iVOye3K9P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAlyZ7TwACgkQFkJ4iaW4
c+55/RAA2r1QTWiBrvh0X5J9zV7K6fs3sOAIaIs0FYkoDjwkVz8LGxnrlhhKCGKx
hD3DSAesFH1m2bbGzslm8aqzaUEDA8dypa5DBjkGG5frpPsN81mr/qh6QCY3yFhS
dq8BwUVyHTArurXk+h9z4t7DS9dCsrcvtjJJ5dDr7m4PHb4reRWAWkxzkO0ErO/Q
CaM1IkZGPwsG/K4ipaUjwl+mqRVbmxirmkmmjtoZYlJVT709Wa98ByHvbPqqnu5S
/+VQ2agQ9bEiFYsgTUWfmYiVPDhzYRISyCXy7RSKAaXLJBIvyDUs0CVXRrc6QJgS
UcSvMM+siXGKg8kVN2Yz+KnjlkoifR84RuQpdCGNRTyAKwKljWg/AzvvdV88DbMC
PoudqZRg2LOQsHUAUZvvQWNfPACgUJDvwTxx18YhfjgNeSsUi2ot+W5tdKmbEJnh
PYkSUZwWqZ5l8z7wVxasXN262B3yxf79vAfD6tmLhOF7rRY6VULQmW0zOMgUqOmd
sg8e+lVOJCbIQXihYZWH1A5iRGNLqOZ8G7WY/r0fRzRSP3Z1wjVb+INoTcH1Y7b6
JdRhedr3v3wQwIBVbCnasKtM01peGjiiJGpxoEqycN9cpbjQmJQhKOsATd7Dj40p
Vli0U+dYf4MLP/Hg/oX5o48WQS9sdAiEE3s7KHuvHBv3pWABKI8=
=UFYQ
-----END PGP SIGNATURE-----

--=-ySIvEmEZ+N1iVOye3K9P--

