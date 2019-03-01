Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED82C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEE82083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+4rrtjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfCAWRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:17:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42841 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCAWRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:17:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so12046029pfi.9;
        Fri, 01 Mar 2019 14:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cpycp2Sh95C4wqU8MRRKTO3KivBo2LtrfQuXil6DXU0=;
        b=j+4rrtjjmkgdz7tpCe/F7GSWvRVCp538JnjGBElOro88v0RjdtG185X85eqOX4gRlQ
         Hh+n3qsflUTxLiDNNRu527BbdhPzY8N0ibv/dq/8I1yw8CNXd9iNe7EuoRW2fD3xWLN+
         3PC4U3HqmB4ZTXzpmmHlwyH4fdgW+85PVCJt7QsIlT1YUsdEoPqdJ2oyh1jX28MXAYz2
         Jqki+bzDJ+yWTQxtaWd3pEVoSh6wxNh2SRxKPP7jX5H/KvJ6HfdGknwMmohQwh14bZvR
         2fyL+GOaCEQ0UBLHRIiLHHaybSqFoEygP6fmxdnTXfsjGt3/ZJO2Ne5b8qiWZTr4m+RB
         obpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cpycp2Sh95C4wqU8MRRKTO3KivBo2LtrfQuXil6DXU0=;
        b=kMVP11aVxJnJR+9KcZdrQFoSWFLw5n7sBA8IHrgRvg+9KktAmw9HMofrgQOPhkxtBL
         jDpH6jCRuqwUOvp23XqonZ02TJHERa9mRJA54LchZN1MWKPV1OhmzayAh1mMiANjegp3
         J7pBw7eM5ErDqy/Ti+agUXVF99ZcYbyAldoMmfjtkECiV4G9rDJplR7xP4Krp3vei5Hk
         j/zVufqJHAlrQqzB4QzYPH+3yDCz4xcFRnadg7lAHzwFk7gL4s52srJjJLYuzbLlILeF
         nnO4B0bBtWFGHKLaV8les9gRBuphApBURST3CL6nM/bC2IbHV8t5Yty5qyZVz0UaDTB2
         8eDQ==
X-Gm-Message-State: APjAAAVcuAbWJ4NRa9pem3h9W4yQT8pqHSiv0+sMyaMnr+08uqp/oyDW
        yOdMLljQhN9gVq9N7oEArQaqNmO8
X-Google-Smtp-Source: APXvYqyAHcGoOfAPdNO4yU/5XHLgWTmX+Fq5VsUNmLquJa4l+xDEgPXF52vDhRjw4bCwpu7ILCGYbg==
X-Received: by 2002:a63:1a5d:: with SMTP id a29mr6602214pgm.369.1551478662715;
        Fri, 01 Mar 2019 14:17:42 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id l28sm29681680pfi.186.2019.03.01.14.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 14:17:41 -0800 (PST)
Subject: Re: [PATCH] bpf: enable program stats
To:     Guenter Roeck <linux@roeck-us.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190301220323.GA13770@roeck-us.net>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <47e1aa53-61c9-653e-3958-3e47082887d0@gmail.com>
Date:   Fri, 1 Mar 2019 14:17:40 -0800
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

