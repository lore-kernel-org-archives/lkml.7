Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B257FC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 01:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7564122DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 01:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfICBoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 21:44:34 -0400
Received: from shelob.surriel.com ([96.67.55.147]:57952 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfICBoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 21:44:34 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i4xrz-0003x6-4W; Mon, 02 Sep 2019 21:44:31 -0400
Message-ID: <7667ded2e740714b0fd8bf82c258359e326c9765.camel@surriel.com>
Subject: Re: [PATCH RFC v4 0/15] sched,fair: flatten CPU controller runqueues
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Mon, 02 Sep 2019 21:44:30 -0400
In-Reply-To: <94ba95b9-9cfe-d715-dded-ff92700d47eb@arm.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <94ba95b9-9cfe-d715-dded-ff92700d47eb@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-SO5Gi8ar7pQ3whC7f4BI"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SO5Gi8ar7pQ3whC7f4BI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-02 at 12:53 +0200, Dietmar Eggemann wrote:
> On 22/08/2019 04:17, Rik van Riel wrote:

> > My main TODO items for the next period of time are likely going to
> > be testing, testing, and testing. I hope to find and flush out any
> > corner case I can find, and make sure performance does not regress
> > with any workloads, and hopefully improves some.
>=20
> I did some testing with a small & simple rt-app based test-case:
>=20
> 2 CPUs (rq->cpu_capacity_orig=3D1024), CPUfreq performance governor
>=20
> 2 taskgroups /tg0 and /tg1
>=20
> 6 CFS tasks (periodic, 8/16ms (runtime/period))
>=20
> /tg0 (cpu.shares=3D1024) ran 4 tasks and /tg1 (cpu.shares=3D1024) ran 2
> tasks
>=20
> (arm64 defconfig with !CONFIG_NUMA_BALANCING,
> !CONFIG_SCHED_AUTOGROUP)
>=20
> ---
>=20
> v5.2:
>=20
> The 2 /tg1 tasks ran 8/16ms. The 4 /tg0 tasks ran 4/16ms in the
> beginning and then 8/16ms after the 2 /tg1 tasks did finish.
>=20
> ---
>=20
> v5.2 + v4:
>=20
> There is no runtime/period pattern visible anymore. I see a lot of
> extra
> wakeup latency for those tasks though.
>=20
> v5.2 + (v4 without 07/15, 08/15, 15/15) didn't change much.

One thing to keep in mind is that with the hierarchical
CPU controller code, you are always either comparing
tg0 and tg1 (of equal priority), or tasks of equal priority,
once the load balancer has equalized the load between CPUs.

With the flat CPU controller, the preemption code is comparing
sched_entities with other sched_entities that have 2x the
priority, similar to a nice level 0 entity compared against a
nice level ~3 task.

I do not know whether the code has ever given a predictable
scheduling pattern when the CPU is fully loaded with a mix of
different priority tasks that each want a 50% duty cycle.

But maybe it has, and I need to look into that :)

Figuring out exactly what the preemption code should do might
be a good discussion for Plumbers, too.

--=20
All Rights Reversed.

--=-SO5Gi8ar7pQ3whC7f4BI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1txX4ACgkQznnekoTE
3oMBcAgAlGoo82sIdVBz9RVnkhDwc4SsDvhaROmJau+XIqRoFSnJyzeMTS1xUCJA
67p3zzble6sPJozDTQ9MIR/dxQvr86iwq9FdSSSgUByuJWOtC8ijfi//N1J9l6n3
ZdjBlcLH6E+AePg89p2A67butlSqvArYGZrqrqGC0s1QjpUvp8rU95m0142jKPKj
apg4dmWV1DgBf29TvFYISFh/PXV9pZs9d+qW7dN/11rNxcQGfWYIdxWbpUDSOV1j
xGhs/ldGLkTVmtg4k4/ewPNFNxz1kwgcYXlfxibpobaZH/1atjJiReb1G74WFusX
mm5z4cWE2roHGwruNH7lTfcAksodnw==
=zQF0
-----END PGP SIGNATURE-----

--=-SO5Gi8ar7pQ3whC7f4BI--

