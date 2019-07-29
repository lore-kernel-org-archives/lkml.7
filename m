Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ACFC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7461C2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbfG2VVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:21:10 -0400
Received: from shelob.surriel.com ([96.67.55.147]:48794 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388163AbfG2VVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:21:09 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hsD4u-00061P-72; Mon, 29 Jul 2019 17:21:08 -0400
Message-ID: <ec9effc07a94b28ecf364de40dee183bcfb146fc.camel@surriel.com>
Subject: Re: [PATCH v3] sched/core: Don't use dying mm as active_mm of
 kthreads
From:   Rik van Riel <riel@surriel.com>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Michal Hocko <mhocko@kernel.org>
Date:   Mon, 29 Jul 2019 17:21:07 -0400
In-Reply-To: <20190729210728.21634-1-longman@redhat.com>
References: <20190729210728.21634-1-longman@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-l4XujGBB1uulLbJ4CPGM"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l4XujGBB1uulLbJ4CPGM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-29 at 17:07 -0400, Waiman Long wrote:
> It was found that a dying mm_struct where the owning task has exited
> can stay on as active_mm of kernel threads as long as no other user
> tasks run on those CPUs that use it as active_mm. This prolongs the
> life time of dying mm holding up some resources that cannot be freed
> on a mostly idle system.

On what kernels does this happen?

Don't we explicitly flush all lazy TLB CPUs at exit
time, when we are about to free page tables?

Does this happen only on the CPU where the task in
question is exiting, or also on other CPUs?

If it is only on the CPU where the task is exiting,
would the TASK_DEAD handling in finish_task_switch()
be a better place to handle this?

> Fix that by forcing the kernel threads to use init_mm as the
> active_mm
> during a kernel thread to kernel thread transition if the previous
> active_mm is dying (!mm_users). This will allows the freeing of
> resources
> associated with the dying mm ASAP.
>=20
> The presence of a kernel-to-kernel thread transition indicates that
> the cpu is probably idling with no higher priority user task to run.
> So the overhead of loading the mm_users cacheline should not really
> matter in this case.
>=20
> My testing on an x86 system showed that the mm_struct was freed
> within
> seconds after the task exited instead of staying alive for minutes or
> even longer on a mostly idle system before this patch.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 795077af4f1a..41997e676251 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3214,6 +3214,8 @@ static __always_inline struct rq *
>  context_switch(struct rq *rq, struct task_struct *prev,
>  	       struct task_struct *next, struct rq_flags *rf)
>  {
> +	struct mm_struct *next_mm =3D next->mm;
> +
>  	prepare_task_switch(rq, prev, next);
> =20
>  	/*
> @@ -3229,8 +3231,22 @@ context_switch(struct rq *rq, struct
> task_struct *prev,
>  	 *
>  	 * kernel ->   user   switch + mmdrop() active
>  	 *   user ->   user   switch
> +	 *
> +	 * kernel -> kernel and !prev->active_mm->mm_users:
> +	 *   switch to init_mm + mmgrab() + mmdrop()
>  	 */
> -	if (!next->mm) {                                // to kernel
> +	if (!next_mm) {					// to kernel
> +		/*
> +		 * Checking is only done on kernel -> kernel transition
> +		 * to avoid any performance overhead while user tasks
> +		 * are running.
> +		 */
> +		if (unlikely(!prev->mm &&
> +			     !atomic_read(&prev->active_mm->mm_users)))=20
> {
> +			next_mm =3D next->active_mm =3D &init_mm;
> +			mmgrab(next_mm);
> +			goto mm_switch;
> +		}
>  		enter_lazy_tlb(prev->active_mm, next);
> =20
>  		next->active_mm =3D prev->active_mm;
> @@ -3239,6 +3255,7 @@ context_switch(struct rq *rq, struct
> task_struct *prev,
>  		else
>  			prev->active_mm =3D NULL;
>  	} else {                                        // to user
> +mm_switch:
>  		/*
>  		 * sys_membarrier() requires an smp_mb() between
> setting
>  		 * rq->curr and returning to userspace.
> @@ -3248,7 +3265,7 @@ context_switch(struct rq *rq, struct
> task_struct *prev,
>  		 * finish_task_switch()'s mmdrop().
>  		 */
> =20
> -		switch_mm_irqs_off(prev->active_mm, next->mm, next);
> +		switch_mm_irqs_off(prev->active_mm, next_mm, next);
> =20
>  		if (!prev->mm) {                        // from kernel
>  			/* will mmdrop() in finish_task_switch(). */
--=20
All Rights Reversed.

--=-l4XujGBB1uulLbJ4CPGM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0/Y0MACgkQznnekoTE
3oOaKQf/VSVsZmXhfcU6zOpLa8iKeG1i8twZxHUp3pmctc0g9XcW7a+h60GTX/Aq
wHbRpgAnjpltplzqrWqipaxvj+fj+8IRNOBuWzB20gupeq+bx/tJHcvnXpAlUsZJ
Zgj4eIzYETaREYfdUgEmBZg6gE9DyLI3sEz5/RH5L4/V+HkdYu9i1bVX5rfNq1kn
iIgK7EjGmoM84W/zNgIFMtvGZiWiTDkYMhjqTpp5wVUNHHutF41gHNVEQ1KXr/la
Xdu2OgionGyrr2SfsU/KxWN8Ha34E1IjVEaHcR1AhLPIdOX6DeWUB2aFr9Ymx7HM
i1UfCr9K0VKZ3cWVGAZDmNtm+kQXEg==
=kV++
-----END PGP SIGNATURE-----

--=-l4XujGBB1uulLbJ4CPGM--

