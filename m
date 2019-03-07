Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDC120684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FLIEkJR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCGJzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:55:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3KyYg6XzXq03jSbFgxzIANsLy4hwtpzsWBAcpbUBTw4=; b=FLIEkJR6kXMN+/F+CBCUoBpbl
        WoY78KjtNDL8Dl72ErAwpOmWvz1HqbrUf7AkRrB2bhalCQ/UZQs+tMVMmLodQIKepLQWTni5JwrN5
        74JracZzYpKo0SovpUsiJfUvnXskLqVkf2Cy9Z2ktUGxFNCcUxNf+fdEWx1ZvGU0Wn6aing2uiTfo
        RZL4I13FxlqwEOcvphSdKPJGiT2O0c8vrAQI9upyHua0p/YsKqaND40rGbTGTkM+FzgnJqfDIcXqb
        8yFTeKDGwAEtxn7z0wAyLYss74ZuMdZ3Jv41YfxIqqYWiXTOABqvZ2QW0QQdxGoalzDq34Qt37yt1
        tCeICQYUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1pk2-0001DR-Pd; Thu, 07 Mar 2019 09:55:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40E2420297ED1; Thu,  7 Mar 2019 10:55:03 +0100 (CET)
Date:   Thu, 7 Mar 2019 10:55:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        shaoyafang@didiglobal.com
Subject: Re: [PATCH] sched: fair: fix missed CONFIG_SCHEDSTATS
Message-ID: <20190307095503.GB32477@hirez.programming.kicks-ass.net>
References: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com>
 <20190306100907.GT32477@hirez.programming.kicks-ass.net>
 <CALOAHbC1zqzU8-ikcLOUMKY5cbyuW_B6MK5rz7G6rTK-SoyMTQ@mail.gmail.com>
 <20190306112707.GU32477@hirez.programming.kicks-ass.net>
 <CALOAHbB7EZ83R3gHcGa9oZWq=7CEgBkL2cXav_7N13u4U44+uA@mail.gmail.com>
 <20190306123834.GW32494@hirez.programming.kicks-ass.net>
 <CALOAHbBDArxamap+TsWXy227N-UOsKVDA-HkGVF1M0O2Fk8qEg@mail.gmail.com>
 <CALOAHbAC-aev3s_n+byWMyeoBo8knFdbKUcXUjsbM3D8iFRWOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAC-aev3s_n+byWMyeoBo8knFdbKUcXUjsbM3D8iFRWOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:49:58PM +0800, Yafang Shao wrote:
> What about your opinon ?
> 
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 9a4bdfa..a0291f2 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -336,6 +336,7 @@ static inline long __trace_sched_switch_state(bool
> preempt, struct task_struct *
>                   __entry->pid, __entry->old_pid)
>  );
> 
> +#ifdef CONFIG_SCHEDSTATS
>  /*
>   * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
>   *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
> @@ -394,6 +395,14 @@ static inline long
> __trace_sched_switch_state(bool preempt, struct task_struct *
>  DEFINE_EVENT(sched_stat_template, sched_stat_blocked,
>              TP_PROTO(struct task_struct *tsk, u64 delay),
>              TP_ARGS(tsk, delay));
> +#else
> +
> +#define trace_sched_stat_wait(...) do {} while (0)
> +#define trace_sched_stat_sleep(...) do {} while (0)
> +#define trace_sched_stat_iowait(...) do {} while (0)
> +#define trace_sched_stat_blocked(...) do {} while (0)

Make those inline functions that take proper arguments.

> +#endif
