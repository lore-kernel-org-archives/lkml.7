Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23871C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3446206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="IdFqzbnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbfG2Q5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:57:30 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38042 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbfG2Q5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564419447; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HC/jSkCdvm90Ozg58x1zsdB2BSsxVhaJhq9+3F9/Oi0=;
        b=IdFqzbnBdtYEV8yEqrTrmZyrvucwFFswhgvMdFnBFLmG0aqBYWv18fdQdk3xqLA3BR+yKo
        Y5RcvKDFCYbqbJUL7xRGgk2PB06BY95Xga0IqjwIKN0jGomveent/ipdd/9nvz1rH+6xNe
        79F/oSO8mVbCOk61Nl8YMj/BX/JkWMU=
Date:   Mon, 29 Jul 2019 12:57:12 -0400
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/4] irqchip: ingenic: Get virq number from IRQ domain
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Zhou Yanjie <zhouyanjie@zoho.com>
Message-Id: <1564419432.1759.0@crapouillou.net>
In-Reply-To: <538e79e5-539b-3066-b662-8ed4ec8bf261@arm.com>
References: <20190727191741.30317-1-paul@crapouillou.net>
        <20190727191741.30317-3-paul@crapouillou.net>
        <538e79e5-539b-3066-b662-8ed4ec8bf261@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,


Le lun. 29 juil. 2019 =E0 6:38, Marc Zyngier <marc.zyngier@arm.com> a=20
=E9crit :
> [+ Zhou Yanjie]
>=20
> Paul,
>=20
> On 27/07/2019 20:17, Paul Cercueil wrote:
>>  Get the virq number from the IRQ domain instead of calculating it=20
>> from
>>  the hardcoded irq base.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/irqchip/irq-ingenic.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/irqchip/irq-ingenic.c=20
>> b/drivers/irqchip/irq-ingenic.c
>>  index d97a3a500249..82a079fa3a3d 100644
>>  --- a/drivers/irqchip/irq-ingenic.c
>>  +++ b/drivers/irqchip/irq-ingenic.c
>>  @@ -21,6 +21,7 @@
>>=20
>>   struct ingenic_intc_data {
>>   	void __iomem *base;
>>  +	struct irq_domain *domain;
>>   	unsigned num_chips;
>>   };
>>=20
>>  @@ -34,6 +35,7 @@ struct ingenic_intc_data {
>>   static irqreturn_t intc_cascade(int irq, void *data)
>>   {
>>   	struct ingenic_intc_data *intc =3D irq_get_handler_data(irq);
>>  +	struct irq_domain *domain =3D intc->domain;
>>   	uint32_t irq_reg;
>>   	unsigned i;
>>=20
>>  @@ -43,7 +45,8 @@ static irqreturn_t intc_cascade(int irq, void=20
>> *data)
>>   		if (!irq_reg)
>>   			continue;
>>=20
>>  -		generic_handle_irq(__fls(irq_reg) + (i * 32) + JZ4740_IRQ_BASE);
>>  +		irq =3D irq_find_mapping(domain, __fls(irq_reg) + (i * 32));
>>  +		generic_handle_irq(irq);
>>   	}
>>=20
>>   	return IRQ_HANDLED;
>>  @@ -95,6 +98,8 @@ static int __init ingenic_intc_of_init(struct=20
>> device_node *node,
>>   		goto out_unmap_base;
>>   	}
>>=20
>>  +	intc->domain =3D domain;
>>  +
>>   	for (i =3D 0; i < num_chips; i++) {
>>   		/* Mask all irqs */
>>   		writel(0xffffffff, intc->base + (i * CHIP_SIZE) +
>>=20
>=20
> This is likely to conflict with this[1] series, which turns the
> intc_cascade function into a chained handler (which it should have=20
> been
> from the start). Can you please work with Zhou to post a unified=20
> series?
>=20
> Having two people working independently on the same file is likely to
> end badly otherwise.

I'm registered as maintainer for Ingenic SoCs (including ingenic-irq.c)
and Zhou didn't Cc me on his patchset... And if he did I'd have a few
comments on his patches that would have to be addressed in a V5.

If you think my patchset is fine, then maybe merge it then Zhou can just
rebase on top?

Cheers,
-Paul

> Thanks,
>=20
> 	M.
>=20
> [1]
> https://lore.kernel.org/lkml/1564335273-22931-1-git-send-email-zhouyanjie=
@zoho.com/
> --
> Jazz is not dead. It just smells funny...

=

