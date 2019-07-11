Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAE4C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D593208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="epwk97CN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfGKS21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 14:28:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57008 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfGKS21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HxCzNxOIQZt0+rty3Kl/rNo0J5gMjFED9BopvcOajow=; b=epwk97CN0mtq8nEP+YnTndzhY
        eiJZj4hzSx9Fpv/RQqX7l0ibb7481zhrONbKlzm0pe2U/PRSrQ6Z6XF5elLj1aWrui5xqC6PSAx/M
        jm1VgmsHDeXrgz+vl46Xgr/ikJ36vbx4RNDFmvwTXIRFgspHztzGlTY93BGCEuHnKiTMgrO8jKody
        8wwirJTLm1WgPSBvKuF55rw+zNV+HGzF44AsIE6kSy6s7LT709k8AhEKBvohJlF3JQLpDrhvWxZEL
        geNIixKjs+lWlpzGEeDrxEA4fM0HefqVvYb3yqhZURQd5N3eJ2CW/1k103OL3t2i1vnGfC7a4NzU3
        Vj59dIuzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hldnY-0005x9-Sl; Thu, 11 Jul 2019 18:28:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F5D720B627C7; Thu, 11 Jul 2019 20:28:02 +0200 (CEST)
Date:   Thu, 11 Jul 2019 20:28:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Subject: Re: [PATCH v3 6/6] x86/entry/64: Remove TRACE_IRQS_*_DEBUG
Message-ID: <20190711182802.GH3402@hirez.programming.kicks-ass.net>
References: <20190711114054.406765395@infradead.org>
 <20190711114336.174080643@infradead.org>
 <CALCETrWYZHhP80PBxOcm5sc=p=StUbuwdvjDj-E3ma7wi3w-Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWYZHhP80PBxOcm5sc=p=StUbuwdvjDj-E3ma7wi3w-Pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 07:45:56AM -0700, Andy Lutomirski wrote:
> On Thu, Jul 11, 2019 at 4:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Since INT3/#BP no longer runs on an IST, this workaround is no longer
> > required.
> >
> > Tested by running lockdep+ftrace as described in the initial commit:
> >
> >   5963e317b1e9 ("ftrace/x86: Do not change stacks in DEBUG when calling lockdep")
> >
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I would definitely like to see this happen, but there are all kinds of
> possibly nasties here.  Ideally we'd like get rid of IST for #DB, but
> we can't due to the MOV SS mess.  There are a few relevant cases we
> care about:
> 
> #DB from user mode -> anything that hits in C code: irrelevant --
> we've exited the IST stack already.
> 
> #DB from user mode -> NMI/MCE in the asm -> #DB: The NMI code tries to
> get this right.  The MCE code does not.
> 
> #DB from kernel mode -> NMI/MCE -> #DB: same as above.
> 
> MOV SS -> #DB from entry -> #DB again: ugh.  We get some protection
> from shift_ist.
> 
> IMO we would ideally just clear DR7 in sensitive contexts.  Or extend
> the debug_stack_set_zero(), etc hack.
> 
> All that being said, the actual _DEBUG macros shouldn't matter here, I
> think.  But I'd like to sleep on it.   So not-yet-acked-by me.

How about something lovely like:

#DB from kernel space; in say lockdep.
the #DB entry calls back into lockdep through trace_irq
which then hits the same #DB

and we get recursive #DB.

Now, I don't think we can actually make that happen, because most/all
the relevant functions have NOKPROBE_SYMBOL() on. Even the idtentry
generates _ASM_NOKPROBE().

Still, it might make sense to have #DB itself clear/restore DR7 if it
doesn't already.

Also, the comment on do_debug() seems wrong; we can set watchpoints on
kernel text just fine these days.
