Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D2C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3556D2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfHUJbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:31:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726447AbfHUJbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:31:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B9D67FB12728DFC5AF07;
        Wed, 21 Aug 2019 17:31:45 +0800 (CST)
Received: from [127.0.0.1] (10.119.195.53) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 17:31:35 +0800
To:     <linux-kernel@vger.kernel.org>, <linux-audit@redhat.com>,
        <paul@paul-moore.com>, <eparis@redhat.com>
From:   Chen Wandun <chenwandun@huawei.com>
Subject: [Question] audit_names use after delete in audit_filter_inodes
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <4997df37-4a80-5cf5-effc-0a6f040c4528@huawei.com>
Date:   Wed, 21 Aug 2019 17:32:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.119.195.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Recently, I hit a use after delete in audit_filter_inodes,

In this case, I found audit_names->list->next is dead000000000100, when enumerate each
audit_names on list context->names_list.

void audit_filter_inodes(struct task_struct *tsk, struct audit_context *ctx)
{
         struct audit_names *n;

         if (audit_pid && tsk->tgid == audit_pid)
                 return;

         rcu_read_lock();

         list_for_each_entry(n, &ctx->names_list, list) {
                 if (audit_filter_inode_name(tsk, n, ctx))
                         break;
         }
         rcu_read_unlock();
}

it seem like the audit_names was already delete from context->names_list.

In source code, there is no any protection on context->names_list when read and write,
is there any race in read and write?

Unfortunately, there is no way to reproduce it.

the call stack is below:
[321315.077117] CPU: 6 PID: 8944 Comm: DefSch0100 Tainted: G           OE  ----V-------   3.10.0-327.62.59.83.w75.x86_64 #1
[321315.077117] Hardware name: OpenStack Foundation OpenStack Nova, BIOS rel-1.8.1-0-g4adadbd-20170107_142945-9_64_246_229 04/01/2014
[321315.113772] task: ffff8804061c4500 ti: ffff8804021d8000 task.ti: ffff8804021d8000
[321315.113772] RIP: 0010:[<ffffffff8110f038>]  [<ffffffff8110f038>] audit_filter_inodes+0x68/0x130
[321315.113772] RSP: 0018:ffff8804021dbef0  EFLAGS: 00010297
[321315.113772] RAX: ffff88040632aa48 RBX: ffff88040632a800 RCX: 000000000000000a
[321315.113772] RDX: 00000000000000c0 RSI: ffff88040632a800 RDI: ffff8804061c4500
[321315.132068] RBP: ffff8804021dbf40 R08: 0000000000000000 R09: 0000000000000000
[321315.132068] R10: 00007fd38197ac00 R11: 0000000000000206 R12: dead000000000100
[321315.132068] R13: ffff8804061c4500 R14: 00000000ffffffff R15: ffff88040632a800
[321315.132068] FS:  00007fd38197b700(0000) GS:ffff88053c380000(0000) knlGS:0000000000000000
[321315.132068] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[321315.132068] CR2: 00007fe48936d156 CR3: 0000000098b50000 CR4: 00000000001407e0
[321315.149373] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[321315.149373] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[321315.149373] Stack:
[321315.149373]  ffff88040632aa48 ffff8804061c4500 ffff8804021dbf78 ffffffff819a6260
[321315.149373]  00000000aefb5477 ffff88040632a800 00007fd3d6e80690 ffff8804061c4500
[321315.149373]  00007fd38197ac70 00007fd3f218d008 ffff8804021dbf78 ffffffff8110f7d5
[321315.149373] Call Trace:
[321315.149373]  [<ffffffff8110f7d5>] __audit_syscall_exit+0x245/0x280
[321315.149373]  [<ffffffff8165316b>] sysret_audit+0x17/0x21
[321315.149373] Code: 84 be 00 00 00 4d 8b a7 48 02 00 00 49 8d 87 48 02 00 00 48 89 45 b0 49 39 c4 0f 84 a3 00 00 00 41 be ff ff ff ff 0f 1f 44 00 00 <49> 8b 44 24 20 83 e0 1f 48 c1 e0 04 4c 8d a8 e0 5e df 81 48 8b
[321315.149373] RIP  [<ffffffff8110f038>] audit_filter_inodes+0x68/0x130
[321315.149373]  RSP <ffff8804021dbef0>
[321315.196242] ---[ end trace e1b43c8e59447f0a ]---

I am unfamiliar with audit. I will be appreciated if you could give me some suggestion.

Thanks
ChenWandun

