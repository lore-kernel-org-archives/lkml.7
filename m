Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A1EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC83E2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oMQsnHpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfJJJ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:26:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58264 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfJJJ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ucBuyeeLDJsEtRowiGWFwWwG4ORGoQdlz5htLCYYsjU=; b=oMQsnHpAQk9OJrJso9AZyVhV9
        I6L8cIV20qnY4sdQWKULfXz+/2pFVxK2/2UZmjxUzgCCTXC8yLN9SoEZpDVwJaxbA9F99uYtbN+Iw
        QY70/Nfs/4VzPiW+FbvOnplREOJ/KlwMEnJswY0GPLpyTTmBwlBxr0RCqqM8pHrwjjICMhLf9RNk2
        rqf+XCO+F9iCpc2k8dELgE+/kg4z+fW9cSQQyno/2bOBCP7agQIyDdvGuGZm9bFlJJgknGsgpDXe2
        huJE7n6/+xkzVQ0D7bxF5QVAAyh/s7HEq3L66NkrOgimmehowZflB51afPF1rnp87adc2eQqUz+qq
        YTh3cHnIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIUhz-00016o-Dn; Thu, 10 Oct 2019 09:26:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6CA93008C1;
        Thu, 10 Oct 2019 11:25:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9DA720C3749D; Thu, 10 Oct 2019 11:26:05 +0200 (CEST)
Date:   Thu, 10 Oct 2019 11:26:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191010092605.GH2359@hirez.programming.kicks-ass.net>
References: <20191009223638.60b78727@oasis.local.home>
 <20191010073121.GN2311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010073121.GN2311@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 09:31:21AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 09, 2019 at 10:36:38PM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > In the process of using text_poke_bp() for ftrace on x86, when
> > performing the following action:
> > 
> >  # rmmod snd_hda_codec_hdmi
> >  # echo function > /sys/kernel/tracing/current_tracer
> >  # modprobe snd_hda_codec_hdmi
> > 
> > It triggered this:
> > 
> >  BUG: unable to handle page fault for address: ffffffffa03d0000
> >  #PF: supervisor write access in kernel mode
> >  #PF: error_code(0x0003) - permissions violation
> >  PGD 2a12067 P4D 2a12067 PUD 2a13063 PMD c42bc067 PTE c58a0061
> >  Oops: 0003 [#1] PREEMPT SMP KASAN PTI
> >  CPU: 1 PID: 1182 Comm: modprobe Not tainted 5.4.0-rc2-test+ #50
> >  Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
> >  RIP: 0010:memcpy_erms+0x6/0x10
> >  Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
> >  RSP: 0018:ffff8880a10479e0 EFLAGS: 00010246
> >  RAX: ffffffffa03d0000 RBX: ffffffffa03d0000 RCX: 0000000000000005
> >  RDX: 0000000000000005 RSI: ffffffff8363e160 RDI: ffffffffa03d0000
> >  RBP: ffff88807e9ec000 R08: fffffbfff407a001 R09: fffffbfff407a001
> >  R10: fffffbfff407a000 R11: ffffffffa03d0004 R12: ffffffff8221f160
> >  R13: ffffffffa03d0000 R14: ffff88807e9ec000 R15: ffffffffa0481640
> >  FS:  00007eff92e28280(0000) GS:ffff8880d4840000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: ffffffffa03d0000 CR3: 00000000a1048001 CR4: 00000000001606e0
> >  Call Trace:
> >   ftrace_make_call+0x76/0x90
> >   ftrace_module_enable+0x493/0x4f0
> >   load_module+0x3a31/0x3e10
> >   ? ring_buffer_read+0x70/0x70
> >   ? module_frob_arch_sections+0x20/0x20
> >   ? rb_commit+0xee/0x600
> >   ? tracing_generic_entry_update+0xe1/0xf0
> >   ? ring_buffer_unlock_commit+0xfb/0x220
> >   ? 0xffffffffa0000061
> >   ? __do_sys_finit_module+0x11a/0x1b0
> >   __do_sys_finit_module+0x11a/0x1b0
> >   ? __ia32_sys_init_module+0x40/0x40
> >   ? ring_buffer_unlock_commit+0xfb/0x220
> >   ? function_trace_call+0x179/0x260
> >   ? __do_sys_finit_module+0x1b0/0x1b0
> >   ? __do_sys_finit_module+0x1b0/0x1b0
> >   ? do_syscall_64+0x58/0x1a0
> >   do_syscall_64+0x68/0x1a0
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >  RIP: 0033:0x7eff92f42efd
> > 
> > The reason is that ftrace_module_enable() is called after the module
> > has set its text to read-only. There's subtle reasons that this needs
> > to be called afterward, and we need to continue to do so.
> 
> Please explain.

Also, no. If you _have_ to modify code after, then you get to use
text_poke_bp() instead of text_poke_early().

But first we need to document why this needs to be late. That's the
crucial point and you forgot to explain.
