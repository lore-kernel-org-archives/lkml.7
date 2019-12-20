Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1A5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5D624679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Hk/RPTpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfLTIwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:52:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38491 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfLTIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:52:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id k8so9185046ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 00:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJ3lk8Uariqmq37DApYgBvr7+eUfRAGIy1QSR0W54j0=;
        b=Hk/RPTpx//p4v2hUzvG+2OOnvygI7UXjQ9GbryxEf+Lh4VSwZ0yGK6uPkEK+ElOfhB
         Qje/hqDv/1U9wKlx9Fd0JSK6I8q8K4Zve+j5qE8CV7FckQsPJOrH64zMYVj5lNv6UcJs
         29qBQX22pGq2w1wRZIba9+QM6eZM91nBdFgVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJ3lk8Uariqmq37DApYgBvr7+eUfRAGIy1QSR0W54j0=;
        b=BKCsEm9Sw3yeqtddtePXpSItVDJfYagI7ojzJ+CMyM47AUqDyc4ckrznRv/XljZedb
         AAZzQdAs63hNmGz0wp1hoiCBQLncCWqMUz6CyF1k+rdBcwTqTUDfaNBge0kApU7GlnKm
         IN2z9fwGXrfSEsPY3LVadXS/YerXYnbmynuUwtQdeDtjVqpNgk2rftzgazyaCYu9qdN2
         TqybM6xE0Eb2fW6kipqpaHcOfGbVqeiRxARWcmPVPeEZjS9cqywwUsyOVOqjX1KLbj51
         UVwLrpsFprSGvW/UkHkgf1Dv1FRciQMbksSIrGsb20C6Pbxq8n7RFLjiH1v4mJAzfXqq
         oaaw==
X-Gm-Message-State: APjAAAUi3WrWMTUjygyZlopc6beFEkalhmFOCYGNsAA5Id9aYfa1LAFn
        THFOJT7gzl9JFrPiSWPVV+U1XQ==
X-Google-Smtp-Source: APXvYqwWM8ZKaMydz5uoa8ssQ4lrRkP37MezeQmWz5W2b3HHxn+5HcX5uG3Ix9hD/zH97ItSXxuk7g==
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr1432644ljk.51.1576831953303;
        Fri, 20 Dec 2019 00:52:33 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r26sm3645912lfm.82.2019.12.20.00.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 00:52:32 -0800 (PST)
Subject: Re: [RFC][PATCH 2/4] sched: Have sched_class_highest define by
 vmlinux.lds.h
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
 <20191219214558.682913590@goodmis.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <92b43ea2-6d21-fe5e-239a-c45d3484ada4@rasmusvillemoes.dk>
Date:   Fri, 20 Dec 2019 09:52:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191219214558.682913590@goodmis.org>
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
> Now that the sched_class descriptors are defined by the linker script, and
> this needs to be aware of the existance of stop_sched_class when SMP is
> enabled or not, as it is used as the "highest" priority when defined. Move
> the declaration of sched_class_highest to the same location in the linker
> script that inserts stop_sched_class, and this will also make it easier to
> see what should be defined as the highest class, as this linker script
> location defines the priorities as well.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
>  kernel/sched/sched.h              |  9 +++------
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 772d961c69a5..1c14c4ddf785 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -109,9 +109,16 @@
>  #endif
>  
>  #ifdef CONFIG_SMP
> -#define STOP_SCHED_CLASS	*(__stop_sched_class)
> +#define STOP_SCHED_CLASS		\
> +	STRUCT_ALIGN();			\
> +	sched_class_highest = .;	\
> +	*(__stop_sched_class)
> +#define BEFORE_DL_SCHED_CLASS
>  #else
>  #define STOP_SCHED_CLASS
> +#define BEFORE_DL_SCHED_CLASS		\
> +	STRUCT_ALIGN();			\
> +	sched_class_highest = .;
>  #endif
>  
>  /*
> @@ -120,9 +127,11 @@
>   * relation to each other.
>   */
>  #define SCHED_DATA				\
> +	STRUCT_ALIGN();				\
>  	*(__idle_sched_class)			\
>  	*(__fair_sched_class)			\
>  	*(__rt_sched_class)			\
> +	BEFORE_DL_SCHED_CLASS			\
>  	*(__dl_sched_class)			\
>  	STOP_SCHED_CLASS

If you reverse the ordering so the highest sched class comes first, this
can just be

sched_class_highest = .
STOP_SCHED_CLASS
*(__dl_sched_class)
...
*(__idle_sched_class)
__end_sched_classes = .

and this from patch 3/4

 #define for_class_range(class, _from, _to) \
-	for (class = (_from); class != (_to); class = class->next)
+	for (class = (_from); class > (_to); class--)

 #define for_each_class(class) \
-	for_class_range(class, &sched_class_highest, NULL)
+	for_class_range(class, &sched_class_highest, (&__start_sched_classes) - 1)

can instead become

+ for (class = (_from); class < (_to); class++)

and

+ for_class_range(class, &sched_class_highest, &__end_sched_classes)

which seem somewhat more readable.

And actually, I don't think you need the STOP_SCHED_CLASS define at all
- in non-SMP, no object file has a __stop_sched_class section, so
including *(__stop_sched_class) unconditionally will DTRT. (BTW, it's a
bit confusing that stop_task.o is compiled in if CONFIG_SMP, but
stop_task.c also has a #ifdef CONFIG_SMP).

Rasmus
