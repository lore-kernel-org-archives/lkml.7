Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5325C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8073E2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAE8FH7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfH0VWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:22:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45433 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfH0VWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:22:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so197364pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1z6VpcSd91TgNv63C1N9bD4011GqrrTxI2d3i0YxOQ=;
        b=gAE8FH7/bcyE2/lmeaF3wI+X5Li/on8mMNuzIeKmiR8Bz9hnqc6UCQDTpOp+d4QzbP
         bc6o4IixG4d1LCcVLS8Tbhqie3VlgrUV7bh+BSFU5rlfFQfRqc5ir8hKkk3yDocwxVw4
         gz+fhFc2kcgPMpXaSIy3Adt8KTlK1tRJsqzdszz62YX2zBiZE4K5Q5wQN8OoIw7ixs/W
         5ery+4yZgRSmEiIudw+PYM8C4pi2V03y18kKlpuKXQ/inUCG3WByb/6XRECnAvEvg0YK
         hJnt5o56vTrMF9/TEfG/3S2rKlFeYORra6g5FoYE9LRG2HhVIbNrRdbBmTPbbilmdCOd
         PeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1z6VpcSd91TgNv63C1N9bD4011GqrrTxI2d3i0YxOQ=;
        b=kkTflCIH4ZPdKgvFrgwzc2l+ZnR2rayg8DabLglpWz6Cn1aY4OupbQE6kDhPOjRRw+
         OzaPUHFR1k9/yzM+1hZ3Z51lp6sX8uch2Pe1/I3fKZhVUDh7LFqnkhm32KbZHI3dJGrd
         PWD+iOzMzbSGpBedy+3RNG9tWMW0fYLCP3PoHJYJSGEmKt2pO3nBLtccqtpTavJthPP4
         SCQIOy3A9RUVAgOTETVxfiymHJshGDQbGpGW9z5wta28SzCCYTh3wWMBjfF0BrAES9o3
         qWehmZXXIwZ7AVzGTA1qrQlL1ZoiVa3TYc4uGzzJUiCyaxXCTi6rA4Fo/XOFv/HvHPTB
         5kcg==
X-Gm-Message-State: APjAAAXKMU+OOvrTNr9undpLlg7iUaoU2qrP6dE6zGlWhrZlzE1hAgyd
        D5wz7xAkOUWspQRTF8erb4hfJP42fRHEO2sql6rx6A==
X-Google-Smtp-Source: APXvYqwgsXtx5AO9nI1ULSTx31eRAYPq/OEp5RvjalJuXuPxIb9x0KcImXsmxZfOU5pbG9mFd+m9MzXmGYYZMU6rYeM=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr759269pjt.123.1566940927003;
 Tue, 27 Aug 2019 14:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
In-Reply-To: <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Aug 2019 14:21:55 -0700
Message-ID: <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 12:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 27, 2019 at 9:23 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Tue, Aug 27, 2019 at 09:00:52PM +0200, Arnd Bergmann wrote:
> > > On Tue, Aug 27, 2019 at 5:00 PM Ilie Halip <ilie.halip@gmail.com> wrote:
> > > >
> > > > > > $ clang-9 -c  crc32.i  -O2   ; objtool check  crc32.o
> > > > > > crc32.o: warning: objtool: fn1 uses BP as a scratch register
> > > >
> > > > Yes, I see it too. https://godbolt.org/z/N56HW1
> > > >
> > > > > Do you still see this warning with -fno-omit-frame-pointer (assuming
> > > > > clang has that option)?
> > > >
> > > > Using this makes the warning go away. Running objtool with --no-fp
> > > > also gets rid of it.
> > >
> > > I still see the warning after adding back the -fno-omit-frame-pointer
> > > in my reduced test case:
> > >
> > > $ clang-9 -c  crc32.i -Werror -Wno-address-of-packed-member -Wall
> > > -Wno-pointer-sign -Wno-unused-value -Wno-constant-logical-operand -O2
> > > -Wno-unused -fno-omit-frame-pointer
> > > $ objtool check  crc32.o
> > > crc32.o: warning: objtool: fn1 uses BP as a scratch register
> >
> > This warning most likely means that clang is clobbering RBP in leaf
> > functions.  With -fno-omit-frame-pointer, leaf functions don't need to
> > set up the frame pointer, but they at least need to leave RBP untouched,
> > so that an interrupts/exceptions can unwind through the function.
>
> Yes, that clearly matches what I see in the output where it does
>
>    0: 55                    push   %rbp
> ...
>   73: 0f b6 ef              movzbl %bh,%ebp
>   76: 8b 1c 99              mov    (%rcx,%rbx,4),%ebx
>   79: 33 1c aa              xor    (%rdx,%rbp,4),%ebx
> ...
>   95: 5d                    pop    %rbp
>   96: c3                    retq
>
> I just did another simple test: an x86-64 defconfig build with
> UNWINDER_FRAME_POINTER shows the exact symptom as
> my randconfig, so it sounds like any configuration with frame
> pointers would, and there is nothing else to it (this also makes
> sense given that it happens with a relatively simple test case
> outside of the kernel).
>
>        Arnd

Thanks for the description of the issue and the reduced test case.  It
almost reminds me of
https://github.com/ClangBuiltLinux/linux/issues/612.

I've filed https://bugs.llvm.org/show_bug.cgi?id=43128, anything I
should add to the bug report?

-- 
Thanks,
~Nick Desaulniers
