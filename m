Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0101C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941A32077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J9FWJjMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfGQIHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:07:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iLU2s/x/XFW72g+7xvezzJr54C/QdMG1z8d7JQXMXK8=; b=J9FWJjMFAyNOd8WsBOxKRinrf
        wP3WpaAgLuIk031ZacSHHnBSrfYDruGVFJ5UpKsS5Ez5AfCmwJaD76jBOJysjM4kKLen3TCCc1VA+
        MiQO43HzGLaes05X7KjKESytTz+Ai5OTrIydm1LAwAE3TnhW/jqPknVRdegMqYJ6qbigUNHccIv7G
        x6ZXFjBQWYreYXFdCYuJ6kT3+6woQXXZOtL/YQbfu9bCY/SkFaDLlztKRwmb/6ZEoz8PUP8uwxSTT
        SlEOQPs6iV+TlJBAlyjAcM9h5Y+MFyTMkZYN+prG1GDxnsICxvz5rBYFxuNB6nqldHOjHRKT2iqTI
        YnPkk/4cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hneyE-0006ye-TP; Wed, 17 Jul 2019 08:07:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E3CD20B6BE82; Wed, 17 Jul 2019 10:07:25 +0200 (CEST)
Date:   Wed, 17 Jul 2019 10:07:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
Message-ID: <20190717080725.GK3402@hirez.programming.kicks-ass.net>
References: <20190711114054.406765395@infradead.org>
 <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 09:33:50PM +0200, Vegard Nossum wrote:
> ------------[ cut here ]------------
> General protection fault in user access. Non-canonical address?
> WARNING: CPU: 0 PID: 5039 at arch/x86/mm/extable.c:126
> ex_handler_uaccess+0x5d/0x70
> CPU: 0 PID: 5039 Comm: init Not tainted 5.2.0+ #124
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> Ubuntu-1.8.2-1ubuntu1 04/01/2014
> RIP: 0010:ex_handler_uaccess+0x5d/0x70
> Code: 5d 41 5c c3 e8 c4 8e 0e 00 80 3d e5 74 1e 01 00 75 d3 e8 b6 8e 0e 00
> 48 c7 c7 10 a7 fb 81 c6 05 d0 74 1e 01 01 e8 d1 43 01 00 <0f> 0b eb b7 0f 1f
> 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
> RSP: 0000:fffffe000000fc48 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: ffffffff81c07dac RCX: ffffffff811a887c
> RDX: 0000000000000000 RSI: ffffffff8289f05f RDI: 0000000000000093
> RBP: fffffe000000fcb8 R08: 00000036fe0f15d3 R09: 000000000000003f
> R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000d
> R13: 000000000000000d R14: 0000000000000000 R15: 0000000000000000
> FS:  00005555563ab8c0(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000001ff7 CR3: 000000003c804002 CR4: 00000000003606f0
> DR0: 0000000040209100 DR1: 00000000402091a1 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff1 DR7: 00000000000b062a
> Call Trace:
>  <#DB>
>  fixup_exception+0x50/0x6a
>  do_general_protection+0x40/0x160
>  general_protection+0x2d/0x40
> RIP: 0010:arch_stack_walk_user+0x71/0x100
> Code: 00 48 83 e8 10 49 39 c4 77 45 4c 8b 04 24 4c 89 e3 4d 89 fd 4c 89 fd
> 41 83 87 98 0a 00 00 01 0f 01 cb 0f ae e8 31 c0 4c 89 e2 <4c> 8b 33 4d 89 f4
> 85 c0 75 7a 48 8b 73 08 0f 01 ca 85 c0 74 1f 65
> RSP: 0000:fffffe000000fd68 EFLAGS: 00050046
> RAX: 0000000000000000 RBX: 854163717acc2789 RCX: ffffffff811ca27b
> RDX: 854163717acc2789 RSI: 0000000040209102 RDI: fffffe000000fdb8
> RBP: ffff88803d55d040 R08: ffffc9000520bf58 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 854163717acc2789
> R13: ffff88803d55d040 R14: 0000000000000093 R15: ffff88803d55d040
>  ? stack_trace_consume_entry+0x4b/0x80
>  ? arch_stack_walk_user+0x34/0x100
>  ? profile_setup.cold+0xc1/0xc1
>  stack_trace_save_user+0x71/0x9c
>  trace_buffer_unlock_commit_regs+0x1ae/0x270
>  trace_event_buffer_commit+0x90/0x240
>  trace_event_raw_event_preemptirq_template+0x9a/0x100
>  ? debug+0x16/0x70
>  ? perf_trace_preemptirq_template+0x120/0x120
>  ? trace_hardirqs_off_thunk+0x1a/0x1c
>  trace_hardirqs_off_caller+0xf4/0x150
>  trace_hardirqs_off_thunk+0x1a/0x1c
>  ? debug+0x11/0x70
>  debug+0x16/0x70
> RIP: 0010:copy_user_generic_unrolled+0xa0/0xc0
> Code: 7f 40 ff c9 75 b6 89 d1 83 e2 07 c1 e9 03 74 12 4c 8b 06 4c 89 07 48
> 8d 76 08 48 8d 7f 08 ff c9 75 ee 21 d2 74 10 89 d1 8a 06 <88> 07 48 ff c6 48
> ff c7 ff c9 75 f2 31 c0 0f 01 ca c3 0f 1f 40 00
> RSP: 0000:ffffc9000520be38 EFLAGS: 00040202
> RAX: ffff88803d55d09c RBX: ffff88803d55d040 RCX: 0000000000000001
> RDX: 0000000000000001 RSI: 0000000040209102 RDI: ffffc9000520be76
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffffffff000
> R13: 0000000040209102 R14: ffffc9000520be76 R15: 0000000000000000
>  </#DB>
>  __probe_kernel_read+0x57/0x90
>  is_prefetch.isra.0+0xb5/0x210
>  ? tracer_hardirqs_on+0x53/0x1a0
>  __bad_area_nosemaphore+0x9e/0x220
>  __do_page_fault+0x483/0x630
>  ? async_page_fault+0x8/0x40
>  async_page_fault+0x36/0x40
> RIP: 0033:0x40209102
> Code: 00 00 49 bc 00 20 23 40 00 00 00 00 49 bd 00 00 d0 40 00 00 00 00 49
> be ff ff ff ff ff ff ff ff 49 bf 00 50 80 40 00 00 00 00 <9c> 48 81 0c 24 00
> 04 00 00 48 81 0c 24 00 00 04 00 9d ff 2c 25 00
> RSP: 002b:0000000000001fff EFLAGS: 00010217
> RAX: 0000000000000000 RBX: 00000000402090b0 RCX: 0000000000000001
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000041ebb000
> RBP: 854163717acc2789 R08: 0000000000000001 R09: b1f39cc399a61ebb
> R10: 00007ffeab175000 R11: 0000000000000360 R12: 0000000040232000
> R13: 0000000040d00000 R14: ffffffffffffffff R15: 0000000040805000
> ---[ end trace e5e49800ff5aa5ed ]---


  https://lkml.kernel.org/r/57754f11-2c65-a2c8-2f6d-bfab0d2f8b53@etsukata.com

Does something like the below help?

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index c8d0f05721a1..80ad4ccb7025 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -226,12 +226,16 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 		.store	= store,
 		.size	= size,
 	};
+	mm_segment_t fs;
 
 	/* Trace user stack if not a kernel thread */
 	if (current->flags & PF_KTHREAD)
 		return 0;
 
+	fs = get_fs();
+	set_fs(USER_DS);
 	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
+	set_fs(fs);
 	return c.len;
 }
 #endif
