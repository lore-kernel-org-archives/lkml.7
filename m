Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D532C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE012173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RdOyLv9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfGPVyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:54:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41166 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfGPVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:54:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GL9BqI057881;
        Tue, 16 Jul 2019 21:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=GhKB1nnxMUgPdfaQmokZ35zm3j1TuKb+1GyYdjVaC38=;
 b=RdOyLv9AMoYSwfFK98/rrL7ysYefjMMgMYrN8M9MqTU+DnhRPx/4tyRRbth2o6uB98L4
 cf2yWCtECWwDMw3T7NZz+RLmovslxd1GlH+AJdNg8WKQ/I8xzDB+CoCrXmikCAJQMHDY
 5nh882TPRXdzMAp4Z/P4J1tSXmB6LF2rB3wY6lelJ9euGCBesdc0RuPaBYfAl6pDiklX
 vpn0hjH5kEa3+Dehb0GdLv2mRfAfLj4Fv66mfYwhwxXK8hj1Ry2oEw892zrZPqsGSKKN
 ApSe/RXpK8i0y2+swAKcbCGoW37CnZE/k0/VaprJbNGsX/XrrtaQGrQwPdfzi1MNf2VX rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tq6qtq617-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 21:52:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GL8LDc121996;
        Tue, 16 Jul 2019 21:52:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tq5bcn8aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 21:52:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GLqgoK031735;
        Tue, 16 Jul 2019 21:52:43 GMT
