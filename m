Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C540DC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E4120880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YpTAq4r4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbfGPThs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:37:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34346 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGPThr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:37:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GJYUkg179179;
        Tue, 16 Jul 2019 19:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1qfDR8LOOclMEHtdDoRSRWksboxo8pc0ldxYjGRGB8Q=;
 b=YpTAq4r4uAFQUHam9fEklhu/CVb/EBKs2ZOZQBIqX7/y2HSXjvp1yElrgsjlEvD2soPA
 5n5oEhfNcwy71MIoQRJKFYaB+yYFTwpjLb8o+BfmjL0NPnxUw7gFvEVfjZcwfYfCaF1D
 jV6ApFOotHG/l+nQ95DsWTBup62xwlQeERabpWfY2sMeTY4lUJakAfvikKN0guVYAKyW
 EpYskAuVdcNJl4xFZHgPk+WrI3Q/1s0wL3Joh+gNEQQ3g0YzmsfdBMW9bisDwAGtX20s
 2FZJ7FoC7jZQsUz3JOJmxwuDZMrSZrOjlzjkWrwLfJetu5KC905Bt5uBUXKaeqdCS9kC RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tq6qtpn1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 19:35:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GJWoiQ117858;
        Tue, 16 Jul 2019 19:35:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tq5bckgmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 19:35:36 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GJZR4X007538;
        Tue, 16 Jul 2019 19:35:32 GMT
