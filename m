Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8D7C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C741820675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556809861;
	bh=sliCV6k2MNA+3/fwIwgX4ihnR6bXNyMlgAQf4+44PAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K7atjMOB1saL5xYrsrmOR8EDzC4W81fd3WUut8RhwPBCv/UJ7rC7aYmvUqUru2b/U
	 rVNYxGqwVj/RtMUB/XMgKtLCV4Y9+bjc8ijR+A6m+aUN3YOCOukqlHSGdkQLSccroz
	 +gBxlGF7cN7swfQd+AaQro3IZcrGQI86RRGcObfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfEBPLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:11:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50772 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfEBPLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:11:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id p21so3344276wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=flomCnRvQzTWWCJrB4+rAX3G4vO3zfGDKQE1f825vKE=;
        b=KiRnzTyeo6a5EiFg/kLFDBhIISuZz4VbXq9EoJfMxh7UwlM492UNaef9zXonR2WEtJ
         xyGvakCOopbj8HlyF8ZZhstreB+arSJ4Y9EpzZjcSNJNVcNJkne0/SeqrGmNejnBGzpE
         lDpqmoNvTODbEiW3kAcThNuY2WnHnJc7c6dPvkM7XdcOF/ZQi4VRPBO1/wtA4N3AzAua
         vV8CoDwhV69r2uUKven044vPIFLB8WTHgrtEFoH4KI1n2hhyzQ/PEczHJUT4fsNzK12J
         EMK0VN7V52cJFX7/dLXwWQ7nd9XcjojXQxSNWP1bu6S1PRpfH+cipcCz4rOqlgTdZyPy
         2wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=flomCnRvQzTWWCJrB4+rAX3G4vO3zfGDKQE1f825vKE=;
        b=nhDQ0FWqO8q0EdJkMFPuY6wwwRIYCZ+Ja9g5AG/81M1hTAWCrmVGHbuqpHKV4orCWs
         E9MEYiq0gpu72iuZtoyJBENB4n9EHiMEBGlpYwDeZuJ6pFHkDvWkwq4uede2AEWJf3mV
         6xMEQObfDEZwpAVKYGabZYQY2Sj+QFNfqIKbIf7BrE145AD5dZysbHJTlBwTvVMpcL/B
         bPN4Pvnk4Tdj4S5WOkwEyvU0rZwHWQcGS7mPQCTMXAN7/KWakgr2oeMm63RX4TehVkG5
         7fKGPjsmqO2vJ9cUkC+08CAHfQiOaekYewsFnXkzImAwxhlqYJ74/fP3hPhM2UJu6IJm
         4oFw==
X-Gm-Message-State: APjAAAWlCPQe7z1AszLy8fWWXRxvlnw33r7ppRnSaJU6xKHA8BHew8F2
        vgkvYLCBZZGLLxI5q7k2kNE=
X-Google-Smtp-Source: APXvYqwCRacMF5RySKqgm89ppD1BUPcNAoMggbwkXKiaVBCLf8v9vvqxAmMGfDkdmbGN1QNFZ87GRA==
X-Received: by 2002:a05:600c:2199:: with SMTP id e25mr1849413wme.36.1556809858617;
        Thu, 02 May 2019 08:10:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z5sm11010774wre.70.2019.05.02.08.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 08:10:57 -0700 (PDT)
Date:   Thu, 2 May 2019 17:10:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched: Provide a pointer to the valid CPU mask
Message-ID: <20190502151055.GA50195@gmail.com>
References: <20190423142636.14347-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423142636.14347-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> In commit 4b53a3412d66 ("sched/core: Remove the tsk_nr_cpus_allowed()
> wrapper") the tsk_nr_cpus_allowed() wrapper was removed. There was not
> much difference in !RT but in RT we used this to implement
> migrate_disable(). Within a migrate_disable() section the CPU mask is
> restricted to single CPU while the "normal" CPU mask remains untouched.
> 
> As an alternative implementation Ingo suggested to use
> 	struct task_struct {
> 		const cpumask_t		*cpus_ptr;
> 		cpumask_t		cpus_mask;
>         };
> with
> 	t->cpus_allowed_ptr = &t->cpus_allowed;
> 
> In -RT we then can switch the cpus_ptr to
> 	t->cpus_allowed_ptr = &cpumask_of(task_cpu(p));
> 
> in a migration disabled region. The rules are simple:
> - Code that 'uses' ->cpus_allowed would use the pointer.
> - Code that 'modifies' ->cpus_allowed would use the direct mask.
> 
> I proposed this patch as a series earlier and it was shutdown due to the
> migrate_disable() bits. It has been said that migrate_disable() should
> only be used with RT and thus not introduced without it.
> I hereby propose only the mask CPU-bits.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/ia64/kernel/mca.c                     |  2 +-
>  arch/mips/include/asm/switch_to.h          |  4 +--
>  arch/mips/kernel/mips-mt-fpaff.c           |  2 +-
>  arch/mips/kernel/traps.c                   |  6 ++--
>  arch/powerpc/platforms/cell/spufs/sched.c  |  2 +-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c  |  2 +-
>  drivers/infiniband/hw/hfi1/affinity.c      |  6 ++--
>  drivers/infiniband/hw/hfi1/sdma.c          |  3 +-
>  drivers/infiniband/hw/qib/qib_file_ops.c   |  7 ++--
>  fs/proc/array.c                            |  4 +--
>  include/linux/sched.h                      |  5 +--
>  init/init_task.c                           |  3 +-
>  kernel/cgroup/cpuset.c                     |  2 +-
>  kernel/fork.c                              |  2 ++
>  kernel/sched/core.c                        | 40 +++++++++++-----------
>  kernel/sched/cpudeadline.c                 |  4 +--
>  kernel/sched/cpupri.c                      |  4 +--
>  kernel/sched/deadline.c                    |  6 ++--
>  kernel/sched/fair.c                        | 34 +++++++++---------
>  kernel/sched/rt.c                          |  4 +--
>  kernel/trace/trace_hwlat.c                 |  2 +-
>  lib/smp_processor_id.c                     |  2 +-
>  samples/trace_events/trace-events-sample.c |  2 +-
>  23 files changed, 75 insertions(+), 73 deletions(-)

Looks good to me in principle - Peter, Thomas, any fundamental 
objections?

Thanks,

	Ingo
