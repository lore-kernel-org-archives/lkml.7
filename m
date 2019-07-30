Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97651C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745742064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfG3S1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:27:36 -0400
Received: from shelob.surriel.com ([96.67.55.147]:32838 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfG3S1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:27:35 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hsWqI-0000go-Lu; Tue, 30 Jul 2019 14:27:22 -0400
Message-ID: <d38c5d5b5adfc9b9b4f386f912daa8c581ec6328.camel@surriel.com>
Subject: Re: [PATCH RFC v3 0/14] sched,fair: flatten CPU controller runqueues
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Tue, 30 Jul 2019 14:27:22 -0400
In-Reply-To: <20190730162933.GW31398@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
         <20190730162933.GW31398@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-w+XrJxZWZMVSU7Dom0r+"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w+XrJxZWZMVSU7Dom0r+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-30 at 18:29 +0200, Peter Zijlstra wrote:
> On Mon, Jul 22, 2019 at 01:33:34PM -0400, Rik van Riel wrote:
> > Plan for the CONFIG_CFS_BANDWIDTH reimplementation:
> > - When a cgroup gets throttled, mark the cgroup and its children
> >   as throttled.
> > - When pick_next_entity finds a task that is on a throttled cgroup,
> >   stash it on the cgroup runqueue (which is not used for runnable
> >   tasks any more). Leave the vruntime unchanged, and adjust that
> >   runqueue's vruntime to be that of the left-most task.
>=20
> and ignore such tasks for the load-balancer; I suppose

Good point. I suppose we need to find a lazy way of doing
this, too...

> > - When a cgroup gets unthrottled, and has tasks on it, place it on
> >   a vruntime ordered heap separate from the main runqueue.
>=20
> and expose said heap to the load-balancer..
>=20
> Now, I suppose you do this because merging heaps is easier than
> merging
> RB trees? (not in complexity iirc, but probably in code)
>=20
> > - Have pick_next_task_fair grab one task off that heap every time
> > it
> >   is called, and the min vruntime of that heap is lower than the
> >   vruntime of the CPU's cfs_rq (or the CPU has no other runnable
> > tasks).
>=20
> That's like a smeared out merge :-) But since the other tasks kept on
> running, this CPUs vruntime will be (much) advanced vs those
> throttled
> tasks and we'll most likely end up picking them all before we pick a
> 'normal' task.

The GENTLE_FAIR_SLEEPERS code should place the vruntime
of newly unthrottled tasks to the right of that of the
current top task on the runqueue, to prevent thundering
herd effects (and the throttled group immediately going
over its quota again, while causing bad latency for others).

> > - Place that selected task on the CPU's cfs_rq, renormalizing its
> >   vruntime with the GENTLE_FAIR_SLEEPERS logic. That should help
> >   interleave the already runnable tasks with the recently
> > unthrottled
> >   group, and prevent thundering herd issues.
> > - If the group gets throttled again before all of its task had a
> > chance
> >   to run, vruntime sorting ensures all the tasks in the throttled
> > cgroup
> >   get a chance to run over time.
>=20
>=20
--=20
All Rights Reversed.

--=-w+XrJxZWZMVSU7Dom0r+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1AjAoACgkQznnekoTE
3oN7bgf+MY2UaY9JEX5tYWJt1qyr3gnTvUVp9YZnbcH/BllW6+etzLkgj4inKUzd
NKOQXFnm+VNCQ4DMHxgAKL03EqoR45bvryo0Il4Fvk9QiS1T13KJvKtIZ/MA35Hq
wgBqk6/M/teBQ+hFschJa4kgAJH6YoNYgi+8nVPVgOyiy9ktWD9yiggJSiqau1Zj
5X6nAxtJD//nhMIIN7YfaP3244gyQqFV87LJiuAJPUBrz4BsHlAkGb/Xq7tJQrwa
ROwDOiqXFUh6VwOvu3M/hcSxWrBfOcJvsJGkjZmwhWH2eb0rYwPwrOIV6VbXZTYx
EK/hpWWG0J52GXdsLdsLRGNtwb7G1g==
=7eJP
-----END PGP SIGNATURE-----

--=-w+XrJxZWZMVSU7Dom0r+--

