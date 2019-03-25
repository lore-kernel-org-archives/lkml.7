Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB39C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EFC2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfCYKgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:36:32 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:58000 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbfCYKgb (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 25 Mar 2019 06:36:31 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 25 Mar 2019 11:36:30 +0100
Received: from [192.168.0.30] (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Mon, 25 Mar 2019 10:36:02 +0000
Message-ID: <8eec0949bac18d8ee6f151027ff68de9827f143d.camel@suse.com>
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ryan Thibodeaux <thibodux@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io,
        "luca.abeni" <luca.abeni@santannapisa.it>
Date:   Mon, 25 Mar 2019 11:36:00 +0100
In-Reply-To: <20190324180724.GA4400@nat-wireless-guest-reg-153-50.bu.edu>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
         <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
         <20190323120052.GB11100@centos-dev.localdomain>
         <20190324180724.GA4400@nat-wireless-guest-reg-153-50.bu.edu>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2Aj+Mypawqc5P5Mv2XTx"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2Aj+Mypawqc5P5Mv2XTx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-03-24 at 14:07 -0400, Boris Ostrovsky wrote:
> On Sat, Mar 23, 2019 at 08:00:52AM -0400, Ryan Thibodeaux wrote:
> > This test system was configured to use a TSC clocksource, disabled
> > C states, and lowered the timer slop. I am not claiming the timer
> > slop change was solely responsible for the best results.
>=20
> How can we then be sure that the proposed change will indeed provide
> some sort of benefit?
>=20
> Were there any other changes between your tests to think that slop
> time modification may not be responsible for better results?
>=20
FWIW, in mine and Luca's experiments, changing lowering both timer_slop
in Xen and TIMER_SLOP in Linux, improved latency dramatically, without
any other change.

We also tried _only_ playing with the Xen tunable (as there's a Xen
boot parameter for it already) but that wasn't enough. It was only when
we also tuned TIMER_SLOP in Linux's Xen clockevent device that we got
decent numbers (i.e., comparable to KVM ones).

Reason why we had not share these results yet was that we were still
"polishing" them, and because we also found a couple of other issues,
and we were trying to understand them better, before sending anything
out. But those other issues were --although still about achieving low
latencies-- orthogonal from this, and lowering the default slop is
absolute prerequisite for even talking about having a reasonable vcpu
response time.

A patch like this one, was something we were thinking to submit ourself
sooner or later (backed up by our results). Personally, in addition to
making the value tunable, which I think is a good thing, I also would
lower the default.

Regards,
Dario
--=20
<<This happens because I choose it to happen!>> (Raistlin Majere)
-----------------------------------------------------------------
Dario Faggioli, Ph.D, http://about.me/dario.faggioli
Software Engineer @ SUSE https://www.suse.com/

--=-2Aj+Mypawqc5P5Mv2XTx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAlyYrxAACgkQFkJ4iaW4
c+4RBw/+Jb25t+D3NqB7raaBYvuDFoFlEdJJEBtsPLe8HNDFU3aD8p3Mr+v9m0KU
hWiWBcAfqISbCk3gsb4Qfw5met5E1hg9EsA1qJVhsKdPiwPUrDnRfwxOHRgLSw/6
FPZ+MKo0REE9VvXPkuhcebmM7Ec98Q4iiqXS9POF0iTlDnu1NqiQ2e1II9Eu2/L7
+Bdaq6kbSsTLRuI5HBNdOCcoFMJ74NcI+p6xSvVZOkHTyPFlNiXfhc/tXVXvkPJP
jdJPyqGvVNUtawG/AtEDDwIUxhrEbr+iq4tFRGpVqEQBlYfqI1DbJMCRInEEGA+v
n2bMWJGGSYTteIe1pyxnanCNrVr4q7IdIip0AIxnur6mwx2TDTdzTFI9kBjWZtGb
VfzzXt6YXYiCAtcOIYNdd81xtVJukYsmuWLy8kG2/SCDLTSK1EaBidmUJzcydmfY
pkpN2rS/4SyIw/uiAFxLuC3DaDNumVmiB+kJSJd0sOw+381YDmKr9O0YtiFD8E8K
sgHSaaev73etzvIDawbZJ/6zwVp4wGzzll+lnLEqenzNaq7oPVc1AXag3JWU5dwU
hT11iJseaqIcDhDZHJjQug//9enDk6gBDTcsCX/pGNi3wqrCm1BSSrD8fFqfCJWO
Gc69tHtjXCUjJpOBign0HbJuni4P6LJcklcKyejceSCBwcaUsi8=
=0s/V
-----END PGP SIGNATURE-----

--=-2Aj+Mypawqc5P5Mv2XTx--

