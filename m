Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F8FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858ED2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Fid0taOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfCMK7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:59:21 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:21804 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:59:21 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x2DAxBCL001801;
        Wed, 13 Mar 2019 19:59:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2DAxBCL001801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552474752;
        bh=rMHVjtndHqP4BHp6Pe4r8RxHxG0dstPSziZBW6O0lY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fid0taOIgc3yuVgbqH2agY00H5nu5Ra9aIMilnNlGm6o1ZpjtKaGrZUdK1SmlQhlv
         2SBI5H4177zxvKgrslxalImt34zN9USolZraMrtowEhUwlQXzVu19UWVXcRzCg80R9
         q0JVYhKqdLtVm1FtnAwPsAcofjfd5Gw4LkJwQZsc/yQHHpBbY627U4dIgwPCTz55Wz
         0Go8usGdcYOVcnhRI0IYtWXWDzfZ0852+eQ/wTuYyanFA+vrngmBYsjHEpT20EDUx9
         k7My2yF2NShCkCJFd3iOE6T+M6M9W4sxksOKEJTG916s5GAvj9J1MOd2Y+E7a01Tgo
         PPqDil4mVrKAQ==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id y19so715688vsc.4;
        Wed, 13 Mar 2019 03:59:12 -0700 (PDT)
X-Gm-Message-State: APjAAAWlfp/kPp/BepDArh0RUGQ2MXshkvCBq9TwEp/NHVufUCD4KXh6
        S5MnxgRutjPry4GhLvGk9jAXEmBPsbNVPMwx4N4=
X-Google-Smtp-Source: APXvYqwywsr9BBuEpp4fMEDeuSnTfveaMMLv6B4m+d0AEXP8jtfGpvAbxT5VNxoaSE7EGcdjh/L+tQx0NuTDTR/u4vI=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr22429038vsq.215.1552474751208;
 Wed, 13 Mar 2019 03:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190312215203.27643-1-natechancellor@gmail.com> <80fb5b7f-42f9-4fd1-00cf-bfa7965ff8f7@rasmusvillemoes.dk>
In-Reply-To: <80fb5b7f-42f9-4fd1-00cf-bfa7965ff8f7@rasmusvillemoes.dk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Mar 2019 19:58:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR0LGRXi+zUsf3gb_pOaE2U-LUtd8+QH30cqEuTWUokpg@mail.gmail.com>
Message-ID: <CAK7LNAR0LGRXi+zUsf3gb_pOaE2U-LUtd8+QH30cqEuTWUokpg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Add '-fno-builtin-bcmp' to CLANG_FLAGS
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        clang-built-linux@googlegroups.com, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 5:13 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 12/03/2019 22.52, Nathan Chancellor wrote:
> > After LLVM revision r355672 [1], all known working kernel configurations
> > fail to link [2]:
> >
> > ld: init/do_mounts.o: in function `prepare_namespace':
> > do_mounts.c:(.init.text+0x5ca): undefined reference to `bcmp'
> > ld: do_mounts.c:(.init.text+0x5e6): undefined reference to `bcmp'
> > ld: init/initramfs.o: in function `do_header':
> > initramfs.c:(.init.text+0x6e0): undefined reference to `bcmp'
> > ld: initramfs.c:(.init.text+0x6f8): undefined reference to `bcmp'
> > ld: arch/x86/kernel/setup.o: in function `setup_arch':
> > setup.c:(.init.text+0x21d): undefined reference to `bcmp'
> >
> > Commit 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to
> > builtin") removed '-ffreestanding' globally and the kernel doesn't
> > provide a bcmp definition so the linker cannot find a reference to it.
> >
>
> > Fix this by explicitly telling LLVM through Clang not to emit bcmp
> > references. This flag does not need to be behind 'cc-option' because all
> > working versions of Clang support this flag.
>
> Wouldn't it be better to just define bcmp as an alias for memcmp? They
> seem to have compatible prototypes, and then somebody might someday sit
> down and implement some word-at-a-time version of bcmp making use of the
> weaker guarantees about the return value to gain some performance. But I
> suppose that can also be done later.


I also thought of this.


-- 
Best Regards
Masahiro Yamada
