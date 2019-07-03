Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE410C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0572218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562192824;
	bh=54TJQdnmI9JIs7sWIgYE9UCADvIt2r39ssBw13F7Kc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AqdnQgj/1vKHosaV/ofFqQzITVyq8hkl8QR32zy8e9iDNCq0Xjz4aHtwOSGM4Dud8
	 YXqgO0YXRVQHWkuzJ95zp832ju5QEAeWuxEc1ikX6wKtNEqqSqnQg5920+Cy7Y3EDP
	 jNpWKWc+xbbCeSCxwMuklNQDV9InLmourxSGJ1Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfGCW1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfGCW1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:27:02 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42BF3218BA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2019 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562192821;
        bh=54TJQdnmI9JIs7sWIgYE9UCADvIt2r39ssBw13F7Kc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wr6r8hn0+u4xuDAmaFtOooZkqTaLMD5/MjU59XcM7mVU/EX15u1jID8nIi9mAfv3B
         Yoea+eS8UJlTXSUZXM5Es/Vw7xSnhQdeJQEgONaMnO0ztzFUdaSBvsVPm3UBXwM/NK
         vmqa8UC1cqXJig+N2OKGY5cuJlPPRXtQA4snemcg=
Received: by mail-wm1-f42.google.com with SMTP id c6so3995767wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 15:27:01 -0700 (PDT)
X-Gm-Message-State: APjAAAWkmq1nSM6npEfdqsmPQTbZeMwYeOs9top4quCDEo0Z3VM1pkMz
        owN11obWGGzzAh4aRBL2m3+YOK+CHf21zURhA+DZwg==
X-Google-Smtp-Source: APXvYqxF3U2OW9rexTtLNZvPFG3EuT8YJk1XnSYqRuywgPoqAC8039SaP1Ldg02xrhCtt1keIB6RuDIfAF2nAeEOrFs=
X-Received: by 2002:a7b:c149:: with SMTP id z9mr879318wmi.0.1562192819761;
 Wed, 03 Jul 2019 15:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190703102731.236024951@infradead.org> <20190703102807.588906400@infradead.org>
 <CALCETrVR2_5-=FcJdB3OaKjif9EEzoq+YDhNfPjahVM3JUUrUQ@mail.gmail.com> <20190703220057.GJ3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190703220057.GJ3402@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 3 Jul 2019 15:26:47 -0700
X-Gmail-Original-Message-ID: <CALCETrUEsKt=CyM634Lp265hjJg0Jm==gvN_-_UwGp9S6Mt=MA@mail.gmail.com>
Message-ID: <CALCETrUEsKt=CyM634Lp265hjJg0Jm==gvN_-_UwGp9S6Mt=MA@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/mm, tracing: Fix CR2 corruption
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 3:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 03, 2019 at 01:27:09PM -0700, Andy Lutomirski wrote:
> > On Wed, Jul 3, 2019 at 3:28 AM root <peterz@infradead.org> wrote:
>
> > > @@ -1338,18 +1347,9 @@ ENTRY(error_entry)
> > >         movq    %rax, %rsp                      /* switch stack */
> > >         ENCODE_FRAME_POINTER
> > >         pushq   %r12
> > > -
> > > -       /*
> > > -        * We need to tell lockdep that IRQs are off.  We can't do this until
> > > -        * we fix gsbase, and we should do it before enter_from_user_mode
> > > -        * (which can take locks).
> > > -        */
> > > -       TRACE_IRQS_OFF
> >
> > This hunk looks wrong.  Am I missing some other place that handles the
> > case where we enter from kernel mode and IRQs were on?
>
> > > -   CALL_enter_from_user_mode
> > >     ret
> > >
> > >  .Lerror_entry_done:
> > > -   TRACE_IRQS_OFF
> > >     ret
> > >
> > >     /*
>
> Did you perchance mean to complain about the .Lerror_entry_done one?

Yes, duh.

I would suggest compiling with DEBUG_LOCKDEP and running perf and the
x86 selftests.  IIRC that's what catches most of the IRQ flag tracing
errors.

>
> Because I'm not seeing how the one before CALL_enter_from_user_mode can
> ever be from-kernel.
>
> But yes, that .Lerror_entry_done one looks fishy.
