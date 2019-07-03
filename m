Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89436C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6336921882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfGCUrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCUrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:47:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8BF1218A3;
        Wed,  3 Jul 2019 20:47:03 +0000 (UTC)
Date:   Wed, 3 Jul 2019 16:47:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     root <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Subject: Re: [PATCH 3/3] x86/mm, tracing: Fix CR2 corruption
Message-ID: <20190703164701.54ef979a@gandalf.local.home>
In-Reply-To: <CALCETrVR2_5-=FcJdB3OaKjif9EEzoq+YDhNfPjahVM3JUUrUQ@mail.gmail.com>
References: <20190703102731.236024951@infradead.org>
        <20190703102807.588906400@infradead.org>
        <CALCETrVR2_5-=FcJdB3OaKjif9EEzoq+YDhNfPjahVM3JUUrUQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 13:27:09 -0700
Andy Lutomirski <luto@kernel.org> wrote:


> > @@ -1180,10 +1189,10 @@ idtentry xenint3                do_int3                 has_error_co
> >  #endif
> >
> >  idtentry general_protection    do_general_protection   has_error_code=1
> > -idtentry page_fault            do_page_fault           has_error_code=1
> > +idtentry page_fault            do_page_fault           has_error_code=1        read_cr2=1
> >
> >  #ifdef CONFIG_KVM_GUEST
> > -idtentry async_page_fault      do_async_page_fault     has_error_code=1
> > +idtentry async_page_fault      do_async_page_fault     has_error_code=1        read_cr2=1
> >  #endif
> >
> >  #ifdef CONFIG_X86_MCE
> > @@ -1338,18 +1347,9 @@ ENTRY(error_entry)
> >         movq    %rax, %rsp                      /* switch stack */
> >         ENCODE_FRAME_POINTER
> >         pushq   %r12
> > -
> > -       /*
> > -        * We need to tell lockdep that IRQs are off.  We can't do this until
> > -        * we fix gsbase, and we should do it before enter_from_user_mode
> > -        * (which can take locks).
> > -        */
> > -       TRACE_IRQS_OFF  
> 
> This hunk looks wrong.  Am I missing some other place that handles the
> case where we enter from kernel mode and IRQs were on?

Yeah, looks like we might be missing a TRACE_IRQS_OFF from the
from_usermode_stack_switch path.

-- Steve
