Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C2EC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B590020821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbfDRGxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:53:43 -0400
Received: from ozlabs.org ([203.11.71.1]:55555 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfDRGxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:53:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44l8vm6N9Gz9s4V;
        Thu, 18 Apr 2019 16:53:40 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 07/10] powerpc/8xx: Add Kernel Userspace Access Protection
In-Reply-To: <bac688f0f7f60d6862d839982c9cccbeda6fec3c.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr> <bac688f0f7f60d6862d839982c9cccbeda6fec3c.1552292207.git.christophe.leroy@c-s.fr>
Date:   Thu, 18 Apr 2019 16:53:40 +1000
Message-ID: <87k1fru7m3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
> new file mode 100644
> index 000000000000..a44cc6c1b901
> --- /dev/null
> +++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_KUP_8XX_H_
> +#define _ASM_POWERPC_KUP_8XX_H_
> +
> +#include <asm/bug.h>
> +
> +#ifdef CONFIG_PPC_KUAP
> +
> +#ifdef __ASSEMBLY__
> +
> +.macro kuap_save_and_lock	sp, thread, gpr1, gpr2, gpr3
> +	lis	\gpr2, MD_APG_KUAP@h	/* only APG0 and APG1 are used */
> +	mfspr	\gpr1, SPRN_MD_AP
> +	mtspr	SPRN_MD_AP, \gpr2
> +	stw	\gpr1, STACK_REGS_KUAP(\sp)
> +.endm
> +
> +.macro kuap_restore	sp, current, gpr1, gpr2, gpr3
> +	lwz	\gpr1, STACK_REGS_KUAP(\sp)
> +	mtspr	SPRN_MD_AP, \gpr1
> +.endm
> +
> +.macro kuap_check	current, gpr
> +#ifdef CONFIG_PPC_KUAP_DEBUG
> +	mfspr	\gpr, SPRN_MD_AP
> +	rlwinm	\gpr, \gpr, 16, 0xffff
> +999:	twnei	\gpr, MD_APG_KUAP@h
> +	EMIT_BUG_ENTRY 999b, __FILE__, __LINE__, (BUGFLAG_WARNING | BUGFLAG_ONCE)
> +#endif
> +.endm
> +
> +#else /* !__ASSEMBLY__ */
> +
> +#include <asm/reg.h>
> +
> +static inline void allow_user_access(void __user *to, const void __user *from,
> +				     unsigned long size)
> +{
> +	mtspr(SPRN_MD_AP, MD_APG_INIT);
> +}
> +
> +static inline void prevent_user_access(void __user *to, const void __user *from,
> +				       unsigned long size)
> +{
> +	mtspr(SPRN_MD_AP, MD_APG_KUAP);
> +}
> +
> +static inline void allow_read_from_user(const void __user *from, unsigned long size)
> +{
> +	allow_user_access(NULL, from, size);
> +}
> +
> +static inline void allow_write_to_user(void __user *to, unsigned long size)
> +{
> +	allow_user_access(to, NULL, size);
> +}

I dropped the two above functions when rebasing on my v6.

cheers
