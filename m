Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CDAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB862085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbfCYKsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:48:02 -0400
Received: from ozlabs.org ([203.11.71.1]:33609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbfCYKr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:47:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44SWF75kn8z9sSq;
        Mon, 25 Mar 2019 21:47:55 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peng Hao <peng.hao2@zte.com.cn>, vitb@kernel.crashing.org,
        benh@kernel.crashing.org, paulus@samba.org, christophe.leroy@c-s.fr
Cc:     Wen Yang <wen.yang99@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/8xx: fix possible object reference leak
In-Reply-To: <1553533919-75527-1-git-send-email-peng.hao2@zte.com.cn>
References: <1553533919-75527-1-git-send-email-peng.hao2@zte.com.cn>
Date:   Mon, 25 Mar 2019 21:47:53 +1100
Message-ID: <87d0mfp6w6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peng Hao <peng.hao2@zte.com.cn> writes:

> From: Wen Yang <wen.yang99@zte.com.cn>
>
> The call to of_find_compatible_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> irq_domain_add_linear also calls of_node_get to increase refcount,
> so irq_domain will not be affected when it is released.
>
> Detected by coccinelle with the following warnings:
> ./arch/powerpc/platforms/8xx/pic.c:158:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 136, but without a corresponding object release within this function.
>
> Fixes: a8db8cf0d894 ("irq_domain: Replace irq_alloc_host() with
> revmap-specific initializers")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>
> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/powerpc/platforms/8xx/pic.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
> index 8d5a25d..4453df6 100644
> --- a/arch/powerpc/platforms/8xx/pic.c
> +++ b/arch/powerpc/platforms/8xx/pic.c
> @@ -153,9 +153,7 @@ int mpc8xx_pic_init(void)
>  	if (mpc8xx_pic_host == NULL) {
>  		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
>  		ret = -ENOMEM;
> -		goto out;
>  	}
> -	return 0;

It's fragile to rely on ret being equal to zero here. If the code
further up is changed it's easy enough to miss that ret is expected to
be zero.

Better to set it to zero here explicitly, this is the success path after
all, eg:

	ret = 0;

>  out:
>  	of_node_put(np);


cheers
