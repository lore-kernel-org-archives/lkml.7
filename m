Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B884C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15216217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1SiR62u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfHGCeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 22:34:50 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43989 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfHGCet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:34:49 -0400
Received: by mail-vs1-f66.google.com with SMTP id j26so59706003vsn.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 19:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZySuVgDrMwYu72Sx/Yyym02kCpQXLkPK8PNQdvmdTs=;
        b=F1SiR62uuCiYwaAFZHB76fCXVKxf7JXtPhpxtNgrVd7MyfyLkTV1DIeX/jAyXBunyv
         RQrIlMkIGluKnySzfOF3GZSLDP6MveHIH7veoxvjvHiYv/WElwSO9Iwo0h0q9MtKrvfP
         kL/UCJwy+siSLXnj0w9kxjQETAkg8eD5w50q97dB6F3z+72b41Wrzv2dgqkH/m1FOQ0i
         V5bUDjsT76x73WZJYgzY4Vv9fR4a4k1cEIlUL/gbWQE/MJFoZtehpet47dSrdA/83Gqk
         G38q97D0ZqJoZeASMBUD4lJMr2MlJPqrttFt4KV70TVWSDOfP/xerBtrtLdWIL4aCjIR
         w0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZySuVgDrMwYu72Sx/Yyym02kCpQXLkPK8PNQdvmdTs=;
        b=DAWLYdv3eYP5paHn4ZiAG9OYt0aXbtI7a0lE462b9mgaUXjGanOrGKq6o8uSR6ly+a
         Zy8PutirtPiPKFDDGPXTZQrjB/YcsvoS2zUYJ0pNRuVLOSPMRP8CoLSHU61gfyU9W5pL
         tHiByK4nNQS7Cg2AIwvIo+6RzpUgbiklSuklePRq6+eJ8Oa4857vj2YTcQKo8XP5HRG+
         XNtCj+I2ZYneUslZhouF5MaBqwd026EYYmNRiB1w2feAgiafONs0iCCH3XfhOOzb7R87
         jxrvVMeTsYYppQvAKkMhD+PbX5kHa1PFxZkrzfnAdj6M7Gn0IwL8Jt0VEZESUwcXO+oL
         kqCg==
X-Gm-Message-State: APjAAAXdOn+10xFGyHXtmGz0MmQqq82HOY581n7KjrdS3K15PtKsM8DO
        IWekq6pEuNYQ1vre9Vx4QaUR798XgG4jY9YGjPclcA==
X-Google-Smtp-Source: APXvYqzMwsO5cKGxZ3JYDTOsPOYBmB+qZmPho1/Yle815I5CkBfbapDdnjT0eQA4Zv+lnRSJnerL6Wc4UY2iNLWlUpk=
X-Received: by 2002:a67:ff0a:: with SMTP id v10mr4748856vsp.1.1565145287978;
 Tue, 06 Aug 2019 19:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190807095022.0314e2fc@canb.auug.org.au>
In-Reply-To: <20190807095022.0314e2fc@canb.auug.org.au>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 6 Aug 2019 19:34:36 -0700
Message-ID: <CAMn1gO6P_VfDRjGZb67ZS4Kh0wjTEQi0cbOkmibTokHQOgP7qw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the arm64 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 4:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the arm64 tree, today's linux-next build (powerpc
> ppc64_defconfig) was just spinning in make - it executing some scripts,
> but it was hard to catch just what.
>
> Apparently caused by commit
>
>   5cf896fb6be3 ("arm64: Add support for relocating the kernel with RELR relocations")
>
> I have not idea why, but reverting the above commit allows to build
> to finish.

Okay, I can reproduce with:

$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- defconfig
*** Default configuration is based on 'ppc64_defconfig'
#
# No change to .config
#
$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- -j72
scripts/kconfig/conf  --syncconfig Kconfig
scripts/kconfig/conf  --syncconfig Kconfig
scripts/kconfig/conf  --syncconfig Kconfig
[...]

And confirmed that backing out my patch fixes it.

