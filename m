Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010D4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FB32146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLSPkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:40:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfLSPkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:40:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE20206EC;
        Thu, 19 Dec 2019 15:40:20 +0000 (UTC)
Date:   Thu, 19 Dec 2019 10:40:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Message-ID: <20191219104018.5f8e50d2@gandalf.local.home>
In-Reply-To: <44c95c18-7593-f3e7-f710-a7d424af7442@virtuozzo.com>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
        <20191219131242.GK2827@hirez.programming.kicks-ass.net>
        <20191219140252.GS2871@hirez.programming.kicks-ass.net>
        <bfaa72ca-8bc6-f93c-30d7-5d62f2600f53@virtuozzo.com>
        <20191219094330.0e44c748@gandalf.local.home>
        <11d755e9-e4f8-dd9e-30b0-45aebe260b2f@virtuozzo.com>
        <20191219095941.2eebed84@gandalf.local.home>
        <44c95c18-7593-f3e7-f710-a7d424af7442@virtuozzo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 18:20:58 +0300
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> From: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> This introduces an optimization based on xxx_sched_class addresses
> in two hot scheduler functions: pick_next_task() and check_preempt_curr().
> 
> After this patch, it will be possible to compare pointers to sched classes
> to check, which of them has a higher priority, instead of current iterations
> using for_each_class().
> 
> One more result of the patch is that size of object file becomes a little
> less (excluding added BUG_ON(), which goes in __init section):
> 
> $size kernel/sched/core.o
>          text     data      bss	    dec	    hex	filename
> before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
> after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o
> 
> SCHED_DATA improvements guaranteeing order of sched classes are made
> by Steven Rostedt <rostedt@goodmis.org>

For the above changes, you can add:

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> v2: Steven's data sections ordering. Hunk with comment in Makefile is removed.
> ---
>  include/asm-generic/vmlinux.lds.h |    8 ++++++++
>  kernel/sched/core.c               |   24 +++++++++---------------
>  kernel/sched/deadline.c           |    3 ++-
>  kernel/sched/fair.c               |    3 ++-
>  kernel/sched/idle.c               |    3 ++-
>  kernel/sched/rt.c                 |    3 ++-
>  kernel/sched/stop_task.c          |    3 ++-
>  7 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4..ff12a422ff19 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -108,6 +108,13 @@
>  #define SBSS_MAIN .sbss
>  #endif
>  
