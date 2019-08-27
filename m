Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827D821881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfH0TBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:01:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41995 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0TBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:01:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so120173qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+ZzImw1JQRNETvby9DaqBU/AFeon5xlJQ83gAwLiu8=;
        b=b5JZSsWjp4cRslvorfYwKCYxdlhsqIdojHukLaLhFfYUrDWBFcUjvAe4mME7xCmxHd
         ln4PCFhTrRbfy9+PEqPW1aMgDCACa5Aja3ze7u6B1o88Bxt2fqgyCkQnwDSdc+oyL47Y
         MA1CVWxw2OsxyeQyCzQBN5fxTMjYxLf1h0yWPBb2UVvdbpvE2tvbXLu10Nvv5DibIi3F
         lwvGNFGrtC8l0d6JZEBZuea7jVhf8kctwMwiWDp4SNk3E/SFQF0XWVY6EBsLio2+MovM
         flIThiRQI22dNv76yWP3GE2OwNFT5Tl9gTn2KpGs055mbqViMWj8VKHO5zoSO3Bfneb3
         HMQg==
X-Gm-Message-State: APjAAAUdjllZ0Ee/sSzO4TviNjzp5oCF2xDk18NjbFnAnjsE5Te9edUx
        jua4y4HA0CE0E/Y7YrCCMTtqpH9Uv9dqG/cx0Ok=
X-Google-Smtp-Source: APXvYqx+sBo524ZJLvQADl4Q2MieRTlbqQ0a9aosHZyMbYLgFW/zBqRqfkHlIfIk4T8esIJL8nuzBqZ5Zr8YcQR7DAI=
X-Received: by 2002:a37:4b0d:: with SMTP id y13mr6175qka.3.1566932468383; Tue,
 27 Aug 2019 12:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
In-Reply-To: <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Aug 2019 21:00:52 +0200
Message-ID: <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 5:00 PM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> > > $ clang-9 -c  crc32.i  -O2   ; objtool check  crc32.o
> > > crc32.o: warning: objtool: fn1 uses BP as a scratch register
>
> Yes, I see it too. https://godbolt.org/z/N56HW1
>
> > Do you still see this warning with -fno-omit-frame-pointer (assuming
> > clang has that option)?
>
> Using this makes the warning go away. Running objtool with --no-fp
> also gets rid of it.

I still see the warning after adding back the -fno-omit-frame-pointer
in my reduced test case:

$ clang-9 -c  crc32.i -Werror -Wno-address-of-packed-member -Wall
-Wno-pointer-sign -Wno-unused-value -Wno-constant-logical-operand -O2
-Wno-unused -fno-omit-frame-pointer
$ objtool check  crc32.o
crc32.o: warning: objtool: fn1 uses BP as a scratch register

The kernel configuration has frame pointers enabled:
$ make O=obj-x86  CC=clang-9 V=1 lib/crc32.o
...
clang-9 -Wp,-MD,lib/.crc32.o.d  -nostdinc -isystem
/usr/lib/llvm-9/lib/clang/9.0.0/include -I../arch/x86/include
-I./arch/x86/include/generated -I../include -I./include
-I../arch/x86/include/uapi -I./arch/x86/include/generated/uapi
-I../include/uapi -I./include/generated/uapi -include
../include/linux/kconfig.h -include ../include/linux/compiler_types.h
-D__KERNEL__ -Qunused-arguments -Wall -Wundef
-Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -fshort-wchar -fno-PIE
-Werror=implicit-function-declaration -Werror=implicit-int
-Wno-format-security -std=gnu89 -no-integrated-as
-Werror=unknown-warning-option -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
-mno-avx -m64 -mno-80387 -mstack-alignment=8 -mtune=generic
-mno-red-zone -mcmodel=kernel -DCONFIG_AS_CFI=1
-DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1
-DCONFIG_AS_SSSE3=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1
-DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1
-Wno-sign-compare -fno-asynchronous-unwind-tables
-fno-delete-null-pointer-checks -Wno-address-of-packed-member -O2
-Wframe-larger-than=2048 -fstack-protector
-Wno-format-invalid-specifier -Wno-gnu -Wno-tautological-compare
-mno-global-merge -Wno-unused-const-variable -fno-omit-frame-pointer
-fno-optimize-sibling-calls -Wdeclaration-after-statement -Wvla
-Wno-pointer-sign -fno-strict-overflow -fno-merge-all-constants
-fno-stack-check -Werror=date-time -Werror=incompatible-pointer-types
-Wno-initializer-overrides -Wno-format -Wno-sign-compare
-Wno-format-zero-length -I ../lib -I ./lib
-DKBUILD_BASENAME='"crc32"' -DKBUILD_MODNAME='"crc32"' -c -o
lib/crc32.o ../lib/crc32.c
  /bin/bash ../scripts/gen_ksymdeps.sh lib/crc32.o >> lib/.crc32.o.cmd
   ./tools/objtool/objtool check  lib/crc32.o
lib/crc32.o: warning: objtool: crc32_le uses BP as a scratch register
lib/crc32.o: warning: objtool: __crc32c_le uses BP as a scratch register
lib/crc32.o: warning: objtool: crc32_be uses BP as a scratch register

I uploaded my .config file to https://pastebin.com/raw/dmQ1CsNs for reference.

I don't see anything unusual in the configuration, but it's interesting that
this configuration has more of those warnings that other configurations,
so there must be something to it. Here is a list of how many objtool warnings
I got in some recent randconfig builds:

$ find rand86/ -name \*success -mmin -300  | while read i ; do echo
`grep objtool $i | wc -l`  $i ; done
0 rand86/0x694311F1-success
0 rand86/0x8D972A20-success
35 rand86/0x23203CF4-success
2 rand86/0xCBBF0EE0-success
2 rand86/0x4C14539-success
0 rand86/0xDAF4E782-success
0 rand86/0xC0A55734-success
0 rand86/0x66A9932-success
0 rand86/0x6EA0E018-success
3 rand86/0x39524E4C-success
0 rand86/0x1529A460-success
0 rand86/0xF8B3C01-success
0 rand86/0x3A38D796-success
1 rand86/0xBC23C91A-success
0 rand86/0xBB45D3A4-success
0 rand86/0xA907618F-success
0 rand86/0xE1FD6050-success
2 rand86/0x564C9F97-success
1 rand86/0x6B87B4EC-success
0 rand86/0x138BF05D-success
0 rand86/0xBEA383C4-success
4 rand86/0x13EDB348-success
0 rand86/0xDD0F59A6-success
1 rand86/0x1F629018-success
0 rand86/0x775CC509-success
8 rand86/0xC368A488-success
0 rand86/0x619AB1C8-success
0 rand86/0xF94B887A-success
197 rand86/0xBB7BE7F0-success
0 rand86/0x9C77525F-success
0 rand86/0x8FB025C4-success
50 rand86/0xA25C2C06-success
0 rand86/0xC96DF498-success
3 rand86/0xA9CE5E8F-success
0 rand86/0xC2F8A840-success
0 rand86/0xEAD8A021-success
0 rand86/0x5721D814-success
141 rand86/0x8259791A-success
0 rand86/0x9EB91B3D-success
0 rand86/0x5F1C100E-success
2 rand86/0xD132EF06-success
0 rand86/0x1C679BF4-success
0 rand86/0xE647B3E0-success
0 rand86/0xEA358480-success

    Arnd
