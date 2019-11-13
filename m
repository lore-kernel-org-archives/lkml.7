Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C3DC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84522245A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jmmykf0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfKMKhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:37:07 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17333 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfKMKhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:37:07 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id xADAb3Tb002142
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 19:37:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com xADAb3Tb002142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573641423;
        bh=vcPGyZfOGoTDpK6w4BnpgOccRY8K/jMLES3lTm1Hx/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jmmykf0Hn/H5fOwkbo1f+oEkTvhwquuDqo7mYfdF02yUxh4Iyh09UzgMnyo/gOeX7
         abl06AI9W3ApxFAX/VmXwM6NS0xLoVaFDoEPx7h4E8q8/P774N/Kh44tE4uGet8QqR
         Oa6UZ8IkRW/Z4A0OceVqyB3VChYAs+QM+FC64r78Ickn/09m0HajtyWP7P9BiNX97I
         HIwI34PzEctXQI+PPiE1q1p2QYXrPUSMxUQe+z99k8ir6m+ipLiwn9ADZ9kHyshc6P
         6k4JzJGeic26HOjrGqh787tUuINw/tJL8VGVscRjYkgVDe10bhdDE2ERqOoBwKYrQQ
         zkEU6FNjsu67w==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id n9so994717vsa.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 02:37:03 -0800 (PST)
X-Gm-Message-State: APjAAAU8Jy80UV+9KGZWVNTINyHGtyQKxzPwfl9bX3ksWfBpm6jkgHk6
        FTqoDc93adS/ZJfJhepGIH2ez5Qg0C5/AZDkpR4=
X-Google-Smtp-Source: APXvYqx/umxRxiB31lTxOSaphebXQggTvlT7e9ohTePUA/kWzRFuwp06cwDoQpIQ95knWNxVNLU5BLp8umQpnTWHREM=
X-Received: by 2002:a67:2d08:: with SMTP id t8mr1484550vst.155.1573641422450;
 Wed, 13 Nov 2019 02:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20191112134522.12177-1-ilie.halip@gmail.com> <20191113103055.GA25900@willie-the-truck>
In-Reply-To: <20191113103055.GA25900@willie-the-truck>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Nov 2019 19:36:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNATD3696a0BRCB_jKCMdG_PDWUSnuQwWj1+n1okpe+UD7g@mail.gmail.com>
Message-ID: <CAK7LNATD3696a0BRCB_jKCMdG_PDWUSnuQwWj1+n1okpe+UD7g@mail.gmail.com>
Subject: Re: [PATCH] scripts/tools-support-relr.sh: un-quote variables
To:     Will Deacon <will@kernel.org>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 7:31 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Nov 12, 2019 at 03:45:20PM +0200, Ilie Halip wrote:
> > When the CC variable contains quotes, e.g. when using
> > ccache (make CC="ccache <compiler>"), this script always
> > fails, so CONFIG_RELR is never enabled, even when the
> > toolchain supports this feature. Removing the /dev/null
> > redirect and invoking the script manually shows the issue:
> >
> >     $ CC='/usr/bin/ccache clang' ./scripts/tools-support-relr.sh
> >     ./scripts/tools-support-relr.sh: 7: ./scripts/tools-support-relr.sh: /usr/bin/ccache clang: not found
> >
> > Fix this by un-quoting the variables.
> >
> > Before:
> >     $ make ARCH=arm64 CC='/usr/bin/ccache clang' LD=ld.lld \
> >         NM=llvm-nm OBJCOPY=llvm-objcopy defconfig
> >     $ grep RELR .config
> >     CONFIG_ARCH_HAS_RELR=y
> >
> > With this change:
> >     $ make ARCH=arm64 CC='/usr/bin/ccache clang' LD=ld.lld \
> >         NM=llvm-nm OBJCOPY=llvm-objcopy defconfig
> >     $ grep RELR .config
> >     CONFIG_TOOLS_SUPPORT_RELR=y
> >     CONFIG_ARCH_HAS_RELR=y
> >     CONFIG_RELR=y
> >
> > Fixes: 5cf896fb6be3 ("arm64: Add support for relocating the kernel with RELR relocations")
> > Reported-by: Dmitry Golovin <dima@golovin.in>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/769
> > Cc: Peter Collingbourne <pcc@google.com>
> > Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> > ---
> >  scripts/tools-support-relr.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Thanks, I'll queue this as a fix.
>
> Will

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
