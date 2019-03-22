Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2415AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA28204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfCVUN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:13:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35342 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfCVUN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:13:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id z13so2004382qki.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 13:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3GVlQtUkOBzM0wtGS5EMCR1UzhxBjccrlpb4vEqZEkU=;
        b=m5HBWVT1I+8uCJp8o8inPJRaFAxT5N9XejSgHG5ZZoGtfESbUsip4lE3dGbk5cUr0u
         ZlzaWXmBqmzHhuYU1ZDLtBNbvKx1qlW+1L69L+DzGQjAIxo9LnBvTcdz9Ucc/mRyxdPE
         +iPy2q1OUus+HbrgKZOExIG3drQ4dWWVNRdzUCNXr4C69cMFidvRZObrzRHJhnWrtzBN
         Xfr/QZFhdlVae95A/g7AkRdl9YubD9hi+F8LYI2WPJfdX2wjAIikGRcHBKV5r5XnBntW
         d7a+WFAUhhLNzNHQRb0sRqY1cKcXDLZEHsZV0viV2dH/yMBJOyAEcJFFHeN5vVWAvQ3Z
         tcEg==
X-Gm-Message-State: APjAAAXC78ue6r18Q9zjaJCkzUcnx11rLBpfbe01vn81r5sfT2U3u1qC
        NHRMejB7L9r6GwFj3zmcmqcJmA==
X-Google-Smtp-Source: APXvYqwzUac+SDBZB/olBS2PKp60a32yDr0hpyBUOdAVetzLxH59C389evgLDbw/IpbGp6I71tHhCA==
X-Received: by 2002:ae9:f509:: with SMTP id o9mr9198639qkg.133.1553285637702;
        Fri, 22 Mar 2019 13:13:57 -0700 (PDT)
Received: from [10.150.73.190] (178.sub-174-227-146.myvzw.com. [174.227.146.178])
        by smtp.gmail.com with ESMTPSA id 92sm5508111qtc.97.2019.03.22.13.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 13:13:57 -0700 (PDT)
Subject: Re: [PATCH 2/4] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Carlos O'Donell <carlos@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com>
 <20190212194253.1951-3-mathieu.desnoyers@efficios.com>
From:   Carlos O'Donell <codonell@redhat.com>
Message-ID: <fc431a95-789a-6c02-13d0-d0d01916ee99@redhat.com>
Date:   Fri, 22 Mar 2019 16:13:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190212194253.1951-3-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 2:42 PM, Mathieu Desnoyers wrote:
> When available, use the cpu_id field from __rseq_abi on Linux to
> implement sched_getcpu(). Fall-back on the vgetcpu vDSO if unavailable.
> 
> Benchmarks:
> 
> x86-64: Intel E5-2630 v3@2.40GHz, 16-core, hyperthreading

This patch looks good to me for master, but is blocked on patch 1/4
being reworked.

Reviewed-by: Carlos O'Donell <carlos@redhat.com>

> glibc sched_getcpu():                     13.7 ns (baseline)
> glibc sched_getcpu() using rseq:           2.5 ns (speedup:  5.5x)
> inline load cpuid from __rseq_abi TLS:     0.8 ns (speedup: 17.1x)
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Carlos O'Donell <carlos@redhat.com>
> CC: Florian Weimer <fweimer@redhat.com>
> CC: Joseph Myers <joseph@codesourcery.com>
> CC: Szabolcs Nagy <szabolcs.nagy@arm.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ben Maurer <bmaurer@fb.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Dave Watson <davejwatson@fb.com>
> CC: Paul Turner <pjt@google.com>
> CC: libc-alpha@sourceware.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-api@vger.kernel.org
> ---
>   sysdeps/unix/sysv/linux/sched_getcpu.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/sysdeps/unix/sysv/linux/sched_getcpu.c b/sysdeps/unix/sysv/linux/sched_getcpu.c
> index fb0d317f83..8bfb03778b 100644
> --- a/sysdeps/unix/sysv/linux/sched_getcpu.c
> +++ b/sysdeps/unix/sysv/linux/sched_getcpu.c
> @@ -24,8 +24,8 @@
>   #endif
>   #include <sysdep-vdso.h>
>   
> -int
> -sched_getcpu (void)
> +static int
> +vsyscall_sched_getcpu (void)

OK.

>   {
>   #ifdef __NR_getcpu
>     unsigned int cpu;
> @@ -37,3 +37,24 @@ sched_getcpu (void)
>     return -1;
>   #endif
>   }
> +
> +#ifdef __NR_rseq
> +#include <linux/rseq.h>
> +
> +extern __attribute__ ((tls_model ("initial-exec")))
> +__thread volatile struct rseq __rseq_abi;

OK.

> +
> +int
> +sched_getcpu (void)
> +{
> +  int cpu_id = __rseq_abi.cpu_id;
> +
> +  return cpu_id >= 0 ? cpu_id : vsyscall_sched_getcpu ();

OK. Impressive :-)

> +}
> +#else
> +int
> +sched_getcpu (void)
> +{
> +  return vsyscall_sched_getcpu ();

OK.

> +}
> +#endif
> 


-- 
Cheers,
Carlos.
