Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5E9C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7242087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfKHJsy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:48:54 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:42745 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730616AbfKHJsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:48:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xiejingfeng@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ThUhb-7_1573206530;
Received: from 30.5.113.47(mailfrom:xiejingfeng@linux.alibaba.com fp:SMTPD_---0ThUhb-7_1573206530)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Nov 2019 17:48:50 +0800
User-Agent: Microsoft-MacOutlook/10.1f.0.191103
Date:   Fri, 08 Nov 2019 17:49:01 +0800
Subject: Re: [PATCH] psi:fix divide by zero in psi_update_stats
From:   Jingfeng Xie <xiejingfeng@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <4BB2BD4E-96A9-42C5-9EEC-115CF69A0C1D@linux.alibaba.com>
Thread-Topic: [PATCH] psi:fix divide by zero in psi_update_stats
References: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
 <20191108093136.GI4114@hirez.programming.kicks-ass.net>
In-Reply-To: <20191108093136.GI4114@hirez.programming.kicks-ass.net>
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It happens multiple times on our online machines, the crash call trace is like below:
[58914.066423] divide error: 0000 [#1] SMP
[58914.070416] Modules linked in: ipmi_poweroff ipmi_watchdog toa overlay fuse tcp_diag inet_diag binfmt_misc aisqos(O) aisqos_hotfixes(O)
[58914.083158] CPU: 94 PID: 140364 Comm: kworker/94:2 Tainted: G W OE K 4.9.151-015.ali3000.alios7.x86_64 #1
[58914.093722] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.23.34 02/14/2019
[58914.102728] Workqueue: events psi_update_work
[58914.107258] task: ffff8879da83c280 task.stack: ffffc90059dcc000
[58914.113336] RIP: 0010:[] [] psi_update_stats+0x1c1/0x330
[58914.122183] RSP: 0018:ffffc90059dcfd60 EFLAGS: 00010246
[58914.127650] RAX: 0000000000000000 RBX: ffff8858fe98be50 RCX: 000000007744d640
[58914.134947] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00003594f700648e
[58914.142243] RBP: ffffc90059dcfdf8 R08: 0000359500000000 R09: 0000000000000000
[58914.149538] R10: 0000000000000000 R11: 0000000000000000 R12: 0000359500000000
[58914.156837] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8858fe98bd78
[58914.164136] FS: 0000000000000000(0000) GS:ffff887f7f380000(0000) knlGS:0000000000000000
[58914.172529] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[58914.178467] CR2: 00007f2240452090 CR3: 0000005d5d258000 CR4: 00000000007606f0
[58914.185765] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[58914.193061] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[58914.200360] PKRU: 55555554
[58914.203221] Stack:
[58914.205383] ffff8858fe98bd48 00000000000002f0 0000002e81036d09 ffffc90059dcfde8
[58914.213168] ffff8858fe98bec8 0000000000000000 0000000000000000 0000000000000000
[58914.220951] 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[58914.228734] Call Trace:
[58914.231337] [] psi_update_work+0x22/0x60
[58914.237067] [] process_one_work+0x189/0x420
[58914.243063] [] worker_thread+0x4e/0x4b0
[58914.248701] [] ? process_one_work+0x420/0x420
[58914.254869] [] kthread+0xe6/0x100
[58914.259994] [] ? kthread_park+0x60/0x60
[58914.265640] [] ret_from_fork+0x39/0x50
[58914.271193] Code: 41 29 c3 4d 39 dc 4d 0f 42 dc <49> f7 f1 48 8b 13 48 89 c7 48 c1
[58914.279691] RIP [] psi_update_stats+0x1c1/0x330
[58914.286053] RSP

With full kdump vmcore analysis,  The R8 is period in psi_update_stats which results in the zero division error.


﻿On 2019/11/8 PM 5:31，“Peter Zijlstra”<peterz@infradead.org> wrote:

    On Fri, Nov 08, 2019 at 03:33:24PM +0800, tim wrote:
    > In psi_update_stats, it is possible that period has value like
    > 0xXXXXXXXX00000000 where the lower 32 bit is 0, then it calls div_u64 which
    
    How can this happen? Is that a valid case or should we be avoiding that?
    


