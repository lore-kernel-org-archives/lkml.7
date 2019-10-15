Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F048ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A90920663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QbwZlkJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfJOUbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:31:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32922 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfJOUbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:31:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so13227170pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1Wx7T8Y9ZqViOXmHCItw7Yhq2PJK0YZHH8H14s5lUc=;
        b=QbwZlkJlaa8RwKN2caJSszEFkoIlQfSLAn3vpYi4uG5YF4q4ptdLfRBW41FJmoMy8Z
         mTkDVOXiYk50JsrhH8PcYLTUsoOlKu0EcXayZ3waVLGqK5F26uKE4MACIxoP5PxNqmk2
         HfdFqX7I1cnLRwTtT2STvs/RBIf2Igt2jHymbz7rrKPeelouM01EVgPQCNUPJF2HKKhB
         Zd2nO9p14A0ZRnHKzo3YLkcNq0WY2MpYgYtstXUueZMixAe7Be1nKMIJlUFUD3JMnmCT
         yqqA8ZR9fuUUAA56sbBTjXw25EwrbXB4mrVdNY4OAGmvr20Bp2hotqQKCNf80m/AfWYq
         kg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1Wx7T8Y9ZqViOXmHCItw7Yhq2PJK0YZHH8H14s5lUc=;
        b=NNcskTzF062nxfUQIWCUx41bnxGSyVlM1DYfbomequv7rMWsaUR13T7HNLnEiygKnl
         KfXfFH8mf/ujOolzMez2zozXjMyW5coydKU3NgrwsBQKq4lU/BLkhSU72CG/z4DsRfUp
         noSfhMAjoGqVhyHVaxfTMFs+vQKdTUAfjzLHJbaeuwPSof4eN78F0mllrfI39H8Q/uoY
         Hz+JvOKaZ6kzt+gr44wFUd5PrgkBvRRqJ9iC+2uZFxlrR7s2539zo/rpJAxUqsy+nWYN
         R4u5uRDeYSQcuB9hGvKzbXnq9vimr6+QwSkSRS1xL3qNx3/4QlNyIsWxxAe9gl1XtRIV
         tLaA==
X-Gm-Message-State: APjAAAW9HkyIllF29v88CT3XlapIJUQCEenDGUIAQ3vYkBx0qP6ICT1P
        xOQhTCRKVg5B+pYrKQw8fRlYlgtcz0qBP3mwvRi1YA==
X-Google-Smtp-Source: APXvYqwyx6WvfGAXztJykPND1tjjNggAgNgl6ULQGcJJLh9GTlWdRYROpSxLFbDW9zbbRAdLxGcLKmtO0CqJqMcgfMo=
X-Received: by 2002:a63:5a03:: with SMTP id o3mr3628128pgb.381.1571171500038;
 Tue, 15 Oct 2019 13:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191007211418.30321-1-samitolvanen@google.com>
 <CAKwvOdnX6O0Grth11R8JLoD9bp-BECheucZKHbiHt4=XpQferA@mail.gmail.com> <CABCJKudGtvVazLpZFdbhe9z-4mx_t16zxzkcwYbdAJriakrWqw@mail.gmail.com>
In-Reply-To: <CABCJKudGtvVazLpZFdbhe9z-4mx_t16zxzkcwYbdAJriakrWqw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Oct 2019 13:31:28 -0700
Message-ID: <CAKwvOdk_BJob16HkuKazfpX43mXnhEzBwfM21Tebf_vcbxoPoA@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix alternatives with LLVM's integrated assembler
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 4:47 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Mon, Oct 7, 2019 at 2:34 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > Should the definition of the ALTERNATIVE macro
> > (arch/arm64/include/asm/alternative.h#L295) also be updated in this
> > patch to not pass `1` as the final parameter?
>
> No, that's the default value for cfg in case the caller omits the
> parameter, and it's still needed.
>
> > I get one error on linux-next that looks related:
> > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang AS=clang
> > -j71 arch/arm64/kvm/
> > ...
>
> This patch only touches the inline assembly version (i.e. when
> compiling without -no-integrated-as), while with AS=clang you are
> using clang also for stand-alone assembly code. I believe some
> additional work is needed before we can do that.

Got it, thanks.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
> > arch/arm64/kvm/hyp/entry.S:109:87: error: too many positional arguments
> >  alternative_insn nop, .inst (0xd500401f | ((0) << 16 | (4) << 5) |
> > ((!!1) << 8)), 4, 1
> >
> >                ^
> >
> > Since __ALTERNATIVE_CFG now takes one less arg, with your patch?
>
> __ALTERNATIVE_CFG (with two underscores) is only defined for C code,
> and this patch doesn't change the definition of _ALTERNATIVE_CFG (with
> one underscore) that's used for stand-alone assembly.
>
> Sami



-- 
Thanks,
~Nick Desaulniers