Received: from [10.175.27.185] (/10.175.27.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 21:52:42 +0000
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, rostedt@goodmis.org,
        luto@kernel.org, torvalds@linux-foundation.org,
        linux_lkml_grp@oracle.com
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
References: <20190711114054.406765395@infradead.org>
 <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <97cdd0af-95cc-2583-dc19-129b20809110@oracle.com>
Date:   Tue, 16 Jul 2019 23:51:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160259
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/16/19 9:33 PM, Vegard Nossum wrote:
> 
> On 7/11/19 1:40 PM, Peter Zijlstra wrote:
>> Hi,
>>
>> Here's the latest (and hopefully final) set of tracing vs CR2 patches.
>>
>> They are basically the same as v2, with only minor edits and tags 
>> collected
>> from the last review.
>>
>> Please consider.
>>
> 
> Hi,
> 
> I ran my own battery of tests on your patch set on top of 
> 5ad18b2e60b75c7297a998dea702451d33a052ed and ran into this:
> 
> ------------[ cut here ]------------
> General protection fault in user access. Non-canonical address?
> WARNING: CPU: 0 PID: 5039 at arch/x86/mm/extable.c:126 
> ex_handler_uaccess+0x5d/0x70

Got a different one:

WARNING: CPU: 0 PID: 2150 at arch/x86/kernel/traps.c:791 do_debug+0xfe/0x240
CPU: 0 PID: 2150 Comm: init Not tainted 5.2.0+ #124
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Ubuntu-1.8.2-1ubuntu1 04/01/2014
RIP: 0010:do_debug+0xfe/0x240
Code: 05 07 3d f3 7e f6 85 91 00 00 00 02 0f 85 d8 00 00 00 49 8b 84 24 
18 0b 00 00 f6 44 24 01 40 74 2f f6 85 88 00 00 00 03 75 26 <0f> 0b 80 
e4 bf 49 89 84 24 18 0b 00 00 f0 41 80 0c 24 10 48 81 a5
RSP: 0000:fffffe000000ff20 EFLAGS: 00010046
RAX: 0000000000004002 RBX: 0000000000000000 RCX: ffffffff810e2f72
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff8201f090
RBP: fffffe000000ff58 R08: 0000000000000000 R09: 0000000000000005
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88803e0df040
R13: 0000000000000000 R14: 000000003d376001 R15: 0000000000000000
FS:  0000555556dbc8c0(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000041f38010 CR3: 000000003d376001 CR4: 00000000003606f0
DR0: 0000000000000001 DR1: 0000000041a4f070 DR2: 00007fff959ff000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000003b3062a
Call Trace:
  <#DB>
  debug+0x2d/0x70
RIP: 0010:arch_stack_walk_user+0x74/0x100
Code: e8 10 49 39 c4 77 45 4c 8b 04 24 4c 89 e3 4d 89 fd 4c 89 fd 41 83 
87 98 0a 00 00 01 0f 01 cb 0f ae e8 31 c0 4c 89 e2 4c 8b 33 <4d> 89 f4 
85 c0 75 7a 48 8b 73 08 0f 01 ca 85 c0 74 1f 65 48 8b 04
RSP: 0000:ffffc900030dbd68 EFLAGS: 00040046
RAX: 0000000000000000 RBX: 0000000041a4f073 RCX: ffffffff811ca27b
RDX: 0000000041a4f073 RSI: 0000000041a4f0dd RDI: ffffc900030dbdb8
RBP: ffff88803e0df040 R08: ffffc900030dbf58 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000041a4f073
R13: ffff88803e0df040 R14: 0041281000bf4800 R15: ffff88803e0df040
  ? stack_trace_consume_entry+0x4b/0x80
  </#DB>
  ? profile_setup.cold+0xc1/0xc1
  stack_trace_save_user+0x71/0x9c
  trace_buffer_unlock_commit_regs+0x1ae/0x270
  trace_event_buffer_commit+0x90/0x240
  trace_event_raw_event_preemptirq_template+0x9a/0x100
  ? debug+0x49/0x70
  ? perf_trace_preemptirq_template+0x120/0x120
  ? trace_hardirqs_off_thunk+0x1a/0x1c
  trace_hardirqs_off_caller+0xf4/0x150
  ? debug+0x44/0x70
  trace_hardirqs_off_thunk+0x1a/0x1c
  debug+0x49/0x70
RIP: 0033:0x41a4f0dd
Code: 47 11 b7 d2 36 45 6c 49 be 00 f0 9f 95 ff 7f 00 00 49 bf de a7 b3 
e8 d7 21 3c 15 9c 48 81 0c 24 00 01 00 00 9d b8 62 00 00 00 <8e> c0 0f 
05 66 8c c8 9c 48 81 24 24 ff fe ff ff 9d 48 89 04 25 40
RSP: 002b:0000000040901ea0 EFLAGS: 00000317
RAX: 0000000000000062 RBX: 0000000041281000 RCX: ffffffffffffffff
RDX: 00000000401c0000 RSI: 0000000041892000 RDI: 0000000041281000
RBP: 0000000041a4f073 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff917d7748 R11: 1000000000000000 R12: fdffffffffffffff
R13: 6c4536d2b71147a5 R14: 00007fff959ff000 R15: 153c21d7e8b3a7de
---[ end trace 0cd51ba690f12b47 ]---

The warning is this:

         if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
                 /*
                  * Historical junk that used to handle SYSENTER 
single-stepping.
                  * This should be unreachable now.  If we survive for a 
while
                  * without anyone hitting this warning, we'll turn this 
into
                  * an oops.
                  */
                 tsk->thread.debugreg6 &= ~DR_STEP;
                 set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
                 regs->flags &= ~X86_EFLAGS_TF;
         }

Unfortunately DR6 from the register dump has already been cleared at the
top of do_debug() and the local variable dr6 is on the stack and not
loaded into any of the registers AFAICT.

 From the userspace Code: line you can clearly see it setting EFLAGS_TF,
then it seems to be trapping on the next instruction:

   1b:   9c                      pushfq
   1c:   48 81 0c 24 00 01 00    orq    $0x100,(%rsp)
   23:   00
   24:   9d                      popfq
   25:   b8 62 00 00 00          mov    $0x62,%eax
   2a:*  8e c0                   mov    %eax,%es         <-- trapping 
instruction

You can see that DR1 points to 41a4f070, which is close to userspace RBP
(41a4f073), which is perhaps being accessed by stack_trace_save_user()
and causing the debug exception on a data breakpoint?

The Code: line from stack_trace_save_user() is:

   27:   4c 8b 33                mov    (%rbx),%r14
   2a:*  4d 89 f4                mov    %r14,%r12                <-- 
trapping instruction

with RBX == 41a4f073 so that seems to fit the theory, except I'd have
expected the "trapping instruction" to point at the memory dereference.
(But maybe it's one of those "points to return address" kind of things?)

DR7 is 03b3062a, which is..
  - DR0, DR1, DR2 global breakpoints
  - DR0 reads + writes
  - DR1 reads + writes
  - DR2 reads + writes

A second instance of the same warning:

WARNING: CPU: 0 PID: 601 at arch/x86/kernel/traps.c:791 do_debug+0xfe/0x240
CPU: 0 PID: 601 Comm: init Not tainted 5.2.0+ #124
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Ubuntu-1.8.2-1ubuntu1 04/01/2014
RIP: 0010:do_debug+0xfe/0x240
Code: 05 07 3d f3 7e f6 85 91 00 00 00 02 0f 85 d8 00 00 00 49 8b 84 24 
18 0b 00 00 f6 44 24 01 40 74 2f f6 85 88 00 00 00 03 75 26 <0f> 0b 80 
41 80 0c 24 10 48 81 a5
RSP: 0000:fffffe000000ff20 EFLAGS: 00010046
RAX: 0000000000004002 RBX: 0000000000000000 RCX: ffffffff810e2f72
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff8201f090
RBP: fffffe000000ff58 R08: 0000000000000000 R09: 0000000000000005
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88803e0bd040
R13: 0000000000000000 R14: 000000003d3c6001 R15: 0000000000000000
FS:  0000555556efb8c0(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000041686010 CR3: 000000003d3c6001 CR4: 00000000003606f0
DR0: 0000000000000001 DR1: 00000000400be070 DR2: 00007ffd20c67000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000003b3062a
Call Trace:
  <#DB>
  debug+0x2d/0x70
RIP: 0010:arch_stack_walk_user+0x74/0x100
Code: e8 10 49 39 c4 77 45 4c 8b 04 24 4c 89 e3 4d 89 fd 4c 89 fd 41 83 
87 98 0a 00 00 01 0f 01 cb 0f ae e8 31 c0 4c 89 e2 4c 8b 33 <4d> 89 f4 
85 c0 74 1f 65 48 8b 04
RSP: 0000:ffffc900024f3d68 EFLAGS: 00040046
RAX: 0000000000000000 RBX: 00000000400be073 RCX: ffffffff811ca27b
RDX: 00000000400be073 RSI: 00000000400be0dd RDI: ffffc900024f3db8
RBP: ffff88803e0bd040 R08: ffffc900024f3f58 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000400be073
R13: ffff88803e0bd040 R14: 00404e4000bf4800 R15: ffff88803e0bd040
  ? stack_trace_consume_entry+0x4b/0x80
  </#DB>
  ? profile_setup.cold+0xc1/0xc1
  stack_trace_save_user+0x71/0x9c
  trace_buffer_unlock_commit_regs+0x1ae/0x270
  trace_event_buffer_commit+0x90/0x240
  trace_event_raw_event_preemptirq_template+0x9a/0x100
  ? debug+0x49/0x70
  ? perf_trace_preemptirq_template+0x120/0x120
  ? trace_hardirqs_off_thunk+0x1a/0x1c
  trace_hardirqs_off_caller+0xf4/0x150
  ? debug+0x44/0x70
  trace_hardirqs_off_thunk+0x1a/0x1c
  debug+0x49/0x70
RIP: 0033:0x400be0dd
Code: 3a 51 3e 59 a9 b2 e3 49 be 00 70 c6 20 fd 7f 00 00 49 bf de a7 b3 
e8 d7 21 3c 15 9c 48 81 0c 24 00 01 00 00 9d b8 62 00 00 00 <8e> c0 0f 
ff ff 9d 48 89 04 25 40
RSP: 002b:00000000417d0ea0 EFLAGS: 00000317
RAX: 0000000000000062 RBX: 00000000404e4000 RCX: ffffffffffffffff
RDX: 0000000041da4000 RSI: 0000000040bb0000 RDI: 00000000404e4000
RBP: 00000000400be073 R08: 0000000000000001 R09: 0000000000000001
R10: 9c7fa8aa10386cdb R11: 1000000000000000 R12: fdffffffffffffff
R13: e3b2a9593e513a6b R14: 00007ffd20c67000 R15: 153c21d7e8b3a7de
---[ end trace beb9776710443227 ]---


Vegard
