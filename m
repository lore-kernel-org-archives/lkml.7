Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92DEC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA77B21537
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfGJPFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:05:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35147 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbfGJPFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:05:31 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45kMtx2lmXz9sPj; Thu, 11 Jul 2019 01:05:29 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9e005b761e7ad153dcf40a6cba1d681fe0830ac6
In-Reply-To: <20190705100144.28785-1-yamada.masahiro@socionext.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] powerpc/boot: add {get, put}_unaligned_be32 to xz_config.h
Message-Id: <45kMtx2lmXz9sPj@ozlabs.org>
Date:   Thu, 11 Jul 2019 01:05:29 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-05 at 10:01:43 UTC, Masahiro Yamada wrote:
> The next commit will make the way of passing CONFIG options more robust.
> Unfortunately, it would uncover another hidden issue; without this
> commit, skiroot_defconfig would be broken like this:
> 
> |   WRAP    arch/powerpc/boot/zImage.pseries
> | arch/powerpc/boot/wrapper.a(decompress.o): In function `bcj_powerpc.isra.10':
> | decompress.c:(.text+0x720): undefined reference to `get_unaligned_be32'
> | decompress.c:(.text+0x7a8): undefined reference to `put_unaligned_be32'
> | make[1]: *** [arch/powerpc/boot/Makefile;383: arch/powerpc/boot/zImage.pseries] Error 1
> | make: *** [arch/powerpc/Makefile;295: zImage] Error 2
> 
> skiroot_defconfig is the only defconfig that enables CONFIG_KERNEL_XZ
> for ppc, which has never been correctly built before.
> 
> I figured out the root cause in lib/decompress_unxz.c:
> 
> | #ifdef CONFIG_PPC
> | #      define XZ_DEC_POWERPC
> | #endif
> 
> CONFIG_PPC is undefined here in the ppc bootwrapper because autoconf.h
> is not included except by arch/powerpc/boot/serial.c
> 
> XZ_DEC_POWERPC is not defined, therefore, bcj_powerpc() is not compiled
> for the bootwrapper.
> 
> With the next commit passing CONFIG_PPC correctly, we would realize that
> {get,put}_unaligned_be32 was missing.
> 
> Unlike the other decompressors, the ppc bootwrapper duplicates all the
> necessary helpers in arch/powerpc/boot/.
> 
> The other architectures define __KERNEL__ and pull in helpers for
> building the decompressors.
> 
> If ppc bootwrapper had defined __KERNEL__, lib/xz/xz_private.h would
> have included <asm/unaligned.h>:
> 
> | #ifdef __KERNEL__
> | #       include <linux/xz.h>
> | #       include <linux/kernel.h>
> | #       include <asm/unaligned.h>
> 
> However, doing so would cause tons of definition conflicts since the
> bootwrapper has duplicated everything.
> 
> I just added copies of {get,put}_unaligned_be32, following the
> bootwrapper coding convention.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9e005b761e7ad153dcf40a6cba1d681fe0830ac6

cheers
