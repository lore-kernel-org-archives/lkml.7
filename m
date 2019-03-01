Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8384BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548A42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOOi7xqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfCAWRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:17:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45112 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCAWRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:17:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id r14so12098031pls.12;
        Fri, 01 Mar 2019 14:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cpycp2Sh95C4wqU8MRRKTO3KivBo2LtrfQuXil6DXU0=;
        b=NOOi7xqpi21TC0E7ALf0ZvCwFuh9Rq3JmXUhqZQsMknz9U9cLwtVsOnKMGPJjfyywZ
         TTLp4N6VMvKeLt+M4NZUxtclA5k83XyqFcG1UZ5xPEVf7oTEkvTpV4ffl8Tw3K7dpmFg
         rpNajQ9yRstFV5iuUGx8Tnqlu/p2+UNuKFBUD+y3siRBQguB++frR3InrugayCPsOU7k
         y2rA3Gj8enkWvirNZ7A9GPMGDLztrmyLC/Kei13ZV9liV7tvu6Cu88pH6fyOZkyHwOYO
         67uji0eDGd5gpRR06PoaYErSJdTqoBRUK2etGNBNumwk5ZgEmEsJb9YZLsGZYfV5Shue
         0g3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cpycp2Sh95C4wqU8MRRKTO3KivBo2LtrfQuXil6DXU0=;
        b=PcOS0CEC1SS7mTuZLgua34K/u1gQlKjliXL8c2edbl80xDDmpdDZDXbhTlq3ljn+KC
         VSkSfp86kFI+uz89zDxx3lELOniKgzvNdlvstZn9z5INrooRE8Kh6c45dM70Yws3qZZq
         B7aqg9F91r9TvEGdhibLvES/jdDnvvn8cFm5N7N/v3N8SGtgI95qD0Vo2shhhNgTrHNb
         8E8yl7fZDA4NAWqDcB+yEPzE3q3BpCdKVMK4N3fgXv/5LheEUPkWm4WHAMCUQxgwdNj4
         Q/efuqsGSoHF3XSiYD7HrbjW4N2cOGle0b2hndKNdC5hKcMbYHtcCDnl8kbh/e0ZzRsF
         R6CQ==
X-Gm-Message-State: APjAAAWDE4jDdF2lvOqHBR9z2gTOvK0i+Le3gAaD1aWEcZ1w7YSSrrTg
        WeSaZv3hReovj2HriqZ1sKi5c93W
X-Google-Smtp-Source: APXvYqwq1zF0VVm/ayheptRE5rsC/9rWVqXZJM5LxqVPAmbAehG19URBsTLVl4JVpK+UL3lPUE8DrA==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr8018404plk.282.1551478654468;
        Fri, 01 Mar 2019 14:17:34 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id v6sm32404909pgb.2.2019.03.01.14.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 14:17:33 -0800 (PST)
Subject: Re: [PATCH] bpf: enable program stats
To:     Guenter Roeck <linux@roeck-us.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190301220323.GA13770@roeck-us.net>
From:   Eric Dumazet <erdnetdev@gmail.com>
Message-ID: <4b40a893-7385-915b-378c-ad10c015780f@gmail.com>
Date:   Fri, 1 Mar 2019 14:17:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190301220323.GA13770@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2019 02:03 PM, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Feb 25, 2019 at 02:28:39PM -0800, Alexei Starovoitov wrote:
>> JITed BPF programs are indistinguishable from kernel functions, but unlike
>> kernel code BPF code can be changed often.
>> Typical approach of "perf record" + "perf report" profiling and tuning of
>> kernel code works just as well for BPF programs, but kernel code doesn't
>> need to be monitored whereas BPF programs do.
>> Users load and run large amount of BPF programs.
>> These BPF stats allow tools monitor the usage of BPF on the server.
>> The monitoring tools will turn sysctl kernel.bpf_stats_enabled
>> on and off for few seconds to sample average cost of the programs.
>> Aggregated data over hours and days will provide an insight into cost of BPF
>> and alarms can trigger in case given program suddenly gets more expensive.
>>
>> The cost of two sched_clock() per program invocation adds ~20 nsec.
>> Fast BPF progs (like selftests/bpf/progs/test_pkt_access.c) will slow down
>> from ~10 nsec to ~30 nsec.
>> static_key minimizes the cost of the stats collection.
>> There is no measurable difference before/after this patch
>> with kernel.bpf_stats_enabled=0
>>
> 
> This patch causes my qemu tests for 'parisc' to crash. Reverting this patch
> as well as "bpf: expose program stats via bpf_prog_info" fixes the problem.
> 
> Crash log and bisect results are attached. Bisect ends with the merge;
> I identified the two patches manually.
> 
> I suspect that
> 	prog->aux->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
> 	...
> 	u64_stats_init(&prog->aux->stats->syncp);
> may be wrong. At the very least it looks odd, and I don't find a similar use
> of u64_stats_init() anywhere else in the kernel.

Yes, a loop is needed there.

Something like :

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1c14c347f3cfe1f7c0cf8a7eccff8135b16df81f..3f08c257858e1570339cd64a6351824bcc332ee3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -109,6 +109,7 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 {
        gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
        struct bpf_prog *prog;
+       int cpu;
 
        prog = bpf_prog_alloc_no_stats(size, gfp_extra_flags);
        if (!prog)
@@ -121,7 +122,12 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
                return NULL;
        }
 
-       u64_stats_init(&prog->aux->stats->syncp);
+       for_each_possible_cpu(cpu) {
+               struct bpf_prog_stats *pstats;
+
+               pstats = per_cpu_ptr(prog->aux->stats, cpu);
+               u64_stats_init(&pstats->syncp);
+       }
        return prog;
 }
 EXPORT_SYMBOL_GPL(bpf_prog_alloc);

