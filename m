Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11677C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE05D2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="GPtbj+JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfCNP2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:28:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37783 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCNP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:28:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id c1so3581574qkk.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6DW0e1XXFCWjKZ79c+JqQQjJlUnakv2VsXmzF5K/ylA=;
        b=GPtbj+JYSXgGIPgd/5EGD7N9lg5h8rqZ1Vm43lKODe7b2YAzi2GLFhVKMsp3ZYiGkM
         1IcskULEoNs8cuNQ9+RspBJsnP+kfW42n/aT23Vonbbf1FL4e0WJvLgOUuCEDR9y1qVn
         pE1oeWRlKNvuaUtCs+s2vLQKMh+w3PHmjhLN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6DW0e1XXFCWjKZ79c+JqQQjJlUnakv2VsXmzF5K/ylA=;
        b=MZVOSv+GlHKg/ll3T+3Pq7kVDZWLAoVd7CACEZOJA7xC3FTAgfCw/UmqJY8RmdAD8J
         AiX+cEocX9jpGcw70IW1QfxNO9AIyNHu30zemIYyvjJc//Lc1eouypG18LkejbYk4r3Z
         lE6ecR5UEff2Uqahifvxbr7pDR85VSWDhdchBIaRBGGyE94pZX/W2deWkZeRNBd6w6YO
         YTLcq3OWGbVZ1akK8tOYXyl1CXmj9Gklcq9OCOrDq5a6sXnCNIDD7Tg25vLk5Ingpqtd
         VDPpB3Z00QHOMIefo5knjJeLzQWvvR6+mHK6HERiH+hswQDQiRE3LGkcSDEHSUhhz4A0
         dlDw==
X-Gm-Message-State: APjAAAU653yY6pq1rFaVRbMV2ixxc+4lreS/K/9xfgp75NvJmfy5776W
        h9RAuBcaNbive2f4IyOOWV/DfQ==
X-Google-Smtp-Source: APXvYqzvivw5kIAnNQxQZSuDuOYuef7Tu/PlDLzqWUhHsqfl80naK3vDa4bgS8trOxfGkdI6UAb6cg==
X-Received: by 2002:a37:9b46:: with SMTP id d67mr10866051qke.276.1552577324122;
        Thu, 14 Mar 2019 08:28:44 -0700 (PDT)
Received: from [192.168.1.240] (modemcable077.38-81-70.mc.videotron.ca. [70.81.38.77])
        by smtp.gmail.com with ESMTPSA id v19sm348727qkj.3.2019.03.14.08.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Mar 2019 08:28:43 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Date:   Thu, 14 Mar 2019 11:28:31 -0400
Message-Id: <1552577311-8218-1-git-send-email-jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190218165620.383905466@infradead.org>
References: <20190218165620.383905466@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 8:56 AM, Peter Zijlstra wrote:
> A much 'demanded' feature: core-scheduling :-(
>
> I still hate it with a passion, and that is part of why it took a little
> longer than 'promised'.
>
> While this one doesn't have all the 'features' of the previous (never
> published) version and isn't L1TF 'complete', I tend to like the structure
> better (relatively speaking: I hate it slightly less).
>
> This one is sched class agnostic and therefore, in principle, doesn't horribly
> wreck RT (in fact, RT could 'ab'use this by setting 'task->core_cookie = task'
> to force-idle siblings).
>
> Now, as hinted by that, there are semi sane reasons for actually having this.
> Various hardware features like Intel RDT - Memory Bandwidth Allocation, work
> per core (due to SMT fundamentally sharing caches) and therefore grouping
> related tasks on a core makes it more reliable.
>
> However; whichever way around you turn this cookie; it is expensive and nasty.

We are seeing this hard lockup within 1 hour of testing the patchset with 2
VMs using the core scheduler feature. Here is the full dmesg. We have the
kdump as well if more information is necessary.

