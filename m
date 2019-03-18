Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C4220854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfCRLfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:35:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbfCRLfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:35:30 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9C7A56BF594085F13FCB;
        Mon, 18 Mar 2019 19:35:27 +0800 (CST)
Received: from [127.0.0.1] (10.57.123.83) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Mar 2019
 19:35:18 +0800
Subject: Re: [PATCH] futex:fix robust futex alignment exception
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1552621478-119787-1-git-send-email-chenjie6@huawei.com>
 <20190315084131.GS5996@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903171534590.9068@nanos.tec.linutronix.de>
 <20190318104852.GL6058@hirez.programming.kicks-ass.net>
CC:     <linux-kernel@vger.kernel.org>, <dvhart@infradead.org>,
        <mingo@redhat.com>, <zengweilin@huawei.com>
From:   "Chenjie (K)" <chenjie6@huawei.com>
Message-ID: <5C8F8276.2040807@huawei.com>
Date:   Mon, 18 Mar 2019 19:35:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190318104852.GL6058@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.123.83]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test case:

#include <stdio.h>
#include <linux/futex.h>
#include <syscall.h>
#include <unistd.h>
  #include <stdlib.h>

int main()
{
	char *p = malloc(128);

	struct robust_list_head *ro1;
	struct robust_list *entry;
	struct robust_list *pending;

	int ret = 0;

	pid_t pid = getpid();
	
	printf("p %p  pid [%d] \n", p, pid);

	ro1 = p;
	entry = p + 20;
	pending = p + 40;

	ro1->list.next = entry;
	ro1->list_op_pending = pending;

	entry->next = &(ro1->list);

	ro1->futex_offset = 41;

	*((int *)((char *)entry + 41)) = pid;

	printf(" entry + offert [%p] [%d] \n",  (int *)((char *)entry + 41), 
*((int *)((char *)entry + 41)));

	ret = syscall(SYS_set_robust_list, ro1, 12);

	printf("ret = [%d]\n", ret);


	return 0;
}

and we test it on arm a9 platform

Alignment trap: not handling instruction e191ef9f at [<c018cf5c>]
Unhandled fault: alignment exception (0x011) at 0x01b1218d
pgd = c3b50000
[01b1218d] *pgd=843c8831, *pte=b831d75f, *ppte=b831dc7f
Internal error: : 11 [#1] SMP ARM
Modules linked in: nfsv3 veth(O) ping(O) nand mtdblock mtd_blkdevs 
nand_ecc nand_ids gmac(O) pramdisk(O) rtos_kbox_panic(O) 
rtos_snapshot(O) double_cluster(O) uart_suspend(O) rsm(O) 
follow_huge_pfn(O) cache_ops(O) nfsd auth_rpcgss exportfs nfs_acl nfs 
lockd sunrpc oid_registry grace physmap cfi_cmdset_0002 cfi_probe 
cfi_util mtd gen_probe chipreg ohci_platform ehci_platform ohci_hcd 
ehci_hcd vfat fat sd_mod enable_uart_rx(O)
CPU: 1 PID: 786 Comm: set_robust_list Tainted: G        W  O    4.4.171 #3
Hardware name: Hisilicon A9
task: ef0045e8 task.stack: c3b68000
PC is at cmpxchg_futex_value_locked+0x48/0xac
LR is at 0x42b12190
pc : [<c018cf5c>]    lr : [<42b12190>]    psr: 60070213
sp : c3b69ed8  ip : fffffff2  fp : c05d9eeb
r10: ffffe000  r9 : ef0045e8  r8 : 00000000
r7 : 01b12178  r6 : 00000312  r5 : 01b1218d  r4 : ef0045e8
r3 : 40000000  r2 : 00000312  r1 : 01b1218d  r0 : c3b69ee0
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 1ac5387d  Table: 8455004a  DAC: 55555555
Process set_robust_list (pid: 786, stack limit = 0xc3b68210)
Stack: (0xc3b69ed8 to 0xc3b6a000)
9ec0:                                                       c080e2a8 
c018ff44
9ee0: 01b1218d dc8ba6ab 00000000 01b12164 01b12150 ef0045e8 01b12178 
01b12150
9f00: 00000000 00000029 01b12178 c01900dc 00000800 00000000 ffffe000 
00000000
9f20: ffffe000 ef0045e8 c2e6dc00 ffffe000 c2e6dc00 c01077a4 00000000 
000000f8
9f40: b6fa2e30 c011afd8 ef0045e8 c2e6dc00 dc8ba6ab ef0045e8 c2e6dc00 
ffffe000
9f60: ffffe000 c011f370 00000000 ef00486c ef00486c dc8ba6ab c38aed20 
ffffe000
9f80: b6fa2e30 c0120d44 00000000 b6fa1500 00000000 000000f8 c01077a4 
c0120e14
9fa0: b6fa1500 c0107790 b6fa1500 b6fa1500 00000000 00000000 0097fadd 
00000000
9fc0: b6fa1500 b6fa1500 00000000 000000f8 00000000 00000001 b6fa6120 
b6fa2e30
9fe0: 00000000 be80eb98 b6e8d4c8 b6efe53c 60070210 00000000 00000000 
00000000
[<c018cf5c>] (cmpxchg_futex_value_locked) from [<c018ff44>] 
(handle_futex_death+0xa8/0x110)
[<c018ff44>] (handle_futex_death) from [<c01900dc>] 
(exit_robust_list+0x130/0x1b4)
[<c01900dc>] (exit_robust_list) from [<c011afd8>] (mm_release+0x1c/0x13c)
[<c011afd8>] (mm_release) from [<c011f370>] (do_exit+0x240/0x9b8)
[<c011f370>] (do_exit) from [<c0120d44>] (do_group_exit+0x58/0x108)
[<c0120d44>] (do_group_exit) from [<c0120e14> (__wake_up_parent+0x0/0x18)
Code: 0c40a011 0900001a 5bf07ff5 00f091f5 (9fef91e1)


On 2019/3/18 18:48, Peter Zijlstra wrote:
> On Sun, Mar 17, 2019 at 03:36:35PM +0100, Thomas Gleixner wrote:
>> On Fri, 15 Mar 2019, Peter Zijlstra wrote:
>
>>> That is; why aren't there any alignment tests anywhere? Or am I just
>>> gone blind?
>>
>> uaddrs for the futex syscalls are checked in get_futex_key().
>
> blind it is...
>
> Thanks!
>
>

