Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14AECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E8D20872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IyN/hBPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbfJOUau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:30:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36962 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfJOUau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:30:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id p1so12838816pgi.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzk1qvTErm6MzlmjU++xwNdwuPNSLvMppNGGRMZH7Og=;
        b=IyN/hBPF4/R54V/cNKNajn6JQXuJDUT5ZPw8d82nxcT3NAgQxdXVCLbwH0kIFzY7Yd
         pa4M5ylWMOwB1wbttqvdKtJoI0hRcqdTb/MduON7u7TRwjPgJpRTPpEov8ettl67kdxR
         7aK7oKyd06USDYybsN8LkONIh31YHhEHRlBbfQg/06RhcvRGMWY8FJR1wxrHrZVMc/k1
         797M6Dt6sLOkoezNxRJRlFMPR4sWks1VtjC/pHNVd4Lym8iqF/HOWVKLr1mF8wszB/H9
         TpSznSzAiKdA3r/sscQjWQjskaeWORggI3HvaiKHe+9fBe8Wx0WbjgT3r7TDmnwo7wGW
         NjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzk1qvTErm6MzlmjU++xwNdwuPNSLvMppNGGRMZH7Og=;
        b=mlf/FRAqllfQP/5yOU6zkluMbLFb7NpVQSTZa57oE2HzxP1pSUFXacyUH/l2hR8kDe
         GGRgLp5+3Qq7pf4IhYvXNnRYZJAjqORocIuKfYWEvgAjAo64JU7dKcpnnpYiy4YO7XG7
         TQoZBKl1ZNb+2qgW+l8OYof1bIt0eQonn2llp1AESe4yActoDFsVNiKRje5UUHW3NQ7U
         yUshA+Y/Y2dBH/TveGnGyr4vCjcWiDGtTmD/BoACECG/DClr177RFsKdrHC2Dgvh7msq
         5zD0Q2JtI0vqHAsFcjpkEL2EKEVEQgB4q0kaa2/mOx/+XvR2OjAzHt5dugOmOihkCHKM
         5SMg==
X-Gm-Message-State: APjAAAWmcNUmG/IIJuJiZGroHYAfjhz1ahoKw9xtji+FCCXu8VSboy8/
        V+u3sv4750+ITT3mVzM/2RfZr+8TE70kjr1S8g1GKA==
X-Google-Smtp-Source: APXvYqx0eRPPuDDI1HBjXtrhJQx5x6xoVfeO7id3PzGSUww80+yZAp1Tw387MKgbeWgjXFnrJGGsMGf27GFJZ/mEOsc=
X-Received: by 2002:a62:ee01:: with SMTP id e1mr41183643pfi.3.1571171448200;
 Tue, 15 Oct 2019 13:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191007211418.30321-1-samitolvanen@google.com>
 <CAKwvOdnX6O0Grth11R8JLoD9bp-BECheucZKHbiHt4=XpQferA@mail.gmail.com>
 <CABCJKudGtvVazLpZFdbhe9z-4mx_t16zxzkcwYbdAJriakrWqw@mail.gmail.com> <20191015000017.66jkcya6zzbi7qqc@willie-the-truck>
In-Reply-To: <20191015000017.66jkcya6zzbi7qqc@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Oct 2019 13:30:36 -0700
Message-ID: <CAKwvOdnAKNRH7NeOjCDN-ZayE2id_3=FtC5gh0UwoRNpQOaRDg@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix alternatives with LLVM's integrated assembler
To:     Will Deacon <will@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 5:00 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Oct 07, 2019 at 04:47:20PM -0700, Sami Tolvanen wrote:
> > On Mon, Oct 7, 2019 at 2:34 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > Should the definition of the ALTERNATIVE macro
> > > (arch/arm64/include/asm/alternative.h#L295) also be updated in this
> > > patch to not pass `1` as the final parameter?
> >
> > No, that's the default value for cfg in case the caller omits the
> > parameter, and it's still needed.
> >
> > > I get one error on linux-next that looks related:
> > > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang AS=clang
> > > -j71 arch/arm64/kvm/
> > > ...
> >
> > This patch only touches the inline assembly version (i.e. when
> > compiling without -no-integrated-as), while with AS=clang you are
> > using clang also for stand-alone assembly code. I believe some
> > additional work is needed before we can do that.
>
> Is there any benefit from supporting '-no-integrated-as' but not 'AS=clang'?

I don't think so.

> afaict, you have to hack the top-level Makefile for that.

That's right.

$ make CC=clang

sets `-no-integrated-as` in the top level Makefile, unless `AS=clang`
was specified.  So today it's either Clang for inline+out of line, or
GAS for both, but we don't support mixing and matching (ie. GAS for
inline, Clang for out of line, or vice versa).

But older LTS kernels probably don't have the patch that ties the two
together, so Sami's patch addresses the removal of `-no-integrated-as`
for inline assembly (IIUC).

-- 
Thanks,
~Nick Desaulniers
