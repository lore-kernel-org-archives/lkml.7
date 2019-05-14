Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F2C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF912086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfENG4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 02:56:07 -0400
Received: from ozlabs.org ([203.11.71.1]:56853 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfENG4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 02:56:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4537kY0Mcqz9sML;
        Tue, 14 May 2019 16:56:05 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vitaly Bordug <vitb@kernel.crashing.org>,
        Scott Wood <oss@buserror.net>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/8xx: Add microcode patch to move SMC parameter RAM.
In-Reply-To: <dd715639629639505ef4edd36d5a1aa4361e6edf.1557487355.git.christophe.leroy@c-s.fr>
References: <35488171038e3d40e7680b8513dfbd52ff7b6ef2.1557487355.git.christophe.leroy@c-s.fr> <dd715639629639505ef4edd36d5a1aa4361e6edf.1557487355.git.christophe.leroy@c-s.fr>
Date:   Tue, 14 May 2019 16:56:04 +1000
Message-ID: <87a7fptth7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Some SCC functions like the QMC requires an extended parameter RAM.
> On modern 8xx (ie 866 and 885), SPI area can already be relocated,
> allowing the use of those functions on SCC2. But SCC3 and SCC4
> parameter RAM collide with SMC1 and SMC2 parameter RAMs.
>
> This patch adds microcode to allow the relocation of both SMC1 and
> SMC2, and relocate them at offsets 0x1ec0 and 0x1fc0.
> Those offsets are by default for the CPM1 DSP1 and DSP2, but there
> is no kernel driver using them at the moment so this area can be
> reused.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/platforms/8xx/Kconfig      |   7 ++
>  arch/powerpc/platforms/8xx/micropatch.c | 109 +++++++++++++++++++++++++++++++-
>  2 files changed, 114 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/8xx/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
> index 33a9042fca80..dc4423daf7d4 100644
> --- a/arch/powerpc/platforms/8xx/micropatch.c
> +++ b/arch/powerpc/platforms/8xx/micropatch.c
> @@ -622,6 +622,86 @@ static uint patch_2f00[] __initdata = {
>  };
>  #endif
>  
> +/*
> + * SMC relocation patch arrays.
> + */
> +
> +#ifdef CONFIG_SMC_UCODE_PATCH
> +
> +static uint patch_2000[] __initdata = {
> +	0x3fff0000, 0x3ffd0000, 0x3ffb0000, 0x3ff90000,
> +	0x5fefeff8, 0x5f91eff8, 0x3ff30000, 0x3ff10000,
> +	0x3a11e710, 0xedf0ccb9, 0xf318ed66, 0x7f0e5fe2,

Do we have any doc on what these values are?

I get that it's microcode but do we have any more detail than that?
What's the source etc?

cheers
