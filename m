Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AEEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380E2218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfCUNzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfCUNzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:55:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E297218A5;
        Thu, 21 Mar 2019 13:55:04 +0000 (UTC)
Date:   Thu, 21 Mar 2019 09:55:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321095502.47b51356@gandalf.local.home>
In-Reply-To: <20190321093242.4a948198@gandalf.local.home>
References: <20190320221534.165ab87b@oasis.local.home>
        <20190321083317.GL6058@hirez.programming.kicks-ass.net>
        <20190321090241.GL6521@hirez.programming.kicks-ass.net>
        <20190321104517.GM6521@hirez.programming.kicks-ass.net>
        <20190321093242.4a948198@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 09:32:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I tested your code and it also fixes the issue,

Although I just hit this:

------------[ cut here ]------------
General protection fault in user access. Non-canonical address?
WARNING: CPU: 2 PID: 1620 at arch/x86/mm/extable.c:125 ex_handler_uaccess+0xc4/0xf0
Modules linked in: iptable_mangle xt_CHECKSUM tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter snd_hda_codec_hdmi iTCO_wdt snd_hda_codec_realtek snd_hda_codec_generic iTCO_vendor_support wmi_bmof snd_hda_intel snd_hda_codec intel_rapl x86_pkg_temp_thermal intel_powerclamp snd_hda_core coretemp snd_seq crct10dif_pclmul crct10dif_common i915 aesni_intel snd_seq_device snd_pcm aes_x86_64 crypto_simd cryptd snd_timer glue_helper i2c_i801 lpc_ich video wmi pcc_cpufreq ip_tables x_tables e1000e
CPU: 2 PID: 1620 Comm: dhclient Not tainted 5.1.0-rc1-test-yocto-standard+ #42
Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
RIP: 0010:ex_handler_uaccess+0xc4/0xf0
Code: 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 e8 ca f6 ac c6 05 23 9f 8e 01 01 e8 68 df 11 00 48 c7 c7 20 69 b9 ac e8 4b 42 01 00 <0f> 0b b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 b8 ca f6 ac e8
RSP: 0018:ffffa4bd409e79a0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffffac602400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffacf7f118
RBP: ffffa4bd409e79b8 R08: ffffffffad27ba00 R09: 000000000000003f
R10: 0000000000000000 R11: 0000000000000654 R12: 0000000000000001
R13: ffffa4bd409e7a28 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f7e2fe13e80(0000) GS:ffff8b101a880000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000001010 CR3: 0000000114d68001 CR4: 00000000001606e0
Call Trace:
 fixup_exception+0x4a/0x61
 do_general_protection+0x50/0x190
 general_protection+0x27/0x30
RIP: 0010:save_stack_trace_user+0xc9/0x190
Code: 0f 96 c6 48 c7 c7 88 6a f6 ac 31 c9 e8 40 e8 14 00 49 39 dc 0f 87 c3 00 00 00 41 83 87 a0 18 00 00 01 0f 1f 00 0f ae e8 31 db <4d> 8b 3c 24 31 f6 85 db ba 01 00 00 00 40 0f 94 c6 48 c7 c7 b8 6a
RSP: 0018:ffffa4bd409e7ad8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffffacf66a88
RBP: ffffa4bd409e7b00 R08: 0000000000000000 R09: ffff8b0fb4df1a08
R10: 00000000000009f4 R11: ffff8b0fb4df1a04 R12: 62696c2f7273752f
R13: ffffa4bd409e7f58 R14: ffffa4bd409e7b10 R15: ffff8b1017d53a80
 ? save_stack_trace_user+0xb0/0x190
 ftrace_trace_userstack+0x128/0x1c0
 trace_buffer_unlock_commit_regs+0x83/0xb0
 trace_event_buffer_commit+0x6e/0x1e0
 trace_event_raw_event_preemptirq_template+0x73/0xb0
 ? __get_user_pages+0x2d0/0x860
 ? handle_mm_fault+0xa9/0x3c0
 trace_hardirqs_off+0xbd/0x100
 handle_mm_fault+0xa9/0x3c0
 __get_user_pages+0x2d0/0x860
 get_user_pages_remote+0x169/0x260
 copy_strings.isra.8.part.9+0x18e/0x300
 copy_strings_kernel+0x39/0x50
 __do_execve_file.isra.14+0x5b3/0x9e0
 do_execve+0x25/0x30
 __x64_sys_execve+0x2b/0x40
 do_syscall_64+0x79/0x1f0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f7e30272b0b
Code: 41 89 01 eb da 66 2e 0f 1f 84 00 00 00 00 00 f7 d8 64 41 89 01 eb d6 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 63 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc34858f28 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00005635d0651f60 RCX: 00007f7e30272b0b
RDX: 00005635d0658a60 RSI: 00007ffc34858f40 RDI: 00007ffc3485ae89
RBP: 00007ffc3485ae89 R08: 00005635d05ff290 R09: 0000000000000001
R10: 00007f7e2fe13e80 R11: 0000000000000206 R12: 00005635d0658a60
R13: 0000000000000000 R14: 00005635d05d9be0 R15: 0000000000000136
---[ end trace 0a02ebd5916dacc5 ]---

Looks to be an issue with the save_stack_trace_user() not checking if
the address is canonical before reading it. I guess access_ok() doesn't
check that. Should we add something in save_stack_trace_user() to test
if the frame it reads is canonical or not before reading it. We don't
really want these warnings to happen because the user space stack has a
non-canonical address in it as the stack tracer reads it.

--- Steve
