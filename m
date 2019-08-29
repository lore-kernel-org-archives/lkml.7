Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9BCC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8953E20578
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfH2QAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:00:43 -0400
Received: from shelob.surriel.com ([96.67.55.147]:47374 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2QAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:00:43 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i3Mqe-0005Fy-3V; Thu, 29 Aug 2019 12:00:32 -0400
Message-ID: <2a87463e8a51c34733e9c1fcf63380f9caa7afc4.camel@surriel.com>
Subject: Re: [PATCH 08/15] sched,fair: simplify timeslice length code
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Date:   Thu, 29 Aug 2019 12:00:31 -0400
In-Reply-To: <CAKfTPtDX+keNfNxf78yMoF3QaXSG_fZHJ_nqCFKYDMYGa84A6Q@mail.gmail.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-9-riel@surriel.com>
         <CAKfTPtDxHijR3PCOFfxA-r02rf2hVP4LpB=y-9emHS7znTPxTA@mail.gmail.com>
         <d703071084dadb477b8248b041d0d1aa730d65cd.camel@surriel.com>
         <CAKfTPtDX+keNfNxf78yMoF3QaXSG_fZHJ_nqCFKYDMYGa84A6Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Yw65qFbYmw1sgFBKWgUh"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Yw65qFbYmw1sgFBKWgUh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-29 at 16:02 +0200, Vincent Guittot wrote:
> On Thu, 29 Aug 2019 at 01:19, Rik van Riel <riel@surriel.com> wrote:
>=20
> > What am I overlooking?
>=20
> My point is more for task that runs several ticks in a row. Their
> sched_slice will be shorter in some cases with your changes so they
> can be preempted earlier by other runnable tasks with a lower
> vruntime
> and there will be more context switch

I can think of exactly one case where the time slice
will be shorter with my new code than with the old code,
and that is the case where:
- A CPU has nr_running > sched_nr_latency
- __sched_period returns a value larger than sysctl_sched_latency
- one of the tasks is much higher priority than the others
- that one task alone gets a timeslice larger than sysctl_sched_latency

With the new code, that high priority task will get a time
slice that is a (large) fraction of sysctl_sched_latency,
while the other (lower priority) tasks get their time slices
rounded up to sysctl_sched_min_granularity.

When tasks get their timeslice rounded up, that will increase
the total sched period in a similar way the old code did by
returning a longer period from __sched_period.

If a CPU is faced with a large number of equal priority tasks,
both the old code and the new code would end up giving each
task a timeslice length of sysctl_sched_min_granularity.

What am I missing?

--=20
All Rights Reversed.

--=-Yw65qFbYmw1sgFBKWgUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1n9p8ACgkQznnekoTE
3oMjlgf/evRSTEvFMm0Iub5xuKyORVFE9fxUJVkOQFWuGxw1/ZAt6sVn3Yz0dOGd
0dwh72kjMhVfiid0sfL4iUmPLfwT3a2khyNyft83JmyhJrxVGy4pfM2qtqo2qp1/
aVV4Eh/fe2TO+QBYAN5eiUU7oIjmrTpEvOOR36hDjiWpyOSkvVw8qgxZPndNcLAW
YUwMYNrIfsaBBgsfIyHHK9vglTDxghW/6XcJrgdtikvxeB7qsB2votkCunyDNi0y
Kjkx4+d7Rf1LX24YuiIrzDYe6xtOa0FoYL2xx+CS68CqHufq4FoZwW+6/ci2JfeD
eghcEvTXmWf36u6OUXy08aUTQNOUeg==
=BZqm
-----END PGP SIGNATURE-----

--=-Yw65qFbYmw1sgFBKWgUh--

