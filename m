Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA886CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D74021872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571933924;
	bh=hqVw2CfkuDpCReYQpVPUdZMTX306EhtBcgoPSJOsN8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e/lxyFk/mw3iRtP7qUvo2YWhO2u8bEqs2yozZq9m+CfAKI8Vw3b1Hn3eOTgUQTRnt
	 AafirLfPtDnrOt/SUDyN047sulvfmurO2W3bQYekYeLG3dGObO+BEZHp3kXQ30qSwW
	 S6xv1q+3DEuwm0fmHKDJo/IW2ZY5Scb2Y3rREsxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439782AbfJXQSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439771AbfJXQSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:18:43 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8147E21D71
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571933921;
        bh=hqVw2CfkuDpCReYQpVPUdZMTX306EhtBcgoPSJOsN8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YuONv0zjyooTw5EzBFHZ+d1WPpe7ePP7JFGd9g8Xvcdxp5jB91QtALUIM9yCm1fsB
         WznBi7LPAE6yRdV7SPAgRFMo+++htnKc1X4n4b75Z4+jPC0G1cyubBUjwhPm9y8NM5
         ScmiCywZTQeSJ94V80AJefCAUvYOXFhKspW9aDII=
Received: by mail-wr1-f51.google.com with SMTP id z11so3391500wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:18:41 -0700 (PDT)
X-Gm-Message-State: APjAAAWwXk6KSPNREWw6twypQg5A3cHhgJCKRh+RH6YRk472+091R2Ja
        NvO8eusam/eOsBcdln5XOfO0bthwyIgusTxlC6p06Q==
X-Google-Smtp-Source: APXvYqwZ4YJrjYk6QF+5lCb0xhRWY6z2YGe3C91dvqETvmz9oQm459bN5hIePwJfq3A8uLCu5XSi1H3ybkHIPu8sa4U=
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr4403914wrt.195.1571933919909;
 Thu, 24 Oct 2019 09:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191023122705.198339581@linutronix.de> <20191023123118.296135499@linutronix.de>
 <20191023220618.qsmog2k5oaagj27v@treble> <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 24 Oct 2019 09:18:26 -0700
X-Gmail-Original-Message-ID: <CALCETrX+N_cR-HAmQyHxqUo0LPCk4GmqbzizXk-gq9qp00-RdA@mail.gmail.com>
Message-ID: <CALCETrX+N_cR-HAmQyHxqUo0LPCk4GmqbzizXk-gq9qp00-RdA@mail.gmail.com>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt disable
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 4:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 23 Oct 2019, Josh Poimboeuf wrote:
>
> > On Wed, Oct 23, 2019 at 02:27:12PM +0200, Thomas Gleixner wrote:
> > > Now that the trap handlers return with interrupts disabled, the
> > > unconditional disabling of interrupts in the low level entry code can be
> > > removed along with the trace calls.
> > >
> > > Add debug checks where appropriate.
> >
> > This seems a little scary.  Does anybody other than Andy actually run
> > with CONFIG_DEBUG_ENTRY?
>
> I do.
>
> > What happens if somebody accidentally leaves irqs enabled?  How do we
> > know you found all the leaks?
>
> For the DO_ERROR() ones that's trivial:
>
>  #define DO_ERROR(trapnr, signr, sicode, addr, str, name)                  \
>  dotraplinkage void do_##name(struct pt_regs *regs, long error_code)       \
>  {                                                                         \
>         do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
> +       lockdep_assert_irqs_disabled();                                    \
>  }
>
>  DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
>
> Now for the rest we surely could do:
>
> dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
> {
>         __do_bounds(regs, error_code);
>         lockdep_assert_irqs_disabled();
> }
>
> and move the existing body into a static function so independent of any
> (future) return path there the lockdep assert will be invoked.
>

If we do this, can we macro-ize it:

DEFINE_IDTENTRY_HANDLER(do_bounds)
{
 ...
}

If you do this, please don't worry about the weird ones that take cr2
as a third argument.  Once your series lands, I will send a follow-up
to get rid of it.  It's 2/3 written already.
