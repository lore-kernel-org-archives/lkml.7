Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21131C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE774205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfH0TrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:47:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45156 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfH0TrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:47:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so232665qki.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4To99pYhN71BTubz3nGrKNYdHAubr+/NI0V79/X3hJs=;
        b=eIER/fcg/bb8CtoL5M4B+mNljjXp5kYb0V3ZF5yO7nse6FdkZsPzDBdSDaXT9QRGu+
         P8+fkpDAHCx+UpRSRbir2PSrujt2k4/SukSqICpKycHpCilZ+VZQ3Ab7cw7iqrN6TSB2
         IBgSuCepQV7c2Is7urtvI+/ZQtdFCczXNrcUg1MW0QrlCWrmr36CDkjNZ62rrX9oKzAV
         beLUN4fKGUfi8hHI/acmVmRsbbwZlTFQe7n7mHiRgZfe8XSJ1lSL82yo2p9oSwcJ1NXr
         00fOCsFWWdEtxhq5swKOBhB/shtV3Lo0xk2S17brL/3psOdE0cSK2t+qWJupsDXbeP6n
         28OA==
X-Gm-Message-State: APjAAAXSPOB6na06idRJK/kN/8nTWnkgh9nk59HIAMQUDu0kCS3F1AJS
        QV1r2m6BSVonOStywpMPOjZDdJZHu8iL+UCG1nc=
X-Google-Smtp-Source: APXvYqxgckRsvPeHZn6b1p3gkctQ9LIf08zCEsVjrFAuwpT25u3v1l2WFcylpqiWKU+fjXiK26F3oHm+fGG8s+06hRM=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr228694qkb.394.1566935238574;
 Tue, 27 Aug 2019 12:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com> <20190827192255.wbyn732llzckmqmq@treble>
In-Reply-To: <20190827192255.wbyn732llzckmqmq@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Aug 2019 21:47:02 +0200
Message-ID: <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 9:23 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Tue, Aug 27, 2019 at 09:00:52PM +0200, Arnd Bergmann wrote:
> > On Tue, Aug 27, 2019 at 5:00 PM Ilie Halip <ilie.halip@gmail.com> wrote:
> > >
> > > > > $ clang-9 -c  crc32.i  -O2   ; objtool check  crc32.o
> > > > > crc32.o: warning: objtool: fn1 uses BP as a scratch register
> > >
> > > Yes, I see it too. https://godbolt.org/z/N56HW1
> > >
> > > > Do you still see this warning with -fno-omit-frame-pointer (assuming
> > > > clang has that option)?
> > >
> > > Using this makes the warning go away. Running objtool with --no-fp
> > > also gets rid of it.
> >
> > I still see the warning after adding back the -fno-omit-frame-pointer
> > in my reduced test case:
> >
> > $ clang-9 -c  crc32.i -Werror -Wno-address-of-packed-member -Wall
> > -Wno-pointer-sign -Wno-unused-value -Wno-constant-logical-operand -O2
> > -Wno-unused -fno-omit-frame-pointer
> > $ objtool check  crc32.o
> > crc32.o: warning: objtool: fn1 uses BP as a scratch register
>
> This warning most likely means that clang is clobbering RBP in leaf
> functions.  With -fno-omit-frame-pointer, leaf functions don't need to
> set up the frame pointer, but they at least need to leave RBP untouched,
> so that an interrupts/exceptions can unwind through the function.

Yes, that clearly matches what I see in the output where it does

   0: 55                    push   %rbp
...
  73: 0f b6 ef              movzbl %bh,%ebp
  76: 8b 1c 99              mov    (%rcx,%rbx,4),%ebx
  79: 33 1c aa              xor    (%rdx,%rbp,4),%ebx
...
  95: 5d                    pop    %rbp
  96: c3                    retq

I just did another simple test: an x86-64 defconfig build with
UNWINDER_FRAME_POINTER shows the exact symptom as
my randconfig, so it sounds like any configuration with frame
pointers would, and there is nothing else to it (this also makes
sense given that it happens with a relatively simple test case
outside of the kernel).

       Arnd