Received: from [10.175.27.185] (/10.175.27.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 19:35:26 +0000
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, rostedt@goodmis.org,
        luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
References: <20190711114054.406765395@infradead.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
Date:   Tue, 16 Jul 2019 21:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711114054.406765395@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160239
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/19 1:40 PM, Peter Zijlstra wrote:
> Hi,
> 
> Here's the latest (and hopefully final) set of tracing vs CR2 patches.
> 
> They are basically the same as v2, with only minor edits and tags collected
> from the last review.
> 
> Please consider.
> 

Hi,

I ran my own battery of tests on your patch set on top of 
5ad18b2e60b75c7297a998dea702451d33a052ed and ran into this:

------------[ cut here ]------------
General protection fault in user access. Non-canonical address?
WARNING: CPU: 0 PID: 5039 at arch/x86/mm/extable.c:126 
ex_handler_uaccess+0x5d/0x70
CPU: 0 PID: 5039 Comm: init Not tainted 5.2.0+ #124
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Ubuntu-1.8.2-1ubuntu1 04/01/2014
RIP: 0010:ex_handler_uaccess+0x5d/0x70
Code: 5d 41 5c c3 e8 c4 8e 0e 00 80 3d e5 74 1e 01 00 75 d3 e8 b6 8e 0e 
00 48 c7 c7 10 a7 fb 81 c6 05 d0 74 1e 01 01 e8 d1 43 01 00 <0f> 0b eb 
b7 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
RSP: 0000:fffffe000000fc48 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff81c07dac RCX: ffffffff811a887c
RDX: 0000000000000000 RSI: ffffffff8289f05f RDI: 0000000000000093
RBP: fffffe000000fcb8 R08: 00000036fe0f15d3 R09: 000000000000003f
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000d
R13: 000000000000000d R14: 0000000000000000 R15: 0000000000000000
FS:  00005555563ab8c0(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000001ff7 CR3: 000000003c804002 CR4: 00000000003606f0
DR0: 0000000040209100 DR1: 00000000402091a1 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff1 DR7: 00000000000b062a
Call Trace:
  <#DB>
  fixup_exception+0x50/0x6a
  do_general_protection+0x40/0x160
  general_protection+0x2d/0x40
RIP: 0010:arch_stack_walk_user+0x71/0x100
Code: 00 48 83 e8 10 49 39 c4 77 45 4c 8b 04 24 4c 89 e3 4d 89 fd 4c 89 
fd 41 83 87 98 0a 00 00 01 0f 01 cb 0f ae e8 31 c0 4c 89 e2 <4c> 8b 33 
4d 89 f4 85 c0 75 7a 48 8b 73 08 0f 01 ca 85 c0 74 1f 65
RSP: 0000:fffffe000000fd68 EFLAGS: 00050046
RAX: 0000000000000000 RBX: 854163717acc2789 RCX: ffffffff811ca27b
RDX: 854163717acc2789 RSI: 0000000040209102 RDI: fffffe000000fdb8
RBP: ffff88803d55d040 R08: ffffc9000520bf58 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 854163717acc2789
R13: ffff88803d55d040 R14: 0000000000000093 R15: ffff88803d55d040
  ? stack_trace_consume_entry+0x4b/0x80
  ? arch_stack_walk_user+0x34/0x100
  ? profile_setup.cold+0xc1/0xc1
  stack_trace_save_user+0x71/0x9c
  trace_buffer_unlock_commit_regs+0x1ae/0x270
  trace_event_buffer_commit+0x90/0x240
  trace_event_raw_event_preemptirq_template+0x9a/0x100
  ? debug+0x16/0x70
  ? perf_trace_preemptirq_template+0x120/0x120
  ? trace_hardirqs_off_thunk+0x1a/0x1c
  trace_hardirqs_off_caller+0xf4/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? debug+0x11/0x70
  debug+0x16/0x70
RIP: 0010:copy_user_generic_unrolled+0xa0/0xc0
Code: 7f 40 ff c9 75 b6 89 d1 83 e2 07 c1 e9 03 74 12 4c 8b 06 4c 89 07 
48 8d 76 08 48 8d 7f 08 ff c9 75 ee 21 d2 74 10 89 d1 8a 06 <88> 07 48 
ff c6 48 ff c7 ff c9 75 f2 31 c0 0f 01 ca c3 0f 1f 40 00
RSP: 0000:ffffc9000520be38 EFLAGS: 00040202
RAX: ffff88803d55d09c RBX: ffff88803d55d040 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000040209102 RDI: ffffc9000520be76
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffffffff000
R13: 0000000040209102 R14: ffffc9000520be76 R15: 0000000000000000
  </#DB>
  __probe_kernel_read+0x57/0x90
  is_prefetch.isra.0+0xb5/0x210
  ? tracer_hardirqs_on+0x53/0x1a0
  __bad_area_nosemaphore+0x9e/0x220
  __do_page_fault+0x483/0x630
  ? async_page_fault+0x8/0x40
  async_page_fault+0x36/0x40
RIP: 0033:0x40209102
Code: 00 00 49 bc 00 20 23 40 00 00 00 00 49 bd 00 00 d0 40 00 00 00 00 
49 be ff ff ff ff ff ff ff ff 49 bf 00 50 80 40 00 00 00 00 <9c> 48 81 
0c 24 00 04 00 00 48 81 0c 24 00 00 04 00 9d ff 2c 25 00
RSP: 002b:0000000000001fff EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00000000402090b0 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000041ebb000
RBP: 854163717acc2789 R08: 0000000000000001 R09: b1f39cc399a61ebb
R10: 00007ffeab175000 R11: 0000000000000360 R12: 0000000040232000
R13: 0000000040d00000 R14: ffffffffffffffff R15: 0000000040805000
---[ end trace e5e49800ff5aa5ed ]---
PANIC: double fault, error_code: 0x0
CPU: 0 PID: 5039 Comm: init Tainted: G        W         5.2.0+ #124
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Ubuntu-1.8.2-1ubuntu1 04/01/2014
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f008 EFLAGS: 00010093
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f088 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00005555563ab8c0(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffe000000eff8 CR3: 000000003c804002 CR4: 00000000003606f0
DR0: 0000000040209100 DR1: 00000000402091a1 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000b062a
Call Trace:
  <#DB>
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f148 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f1c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f288 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f308 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f3c8 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f448 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f508 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f588 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f648 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f6c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f788 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f808 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f8c8 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f948 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000fa08 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
RAX: 0000000000006004 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000006004 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000fa88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  async_page_fault+0x16/0x40
RIP: 0010:fixup_bad_iret+0x6/0x50
Code: 2d a8 00 00 00 48 39 f8 74 0b b9 15 00 00 00 48 89 c7 f3 48 a5 c3 
0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41 54 55 48 89 fd <65> 48 8b 
3d a6 31 f2 7e 48 8b b5 a0 00 00 00 4c 8d a7 50 ff ff ff
RSP: 0000:fffffe000000fb48 EFLAGS: 00010082 ORIG_RAX: 0000000000000000
RAX: 800000003c804002 RBX: 0000000000000000 RCX: ffffffff81a00b97
RDX: 0000000000000000 RSI: ffffffff81a013a8 RDI: fffffe000000fb60
RBP: fffffe000000fb60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? native_iret+0x7/0x7
  ? general_protection+0x8/0x40
  error_entry+0xe5/0xf0
RIP: 0010:native_irq_return_iret+0x0/0x2
Code: 5b 41 5b 41 5a 41 59 41 58 58 59 5a 5e 5f 48 83 c4 08 e9 0c 00 00 
00 90 90 66 2e 0f 1f 84 00 00 00 00 00 f6 44 24 20 04 75 02 <48> cf 57 
0f 01 f8 0f 1f 00 66 90 0f 20 df 48 0f ba ef 3f 48 81 e7
RSP: 0000:fffffe000000fc18 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
RAX: fffffe000000fe08 RBX: ffffffff81c07dac RCX: ffff88803c824000
RDX: ffffffff8126a228 RSI: 0000000040209100 RDI: 0000000000000000
RBP: fffffe000000fcb8 R08: fffffe000000fec0 R09: ffffffff8125b177
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000d
R13: 000000000000000d R14: 0000000000000000 R15: 0000000000000000
  ? general_protection+0x8/0x40
  ? perf_exclude_event+0x67/0x90
  ? perf_bp_event+0x98/0xe0
RIP: 0000:0x2
Code: Bad RIP value.
RSP: 0000:0000000005080021 EFLAGS: 00000000
  ? ex_handler_uaccess+0x5d/0x70
  ? fixup_exception+0x50/0x6a
  ? do_general_protection+0x40/0x160
  ? general_protection+0x2d/0x40
  ? stack_trace_consume_entry+0x4b/0x80
  ? arch_stack_walk_user+0x71/0x100
  ? arch_stack_walk_user+0x34/0x100
  ? profile_setup.cold+0xc1/0xc1
  ? stack_trace_save_user+0x71/0x9c
  ? __this_cpu_preempt_check+0xc/0xc6
  ? hw_breakpoint_exceptions_notify+0x120/0x1c0
  ? notifier_call_chain+0x8e/0xb0
  ? atomic_notifier_call_chain+0x37/0x40
  ? notify_die+0x5c/0x80
  ? trace_hardirqs_off_caller+0x20/0x150
  ? trace_hardirqs_off_thunk+0x1a/0x1c
  ? debug_smp_processor_id+0x28/0xd0
  ? paranoid_exit+0xb/0xb0
  ? copy_user_enhanced_fast_string+0xe/0x20
  </#DB>
WARNING: stack recursion on stack type 9
Kernel panic - not syncing: Machine halted.
CPU: 0 PID: 5039 Comm: init Tainted: G        W         5.2.0+ #124
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Ubuntu-1.8.2-1ubuntu1 04/01/2014
Call Trace:
  <#DF>
  dump_stack+0xe1/0x133
  panic+0x159/0x3d8
  ? get_cpu_entry_area+0x8/0x30
  df_debug+0x24/0x2d
  do_double_fault+0x94/0xf0
  double_fault+0x2c/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f008 EFLAGS: 00010093
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f088 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  </#DF>
  <#DB>
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f148 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f1c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f288 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f308 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f3c8 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f448 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f508 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f588 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f648 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f6c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f788 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f808 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000f8c8 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
RAX: 0000000000016cc0 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000016cc0 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000f948 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  async_page_fault+0x16/0x40
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
Code: 82 e8 74 2d f8 ff 48 89 9d 10 01 00 00 48 89 ee 5b 4c 89 e7 5d 41 
5c e9 8e 5d 12 00 5b b8 f4 ff ff ff 5d 41 5c c3 0f 1f 40 00 <65> 48 8b 
04 25 c0 6c 01 00 65 8b 15 78 ba df 7e 81 e2 00 01 1f 00
RSP: 0000:fffffe000000fa08 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
RAX: 0000000000006004 RBX: ffffffff81a01436 RCX: ffffffff81a00b97
RDX: 0000000000006004 RSI: ffffffff81a01428 RDI: ffffffff81a01436
RBP: fffffe000000fa88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? async_page_fault+0x16/0x40
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  ? async_page_fault+0x16/0x40
  trace_hardirqs_off_caller+0x10/0x150
  trace_hardirqs_off_thunk+0x1a/0x1c
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x40
  async_page_fault+0x16/0x40
RIP: 0010:fixup_bad_iret+0x6/0x50
Code: 2d a8 00 00 00 48 39 f8 74 0b b9 15 00 00 00 48 89 c7 f3 48 a5 c3 
0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41 54 55 48 89 fd <65> 48 8b 
3d a6 31 f2 7e 48 8b b5 a0 00 00 00 4c 8d a7 50 ff ff ff
RSP: 0000:fffffe000000fb48 EFLAGS: 00010082 ORIG_RAX: 0000000000000000
RAX: 800000003c804002 RBX: 0000000000000000 RCX: ffffffff81a00b97
RDX: 0000000000000000 RSI: ffffffff81a013a8 RDI: fffffe000000fb60
RBP: fffffe000000fb60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  ? native_iret+0x7/0x7
  ? general_protection+0x8/0x40
  error_entry+0xe5/0xf0
RIP: 0010:native_irq_return_iret+0x0/0x2
Code: 5b 41 5b 41 5a 41 59 41 58 58 59 5a 5e 5f 48 83 c4 08 e9 0c 00 00 
00 90 90 66 2e 0f 1f 84 00 00 00 00 00 f6 44 24 20 04 75 02 <48> cf 57 
0f 01 f8 0f 1f 00 66 90 0f 20 df 48 0f ba ef 3f 48 81 e7
RSP: 0000:fffffe000000fc18 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
RAX: fffffe000000fe08 RBX: ffffffff81c07dac RCX: ffff88803c824000
RDX: ffffffff8126a228 RSI: 0000000040209100 RDI: 0000000000000000
RBP: fffffe000000fcb8 R08: fffffe000000fec0 R09: ffffffff8125b177
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000d
R13: 000000000000000d R14: 0000000000000000 R15: 0000000000000000
  ? general_protection+0x8/0x40
  ? perf_exclude_event+0x67/0x90
  ? perf_bp_event+0x98/0xe0
RIP: 0000:0x2
Code: Bad RIP value.
RSP: 0000:0000000005080021 EFLAGS: 00000000
  ? ex_handler_uaccess+0x5d/0x70
  ? fixup_exception+0x50/0x6a
  ? do_general_protection+0x40/0x160
  ? general_protection+0x2d/0x40
  ? stack_trace_consume_entry+0x4b/0x80
  ? arch_stack_walk_user+0x71/0x100
  ? arch_stack_walk_user+0x34/0x100
  ? profile_setup.cold+0xc1/0xc1
  ? stack_trace_save_user+0x71/0x9c
  ? __this_cpu_preempt_check+0xc/0xc6
  ? hw_breakpoint_exceptions_notify+0x120/0x1c0
  ? notifier_call_chain+0x8e/0xb0
  ? atomic_notifier_call_chain+0x37/0x40
  ? notify_die+0x5c/0x80
  ? trace_hardirqs_off_caller+0x20/0x150
  ? trace_hardirqs_off_thunk+0x1a/0x1c
  ? debug_smp_processor_id+0x28/0xd0
  ? paranoid_exit+0xb/0xb0
  ? copy_user_enhanced_fast_string+0xe/0x20
  </#DB>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Machine halted. ]---

There's quite a bit to unpack there... I haven't looked into it AT ALL
yet, but at least you have the report. Will try to see if I can get a
reproducible test case.


Vegard
