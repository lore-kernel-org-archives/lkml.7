Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A4FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A7F20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVkLBpL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDCTTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:19:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35096 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDCTTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:19:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id t4so15930190ljc.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 12:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1RxFl1rlgcdvv54vamWlsrxDybk3dbBPoWolgwn8RJ4=;
        b=FVkLBpL+815Qo+W0sM39wLykAtzXvimgcpO/3l8jev5VlqeRZhd/GXw9oQPOHKjQBo
         sUqqZTjNabyBJsMQxBhqdz2DFjnRRnNxYVFhZHWFlO31V8FhFtOfwhSV3wHeYcya0n0t
         BCcVWMwxZtFYdmq+oVjsyveFtr0Kis04hPcg/RsqK+psY/8+sBJoFmu1nwUqRQxqg9W0
         S7uWcVfizfkb9yKvy9qY1BopKlj/iv6iIyquKLAa1/2e0wsNBDwWFNZ05qzPjGmh6/9t
         H/tDYkhS2ZiXA+mPwM0YC+Ck4wE8TgBmAH4f6xMBVj5/xnPGAFR1L2MjUBXzLWR7HFAC
         IfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1RxFl1rlgcdvv54vamWlsrxDybk3dbBPoWolgwn8RJ4=;
        b=ba+v9OtoUsNhN7v/dYlCSHstWVY+h26sm3lA0tM3ZkaTAlGWuqmvt9RDK/JC3G1I2m
         KqC1G9T2tJKG41SQBs0cVLd3UtN2kFUv9Nftacg8qw0XnwGKfLVmukKzNqZ2fUqngGk/
         6meYSjbMfwCN3bFL9a6N/yKI1oorX+cTerrISc7tqLR5td2vkI+BS3kYnvBJlyLUn4jR
         R6kaJM985uzFwypWwyxJN7dTRsulmHOYdOiyoXZPpqCr/ayekfjV7xmCtBphOxWg0VUQ
         TQnOG3bvPErQsCMmJ8G547I4ce/KOyHPjVOmnJcm/IrD0VS8EOATa0vs7AIDhXIUNCPP
         uuxA==
X-Gm-Message-State: APjAAAX+IpxaAtz2HOnRV6FLCXUCBs2ofWeSKJYrrQny6E7wjxvh6EPg
        NhY+g87rQXy0njPhFRJS+W8=
X-Google-Smtp-Source: APXvYqxfsO2kVtsCrdBu9U8Be9Jz4KpB+I3UF34SmpHt31t8efJdLZvURbQKSOYj9JgVQs5AtSut1Q==
X-Received: by 2002:a2e:895a:: with SMTP id b26mr802114ljk.89.1554319186144;
        Wed, 03 Apr 2019 12:19:46 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id z8sm3472677ljc.50.2019.04.03.12.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 12:19:45 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id ADD4F46041D; Wed,  3 Apr 2019 22:19:44 +0300 (MSK)
Date:   Wed, 3 Apr 2019 22:19:44 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: perf: perf_fuzzer crashes on Pentium 4 systems
Message-ID: <20190403191944.GH1421@uranus.lan>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904031043170.29188@macbook-air>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:59:32AM -0400, Vince Weaver wrote:
> 
> so moving this to its own thread.
> 
> There was a two-part question asked.
> 	1. Can the perf-fuzzer crash a Pentium 4 system
> 	2. Does anyone care anymore?
> 
> The answer to #1 turns out to be "yes"
> I'm not sure about #2 (but it's telling my p4 test system hadn't been 
> turned on in over 3 years).
> 
> In any case the perf_fuzzer can crash my p4 system within an hour or so.  
> The debugging from this isn't great, I forget what the preferred debug 
> things to enable in the kernel hacking menu are.
> 
> Here is one crash that just happened:
> 
> The instruction at RIP is unhelpfully
> 	./arch/x86/include/asm/processor.h:400
> which is
> 	DECLARE_PER_CPU_FIRST(union irq_stack_union, irq_stack_union) __visible;
> 
> Though looking at the assembly it looks like
> 	p4_pmu_enable_event() is called with NULL as the paramater.
> 

You know, seems I got what happened -- p4_general_events do
not cover all general events, they stop at PERF_COUNT_HW_BUS_CYCLES,
while more 3 general event left. This is 'cause I've not been following
pmu evolution in code. I will try to cover this events hopefully more
less soon and send you a patch to test (if you don't mind).
