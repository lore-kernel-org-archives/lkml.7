Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F7DC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ED821E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvO/Ssjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGCA1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:27:11 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46492 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGCA1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:27:10 -0400
Received: by mail-pl1-f180.google.com with SMTP id e5so169989pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVeYE2lI3WjawRv5ylltj1PK2bEL0Yzgl985bGk3R7M=;
        b=KvO/SsjqdxRY1GxdPcOT/aUG+OCDqrC5o062EDydJkQwDn15z49XNA58ZDfb6j1t5H
         kvutHrNu83NbGoz3jDaV9tcr+6KOKbq16/a08aFJ3qBT+oStKFYlyTzDSIgyiMoTkJs0
         oDkPHlotReORAfGrHzpyWVk1onuPIT6px7Cb2awzWJZAcNDPZfBACr4w/0U69zZ5qKKc
         wCU86cFAHk5rUUrN2urt3y2FWUt4qK+uiFYhE4jc5q+Vwrtk90O5GgI3KymDbQj6btQR
         JQPc1tZdI9uTStT+zlmGJt/FgtV+Y98ddtiyN76rSEbSlP74wHDEC1iKmV1NGs1cPphq
         dGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVeYE2lI3WjawRv5ylltj1PK2bEL0Yzgl985bGk3R7M=;
        b=FAEGMMCnTRWPThIwTHQIK2t/Ea51+gXWDjLJi70j2Hr708vtpDXdoaqFeYKK7clBjT
         X31hVvaQMlDvaHVOt6yij9Fov2xQerwzNskLIa69zUanjZqS/bTgXAnVPt3udjeLVbJk
         LrnhmH1LHAcl6hg6BISgebNAt4PJQx3AAwJ8+IdALr0mv+f/nD/PV1V1GGGooCX1xED3
         1u6TATZ0JdFw27ZfgKpjkhu5uDDkxcdx+JA1hlxmUzfqg86/qvtk1b++Xw5zhj0LLbOL
         RqzerRzYloAu/Ag9UH61e/SFVN483rCFHBp89+qvk48n6mH+J0gAat7JLVc4tu5mFPtG
         ISPg==
X-Gm-Message-State: APjAAAXHm3E9fOm23DkBLgs5u1KSfZS2k+T3GltZ3HgXQQnnYCeSqOlo
        hXagk4WkZzeH6EdGt1DCBMQsBfW8GlF8WH9s49E8lFEEW+s=
X-Google-Smtp-Source: APXvYqzNWCKTQ7od3rLKjPwNO09v1yntf67yfperr1BKlEPuIBGnS7KugcRWUK2CbdZZ5sRr5Vlp700rWDEiIIKiiLY=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr36225620pld.119.1562106849868;
 Tue, 02 Jul 2019 15:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
 <alpine.DEB.2.21.1907022332000.1802@nanos.tec.linutronix.de>
 <CAKwvOdn-=u1v8B1ni8QqiOXaimhc_tG6O=8kMb4c2vv62=D42g@mail.gmail.com> <alpine.DEB.2.21.1907030018170.1802@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907030018170.1802@nanos.tec.linutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Jul 2019 15:33:58 -0700
Message-ID: <CAKwvOdkN8FyvpjiuW+cA0+qGQSNvzSbA0Hop69QxQAbTMqNTMw@mail.gmail.com>
Subject: Re: objtool warnings in prerelease clang-9
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>,
        Chandler Carruth <chandlerc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 3:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Nick,
>
> On Tue, 2 Jul 2019, Nick Desaulniers wrote:
> > On Tue, Jul 2, 2019 at 2:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Tue, 2 Jul 2019, Nick Desaulniers wrote:
> >
> > > > This causes objtool to not find any issues in
> > > > arch/x86/kernel/cpu/mtrr/generic.o.  I don't observe any duplication
> > > > in the __jump_table section of the resulting .o file.  It also cuts
> > > > down the objtool warnings I observe in a defconfig (listed at the
> > > > beginning of the email) from 4 to 2. (platform-quirks.o predates asm
> > > > goto,
> > >
> > > It does not have asm goto inside :)
> >
> > I think you're conflating arch/x86/kernel/cpu/mtrr/generic.o with
> > arch/x86/kernel/platform-quirks.o.
>
> Nope. I deliberately split the quote after the platform-quirks part so the
> reply goes near to it. Seems it wasn't as obvious as I thought :)

Oh yes, sorry, I see now what you meant.
-- 
Thanks,
~Nick Desaulniers
