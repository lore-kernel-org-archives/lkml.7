Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF745C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8BC20651
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="gjK+L6uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfDCO7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:59:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41379 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfDCO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:59:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id o129so10315176qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=uTCBiYjyTG9rHs7JaQZ3NGLTJi0/3lqoE44fjzggmZs=;
        b=gjK+L6uBEUacclwAwrchXvl8dH3gbqg/VSC08h5RIWemEjKIQ8wohrkhc/hzLjfEa+
         xamBQgblKpDq1G7vXkXMJgNe6HNeyy2FlbCfKfAgBgEwVLqRW1U1l9tqL20B+xUqnvG/
         nkiBeDkXBdmNYDmXLaXEoRQE4HOc2FvHgUBUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=uTCBiYjyTG9rHs7JaQZ3NGLTJi0/3lqoE44fjzggmZs=;
        b=dw1QezCc16039XcXvfQBkRwIr8lXQOPqqkjujRDgoK1Z5XefEL5PJJQDKVZUUHzisX
         lUcxRAhUsPj5qoQi/WKvsV4s9LY+3XmbLQlBjpgB2Mg7eMqhgnfTt2J+DB6gs9gt4CdN
         5rTeQY9TVmcXHPOTTe9XV8As8Y4lavwfuv5YQC8J19WEEgMc8JPq8WQTK+VNHaQ0iqq5
         YHnwTbpOKmPSI3K4ZchO38Y+pmMKktrHzIhEMxMkTah6RyWqQgGphUvavjqKMTtF7YI/
         47awbOqr0/AD0xLl1PDCFpw+/G0lOKTPeCAHsX6c+hkbIomf5IiVmVdrQQxLZ8oPNZPL
         Y4Jw==
X-Gm-Message-State: APjAAAUcIObq9Unt7yrw7aB+IEqPHu6eWwDXMbxd3UPpT54BohNj1OcZ
        13yF5NYb0m2I49WL0NoDEqHH9A==
X-Google-Smtp-Source: APXvYqz5PKxd9DeOaTLLBVCRoOM5mvYql1shH2altkqnpblSYOErywYg9YY04K+DqKL8uQD3b6b92A==
X-Received: by 2002:ae9:eb0b:: with SMTP id b11mr411785qkg.214.1554303574365;
        Wed, 03 Apr 2019 07:59:34 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id n5sm8796863qkk.4.2019.04.03.07.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 07:59:33 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 3 Apr 2019 10:59:32 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: perf: perf_fuzzer crashes on Pentium 4 systems
Message-ID: <alpine.DEB.2.21.1904031043170.29188@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


so moving this to its own thread.

There was a two-part question asked.
	1. Can the perf-fuzzer crash a Pentium 4 system
	2. Does anyone care anymore?

The answer to #1 turns out to be "yes"
I'm not sure about #2 (but it's telling my p4 test system hadn't been 
turned on in over 3 years).

In any case the perf_fuzzer can crash my p4 system within an hour or so.  
The debugging from this isn't great, I forget what the preferred debug 
things to enable in the kernel hacking menu are.

Here is one crash that just happened:

The instruction at RIP is unhelpfully
	./arch/x86/include/asm/processor.h:400
which is
	DECLARE_PER_CPU_FIRST(union irq_stack_union, irq_stack_union) __visible;

Though looking at the assembly it looks like
	p4_pmu_enable_event() is called with NULL as the paramater.

[ 1930.122902] BUG: unable to handle kernel NULL pointer dereference at 0000000000000158
[ 1930.130715] #PF error: [normal kernel read fault]
[ 1930.135402] PGD 0 P4D 0 
[ 1930.137928] Oops: 0000 [#1] SMP PTI
[ 1930.141405] CPU: 0 PID: 30179 Comm: perf_fuzzer Tainted: G        W         5.1.0-rc3+ #6
[ 1930.149555] Hardware name: LENOVO 88088NU/LENOVO, BIOS 2JKT37AUS 07/12/2007
[ 1930.156497] RIP: 0010:p4_pmu_enable_event+0x10/0x160
[ 1930.161443] Code: 89 f0 0f 30 31 c0 8b 15 e6 2e 0f 01 85 d2 7f 01 c3 89 c2 89 cf e9 70 65 3b 00 0f 1f 44 00 00 41 56 41 55 41 54 49 89 fc 55 53 <48> 8b 9f 58 01 00 00 48 89 dd 48 89 da 48 c1 ed 20 48 c1 ea 3f 89
[ 1930.180155] RSP: 0018:ffffc90001f57d50 EFLAGS: 00010017
[ 1930.185361] RAX: 0000000000000000 RBX: 000000000000000c RCX: 0000000000000360
[ 1930.192472] RDX: 0000000000000000 RSI: 0000000000000400 RDI: 0000000000000000
[ 1930.199582] RBP: ffff88803e40f620 R08: 00000000ffffffff R09: 0000000c00000000
[ 1930.206691] R10: 4801fe0000fc0000 R11: 8000000fce030200 R12: 0000000000000000
[ 1930.213802] R13: ffff888035c4a0c0 R14: ffff88803e429300 R15: 0000000000000402
[ 1930.220913] FS:  00007ff3b934a540(0000) GS:ffff88803e400000(0000) knlGS:0000000000000000
[ 1930.228976] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1930.234700] CR2: 0000000000000158 CR3: 000000003a72e000 CR4: 00000000000007f0
[ 1930.241811] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1930.248921] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[ 1930.256030] Call Trace:
[ 1930.258472]  p4_pmu_enable_all+0x3c/0x50
[ 1930.262384]  __perf_event_task_sched_in+0x174/0x1a0
[ 1930.267247]  ? __switch_to_asm+0x34/0x70
[ 1930.271155]  ? __switch_to_asm+0x40/0x70
[ 1930.275064]  ? __switch_to_asm+0x34/0x70
[ 1930.278971]  ? __switch_to_asm+0x40/0x70
[ 1930.282882]  finish_task_switch+0x10a/0x290
[ 1930.287053]  __schedule+0x207/0x800
[ 1930.290530]  ? event_function_call+0x85/0x100
[ 1930.294873]  ? ctx_resched+0xc0/0xc0
[ 1930.298437]  preempt_schedule_common+0xa/0x20
[ 1930.302777]  _cond_resched+0x1d/0x30
[ 1930.306340]  mutex_lock+0xe/0x30
[ 1930.309558]  perf_event_ctx_lock_nested.isra.89+0x46/0x90
[ 1930.314939]  ? _perf_event_disable+0x40/0x40
[ 1930.319193]  perf_event_task_enable+0x3f/0xa0
[ 1930.323537]  __x64_sys_prctl+0x1b2/0x560
[ 1930.327448]  do_syscall_64+0x4f/0xf0
[ 1930.331011]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1930.336045] RIP: 0033:0x7ff3b928240a