[ 1989.647539] core sched enabled
[ 3353.211527] NMI: IOCK error (debug interrupt?) for reason 75 on CPU 0.
[ 3353.211528] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted
5.0-0.coresched-generic #1
[ 3353.211530] RIP: 0010:native_queued_spin_lock_slowpath+0x199/0x1e0
[ 3353.211532] Code: eb e8 c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 05 48 63 f6
48 05 00 3a 02 00 48 03 04 f5 20 48 bb a6 48 89 10 8b 42 08 85 c0 75 09 <f3>
90 8b 42 08 85 c0 74 f7 48 8b 32 48 85 f6 74 8e 0f 18 0e eb 8f
[ 3353.211533] RSP: 0018:ffff97ba3f603e18 EFLAGS: 00000046
[ 3353.211535] RAX: 0000000000000000 RBX: 0000000000000202 RCX:
0000000000040000
[ 3353.211535] RDX: ffff97ba3f623a00 RSI: 0000000000000007 RDI:
ffff97dabf822d40
[ 3353.211536] RBP: ffff97ba3f603e18 R08: 0000000000040000 R09:
0000000000018499
[ 3353.211537] R10: 0000000000000001 R11: 0000000000000000 R12:
0000000000000001
[ 3353.211538] R13: ffffffffa7340740 R14: 000000000000000c R15:
000000000000000c
[ 3353.211539] FS:  0000000000000000(0000) GS:ffff97ba3f600000(0000)
knlGS:0000000000000000
[ 3353.211544] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3353.211545] CR2: 00007efeac310004 CR3: 0000001bf4c0e002 CR4:
00000000001626f0
[ 3353.211546] Call Trace:
[ 3353.211546]  <IRQ>
[ 3353.211547]  _raw_spin_lock_irqsave+0x35/0x40
[ 3353.211548]  update_blocked_averages+0x35/0x5d0
[ 3353.211549]  ? rebalance_domains+0x180/0x2c0
[ 3353.211549]  update_nohz_stats+0x48/0x60
[ 3353.211550]  _nohz_idle_balance+0xdf/0x290
[ 3353.211551]  run_rebalance_domains+0x97/0xa0
[ 3353.211551]  __do_softirq+0xe4/0x2f3
[ 3353.211552]  irq_exit+0xb6/0xc0
[ 3353.211553]  scheduler_ipi+0xe4/0x130
[ 3353.211553]  smp_reschedule_interrupt+0x39/0xe0
[ 3353.211554]  reschedule_interrupt+0xf/0x20
[ 3353.211555]  </IRQ>
[ 3353.211556] RIP: 0010:cpuidle_enter_state+0xbc/0x440
[ 3353.211557] Code: ff e8 d8 dd 86 ff 80 7d d3 00 74 17 9c 58 0f 1f 44 00
00 f6 c4 02 0f 85 54 03 00 00 31 ff e8 eb 1d 8d ff fb 66 0f 1f 44 00 00 <45>
85 f6 0f 88 1a 03 00 00 4c 2b 6d c8 48 ba cf f7 53 e3 a5 9b c4
[ 3353.211558] RSP: 0018:ffffffffa6e03df8 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff02
[ 3353.211560] RAX: ffff97ba3f622d40 RBX: ffffffffa6f545e0 RCX:
000000000000001f
[ 3353.211561] RDX: 0000024c9b7d936c RSI: 0000000047318912 RDI:
0000000000000000
[ 3353.211562] RBP: ffffffffa6e03e38 R08: 0000000000000002 R09:
0000000000022600
[ 3353.211562] R10: ffffffffa6e03dc8 R11: 00000000000002dc R12:
ffffd6c67f602968
[ 3353.211563] R13: 0000024c9b7d936c R14: 0000000000000004 R15:
ffffffffa6f54760
[ 3353.211564]  ? cpuidle_enter_state+0x98/0x440
[ 3353.211565]  cpuidle_enter+0x17/0x20
[ 3353.211565]  call_cpuidle+0x23/0x40
[ 3353.211566]  do_idle+0x204/0x280
[ 3353.211567]  cpu_startup_entry+0x1d/0x20
[ 3353.211567]  rest_init+0xae/0xb0
[ 3353.211568]  arch_call_rest_init+0xe/0x1b
[ 3353.211569]  start_kernel+0x4f5/0x516
[ 3353.211569]  x86_64_start_reservations+0x24/0x26
[ 3353.211570]  x86_64_start_kernel+0x74/0x77
[ 3353.211571]  secondary_startup_64+0xa4/0xb0
[ 3353.211571] Kernel panic - not syncing: NMI IOCK error: Not continuing
[ 3353.211572] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted
5.0-0.coresched-generic #1
[ 3353.211574] Call Trace:
[ 3353.211575]  <NMI>
[ 3353.211575]  dump_stack+0x63/0x85
[ 3353.211576]  panic+0xfe/0x2a4
[ 3353.211576]  nmi_panic+0x39/0x40
[ 3353.211577]  io_check_error+0x92/0xa0
[ 3353.211578]  default_do_nmi+0x9e/0x110
[ 3353.211578]  do_nmi+0x119/0x180
[ 3353.211579]  end_repeat_nmi+0x16/0x50
[ 3353.211580] RIP: 0010:native_queued_spin_lock_slowpath+0x199/0x1e0
[ 3353.211581] Code: eb e8 c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 05 48 63 f6
48 05 00 3a 02 00 48 03 04 f5 20 48 bb a6 48 89 10 8b 42 08 85 c0 75 09 <f3>
90 8b 42 08 85 c0 74 f7 48 8b 32 48 85 f6 74 8e 0f 18 0e eb 8f
[ 3353.211582] RSP: 0018:ffff97ba3f603e18 EFLAGS: 00000046
[ 3353.211583] RAX: 0000000000000000 RBX: 0000000000000202 RCX:
0000000000040000
[ 3353.211584] RDX: ffff97ba3f623a00 RSI: 0000000000000007 RDI:
ffff97dabf822d40
[ 3353.211585] RBP: ffff97ba3f603e18 R08: 0000000000040000 R09:
0000000000018499
[ 3353.211586] R10: 0000000000000001 R11: 0000000000000000 R12:
0000000000000001
[ 3353.211587] R13: ffffffffa7340740 R14: 000000000000000c R15:
000000000000000c
[ 3353.211587]  ? native_queued_spin_lock_slowpath+0x199/0x1e0
[ 3353.211588]  ? native_queued_spin_lock_slowpath+0x199/0x1e0
[ 3353.211589]  </NMI>
[ 3353.211589]  <IRQ>
[ 3353.211590]  _raw_spin_lock_irqsave+0x35/0x40
[ 3353.211591]  update_blocked_averages+0x35/0x5d0
[ 3353.211591]  ? rebalance_domains+0x180/0x2c0
[ 3353.211592]  update_nohz_stats+0x48/0x60
[ 3353.211593]  _nohz_idle_balance+0xdf/0x290
[ 3353.211593]  run_rebalance_domains+0x97/0xa0
[ 3353.211594]  __do_softirq+0xe4/0x2f3
[ 3353.211595]  irq_exit+0xb6/0xc0
[ 3353.211595]  scheduler_ipi+0xe4/0x130
[ 3353.211596]  smp_reschedule_interrupt+0x39/0xe0
[ 3353.211597]  reschedule_interrupt+0xf/0x20
[ 3353.211597]  </IRQ>
[ 3353.211598] RIP: 0010:cpuidle_enter_state+0xbc/0x440
[ 3353.211599] Code: ff e8 d8 dd 86 ff 80 7d d3 00 74 17 9c 58 0f 1f 44 00
00 f6 c4 02 0f 85 54 03 00 00 31 ff e8 eb 1d 8d ff fb 66 0f 1f 44 00 00 <45>
85 f6 0f 88 1a 03 00 00 4c 2b 6d c8 48 ba cf f7 53 e3 a5 9b c4
[ 3353.211600] RSP: 0018:ffffffffa6e03df8 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff02
[ 3353.211602] RAX: ffff97ba3f622d40 RBX: ffffffffa6f545e0 RCX:
000000000000001f
[ 3353.211603] RDX: 0000024c9b7d936c RSI: 0000000047318912 RDI:
0000000000000000
[ 3353.211603] RBP: ffffffffa6e03e38 R08: 0000000000000002 R09:
0000000000022600
[ 3353.211604] R10: ffffffffa6e03dc8 R11: 00000000000002dc R12:
ffffd6c67f602968
[ 3353.211605] R13: 0000024c9b7d936c R14: 0000000000000004 R15:
ffffffffa6f54760
[ 3353.211606]  ? cpuidle_enter_state+0x98/0x440
[ 3353.211607]  cpuidle_enter+0x17/0x20
[ 3353.211607]  call_cpuidle+0x23/0x40
[ 3353.211608]  do_idle+0x204/0x280
[ 3353.211609]  cpu_startup_entry+0x1d/0x20
[ 3353.211609]  rest_init+0xae/0xb0
[ 3353.211610]  arch_call_rest_init+0xe/0x1b
[ 3353.211611]  start_kernel+0x4f5/0x516
[ 3353.211611]  x86_64_start_reservations+0x24/0x26
[ 3353.211612]  x86_64_start_kernel+0x74/0x77
[ 3353.211613]  secondary_startup_64+0xa4/0xb0

