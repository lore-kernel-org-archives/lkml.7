Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1C8CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10A820663
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cIOSJZ+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfJ3Kuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:50:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17220 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfJ3Kuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:50:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4734xS2QKVz9vC12;
        Wed, 30 Oct 2019 11:50:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cIOSJZ+p; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id C5E8cMKl0Hpk; Wed, 30 Oct 2019 11:50:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4734xS1MC8z9tyjM;
        Wed, 30 Oct 2019 11:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572432652; bh=yUF2yaRPDVt2MHQzuOd+5u8GS8OOZX8ob6V4sZYv3T8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cIOSJZ+pZAZWHOzkDLlgrmQ+931Y5RSXG+7R/vb9ZS335oBTpGfI+B5occqw4GVug
         I4zSE7RoIlqWzDcHogHfXQuGRoNNOCgobcFwuDY8ZJ6GTgyelHgI5abDWX7mdF9cIZ
         U9bvG6ippiZFIITdnFAj2p2/GRafJ8CgbcnzpKcw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 19F978B875;
        Wed, 30 Oct 2019 11:50:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zdibLVy7pdhC; Wed, 30 Oct 2019 11:50:53 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D6088B7C7;
        Wed, 30 Oct 2019 11:50:50 +0100 (CET)
Subject: Re: [PATCH v2 17/23] soc: fsl: qe: make qe_ic_cascade_* static
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-18-linux@rasmusvillemoes.dk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1d12e0d1-a873-d841-6e73-22ec1d09c268@c-s.fr>
Date:   Wed, 30 Oct 2019 11:50:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025124058.22580-18-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/10/2019 à 14:40, Rasmus Villemoes a écrit :
> Now that the references from arch/powerpc/ are gone, these are only
> referenced from inside qe_ic.c, so make them static.

Why do that in two steps ?
I think patch 9 could remain until here, and then you could squash patch 
9 and patch 17 together here.

Christophe

> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   drivers/soc/fsl/qe/qe_ic.c | 6 +++---
>   include/soc/fsl/qe/qe_ic.h | 4 ----
>   2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
> index 545eb67094d1..e20f1205c0df 100644
> --- a/drivers/soc/fsl/qe/qe_ic.c
> +++ b/drivers/soc/fsl/qe/qe_ic.c
> @@ -402,7 +402,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
>   	return irq_linear_revmap(qe_ic->irqhost, irq);
>   }
>   
> -void qe_ic_cascade_low(struct irq_desc *desc)
> +static void qe_ic_cascade_low(struct irq_desc *desc)
>   {
>   	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
>   	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
> @@ -415,7 +415,7 @@ void qe_ic_cascade_low(struct irq_desc *desc)
>   		chip->irq_eoi(&desc->irq_data);
>   }
>   
> -void qe_ic_cascade_high(struct irq_desc *desc)
> +static void qe_ic_cascade_high(struct irq_desc *desc)
>   {
>   	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
>   	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
> @@ -428,7 +428,7 @@ void qe_ic_cascade_high(struct irq_desc *desc)
>   		chip->irq_eoi(&desc->irq_data);
>   }
>   
> -void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
> +static void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
>   {
>   	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
>   	unsigned int cascade_irq;
> diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
> index 8ec21a3bd859..43e4ce95c6a0 100644
> --- a/include/soc/fsl/qe/qe_ic.h
> +++ b/include/soc/fsl/qe/qe_ic.h
> @@ -67,8 +67,4 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
>   int qe_ic_set_priority(unsigned int virq, unsigned int priority);
>   int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
>   
> -void qe_ic_cascade_low(struct irq_desc *desc);
> -void qe_ic_cascade_high(struct irq_desc *desc);
> -void qe_ic_cascade_muxed_mpic(struct irq_desc *desc);
> -
>   #endif /* _ASM_POWERPC_QE_IC_H */
> 
