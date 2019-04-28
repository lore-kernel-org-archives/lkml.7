Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E98C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4670206C1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfD1Tnu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfD1Tnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 15:43:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6A1420679;
        Sun, 28 Apr 2019 19:43:46 +0000 (UTC)
Date:   Sun, 28 Apr 2019 15:43:45 -0400
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
Message-ID: <20190428154345.789635b3@oasis.local.home>
In-Reply-To: <D5735AF7-D603-4B20-A3EE-B519044D1E5D@amacapital.net>
References: <20190427100639.15074-1-nstange@suse.de>
        <20190427100639.15074-2-nstange@suse.de>
        <F6268634-96D3-4267-B739-6D375FAB26A8@amacapital.net>
        <20190428135143.09d35bb6@oasis.local.home>
        <D5735AF7-D603-4B20-A3EE-B519044D1E5D@amacapital.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Apr 2019 11:08:34 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> > 
> > Perhaps adding another slot into pt_regs that gets used by int3 to
> > store a slot to emulate a call on return?
> > 
> >   
> 
> That’s not totally nuts, although finding pt_regs isn’t entirely trivial.

I meant on the int3 handler (which stores the pt_regs).

> 
> I still think I prefer an approach where we just emulate the call directly.

Then, on the return of int3, if there's anything in that slot, then we
could possibly shift the exception handler frame (that was added by the
hardware), insert the slot data into the top of the stack, and then
call iret (which the int3 handler, would add the return ip to be the
function being called), which would in essence emulate the call directly.

I believe the complexity comes from the exception frame added by the
hardware is where we need to put the return of the call for the
emulation.

-- Steve
