Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4A1CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5FF20663
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="IF1kk/S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfJ3Kph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:45:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12277 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfJ3Kph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:45:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4734qL1h7cz9vC0r;
        Wed, 30 Oct 2019 11:45:34 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IF1kk/S9; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RKPDgr6MaFYQ; Wed, 30 Oct 2019 11:45:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4734qL0cgqz9vC0q;
        Wed, 30 Oct 2019 11:45:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572432334; bh=ldw9WUgmvPJSr0yqobCGkdD8WgYCJ83JuIM2Zc0dqTc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IF1kk/S9aewyTgTqFIvoD/cCPMgynwOcooIsZlNEKD4i5AsCVo2kQzfnPEuMaYd58
         skGXIRVEm0Diy5eW0JoSWYE1FYReNLhQWiSxAiiz/qKkW6ThLRH/EqczlF22hawOck
         L3ea7nQRw5B+cWk5/dFW6Onwwn7dQRC4k+cJrBAU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C5BDD8B7AF;
        Wed, 30 Oct 2019 11:45:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6ZJvPf1P5Mu6; Wed, 30 Oct 2019 11:45:34 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 34E9E8B7C8;
        Wed, 30 Oct 2019 11:45:32 +0100 (CET)
Subject: Re: [PATCH v2 09/23] soc: fsl: qe: move qe_ic_cascade_* functions to
 qe_ic.c
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-10-linux@rasmusvillemoes.dk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b01b12fc-88a5-8bc9-5a48-e35ad75b49d9@c-s.fr>
Date:   Wed, 30 Oct 2019 11:45:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025124058.22580-10-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/10/2019 à 14:40, Rasmus Villemoes a écrit :
> These functions are only ever called through a function pointer, and
> therefore it makes no sense for them to be "static inline" - gcc has
> no choice but to emit a copy in each translation unit that takes the
> address of one of these (currently various platform code under
> arch/powerpc/). So move them into qe_ic.c and leave ordinary extern
> declarations in the header file.

What is the point in moving fonctions that you will drop in the next 
patch (qe_ic_cascade_low_ipic() and qe_ic_cascade_high_ipic())
Only move the ones that will remain.

Christophe


> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   drivers/soc/fsl/qe/qe_ic.c | 58 +++++++++++++++++++++++++++++++++++
>   include/soc/fsl/qe/qe_ic.h | 62 +++-----------------------------------
>   2 files changed, 63 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
> index 7b1870d2866a..a847b2672e90 100644
> --- a/drivers/soc/fsl/qe/qe_ic.c
> +++ b/drivers/soc/fsl/qe/qe_ic.c
> @@ -402,6 +402,64 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
>   	return irq_linear_revmap(qe_ic->irqhost, irq);
>   }
>   
> +void qe_ic_cascade_low_ipic(struct irq_desc *desc)
> +{
> +	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> +	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
> +
> +	if (cascade_irq != NO_IRQ)
> +		generic_handle_irq(cascade_irq);
> +}
> +
> +void qe_ic_cascade_high_ipic(struct irq_desc *desc)
> +{
> +	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> +	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
> +
> +	if (cascade_irq != NO_IRQ)
> +		generic_handle_irq(cascade_irq);
> +}
> +
> +void qe_ic_cascade_low_mpic(struct irq_desc *desc)
> +{
> +	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> +	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	if (cascade_irq != NO_IRQ)
> +		generic_handle_irq(cascade_irq);
> +
> +	chip->irq_eoi(&desc->irq_data);
> +}
> +
> +void qe_ic_cascade_high_mpic(struct irq_desc *desc)
> +{
> +	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> +	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	if (cascade_irq != NO_IRQ)
> +		generic_handle_irq(cascade_irq);
> +
> +	chip->irq_eoi(&desc->irq_data);
> +}
> +
> +void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
> +{
> +	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> +	unsigned int cascade_irq;
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	cascade_irq = qe_ic_get_high_irq(qe_ic);
> +	if (cascade_irq == NO_IRQ)
> +		cascade_irq = qe_ic_get_low_irq(qe_ic);
> +
> +	if (cascade_irq != NO_IRQ)
> +		generic_handle_irq(cascade_irq);
> +
> +	chip->irq_eoi(&desc->irq_data);
> +}
> +
>   void __init qe_ic_init(struct device_node *node, unsigned int flags,
>   		       void (*low_handler)(struct irq_desc *desc),
>   		       void (*high_handler)(struct irq_desc *desc))
> diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
> index 714a9b890d8d..f3492eb13052 100644
> --- a/include/soc/fsl/qe/qe_ic.h
> +++ b/include/soc/fsl/qe/qe_ic.h
> @@ -74,62 +74,10 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
>   int qe_ic_set_priority(unsigned int virq, unsigned int priority);
>   int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
>   
> -static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
> -{
> -	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> -	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
> -
> -	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq);
> -}
> -
> -static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
> -{
> -	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> -	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
> -
> -	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq);
> -}
> -
> -static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
> -{
> -	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> -	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> -
> -	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq);
> -
> -	chip->irq_eoi(&desc->irq_data);
> -}
> -
> -static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
> -{
> -	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> -	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> -
> -	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq);
> -
> -	chip->irq_eoi(&desc->irq_data);
> -}
> -
> -static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
> -{
> -	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
> -	unsigned int cascade_irq;
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> -
> -	cascade_irq = qe_ic_get_high_irq(qe_ic);
> -	if (cascade_irq == NO_IRQ)
> -		cascade_irq = qe_ic_get_low_irq(qe_ic);
> -
> -	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq);
> -
> -	chip->irq_eoi(&desc->irq_data);
> -}
> +void qe_ic_cascade_low_ipic(struct irq_desc *desc);
> +void qe_ic_cascade_high_ipic(struct irq_desc *desc);
> +void qe_ic_cascade_low_mpic(struct irq_desc *desc);
> +void qe_ic_cascade_high_mpic(struct irq_desc *desc);
> +void qe_ic_cascade_muxed_mpic(struct irq_desc *desc);
>   
>   #endif /* _ASM_POWERPC_QE_IC_H */
> 
