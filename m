Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B20EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9323206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDCQQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDCQQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:16:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342D4206B7;
        Wed,  3 Apr 2019 16:16:42 +0000 (UTC)
Date:   Wed, 3 Apr 2019 12:16:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: WARN_ON: userstacktrace on irq events
Message-ID: <20190403121640.70128095@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Juri reported this from the -rt kernel, but I can easily trigger it in
mainline. By simply doing:

 # cd /sys/kernel/tracing
 # echo 1 > options/userstacktrace
 # echo 1 > events/irq/enable

With CONFIG_DEBUG_ATOMIC_SLEEP enabled, we get a WARNING splat of:

WARNING: CPU: 1 PID: 1688 at arch/x86/kernel/stacktrace.c:180 save_stack_trace_user+0x12b/0x140
Modules linked in: iptable_mangle xt_CHECKSUM tun
CPU: 1 PID: 1688 Comm: sshd Not tainted 5.1.0-rc3-test+ #14
Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
RIP: 0010:save_stack_trace_user+0x12b/0x140
Code: 44 8d 58 01 44 89 1f 48 89 34 c2 8b 07 89 c2 8b 77 04 49 39 ca 74 ad 4c 89 d1 39 f0 0f 82 37 ff ff ff c3 89 c2 8b 77 04 eb 9a <0f> 0b e9 3b ff ff ff 31 f6 e9 70 ff ff ff 8b 17 8b 77 04 eb 85 0f
RSP: 0000:ffff8880d0687e40 EFLAGS: 00010006
RAX: 0000000000000001 RBX: 1ffff1101a0d0fc9 RCX: 00007fff28a44f12
RDX: 0000000000010000 RSI: 00007faa5f81f098 RDI: ffff8880d0687e68
RBP: ffff8880cc058368 R08: ffff888085ae7f58 R09: 0000000000000000
R10: ffffed100f207c97 R11: ffff88807903e4bb R12: ffff88807903e468
R13: ffff88807903e46c R14: 0000000000000698 R15: ffff88807903e46c
FS:  00007faa5f43cdc0(0000) GS:ffff8880d0680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000081 CR3: 0000000085296004 CR4: 00000000001606e0
Call Trace:
 <IRQ>
 ftrace_trace_userstack+0x17e/0x1f0
 ? __trace_stack+0x80/0x80
 trace_event_buffer_commit+0xd0/0x300
 ? trace_event_buffer_reserve+0x107/0x130
 trace_event_raw_event_x86_irq_vector+0xb8/0x120
 ? __bpf_trace_vector_setup+0x10/0x10
 ? irqtime_account_irq+0x46/0xe0
 ? __bpf_trace_vector_setup+0x10/0x10
 smp_apic_timer_interrupt+0x208/0x270
 apic_timer_interrupt+0xf/0x20
 </IRQ>
RIP: 0033:0x7faa5f81f098
Code: 89 d1 40 0f b6 c6 48 89 fa f3 aa 48 89 d0 c3 0f 1f 00 f3 0f 1e fa 48 39 d1 0f 82 43 80 06 00 0f 1f 00 f3 0f 1e fa 66 0f 6e c6 <48> 89 f8 66 0f 60 c0 66 0f 61 c0 66 0f 70 c0 00 48 83 fa 10 0f 82
RSP: 002b:00007fff28a44ef8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 00005649f9d12830 RCX: 0000000000000001
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 00005649f9d36240
RBP: 00007fff28a44f12 R08: 0000000000000000 R09: 0000000000000100
R10: 0000000000000008 R11: 00007fff28a40f90 R12: 0000000000000000
R13: 00007fff28a44f58 R14: 00005649f9d12260 R15: 00005649f9d0ab40
---[ end trace cd684bbd8c344b2a ]---
hrtimer: interrupt took 3268750 ns
------------[ cut here ]------------

This is simply caused by the irq trace events doing a user stack trace:

ftrace_trace_userstack {
  save_stack_trace_user {
    __save_stack_trace_user {
      copy_stack_frame {
        access_ok {
	  WARN_ON_IN_IRQ()

BOOM! Warn on.

Can we make that access_ok() call in the copy_stack_frame not trigger
the warning just if we are in an interrupt?

-- Steve
