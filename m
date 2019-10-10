Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE313ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE55821848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbfJJClj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfJJClj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:41:39 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8EB12086D;
        Thu, 10 Oct 2019 02:41:36 +0000 (UTC)
Date:   Wed, 9 Oct 2019 22:41:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191009224135.2dcf7767@oasis.local.home>
In-Reply-To: <20191008104335.6fcd78c9@gandalf.local.home>
References: <20191007081716.07616230.8@infradead.org>
        <20191007081945.10951536.8@infradead.org>
        <20191008104335.6fcd78c9@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 10:43:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> BTW, I'd really like to take this patch series through my tree. That
> way I can really hammer it, as well as I have code that will be built
> on top of it.

I did a bit of hammering and found two bugs. One I sent a patch to fix
(adding a module when tracing is enabled), but the other bug I
triggered, I'm too tired to debug right now. But figured I'd mention it
anyway.

If you add on the kernel command line:

 ftrace=function ftrace_filter=schedule

You will get this (note, I had KASAN enabled, so it showed more info):



[    1.274356] ftrace: allocating 34274 entries in 134 pages
[    1.320059] Starting tracer 'function'
[    1.323724] ==================================================================
[    1.330798] BUG: KASAN: null-ptr-deref in __get_locked_pte+0x21/0x210
[    1.337186] Read of size 8 at addr 0000000000000050 by task swapper/0
[    1.343579]
[    1.345049] CPU: 0 PID: 0 Comm: swapper Not tainted 5.4.0-rc2-test+ #50
[    1.351613] Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
[    1.360510] Call Trace:
[    1.362932]  dump_stack+0x7c/0xc0
[    1.366213]  ? __get_locked_pte+0x21/0x210
[    1.370272]  ? __get_locked_pte+0x21/0x210
[    1.374331]  __kasan_report.cold.10+0x5/0x3e
[    1.378566]  ? __get_locked_pte+0x21/0x210
[    1.382625]  kasan_report+0xe/0x20
[    1.385993]  __get_locked_pte+0x21/0x210
[    1.389880]  ? 0xffffffffa000005c
[    1.393162]  __text_poke+0x1ca/0x5b0
[    1.396705]  ? optimize_nops.isra.8+0xd0/0xd0
[    1.401023]  ? insn_get_length+0x4f/0x70
[    1.404910]  ? text_poke_loc_init+0x186/0x220
[    1.409229]  ? text_poke_kgdb+0x10/0x10
[    1.413031]  ? 0xffffffffa0000000
[    1.416312]  text_poke_bp_batch+0xb4/0x1e0
[    1.420372]  ? __text_poke+0x5b0/0x5b0
[    1.424088]  ? do_raw_spin_lock+0x113/0x1d0
[    1.428233]  ? 0xffffffffa000005c
[    1.431515]  ? 0xffffffffa0000000
[    1.434797]  text_poke_bp+0x7a/0xa0
[    1.438253]  ? text_poke_queue+0xb0/0xb0
[    1.442139]  ? 0xffffffffa0000000
[    1.445421]  ? 0xffffffffa000005c
[    1.448706]  ? find_vmap_area+0x56/0x80
[    1.452505]  arch_ftrace_update_trampoline+0x114/0x380
[    1.457603]  ? ftrace_caller+0x4e/0x4e
[    1.461316]  ? 0xffffffffa0000091
[    1.464599]  ? arch_ftrace_update_code+0x10/0x10
[    1.469179]  ? mutex_lock+0x86/0xd0
[    1.472634]  ? __mutex_lock_slowpath+0x10/0x10
[    1.477039]  ? mutex_unlock+0x1d/0x40
[    1.480668]  ? arch_jump_label_transform_queue+0x7a/0x90
[    1.485937]  ? __jump_label_update+0x91/0x140
[    1.490256]  ? mutex_unlock+0x1d/0x40
[    1.493885]  ? tracing_start_sched_switch.cold.0+0x60/0x60
[    1.499327]  __register_ftrace_function+0xaf/0xf0
[    1.503991]  ftrace_startup+0x24/0x130
[    1.507706]  register_ftrace_function+0x2d/0x80
[    1.512198]  function_trace_init+0xc1/0x100
[    1.516346]  tracing_set_tracer+0x1fb/0x3c0
[    1.520492]  ? free_snapshot+0x50/0x50
[    1.524205]  ? __kasan_kmalloc.constprop.6+0xc1/0xd0
[    1.529131]  ? __list_add_valid+0x29/0xa0
[    1.533106]  register_tracer+0x235/0x26c
[    1.536993]  early_trace_init+0x29b/0x3a0
[    1.540967]  start_kernel+0x2a3/0x5f7
[    1.544595]  ? mem_encrypt_init+0x6/0x6
[    1.548396]  ? load_ucode_intel_bsp+0x5e/0xa3
[    1.552715]  ? init_intel_microcode+0xc3/0xc3
[    1.557036]  ? load_ucode_bsp+0xcc/0x154
[    1.560923]  secondary_startup_64+0xa4/0xb0
[    1.565070] ==================================================================


-- Steve
