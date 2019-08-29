Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF23FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE07B2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfH2GaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 02:30:23 -0400
Received: from ozlabs.org ([203.11.71.1]:52285 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfH2GaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:30:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Jt5S3rV6z9sBp;
        Thu, 29 Aug 2019 16:30:20 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, segher@kernel.crashing.org,
        npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] powerpc: permanently include 8xx registers in reg.h
In-Reply-To: <e3de2a60198c1b648a5da19ba29938a1e365d1f3.1566931178.git.christophe.leroy@c-s.fr>
References: <e3de2a60198c1b648a5da19ba29938a1e365d1f3.1566931178.git.christophe.leroy@c-s.fr>
Date:   Thu, 29 Aug 2019 16:30:16 +1000
Message-ID: <875zmgv5zb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Most 8xx registers have specific names, so just include
> reg_8xx.h all the time in reg.h in order to have them defined
> even when CONFIG_PPC_8xx is not selected. This will avoid
> the need for #ifdefs in C code.
>
> Guard SPRN_ICTRL in an #ifdef CONFIG_PPC_8xx as this register
> has same name but different meaning and different spr number as
> another register in the mpc7450.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> ---
> v2: no change
> ---
>  arch/powerpc/include/asm/reg.h     | 2 --
>  arch/powerpc/include/asm/reg_8xx.h | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)

This breaks the ppc64e build unfortunately, presumably due to it
changing the ordering of header inclusion.

In file included from ../arch/powerpc/include/asm/percpu.h:13,
                 from ../arch/powerpc/include/asm/mmu.h:137,
                 from ../arch/powerpc/include/asm/reg_8xx.h:8,
                 from ../arch/powerpc/include/asm/reg.h:28,
                 from ../arch/powerpc/include/asm/processor.h:9,
                 from ../include/linux/processor.h:6,
                 from ../arch/powerpc/include/asm/delay.h:6,
                 from ../include/linux/delay.h:26,
                 from ../lib/nmi_backtrace.c:17:
../arch/powerpc/include/asm/paca.h:147:23: error: field 'tcd' has incomplete type
  struct tlb_core_data tcd;
                       ^~~

cheers
