Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143BCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6E72086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7GjIQIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436496AbfITTHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:07:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34289 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393046AbfITTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:07:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so8419145qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 12:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q/KGjCaXuqC+q9Y1P6cVmtNCBtXPlFpLzuPR3kMleDs=;
        b=s7GjIQIGpA35qanzyQmC0VuNti/xfhOaa7YE7CUpKH+DRSfP/L2ggy0GMuBJBMtjYa
         lVZtpIqTTxKe8+XmWHksh+Co9DhDdwUgTMJf8kpyFSy3BGZDuXlj/I4gEt4+QK9EwYy7
         YAxWcvES7yRbWyKndD5YcyPGwvIdxkJ85kmR4RtDR1Lm2DYQemIXSLhzN0nxsXRfbPmg
         ES2RtLTWJBMT96h4BMAHZVBSt607P0P8jgdVZ74tFr+f6f05UidP9QDLmxy0fzEvD1G2
         Nqw/cukhyKjbapt6rpEtnXJfwkdT59T49QNN+2B3mQ0fN2vf6QEJEiOAlnHCJ/RDZedg
         MSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q/KGjCaXuqC+q9Y1P6cVmtNCBtXPlFpLzuPR3kMleDs=;
        b=BLzXv103uHlJh3wKlvUBHABZPxzEXo28QX4fp0GZqp4rHw6zY7gUwS+Fr5h2x7ZaZO
         SGzkZXyYt4PdIePxt7NAJr+oGWecS9lNN5J2eUTfVggGTbqmcD+Gl6j06a+uhGhO0ssn
         U/tdBp2Nl07emlbc3yCdQLMUt/vgEbTEF3hzd4jD+0/K1r92GGsQ3uNnQttIkAgp5fFN
         6iTz5OPeANy2CXvSHcjckr8hGkod/PX1cIlVodMUYnE7fbeofxOrW0mAqWQdzBz07waa
         dIImQVr/cuzjk21lYo268tzKCSbMraMgiFCg8l6TW+q0JPJIho905zJ+XWAh6FPO0HiH
         Gplw==
X-Gm-Message-State: APjAAAVpspjXTjCQZ742zy62PP9p2Ql6zHIuoH0a0vD4rJUM+mQJJKvx
        DGctadiQjaetJKYSuHa3xHU=
X-Google-Smtp-Source: APXvYqwwxocwmxArwNuk5ZpxPp+Q8T/BEekInU5qM+eOu+Zi+ZFF+FRJCTrWWYAu4GOvcSBU8a48Vw==
X-Received: by 2002:a37:b707:: with SMTP id h7mr5174672qkf.69.1569006419906;
        Fri, 20 Sep 2019 12:06:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.65.7.29])
        by smtp.gmail.com with ESMTPSA id o38sm1882682qtc.39.2019.09.20.12.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 12:06:59 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 690D040340; Fri, 20 Sep 2019 16:06:56 -0300 (-03)
Date:   Fri, 20 Sep 2019 16:06:56 -0300
To:     Roy Ben Shlomo <royb@sentinelone.com>
Cc:     Roy Ben Shlomo <roy.benshlomo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: fixing several typos in comments
Message-ID: <20190920190656.GH4865@kernel.org>
References: <20190920171254.31373-1-royb@sentinelone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920171254.31373-1-royb@sentinelone.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 20, 2019 at 08:12:53PM +0300, Roy Ben Shlomo escreveu:
> From: Roy Ben Shlomo <roy.benshlomo@gmail.com>

Thanks, applied.

- Arnaldo
 
> Fixing typos in a few functions' documentation comments
> Signed-off-by: Roy Ben Shlomo <royb@sentinelone.com>
> ---
>  kernel/events/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4f08b17d6426..275eae05af20 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2239,7 +2239,7 @@ static void __perf_event_disable(struct perf_event *event,
>   *
>   * If event->ctx is a cloned context, callers must make sure that
>   * every task struct that event->ctx->task could possibly point to
> - * remains valid.  This condition is satisifed when called through
> + * remains valid.  This condition is satisfied when called through
>   * perf_event_for_each_child or perf_event_for_each because they
>   * hold the top-level event's child_mutex, so any descendant that
>   * goes to exit will block in perf_event_exit_event().
> @@ -6054,7 +6054,7 @@ static void perf_sample_regs_intr(struct perf_regs *regs_intr,
>   * Get remaining task size from user stack pointer.
>   *
>   * It'd be better to take stack vma map and limit this more
> - * precisly, but there's no way to get it safely under interrupt,
> + * precisely, but there's no way to get it safely under interrupt,
>   * so using TASK_SIZE as limit.
>   */
>  static u64 perf_ustack_task_size(struct pt_regs *regs)
> @@ -6616,7 +6616,7 @@ void perf_prepare_sample(struct perf_event_header *header,
>  
>  	if (sample_type & PERF_SAMPLE_STACK_USER) {
>  		/*
> -		 * Either we need PERF_SAMPLE_STACK_USER bit to be allways
> +		 * Either we need PERF_SAMPLE_STACK_USER bit to be always
>  		 * processed as the last one or have additional check added
>  		 * in case new sample type is added, because we could eat
>  		 * up the rest of the sample size.
> -- 
> 2.20.1

-- 

- Arnaldo
