Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605A0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408EC20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfH1XTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 19:19:11 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35482 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfH1XTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 19:19:10 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i37DP-0003vX-60; Wed, 28 Aug 2019 19:18:59 -0400
Message-ID: <d703071084dadb477b8248b041d0d1aa730d65cd.camel@surriel.com>
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
Date:   Wed, 28 Aug 2019 19:18:58 -0400
In-Reply-To: <CAKfTPtDxHijR3PCOFfxA-r02rf2hVP4LpB=y-9emHS7znTPxTA@mail.gmail.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-9-riel@surriel.com>
         <CAKfTPtDxHijR3PCOFfxA-r02rf2hVP4LpB=y-9emHS7znTPxTA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5Tr4lXHpCftQWl9CGQiq"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5Tr4lXHpCftQWl9CGQiq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-28 at 19:32 +0200, Vincent Guittot wrote:
> On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
> > The idea behind __sched_period makes sense, but the results do not
> > always.
> >=20
> > When a CPU has one high priority task and a large number of low
> > priority
> > tasks, __sched_period will return a value larger than
> > sysctl_sched_latency,
> > and the one high priority task may end up getting a timeslice all
> > for itself
> > that is also much larger than sysctl_sched_latency.
>=20
> note that unless you enable sched_feat(HRTICK), the sched_slice is
> mainly used to decide how fast we preempt running task at tick but a
> newly wake up task can preempt it before
>=20
> > The low priority tasks will have their time slices rounded up to
> > sysctl_sched_min_granularity, resulting in an even larger
> > scheduling
> > latency than targeted by __sched_period.
>=20
> Will this not break the fairness between a always running task and a
> short sleeping one with this changes ?

In what way?

The vruntime for the always running task will continue
to advance the same way it always has.

> > Simplify the code by simply ripping out __sched_period and always
> > taking
> > fractions of sysctl_sched_latency.
> >=20
> > If a high priority task ends up getting a "too small" time slice
> > compared
> > to low priority tasks, the vruntime scaling ensures that it will
> > simply
> > get scheduled more frequently than low priority tasks.
>=20
> Will you not increase the number of context switch ?

It should actually decrease the number of context
switches. If a nice +19 task gets a longer time slice
than it would today, its vruntime will be advanced by
more than sysctl_sched_latency, and it will not get
to run again until another task has caught up with its
vruntime.

That means the regular (or high) priority task that
shares the CPU with that nice +19 task might get
several time slices in a row until the nice +19 task
gets to run again.

What am I overlooking?

--=20
All Rights Reversed.

--=-5Tr4lXHpCftQWl9CGQiq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1nC+IACgkQznnekoTE
3oNotgf7BbuP7sQ1i2xJTmmF2o9Eae9tykrnkx/UfL5eRz17UNkNkYl8/AmCy4Th
8IesFu4GwztOVCC4rm90Ftm4G0DOK6Su7Xr7OR7jzwnTSvIOi6/MkAafMAZFXgBF
F1whsJjjQJlK4lI3XzAlggEvRIacOQ3nfQP7kAAl5gGHKbuhW1IPX3NNJPklzxS2
8n/6c6LFjoa3o84YGSs9bbAiqFfuxrqdJEusj+hHD/SP9YesLvOgP/Fc3dKsI72Y
V/9uEIPzBxja35cQmS790hee6X5INvaF87l8vSTLZ40E1caJnp9IeclaLpeC5mih
sRvH8n3dUbCpSTN/oLVA2JpKyE5R0g==
=4eRB
-----END PGP SIGNATURE-----

--=-5Tr4lXHpCftQWl9CGQiq--

