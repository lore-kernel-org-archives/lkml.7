Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C90EC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE95A206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfJGSGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:06:25 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38502 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGSGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:06:25 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1iHXOa-00035O-Sn; Mon, 07 Oct 2019 14:06:08 -0400
Message-ID: <fe69e0878feaf4d8450ac7e44126f9fffe6e9e3c.camel@surriel.com>
Subject: Re: [PATCH v3 09/10] sched/fair: use load instead of runnable load
 in wakeup path
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Date:   Mon, 07 Oct 2019 14:06:08 -0400
In-Reply-To: <CAKfTPtA763zLxToVJpOCKc8TAgD3aZwpwhMZbbzrKiok+UHFaA@mail.gmail.com>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
         <1568878421-12301-10-git-send-email-vincent.guittot@linaro.org>
         <bc879bcb34f089e5888f6721aa2365f0832b69da.camel@surriel.com>
         <CAKfTPtA763zLxToVJpOCKc8TAgD3aZwpwhMZbbzrKiok+UHFaA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6g0u0PwyfypHWJX/o/gH"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6g0u0PwyfypHWJX/o/gH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-07 at 17:27 +0200, Vincent Guittot wrote:
> On Mon, 7 Oct 2019 at 17:14, Rik van Riel <riel@surriel.com> wrote:
> > On Thu, 2019-09-19 at 09:33 +0200, Vincent Guittot wrote:
> > > runnable load has been introduced to take into account the case
> > > where
> > > blocked load biases the wake up path which may end to select an
> > > overloaded
> > > CPU with a large number of runnable tasks instead of an
> > > underutilized
> > > CPU with a huge blocked load.
> > >=20
> > > Tha wake up path now starts to looks for idle CPUs before
> > > comparing
> > > runnable load and it's worth aligning the wake up path with the
> > > load_balance.
> > >=20
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >=20
> > On a single socket system, patches 9 & 10 have the
> > result of driving a woken up task (when wake_wide is
> > true) to the CPU core with the lowest blocked load,
> > even when there is an idle core the task could run on
> > right now.
> >=20
> > With the whole series applied, I see a 1-2% regression
> > in CPU use due to that issue.
> >=20
> > With only patches 1-8 applied, I see a 1% improvement in
> > CPU use for that same workload.
>=20
> Thanks for testing.
> patch 8-9 have just replaced runnable load  by blocked load and then
> removed the duplicated metrics in find_idlest_group.
> I'm preparing an additional patch that reworks  find_idlest_group()
> to
> behave similarly to find_busiest_group(). It gathers statistics what
> it already does, then classifies the groups and finally selects the
> idlest one. This should fix the problem that you mentioned above when
> it selects a group with lowest blocked load whereas there are idle
> cpus in another group with high blocked load.

That should do the trick!

> > Given that it looks like select_idle_sibling and
> > find_idlest_group_cpu do roughly the same thing, I
> > wonder if it is enough to simply add an additional
> > test to find_idlest_group to have it return the
> > LLC sg, if it is called on the LLC sd on a single
> > socket system.
>=20
> That make sense to me
>=20
> > That way find_idlest_group_cpu can still find an
> > idle core like it does today.
> >=20
> > Does that seem like a reasonable thing?
>=20
> That's worth testing

I'll give it a try.

Doing the full find_idlest_group heuristic
inside an LLC seems like it would be overkill,
anyway.

--=20
All Rights Reversed.

--=-6g0u0PwyfypHWJX/o/gH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl2bfpAACgkQznnekoTE
3oN2IAgAjQ23n+upCS/L7x2xgo3k8/iA66cw3M/ju0kO/QLbn7V3TAVGMkiXjNWz
QjidZkY1Zzq/N9n4ugd24vCZit2iZIX2oLwbjzF6FPjHC31WXptQoHXJEw7T8+Jb
BRmMhYKpB3ILxtnxQLKcG7dqWxXlaVbDe2LuG1wTRwh9FxH4PQ46f+BM6owj+8a6
Bz/0sWIHvUMtD2V/RIRR5JdwrRtOoBuknl5sdITgj7kCeWgEyFmJV4gjG9MSHHqQ
Y5EaJAYjny8MC1fvvmEw/2nFcRpZdmzG+hIdIreqYDeKuMaaNmKuoKR4XuxXfEWW
rVUWJNmNEqAH5OuSVDv9Ov0XW5wgvA==
=zQW5
-----END PGP SIGNATURE-----

--=-6g0u0PwyfypHWJX/o/gH--

