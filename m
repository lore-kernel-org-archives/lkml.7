Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E71C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A02206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p4MttR64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfG2Jf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:35:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfG2Jfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=holG7IqjUcljSxxM2S+TjFVhu9NMDj7OJSD6E50qkBw=; b=p4MttR64uYFYXHxpz9W79sCUF
        qnikm0he/3QDFLQXnTsQV83E5+fyf4+okJkFCz/8gDPTJfSZ9Xz5JJVafoKp5epLnXIgEF0kfThQq
        z0WzQ0IfYyOEV54kONRU7IiEHHAeImPDMqaj4+PBjUZFET8FSv2psE7ijM/n1cnopDWZkmwGjsVtE
        xeUG+VpuDQgwZLzQy+GLDf6SdBFRa7a/cWAefHnxRMC8/XHA/KlEykbBf/hHCpa1rEyRhySR7VLa8
        S91u7xAyPONTnFsuXX+T4WMVf/KnhcIuBqtkOyZzJR3Xc6ZqvHbb/rTogfMzPbJGGQUDinu9fg6gE
        0kyXRipCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs24J-0006kt-BL; Mon, 29 Jul 2019 09:35:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9943C20227071; Mon, 29 Jul 2019 11:35:45 +0200 (CEST)
Date:   Mon, 29 Jul 2019 11:35:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
Message-ID: <20190729093545.GV31381@hirez.programming.kicks-ass.net>
References: <20190727164450.GA11726@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727164450.GA11726@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 09:44:50AM -0700, Guenter Roeck wrote:
> Hi,
> 
> I see the following traceback (or similar tracebacks) once in a while
> during my boot tests. In this specific case it is with mainline
> (v5.3-rc1-195-g3ea54d9b0d65), but I have seen it with other branches
> as well. This isn't a new problem; I have seen it for quite some time.
> There is no specific action required to make it appear; just running
> reboot loops is sufficient. The problem doesn't happen a lot;
> non-scientifically I would say I see it maybe once every few hundred
> boots.
> 
> No specific action requested or asked for; this is just informational.
> 
> A complete log is at:
> https://kerneltests.org/builders/qemu-x86-master/builds/1285/steps/qemubuildcommand/logs/stdio
> 
> Guenter
> 
> ---
> [   61.248329] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [   61.268277] e1000e: EEE TX LPI TIMER: 00000000
> [   61.311435] reboot: Restarting system
> [   61.312321] reboot: machine restart
> [   61.342193] ------------[ cut here ]------------
> [   61.342660] sched: Unexpected reschedule of offline CPU#2!
> ILLOPC: ce241f83: 0f 0b
> [   61.344323] WARNING: CPU: 1 PID: 15 at arch/x86/kernel/smp.c:126 native_smp_send_reschedule+0x33/0x40
> [   61.344836] Modules linked in:
> [   61.345694] CPU: 1 PID: 15 Comm: ksoftirqd/1 Not tainted 5.3.0-rc1+ #1
> [   61.345998] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [   61.346569] EIP: native_smp_send_reschedule+0x33/0x40
> [   61.347099] Code: cf 73 1c 8b 15 60 54 2b cf 8b 4a 18 ba fd 00 00 00 e8 05 65 c7 00 c9 c3 8d b4 26 00 00 00 00 50 68 04 ca 1a cf e8 fe e3 01 00 <0f> 0b 58 5a c9 c3 8d b4 26 00 00 00 00 55 89 e5 56 53 83 ec 0c 65
> [   61.347726] EAX: 0000002e EBX: 00000002 ECX: 00000000 EDX: cdd64140
> [   61.347977] ESI: 00000002 EDI: 00000000 EBP: cdd73c88 ESP: cdd73c80
> [   61.348234] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000096
> [   61.348514] CR0: 80050033 CR2: b7ee7048 CR3: 0c28f000 CR4: 000006d0
> [   61.348866] Call Trace:
> [   61.349392]  kick_ilb+0x90/0xa0
> [   61.349629]  trigger_load_balance+0xf0/0x5c0
> [   61.349859]  ? check_preempt_wakeup+0x1b0/0x1b0
> [   61.350057]  scheduler_tick+0xa7/0xd0

kick_ilb() iterates nohz.idle_cpus_mask to find itself an idle_cpu().

idle_cpus_mask() is set from nohz_balance_enter_idle() and cleared from
nohz_balance_exit_idle(). nohz_balance_enter_idle() is called from
__tick_nohz_idle_stop_tick() when entering nohz idle, this includes the
cpu_is_offline() clause of the idle loop.

However, when offline, cpu_active() should also be false, and this
function should no-op.

Then we have nohz_balance_exit_idle() from sched_cpu_dying(), which
should explicitly clear the CPU from the mask when going offline.

So I'm not immediately seeing how we can select an offline CPU to kick.


