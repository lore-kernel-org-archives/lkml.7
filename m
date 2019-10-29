Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34446CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9192087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CFk0NZNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbfJ2LKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:10:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35572 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfJ2LKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:10:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so9015980qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=W7Kz1lk1jTiGFiH/QrMM5e5TkKbKcEVmB9JU/Z9Ifbo=;
        b=CFk0NZNw6lCtY4pC7kLl4vONt0CmFR3XcfKQ/PYZQlQmFD2CgeX+YztULXSrWGAg+m
         /O8gONnFpYX79HHdNe9rEdCjKraeRKekFR4BE7kxjQchY+8z0Cm2CryJOBqGdTn39HUD
         e7LvnYgFVv3ejl9iyWn72GT2ySonqaVExz3e3AIlTB6aFHK0bHMd7Eqf7nyq/Hdiot28
         MX6kNjrV7CtJMIbaVuXosiv/hSi6RCuMc9Yz65uvHu3Be0LhO13+OC9All0f2wu+vHlk
         9i+QdoPhGFOXZZ2Oz80/wkcxUDlVGTNcABucOv5lHCxcNHf+HkcWf+n81XEf+mFiS/im
         RgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=W7Kz1lk1jTiGFiH/QrMM5e5TkKbKcEVmB9JU/Z9Ifbo=;
        b=SsNV8g/co8yVtSOMG+uL3uuNK1az0hKdfDOYI4M4fQe+gpcxKMHPA97Aap8PWZq7sS
         18wehZky2HfIGolZof75/Z3+csgV2znSLZdSbhzOM6BR57o7pGIe6v1lnmRWKYc+14ep
         MfowaHbms1avfHDUuR3MFeaImrefdlWZaDrYOEDM7PM91aKdvQQ+GulNGR4ZspjbLicO
         Th5+/Gii0LwZ0m8I0+oeYceK2bl3WMgmcn0W0epK0vLW+EdYxLBQZxNHwKdx3ysYNJR5
         +YzJCOA0my/LfeM1pMpl+plEFDqK6UL5vu+8GI5dUTMiq+k6donwCrh3xiFHEC/P5KwR
         NI2A==
X-Gm-Message-State: APjAAAUCXOah99RQFdvEb36g36NbpRYDk+y4LYFYl72aO36J/+dBcRcg
        51cLA02b7oRRXnxalR8eZTj2RHTI4Bz2wQ==
X-Google-Smtp-Source: APXvYqzquRGYq6C8pQjQPQfyYnvfNC542XcJbzJYQEkQZ/5Z/Q8g43Fp4LNgLIPcQISTgbwUVtSRig==
X-Received: by 2002:ad4:450c:: with SMTP id k12mr12072073qvu.61.1572347435363;
        Tue, 29 Oct 2019 04:10:35 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q34sm9332310qte.50.2019.10.29.04.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 04:10:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sched: Avoid spurious lock dependencies
Date:   Tue, 29 Oct 2019 07:10:34 -0400
Message-Id: <EE57FDCF-E3CD-4A0D-B0CC-C3CBAA7EBCBD@lca.pw>
References: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        mingo@redhat.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
In-Reply-To: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 1, 2019, at 5:18 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> Does the below adequately describe the situation?
>=20
> ---
> Subject: sched: Avoid spurious lock dependencies
>=20
> While seemingly harmless, __sched_fork() does hrtimer_init(), which,
> when DEBUG_OBJETS, can end up doing allocations.
>=20
> This then results in the following lock order:
>=20
>  rq->lock
>    zone->lock.rlock
>      batched_entropy_u64.lock
>=20
> Which in turn causes deadlocks when we do wakeups while holding that
> batched_entropy lock -- as the random code does.
>=20
> Solve this by moving __sched_fork() out from under rq->lock. This is
> safe because nothing there relies on rq->lock, as also evident from the
> other __sched_fork() callsite.
>=20
> Fixes: b7d5dc21072c ("random: add a spinlock_t to struct batched_entropy")=

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> kernel/sched/core.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7880f4f64d0e..1832fc0fbec5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6039,10 +6039,11 @@ void init_idle(struct task_struct *idle, int cpu)
>    struct rq *rq =3D cpu_rq(cpu);
>    unsigned long flags;
>=20
> +    __sched_fork(0, idle);
> +
>    raw_spin_lock_irqsave(&idle->pi_lock, flags);
>    raw_spin_lock(&rq->lock);
>=20
> -    __sched_fork(0, idle);
>    idle->state =3D TASK_RUNNING;
>    idle->se.exec_start =3D sched_clock();
>    idle->flags |=3D PF_IDLE;

It looks like this patch has been forgotten forever. Do you need to repost, s=
o Ingo might have a better chance to pick it up?=
