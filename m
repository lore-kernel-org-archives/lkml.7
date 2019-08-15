Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4F5C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E2720644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfHOQJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:09:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:55846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728329AbfHOQJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:09:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48CE9AD73;
        Thu, 15 Aug 2019 16:09:30 +0000 (UTC)
Message-ID: <bd1f79c0a9aed2dfae3bb9f5df24fcf5528e3864.camel@suse.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 15 Aug 2019 18:09:28 +0200
In-Reply-To: <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
References: <20190612163345.GB26997@sinkpad>
         <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
         <20190613032246.GA17752@sinkpad>
         <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
         <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
         <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
         <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
         <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
         <20190802153715.GA18075@sinkpad>
         <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
         <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fKuNyrN5LAubUKk4rsAy"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fKuNyrN5LAubUKk4rsAy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-07 at 10:10 -0700, Tim Chen wrote:
> On 8/7/19 1:58 AM, Dario Faggioli wrote:
>=20
> > Since I see that, in this thread, there are various patches being
> > proposed and discussed... should I rerun my benchmarks with them
> > applied? If yes, which ones? And is there, by any chance, one (or
> > maybe
> > more than one) updated git branch(es)?
> >=20
> Hi Dario,
>=20
Hi Tim!

> Having an extra set of eyes are certainly welcomed.
> I'll give my 2 cents on the issues with v3.
>=20
Ok, and thanks a lot for this.

> 1) Unfairness between the sibling threads
> -----------------------------------------
> One sibling thread could be suppressing and force idling
> the sibling thread over proportionally.  Resulting in
> the force idled CPU not getting run and stall tasks on
> suppressed CPU.
>=20
>=20
> [...]
>
> 2) Not rescheduling forced idled CPU
> ------------------------------------
> The forced idled CPU does not get a chance to re-schedule
> itself, and will stall for a long time even though it
> has eligible tasks to run.
>=20
> [...]
>=20
> 3) Load balancing between CPU cores
> -----------------------------------
> Say if one CPU core's sibling threads get forced idled
> a lot as it has mostly incompatible tasks between the siblings,
> moving the incompatible load to other cores and pulling
> compatible load to the core could help CPU utilization.
>=20
> So just considering the load of a task is not enough during
> load balancing, task compatibility also needs to be considered.
> Peter has put in mechanisms to balance compatible tasks between
> CPU thread siblings, but not across cores.
>=20
> [...]
>
Ok. Yes, as said, I've been trying to follow the thread, but thanks a
lot again for this summary.

As said, I'm about to have numbers for the repo/branch I mentioned.

I was considering whether to also re-run the benchmarking campaign with
some of the patches that floated around within this thread. Now, thanks
to your summary, I have an even clearer picture about which patch does
what, and that is indeed very useful.

I'll see about putting something together. I'm thinking of picking:

https://lore.kernel.org/lkml/b7a83fcb-5c34-9794-5688-55c52697fd84@linux.int=
el.com/
https://lore.kernel.org/lkml/20190725143344.GD992@aaronlu/

And maybe even (part of):
https://lore.kernel.org/lkml/20190810141556.GA73644@aaronlu/#t

If anyone has ideas or suggestions about whether or not this choice
makes sense, feel free to share. :-)

Also, I only have another week before leaving, so let's see what I
manage to actually run, and then share here, by then.

Thanks and Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-fKuNyrN5LAubUKk4rsAy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl1Vg7gACgkQFkJ4iaW4
c+7Z7hAAlwTpfoVwhmTyJl3fop1DDwUFulFl/SKmSLk+CkrB5Fc4HHCUNgbyVAfS
rE8a9aYjLQYk6Fw0w6EXo6TOwc02tIgTiG3qqeuhgI7XAxMkgsTpT9wDpG+J9qxo
eRmws0cNvqx2CU538mAfqgqSIzxTY11ImXLjVf47gJ6Sji5x/+dL7aoNF/Kg6qRd
KahZqLSPZwJhskDqqyfUsNdgQleck/cADpR/PGon1nKFgWqYnJWFRtSKVyeDQUML
YZiwr2p3XceyhwvMBgSZrg3oOMQHmnVQKp199mk3aXRX2i3A3VU5pMcRh9EsOnaS
xHkfJLv59g6PUW9CEyOF7/yfBxJjDyJWodZxXXacJTIS4wTt1WT+jKJa/r+uMqKh
sQBl9Thh3BZ40V0nKFxxdza/+KmGpVg8P3mXDSrPzTc91Ci8hxwMnLQJwy+j0CUJ
KUNiXCdRgPvDM3qvwMPRADQodDTbLfUe7za2YJBZSdGGIeAaxSCCgN3s6XIPuBKK
Qm0sIhqIvWbGK2Sad/5m+xCVNNJkEbmvxm3HiLNfnSaWaLjbCvUSDeoV6U1Iirkj
4N2Urr7QtIa/Nz+bkUsVw06VTgXwmIQMaoYpcPrxmxVrfmRbBi931ox9gPG9FUIy
lLL3X2+Wl9c4oS/469UX5ckVyXhL1aOr99TpyJAvpuxuLUDgWmc=
=317a
-----END PGP SIGNATURE-----

--=-fKuNyrN5LAubUKk4rsAy--

