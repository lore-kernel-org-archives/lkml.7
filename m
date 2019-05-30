Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221C8C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB14C24998
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfE3ISL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:18:11 -0400
Received: from mail.windriver.com ([147.11.1.11]:44040 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3ISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:18:11 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x4U8H6DC006300
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 30 May 2019 01:17:06 -0700 (PDT)
Received: from [128.224.162.221] (128.224.162.221) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 30 May
 2019 01:17:05 -0700
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   He Zhe <zhe.he@windriver.com>
Subject: User Stack Tracer Causes Crash 2
Message-ID: <0c437829-3a13-0f5c-15a2-14414be65514@windriver.com>
Date:   Thu, 30 May 2019 16:17:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.221]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://lore.kernel.org/lkml/20190320221534.165ab87b@oasis.local.home/ didn't get merged. And the crash it was trying to fix still happens on the latest master branch. If rebasing the patch on the latest top, the following new crash come up.

Sometimes,

root@intel-x86-64:~# echo 1 > /sys/kernel/debug/tracing/options/userstacktrace
root@intel-x86-64:~# echo 1 > /sys/kernel/debug/tracing/events/preemptirq/irq_disable/enable
root@intel-x86-64:~# echo 1 > /proc/sys/kernel/stack_tracer_enabled
hangs...

Sometimes,

root@intel-x86-64:~# echo 1 > /sys/kernel/debug/tracing/options/userstacktrace
root@intel-x86-64:~# echo 1 > /sys/kernel/debug/tracing/events/preemptirq/irq_disable/enable
root@intel-x86-64:~# echo 1 > /proc/sys/kernel/stack_tracer_enabled
PANIC: double fault, error_code: 0x0
CPU: 0 PID: 492 Comm: sh Not tainted 5.2.0-rc2 #1
Hardware name: Intel Corporation Broadwell Client platform/Basking Ridge, BIOS BDW-E2R1.86C.0118.R01.1503110618 03/11/2015
RIP: 0010:error_entry+0x32/0x100
Code: 89 7c 24 08 52 31 d2 51 31 c9 50 41 50 45 31 c0 41 51 45 31 c9 41 52 45 31 d2 41 53 45 31 db 53 31 db 55 31 ed 41 54 45 31 e4 <41> 55 45 31 ed 41 56 45 31 f6 41 57 45 31 ff 56 48 8d 6c 24 09 f6
RSP: 0018:ffff9ab680000000 EFLAGS: 00010046
RAX: 00000000ae200a97 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffffae200ec9 RDI: ffffffffae201176
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f2c078a4740(0000) GS:ffff988fb8a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff9ab67ffffff8 CR3: 000000005b8ee003 CR4: 00000000003606f0
Call Trace:
 <IRQ>
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_caller_cr2+0x1/0x20
 ? trace_hardirqs_off_thunk_cr2+0x1a/0x1c
 ? native_iret+0x7/0x7
 ? int3+0x29/0x40
 ? error_entry+0x86/0x100
 ? error_entry+0x86/0x100
 ? int3+0x29/0x40
 ? native_iret+0x7/0x7
