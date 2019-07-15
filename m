Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B0C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AB721738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2BUBHzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbfGOVpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:45:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46884 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732820AbfGOVpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:45:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so8939925plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqueIpy9HKyEPPNOnbRMjYrxKpy7dIPibRkspPVD1Rk=;
        b=M2BUBHzkDMP+Fy0+hAqanjqz5peT9rQY0H9qyM3J2LD51m7Bpo/2ZpzIwYdkvHeuQs
         o6WkGGlypNVXtnfgchnLzMiinYbp56C6ft1FyrillW63+TdkQ6uGKiJpfILS8Yivy9AA
         iTYbSo2RISTDu4EWRziBkqro4i5Bf+/aVf8ijSAhzTe/M72rWB83jL1DSS8OkUeMTRoA
         sdXLfXDYTjBkOC3OD9ZaPM5Ezju0iAH7aVsVy9bUgfCj6sg7J++Y7JwyL8ZAU5FDkMsx
         G5AwWrwj9tknul1EfiWQYPWB8ie70eHNgvoSqCT4oGhATRbPdNEURhGhwiLXuBgKC7A9
         paqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqueIpy9HKyEPPNOnbRMjYrxKpy7dIPibRkspPVD1Rk=;
        b=lPEz0mLsFJvGoef3aAy+Kf3EFzNcymdb0ws7ddCFk83n5T6rnlidGhTlFc43OOPnGT
         YSJDCH8tZAozFz/RzCei5C7yPygmcEw4jd0DTs7zZrwdeW1CsvidOtqbi7ZQUj7FbM1C
         Mtosxq6h3cKknmxDp4SUAXUZ2zFP7KAFlqCe0dDHVoxpPSM6wKahODvuW7qUtcmPary0
         DL6kJjF4/Rzz7ryPBn31MMIDxmUGzfs3sQfQI1sOM/VS7jkkOsM+gX1T57BTjNLggYuv
         +LQWUHqzFqpgjW8REDuMgd8F4iq8jgn5jkuJPVnCd9Fw33hk9ays+6aDJ18Bi/9KTNfE
         66xw==
X-Gm-Message-State: APjAAAXT8K4Ujmd0gv3nA3oHsou8uDjHptu7bRlMyZC1FSiqXJyW3DHw
        9ieNPpNF7rLgvxgcnKKTOa8Xb2MYEjKnosq7+iC6/g==
X-Google-Smtp-Source: APXvYqx3+5tO30WhO0nchpxkml29BpDJYkg5+1AHx+oFnyVETCA/qhmD8kPKKgIFqPFtjwzExPGYOtJkbl5s58En02Y=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr29488310pld.119.1563227150812;
 Mon, 15 Jul 2019 14:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563150885.git.jpoimboe@redhat.com> <20190715193834.5tvzukcwq735ufgb@treble>
In-Reply-To: <20190715193834.5tvzukcwq735ufgb@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Jul 2019 14:45:39 -0700
Message-ID: <CAKwvOdnXt=_NVjK7+RjuxeyESytO6ra769i4qjSwt1Gd1G22dA@mail.gmail.com>
Subject: Re: [PATCH 00/22] x86, objtool: several fixes/improvements
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 12:38 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Sun, Jul 14, 2019 at 07:36:55PM -0500, Josh Poimboeuf wrote:
> > There have been a lot of objtool bug reports lately, mainly related to
> > Clang and BPF.  As part of fixing those bugs, I added some improvements
> > to objtool which uncovered yet more bugs (some kernel, some objtool).
> >
> > I've given these patches a lot of testing with both GCC and Clang.  More
> > compile testing of objtool would be appreciated, as the kbuild test
> > robot doesn't seem to be paying much attention to my branches lately.
> >
> > There are still at least three outstanding issues:
> >
> > 1) With clang I see:
> >
> >      drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x88: redundant UACCESS disable

For a defconfig, that's the only issue I see.
(Note that I just landed https://reviews.llvm.org/rL366130 for fixing
up bugs from loop unrolling loops containing asm goto with Clang, so
anyone else testing w/ clang will see fewer objtool warnings with that
patch applied.  A follow up is being worked on in
https://reviews.llvm.org/D64101).

For allmodconfig:
arch/x86/ia32/ia32_signal.o: warning: objtool:
ia32_setup_rt_frame()+0x247: call to memset() with UACCESS enabled
mm/kasan/common.o: warning: objtool: kasan_report()+0x52: call to
__stack_chk_fail() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool:
x32_setup_rt_frame()+0x255: call to memset() with UACCESS enabled
arch/x86/kernel/signal.o: warning: objtool: __setup_rt_frame()+0x254:
call to memset() with UACCESS enabled
drivers/ata/sata_dwc_460ex.o: warning: objtool:
sata_dwc_bmdma_start_by_tag()+0x3a0: can't find switch jump table
lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch()+0x88:
call to memset() with UACCESS enabled
lib/ubsan.o: warning: objtool: ubsan_type_mismatch_common()+0x610:
call to __stack_chk_fail() with UACCESS enabled
lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch_v1()+0x88:
call to memset() with UACCESS enabled
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
.altinstr_replacement+0x56: redundant UACCESS disable

Without your series, I see them anyways, so I don't consider them
regressions added by this series.  Let's follow up on these maybe in a
new thread?  (Shall I send you these object files?)

So for the series:
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> >
> >    I haven't dug into it yet.
> >
> > 2) There's also an issue in clang where a large switch table had a bunch
> >    of unused (bad) entries.  It's not a code correctness issue, but
> >    hopefully it can get fixed in clang anyway.  See patch 20/22 for more
> >    details.

Thanks for the report, let's follow up on steps for me to reproduce.

> > These patches are also at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-many-fixes

Are these the same patches? Some of the commit messages look different, like:
https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?h=objtool-many-fixes&id=3e39561c52c4f0062207d604c972148b7b60c341


--
Thanks,
~Nick Desaulniers
