Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4841AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEA02467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iURuX6qZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfLTMOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:14:32 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39622 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfLTMOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:14:31 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so6858499lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 04:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jPVyNWqL+ITge9L2kzbMz/pzKEvWPu4FEKVTIdRrZCE=;
        b=iURuX6qZppp+iPX9e771pUXhdzmwxnDr40Iu5TexRXdqYS4ME+Ld+jTn3KKLVQNvx6
         IK/G/M8laF4tJY3XI97htmegGe7Yby41dHiQo0WZEwe7okZYt+oTjzLp+ru/fiRLkU0V
         DGkki8xnMtLJetBAsM+7FNKUfjf58bsSBHru4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPVyNWqL+ITge9L2kzbMz/pzKEvWPu4FEKVTIdRrZCE=;
        b=JltjcDk6fR6josa6WsYUBu5azciQuqoH+yTKtFzo7gtYMkY0Q2EeClwwbNEHPJFmwo
         ORoI61JhkJKZpu1Q2WxVQA1sHTbWptlJf6CuDHf7osN1xEewasvGZggpC2ocol3k/J2J
         wjP3dl3H7aIBQHCToGa6ang0DwNPQXGhqXv5z5wuq6u0W2F6PxUR8vQJH3gNxZPKrMrj
         Upr6gKTZotGsTAsTLvb3sEcxUIcd12a3IVPQegra6sVmRBJg4md07g1/JWMvMBjyTi3H
         jFjYkct9TjOWcQE2FTa70wq5jkbztAX95TcnSi94tthjbOKe578E9KjilfG68U0YrhUS
         vfpw==
X-Gm-Message-State: APjAAAUrtnx5vq8UrItR+VQuXw9mqZfkCT59XG/+kaxUG+bwPfS92IHZ
        Vf8LFMfWlKdQj2WdjlconcdnXg==
X-Google-Smtp-Source: APXvYqyA6R53beHhAC2uRVmnMnxXhHfWRwwGjL881P01s+Vu+Pc0OpsGYA7+8a9l2wgireVha4GnVA==
X-Received: by 2002:ac2:5604:: with SMTP id v4mr8164615lfd.152.1576844069609;
        Fri, 20 Dec 2019 04:14:29 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y11sm4812652lfc.27.2019.12.20.04.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 04:14:29 -0800 (PST)
Subject: Re: [RFC][PATCH 3/4] sched: Remove struct sched_class next field
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <tkhai@yandex.ru>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191219214451.340746474@goodmis.org>
 <20191219214558.845353593@goodmis.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <62b3de43-7d36-4847-6c4b-b3e1dda62a70@rasmusvillemoes.dk>
Date:   Fri, 20 Dec 2019 13:14:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191219214558.845353593@goodmis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2019 22.44, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Now that the sched_class descriptors are defined in order via the linker
> script vmlinux.lds.h, there's no reason to have a "next" pointer to the
> previous priroity structure. The order of the sturctures can be aligned as
> an array, and used to index and find the next sched_class descriptor.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  kernel/sched/deadline.c           | 1 -
>  kernel/sched/fair.c               | 1 -
>  kernel/sched/idle.c               | 1 -
>  kernel/sched/rt.c                 | 1 -
>  kernel/sched/sched.h              | 6 +++---
>  kernel/sched/stop_task.c          | 1 -
>  7 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 1c14c4ddf785..f4d480c4f7c6 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -128,6 +128,7 @@
>   */
>  #define SCHED_DATA				\
>  	STRUCT_ALIGN();				\
> +	__start_sched_classes = .;		\
>  	*(__idle_sched_class)			\
>  	*(__fair_sched_class)			\
>  	*(__rt_sched_class)			\

This is broken. It works by accident on a 64 bit SMP config, since you
start at a 32 byte boundary, then include four 8-byte aligned structs,
so the second STRUCT_ALIGN (not visible in this hunk, but comes from the
STOP_SCHED_CLASS) is a no-op, and stop_sched_class ends up at the right
offset from the previous one.

But, for example, a 32 bit non-smp kernel with CONFIG_FAIR_GROUP_SCHED=y
has sizeof(struct sched_class) == 68, and

$ nm -n vmlinux | grep sched_class
c0728660 D idle_sched_class
c0728660 D __start_sched_classes
c07286a4 D fair_sched_class
c07286e8 D rt_sched_class
c0728740 D dl_sched_class
c0728740 D sched_class_highest

notice dl_sched_class is 88 bytes beyond rt_sched_class, while the
others are properly 68-byte separated.

So just drop the second STRUCT_ALIGN (and maybe the first as well).
Maybe throw in some ASSERTs in the linker script, but since the linker
doesn't know sizeof(struct sched_class), the best one can do is perhaps
some kind of ASSERT(fair_sched_class - idle_sched_class ==
rt_sched_class - fair_sched_class). And/or include a BUG_ON that checks
that the sched_class elements actually constitute a proper "struct
sched_class[]" array.

Rasmus
