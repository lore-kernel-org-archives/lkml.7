Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2EFC5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 00:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C632187F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 00:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfGDA0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 20:26:51 -0400
Received: from ozlabs.org ([203.11.71.1]:35881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfGDA0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 20:26:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fJgr3SRDz9sNw;
        Thu,  4 Jul 2019 10:26:48 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH v2] powerpc/boot: pass CONFIG options in a simpler and more robust way
In-Reply-To: <1557756964-13087-1-git-send-email-yamada.masahiro@socionext.com>
References: <1557756964-13087-1-git-send-email-yamada.masahiro@socionext.com>
Date:   Thu, 04 Jul 2019 10:26:48 +1000
Message-ID: <87v9wibq5z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Commit 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to wrapper")
> was wrong, but commit e41b93a6be57 ("powerpc/boot: Fix build failures
> with -j 1") was also wrong.
>
> The correct dependency is:
>
>   $(obj)/serial.o: $(obj)/autoconf.h
>
> However, I do not see the reason why we need to copy autoconf.h to
> arch/power/boot/. Nor do I see consistency in the way of passing
> CONFIG options.
>
> decompress.c references CONFIG_KERNEL_GZIP and CONFIG_KERNEL_XZ, which
> are passed via the command line.
>
> serial.c includes autoconf.h to reference a couple of CONFIG options,
> but this is fragile because we often forget to include "autoconf.h"
> from source files.
>
> In fact, it is already broken.
>
> ppc_asm.h references CONFIG_PPC_8xx, but utils.S is not given any way
> to access CONFIG options. So, CONFIG_PPC_8xx is never defined here.
>
> Pass $(LINUXINCLUDE) to make sure CONFIG options are accessible from
> all .c and .S files in arch/powerpc/boot/.

This breaks our skiroot_defconfig, I don't know why yet:

  In file included from /kisskb/src/arch/powerpc/boot/../../../lib/decompress_unxz.c:236:0,
                   from /kisskb/src/arch/powerpc/boot/decompress.c:42:
  /kisskb/src/arch/powerpc/boot/../../../lib/xz/xz_dec_bcj.c: In function 'bcj_powerpc':
  /kisskb/src/arch/powerpc/boot/../../../lib/xz/xz_dec_bcj.c:166:11: warning: implicit declaration of function 'get_unaligned_be32' [-Wimplicit-function-declaration]
     instr = get_unaligned_be32(buf + i);


http://kisskb.ellerman.id.au/kisskb/buildresult/13862914/

cheers
