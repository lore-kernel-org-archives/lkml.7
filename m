Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C267C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 08:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA282085B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 08:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="g4KBVdoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfHCIcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 04:32:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37247 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387688AbfHCIcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 04:32:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id c9so54493182lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zliUaIFuAopeB3KZQoJf+MOQg1490L4qixnGkVFyCC8=;
        b=g4KBVdoU6LZkKj5EaHaSc3Ab+XV/TG0D74aXLkkWbxl2A8rXIgK9jRDqL+RcByc0S+
         Os+VPH9lmLCE9o2Y0CFEyMalUImG4B9+SXHPRv2zeNYQ8xWXA/nuudTzy64/IOBm612t
         AbY1Q/s8fSczz4TAFxU+edrKFtnytaYkuOMP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zliUaIFuAopeB3KZQoJf+MOQg1490L4qixnGkVFyCC8=;
        b=YyFyhCao81aH0XKT9GpzGNBoF34LRBGfGlcgggGo/MTxDdXbdBaOJ+j9NQ7W0pssVY
         Kv/UfTVP8W2g+IdIERBIdGaZLuoYSadYHspq1BLVoWz2qnDo1Ap66iD4QctKeh/z4k/y
         2HcFRFvfdpA5mM4t4AI/YJjqTk9E01BV4/yMPLarB2Q7ZVU23az2AdjGG9VyK2m+4/bT
         Jt8HmktXampxEghUTftAuXRKx1XTBP5quwK7gu4C+qnFq+ZNEE23TlMeiZulfrD7tnTs
         OZ6wJMUm4HQHs2FjZgS+dZtWgjOBBFjRQkTJzyfqVrAJgSWNKwAEnuoVEpVXZ+rXG9Tf
         cXMQ==
X-Gm-Message-State: APjAAAXjkEWjlR6V5nORdHq3dBh2yC5pmHGi1WBybqvaW5F4bBo+y0KC
        jltqbCSizS/050kglrsd/Az2rhQ944Lviedy6CY=
X-Google-Smtp-Source: APXvYqwwtK7sYxHHH5uf9Nu/AcA3yUDvbQtCmjTA5L8TRAMuQ1gOKOKzCgr/E3b7OkCOm0usRc+V7A7XnHNRv63ZHAU=
X-Received: by 2002:ac2:549b:: with SMTP id t27mr336621lfk.25.1564821150478;
 Sat, 03 Aug 2019 01:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190802094103.163576-1-jiping.ma2@windriver.com>
 <20190802112259.0530a648@gandalf.local.home> <20190803082642.GA224541@google.com>
In-Reply-To: <20190803082642.GA224541@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 3 Aug 2019 04:32:19 -0400
Message-ID: <CAEXW_YSUgqt2RykAXH+1hbVDka4CipNatK-ktZ5+W1e5nWMQvA@mail.gmail.com>
Subject: Re: [PATCH v3] tracing: Function stack size and its name mismatch in arm64
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiping Ma <jiping.ma2@windriver.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 3, 2019 at 4:26 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Aug 02, 2019 at 11:22:59AM -0400, Steven Rostedt wrote:
> [snip]
> > > There is not PC in ARM64 stack, LR is used to for walk_stackframe in
> > > ARM64. Tere is no the issue in ARM32 because there is PC in ARM32 stack.
> > > PC is used to calculate the stack size in trace_stack.c, so the
> > > function name and its stack size appear to be off-by-one.
> > > ARM64 stack layout:
> > >     LR
> > >         FP
> > >         ......
> > >         LR
> > >         FP
> > >         ......
> >
> > I think you are not explaining the issue correctly. From looking at the
> > document, I think what you want to say is that the LR is saved *after*
> > the data for the function. Is that correct? If so, then yes, it would
> > cause the stack tracing algorithm to be incorrect.
> >
> > Most archs do this:
> >
> > On entry to a function:
> >
> >       save return address
> >       reserve local variables and such for current function
> >
> > I think you are saying that arm64 does this backwards.
> >
> >       reserve local variables and such for current function
> >       save return address (LR)
>
> Actually for arm64 it is like what you said about 'Most archs'. It saves FP
> and LR first onto the current stack frame, then assigns the top of the stack
> to FP (marking the new frame). Then executes branch-link, and then allocates
> space to variables on stack in the callee.

Just to add to that, when the branch-link (BL) instruction is
executed, the Link Register (LR) will contain the return address. This
why the existing LR needs to be saved first before the call. The
existing LR will contain the return address of the caller's original
caller.
