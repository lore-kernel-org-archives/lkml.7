Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DC9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005F421872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502758AbfJYR0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:26:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29899 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388862AbfJYR0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:26:08 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 534CBC057EC6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 17:26:07 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id s9so1582811wrw.23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=40gRyfBb4ps5SH5tASPj5Wk8vxcVXH98oDEoIsITulQ=;
        b=Iq8p9lSq514zu0mqD4Lm1rPAn8blJg2n+9Ik3K45ZyvQCsD6XG5/hLbcR9tlHIf7ez
         5GMf0fDUclk8MO/uWSqKxtuOLqD930T4CkpTORt4fjBUU2CR5YZg9Ss9YjO5fZTHshTa
         XHjIJd49zo/4zDPmCaY34RDz+YHAE4r/ykGPxLtXlvg039VAPg+wF+15mBHufQXoxuwM
         TBEHU7xII7rNyAg74XlFscQfB/coHwnF+dq2U9PbXhEOjx2TkoImdId0mY3QtD/snUY/
         sgYkYWaSg7hvKaoSRawF2uYWFgYGpDJeeibGS0QlxBTLrH5SNDXV8AEMk3NdPGgoYEDs
         q5CA==
X-Gm-Message-State: APjAAAUyA3B4ZKaNWKsJT2iuAn4uonlgpsfgXJRv56nqEotBFGLxbqbP
        hvdRb3kWQtDQKKScAGCY/TBXzx1VYj2lCk9nMfTT8QDjK5KIHRw9s5XHSJzS2kfpeJH9AFYiVZZ
        qcznKY6focHaiA0TQPOtmpzZO
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr4608865wmg.89.1572024366074;
        Fri, 25 Oct 2019 10:26:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxN6NZZxBLFYMg5YHl9+sqn9c0uaU2sjYqWfRCptqslqcRU1mKlyZb4SjVt3gCTKPUbIwuexA==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr4608851wmg.89.1572024365828;
        Fri, 25 Oct 2019 10:26:05 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.134])
        by smtp.gmail.com with ESMTPSA id z189sm3996981wmc.25.2019.10.25.10.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:26:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH v2] x86/hyper-v: micro-optimize send_ipi_one case
In-Reply-To: <DM5PR21MB013707183D9E271E60FBD435D7650@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191025131546.18794-1-vkuznets@redhat.com> <DM5PR21MB013707183D9E271E60FBD435D7650@DM5PR21MB0137.namprd21.prod.outlook.com>
Date:   Fri, 25 Oct 2019 19:26:03 +0200
Message-ID: <877e4sbutw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> 
>> When sending an IPI to a single CPU there is no need to deal with cpumasks.
>> With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
>> cycles) improvement with smp_call_function_single() loop benchmark. The
>> optimization, however, is tiny and straitforward. Also, send_ipi_one() is
>> important for PV spinlock kick.
>> 
>> I was also wondering if it would make sense to switch to using regular
>> APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CPU
>> cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
>> vector)).
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> Changes since v1:
>>  - Style changes [Roman, Joe]
>> ---
>>  arch/x86/hyperv/hv_apic.c           | 13 ++++++++++---
>>  arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
>>  2 files changed, 25 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
>> index e01078e93dd3..fd17c6341737 100644
>> --- a/arch/x86/hyperv/hv_apic.c
>> +++ b/arch/x86/hyperv/hv_apic.c
>> @@ -194,10 +194,17 @@ static bool __send_ipi_mask(const struct cpumask *mask, int
>> vector)
>> 
>>  static bool __send_ipi_one(int cpu, int vector)
>>  {
>> -	struct cpumask mask = CPU_MASK_NONE;
>> +	trace_hyperv_send_ipi_one(cpu, vector);
>> 
>> -	cpumask_set_cpu(cpu, &mask);
>> -	return __send_ipi_mask(&mask, vector);
>> +	if (!hv_hypercall_pg || (vector < HV_IPI_LOW_VECTOR) ||
>> +	    (vector > HV_IPI_HIGH_VECTOR))
>> +		return false;
>> +
>> +	if (cpu >= 64)
>> +		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
>
> The above test should be checking the VP number, not the CPU
> number,

Oops, of course, thanks for catching this! v3 is coming!

>  since the VP number is used to form the bitmap argument
> to the hypercall.  In all current implementations of Hyper-V, the CPU number
> and VP number are the same as far as I am aware, but that's not guaranteed in 
> the future.
>
> Michael
>
>> +
>> +	return !hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector,
>> +			       BIT_ULL(hv_cpu_number_to_vp_number(cpu)));
>>  }
>> 

-- 
Vitaly
