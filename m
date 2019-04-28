Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8B7C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAA620693
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfD1Rvs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 13:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfD1Rvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 13:51:48 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 351F420679;
        Sun, 28 Apr 2019 17:51:45 +0000 (UTC)
Date:   Sun, 28 Apr 2019 13:51:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/thread_info: introduce ->ftrace_int3_stack
 member
Message-ID: <20190428135143.09d35bb6@oasis.local.home>
In-Reply-To: <F6268634-96D3-4267-B739-6D375FAB26A8@amacapital.net>
References: <20190427100639.15074-1-nstange@suse.de>
        <20190427100639.15074-2-nstange@suse.de>
        <F6268634-96D3-4267-B739-6D375FAB26A8@amacapital.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Apr 2019 10:41:10 -0700
Andy Lutomirski <luto@amacapital.net> wrote:


> > Note that at any given point
> > in time, there can be at most four such call insn emulations pending:
> > namely at most one per "process", "irq", "softirq" and "nmi" context.
> >   
> 
> That’s quite an assumption. I think your list should also contain
> exception, exceptions nested inside that exception, and machine
> check, at the very least.  I’m also wondering why irq and softirq are
> treated separately.

4 has usually been the context count we choose. But I guess in theory,
if we get exceptions then I could potentially be more.

As for irq vs softirq, an interrupt can preempt a softirq. Interrupts
are enabled while softirqs are running. When sofirqs run, softirqs are
disabled to prevent nested softirqs. But interrupts are enabled again,
and another interrupt may come in while a softirq is executing.

> 
> All this makes me think that one of the other solutions we came up
> with last time we discussed this might be better.

+100

Perhaps adding another slot into pt_regs that gets used by int3 to
store a slot to emulate a call on return?

-- Steve

