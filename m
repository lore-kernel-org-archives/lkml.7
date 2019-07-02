Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB60C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A66D2184C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGBRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGBRsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:48:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB1721721;
        Tue,  2 Jul 2019 17:48:00 +0000 (UTC)
Date:   Tue, 2 Jul 2019 13:47:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eiichi Tsukata <devel@etsukata.com>, edwintorok@gmail.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] x86/stacktrace: Do not access user space memory
 unnecessarily
Message-ID: <20190702134759.4c147d9b@gandalf.local.home>
In-Reply-To: <20190702133905.1482b87e@gandalf.local.home>
References: <20190702053151.26922-1-devel@etsukata.com>
        <20190702072821.GX3419@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de>
        <20190702113355.5be9ebfe@gandalf.local.home>
        <20190702133905.1482b87e@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 13:39:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 2 Jul 2019 11:33:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 2 Jul 2019 16:14:05 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >   
> > > On Tue, 2 Jul 2019, Peter Zijlstra wrote:
> > >     
> > > > On Tue, Jul 02, 2019 at 02:31:51PM +0900, Eiichi Tsukata wrote:      
> > > > > Put the boundary check before it accesses user space to prevent unnecessary
> > > > > access which might crash the machine.
> > > > > 
> > > > > Especially, ftrace preemptirq/irq_disable event with user stack trace
> > > > > option can trigger SEGV in pid 1 which leads to panic.      
> > 
> > Note, I'm only able to trigger this crash with the irq_disable event.
> > The irq_enable and preempt_disable/enable events work just fine. This
> > leads me to believe that the TRACE_IRQS_OFF macro (which uses a thunk
> > trampoline) may have some issues and is probably the place to look at.  
> 
> I figured it out.
> 
> It's another "corruption of the cr2" register issue. The following
> patch makes the issue go away. I'm not suggesting that we use this
> patch, but it shows where the bug lies.
> 
> IIRC, there was patches posted before that fixed this issue. I'll go
> look to see if I can dig them up. Was it Joel that sent them?

Although with this patch, I just triggered this:

