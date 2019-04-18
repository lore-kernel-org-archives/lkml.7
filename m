Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A6EC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01BA2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbfDRGzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:55:33 -0400
Received: from ozlabs.org ([203.11.71.1]:45425 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfDRGzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:55:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44l8xt6jzLz9s4V;
        Thu, 18 Apr 2019 16:55:30 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 10/10] powerpc/32s: Implement Kernel Userspace Access Protection
In-Reply-To: <a2847248a92cb1641b1740fa121c5a30593ae662.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr> <a2847248a92cb1641b1740fa121c5a30593ae662.1552292207.git.christophe.leroy@c-s.fr>
Date:   Thu, 18 Apr 2019 16:55:30 +1000
Message-ID: <87ftqfu7j1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
> index 5f97c742ca71..b3560b2de435 100644
> --- a/arch/powerpc/include/asm/book3s/32/kup.h
> +++ b/arch/powerpc/include/asm/book3s/32/kup.h
> @@ -37,6 +37,113 @@
...
> +
> +static inline void allow_user_access(void __user *to, const void __user *from, u32 size)
> +{
> +	u32 addr = (__force u32)to;
> +	u32 end = min(addr + size, TASK_SIZE);
> +
> +	if (!addr || addr >= TASK_SIZE || !size)
> +		return;
> +
> +	current->thread.kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
> +	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
> +}

When rebasing on my v6 I changed the above to:

static inline void allow_user_access(void __user *to, const void __user *from, u32 size)
{
	u32 addr, end;

	if (__builtin_constant_p(to) && to == NULL)
		return;

	addr = (__force u32)to;

	if (!addr || addr >= TASK_SIZE || !size)
		return;

	end = min(addr + size, TASK_SIZE);
	current->thread.kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
}

Which I think achieves the same result. It does boot :)

> +
> +static inline void prevent_user_access(void __user *to, const void __user *from, u32 size)
> +{
> +	u32 addr = (__force u32)to;
> +	u32 end = min(addr + size, TASK_SIZE);
> +
> +	if (!addr || addr >= TASK_SIZE || !size)
> +		return;
> +
> +	current->thread.kuap = 0;
> +	kuap_update_sr(mfsrin(addr) | SR_KS, addr, end);	/* set Ks */
> +}
> +
> +static inline void allow_read_from_user(const void __user *from, unsigned long size)
> +{
> +}

And I dropped that.

cheers