The problem seems to come from the use of $(NM) in the Kconfig file.
If I apply this diff:

diff --git a/init/Kconfig b/init/Kconfig
index d96127ebc44e0..177a95b323230 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -31,7 +31,7 @@ config CC_HAS_ASM_GOTO
        def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))

 config TOOLS_SUPPORT_RELR
-       def_bool $(success,env "CC=$(CC)" "LD=$(LD)" "NM=$(NM)"
"OBJCOPY=$(OBJCOPY)" $(srctree)/scripts/tools-support-relr.sh)
+       def_bool $(success,$(NM))

 config CC_HAS_WARN_MAYBE_UNINITIALIZED
        def_bool $(cc-option,-Wmaybe-uninitialized)

I still see the hang. Replacing $(NM) with something else makes it go away.

That leads me to ask what is special about $(NM) + powerpc? It turns
out to be this fragment of arch/powerpc/Makefile:

ifdef CONFIG_PPC64
new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' >
/dev/null; then echo y; else echo n; fi)

ifeq ($(new_nm),y)
NM              := $(NM) --synthetic
endif
endif

We're setting NM to something else based on a config option, which I
presume sets up some sort of circular dependency that confuses
Kconfig. Removing this fragment of the makefile (or appending
--synthetic unconditionally) also makes the problem go away.

We should at least able to remove the test for a new-enough binutils.
According to changes.rst we require binutils 2.21 which was released
in 2011, and support for --synthetic was added to binutils in 2004:
https://github.com/bminor/binutils-gdb/commit/0873df2aec48685715d2c5041c1f6f4ed43976c1

But why are we passing --synthetic at all on ppc64? This behaviour
seems to come from this commit from 2004:
https://github.com/mpe/linux-fullhistory/commit/0e32679a4ea48a634d94e97355d47512ef14d71f
which states: "On new toolchains we need to use nm --synthetic or we
miss code symbols."

But I only see a couple of missing symbols if I compare the output of
nm with and without --synthetic on a powerpc64 kernel:

$ diff -u <(powerpc-linux-gnu-nm --synthetic vmlinux)
<(powerpc-linux-gnu-nm  vmlinux)
--- /dev/fd/63 2019-08-06 18:48:56.127020621 -0700
+++ /dev/fd/62 2019-08-06 18:48:56.131020636 -0700
@@ -74840,7 +74840,6 @@
 c000000001901b10 D LZ4_decompress_fast
 c0000000007819a0 T .LZ4_decompress_fast_continue
 c000000001901b70 D LZ4_decompress_fast_continue
-c0000000007811e0 t .LZ4_decompress_fast_extDict
 c000000001901b40 d LZ4_decompress_fast_extDict
 c000000000781960 T .LZ4_decompress_fast_usingDict
 c000000001901b58 D LZ4_decompress_fast_usingDict
@@ -74856,7 +74855,6 @@
 c000000001901bd0 D LZ4_decompress_safe_usingDict
 c0000000007822b0 T .LZ4_decompress_safe_withPrefix64k
 c000000001901b88 D LZ4_decompress_safe_withPrefix64k
-c000000000780c60 t .LZ4_decompress_safe_withSmallPrefix
 c000000001901b28 d LZ4_decompress_safe_withSmallPrefix
 c00000000077fbe0 T .LZ4_setStreamDecode
 c000000001901ac8 D LZ4_setStreamDecode

I guess the problem was worse back in 2004. It almost certainly didn't
involve these particular symbols because they were added in commit
2209fda323e2fd2a2d0885595fd5097717f8d2aa from 2018. So I guess we have
a couple of possible quick fixes (assuming that the Kconfig issue
can't be solved somehow): either stop passing --synthetic on powerpc
and lose a couple of symbols in 64-bit kernels, or start passing it
unconditionally on powerpc (it doesn't seem to make a difference to
the nm output on a ppc64_defconfig kernel with CONFIG_PPC64=n). I'm
cc'ing the powerpc maintainers for their opinion on what to do. While
this is being resolved we should probably back out my patch from
-next.

Peter