[ 1331.706273] WARNING: can't dereference registers at 00000000cb0cab6d for ip interrupt_entry+0xc1/0xf0
[ 1439.850235] ------------[ cut here ]------------
[ 1439.854848] General protection fault in user access. Non-canonical address?
[ 1439.854861] WARNING: CPU: 6 PID: 1620 at arch/x86/mm/extable.c:125 ex_handler_uaccess+0x62/0x70
[ 1439.870455] Modules linked in: ip6t_REJECT nf_reject_ipv6 xt_state nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel i915 snd_hda_codec hp_wmi snd_hwdep wmi_bmof sparse_keymap snd_hda_core rfkill i2c_algo_bit snd_seq iosf_mbi snd_seq_device snd_pcm drm_kms_helper x86_pkg_temp_thermal syscopyarea sysfillrect coretemp sysimgblt snd_timer fb_sys_fops snd drm crc32c_intel tpm_infineon soundcore e1000e ptp tpm_tis pps_core lpc_ich i2c_i801 mfd_core i2c_core tpm_tis_core tpm pcspkr serio_raw wmi video
[ 1439.922501] CPU: 6 PID: 1620 Comm: dhclient Not tainted 5.2.0-rc1-test+ #8
[ 1439.929350] Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
[ 1439.938277] RIP: 0010:ex_handler_uaccess+0x62/0x70
[ 1439.943055] Code: 80 00 00 00 b8 01 00 00 00 5b 5d 41 5c c3 80 3d 09 f3 ed 01 00 75 c5 48 c7 c7 80 bc 24 82 c6 05 f9 f2 ed 01 01 e8 ea ce 06 00 <0f> 0b eb ae 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d d9
[ 1439.961724] RSP: 0018:ffff8880c7fff4f0 EFLAGS: 00010082
[ 1439.966934] RAX: 0000000000000000 RBX: ffffffff820024b8 RCX: 0000000000000000
[ 1439.974045] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffffffff83e12fc0
[ 1439.981156] RBP: ffff8880c7fff578 R08: fffffbfff0561631 R09: fffffbfff0561630
[ 1439.988265] R10: fffffbfff0561630 R11: ffffffff82b0b183 R12: ffffffff820024b8
[ 1439.995368] R13: 000000000000000d R14: 0000000000000000 R15: 0000000000000000
[ 1440.002479] FS:  00007fdc180a2e80(0000) GS:ffff8880d4780000(0000) knlGS:0000000000000000
[ 1440.010537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1440.016268] CR2: 0000000000001010 CR3: 00000000adad0001 CR4: 00000000001606e0
[ 1440.023379] Call Trace:
[ 1440.025827]  ? ex_handler_refcount+0xb0/0xb0
[ 1440.030089]  fixup_exception+0x60/0x7b
[ 1440.033837]  do_general_protection+0x68/0x1f0
[ 1440.038189]  general_protection+0x1e/0x30
[ 1440.042193] RIP: 0010:arch_stack_walk_user+0x6c/0x110
[ 1440.047231] Code: d8 22 00 00 48 83 e8 10 49 39 c7 77 44 4d 89 fd 31 db 65 48 8b 04 25 80 ee 01 00 83 80 e8 21 00 00 01 0f 1f 00 0f ae e8 89 d8 <4d> 8b 75 00 85 c0 0f 85 82 00 00 00 49 8b 75 08 0f 1f 00 85 c0 74
[ 1440.065903] RSP: 0018:ffff8880c7fff620 EFLAGS: 00010002
[ 1440.071117] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff811c5258
[ 1440.078226] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff8880ce9c99c4
[ 1440.085341] RBP: ffffffff811c5200 R08: 1ffff11019d39338 R09: ffffed1019bf2924
[ 1440.092449] R10: ffffed1019bf2924 R11: ffff8880cdf94927 R12: ffff8880c7ffff58
[ 1440.099562] R13: 62696c2f7273752f R14: 62696c2f7273752f R15: 62696c2f7273752f
[ 1440.106679]  ? profile_setup.cold.11+0xa1/0xa1
[ 1440.111115]  ? stack_trace_consume_entry+0x58/0x80
[ 1440.115914]  stack_trace_save_user+0xb6/0xe8
[ 1440.120180]  ? stack_trace_save_tsk_reliable+0x1c0/0x1c0
[ 1440.125489]  trace_buffer_unlock_commit_regs+0x286/0x3f0
[ 1440.130791]  trace_event_buffer_commit+0xd0/0x300
[ 1440.135482]  ? trace_event_buffer_reserve+0xc6/0xf0
[ 1440.140353]  ? 0xffffffff81000000
[ 1440.143662]  trace_event_raw_event_preemptirq_template+0xe1/0x150
[ 1440.149743]  ? perf_trace_preemptirq_template+0x230/0x230
[ 1440.155135]  ? rcu_dynticks_curr_cpu_in_eqs+0x46/0x60
[ 1440.160174]  ? perf_trace_preemptirq_template+0x230/0x230
[ 1440.165558]  ? ktime_get_coarse_real_ts64+0x7f/0xf0
[ 1440.170428]  trace_hardirqs_off+0xbb/0x100
[ 1440.174519]  ktime_get_coarse_real_ts64+0x7f/0xf0
[ 1440.179217]  current_time+0x68/0xf0
[ 1440.182706]  ? timespec64_trunc+0x110/0x110
[ 1440.186902]  ? iov_iter_zero+0x7e0/0x7e0
[ 1440.190822]  ? preempt_count_sub+0xb0/0x100
[ 1440.194995]  ? match_held_lock+0x1b/0x230
[ 1440.199004]  atime_needs_update+0xdf/0x1b0
[ 1440.203093]  touch_atime+0x91/0x170
[ 1440.206576]  ? atime_needs_update+0x1b0/0x1b0
[ 1440.210924]  ? copy_page_to_iter+0x31d/0x560
[ 1440.215179]  ? pagecache_get_page+0x2f/0x3b0
[ 1440.219447]  generic_file_read_iter+0xe00/0x1110
[ 1440.224073]  ? arch_stack_walk+0x92/0xe0
[ 1440.227996]  ? filemap_write_and_wait_range+0x80/0x80
[ 1440.233034]  ? xattr_resolve_name+0x107/0x180
[ 1440.237385]  ? __vfs_getxattr+0xb2/0x100
[ 1440.241304]  ? __vfs_setxattr+0x110/0x110
[ 1440.245319]  new_sync_read+0x24f/0x370
[ 1440.249067]  ? __ia32_sys_llseek+0x1d0/0x1d0
[ 1440.253332]  ? fsnotify+0x690/0x6d0
[ 1440.256835]  ? __fsnotify_update_child_dentry_flags.part.4+0x170/0x170
[ 1440.263389]  vfs_read+0xa6/0x1a0
[ 1440.266631]  kernel_read+0x69/0xa0
[ 1440.270048]  prepare_binprm+0x258/0x2c0
[ 1440.273894]  ? install_exec_creds+0xb0/0xb0
[ 1440.278081]  __do_execve_file.isra.42+0x990/0xfc0
[ 1440.282813]  ? copy_strings_kernel+0x90/0x90
[ 1440.287089]  ? strncpy_from_user+0xd6/0x1f0
[ 1440.291281]  __x64_sys_execve+0x54/0x60
[ 1440.295120]  do_syscall_64+0x68/0x190
[ 1440.298780]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1440.303815] RIP: 0033:0x7fdc18501b0b
[ 1440.307392] Code: 41 89 01 eb da 66 2e 0f 1f 84 00 00 00 00 00 f7 d8 64 41 89 01 eb d6 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 63 0f 00 f7 d8 64 89 01 48
[ 1440.326068] RSP: 002b:00007fff5c5819f8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[ 1440.333610] RAX: ffffffffffffffda RBX: 0000563a5d884f60 RCX: 00007fdc18501b0b
[ 1440.340724] RDX: 0000563a5d88d4a0 RSI: 00007fff5c581a10 RDI: 00007fff5c584e89
[ 1440.347825] RBP: 00007fff5c584e89 R08: 0000563a5d832290 R09: 0000000000000001
[ 1440.354931] R10: 00007fdc180a2e80 R11: 0000000000000202 R12: 0000563a5d88d4a0
[ 1440.362042] R13: 0000000000000000 R14: 0000563a5bb4fbe0 R15: 0000000000000136
[ 1440.369166] ---[ end trace e37d5da069ab7362 ]---

-- Steve
