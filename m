Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C3AC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC1920644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="rp3hvgfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfG3JCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:02:13 -0400
Received: from sender-pp-o92.zoho.com ([135.84.80.237]:25493 "EHLO
        sender-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfG3JCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:02:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564477311; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=OLzFuhAd+KDp9gQQy1FpAbwWsWtyj94QvsMBhw4bjHE8jLJpTiSNXovtZDHhoYQL3DEMHla+wvWG8dy2Q6Cb5J5tprR8IM9gnreos5gZ9aVlDGngb/1R8z4AtcJx5LK9s4c3OfNQfy8UmhShUrvXGAUzg7p95E7VZURoUEV7Uyk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1564477311; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Oiz9kdld0kmUGNCbDmOvMw5vn4dZD/hZDWGm0Gwlsrw=; 
        b=TFn9zSng6006YcvMj2ae1r2QMecSzLgaLTvl3PS2a+N7eCt/a/I1RkHICNPrww+369arrvwx6JofsrMnw0CTc10Uuw8A906okBYx0OpqM5QAskFjgKvh4W7dBttENOuEYRC14OiT/ab4Z3V33agVHEgoyDyylLx3rq5IwuIK3Nw=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=uNg08w3qDo4EGjBXAu0qTsK6DhtHve2ivk4RiMhdmzVyV3nbMSHS3A0Zjt48z1Xo4rYt6sWQgDlZ
    0MJiJisDkd+t+QzG/Uz5wasl+ULup4FvWm3TwaJzW2PGcic7936c  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1564477311;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=3092; bh=Oiz9kdld0kmUGNCbDmOvMw5vn4dZD/hZDWGm0Gwlsrw=;
        b=rp3hvgfhhsM/aOJeHLFC+CZbGK+14atOmPSKWpHVKTq1kjoXvOrnj0mevecAHvwG
        wC2z02NYpOYIrnOsbxgYIMHLcrrHr1mJ831fLOf0tA7Dg/yexK6jcffVy+ReoYN0Ksp
        JFQZGahS+UuTfv4sDCQsrYf9+MDJMvcfp0iMscXw=
Received: from [192.168.88.139] (171.221.113.137 [171.221.113.137]) by mx.zohomail.com
        with SMTPS id 1564477309197356.61846341652324; Tue, 30 Jul 2019 02:01:49 -0700 (PDT)
Subject: Re: [PATCH 3/4] irqchip: ingenic: Get virq number from IRQ domain
To:     Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <20190727191741.30317-1-paul@crapouillou.net>
 <20190727191741.30317-3-paul@crapouillou.net>
 <538e79e5-539b-3066-b662-8ed4ec8bf261@arm.com>
 <1564419432.1759.0@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, od@zcrc.me
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5D3FDD31.9060009@zoho.com>
Date:   Tue, 30 Jul 2019 14:01:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1564419432.1759.0@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

These patches was originally sent on January 26th. It was still the old=20
maintainer
information. When sending v4, I may have some problems with cc setting=20
so that
no cc is given to you. I am really sorry. The main purpose on this patch=20
is to change
the cascade irq to chained irq, I think chained irq is more generic way.=20
Look forward
to your and Marc's comments.

On 2019=E5=B9=B407=E6=9C=8830=E6=97=A5 00:57, Paul Cercueil wrote:
> Hi Marc,
>
>
> Le lun. 29 juil. 2019 =C3=A0 6:38, Marc Zyngier <marc.zyngier@arm.com> a=
=20
> =C3=A9crit :
>> [+ Zhou Yanjie]
>>
>> Paul,
>>
>> On 27/07/2019 20:17, Paul Cercueil wrote:
>>>  Get the virq number from the IRQ domain instead of calculating it from
>>>  the hardcoded irq base.
>>>
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  ---
>>>   drivers/irqchip/irq-ingenic.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>>  diff --git a/drivers/irqchip/irq-ingenic.c=20
>>> b/drivers/irqchip/irq-ingenic.c
>>>  index d97a3a500249..82a079fa3a3d 100644
>>>  --- a/drivers/irqchip/irq-ingenic.c
>>>  +++ b/drivers/irqchip/irq-ingenic.c
>>>  @@ -21,6 +21,7 @@
>>>
>>>   struct ingenic_intc_data {
>>>       void __iomem *base;
>>>  +    struct irq_domain *domain;
>>>       unsigned num_chips;
>>>   };
>>>
>>>  @@ -34,6 +35,7 @@ struct ingenic_intc_data {
>>>   static irqreturn_t intc_cascade(int irq, void *data)
>>>   {
>>>       struct ingenic_intc_data *intc =3D irq_get_handler_data(irq);
>>>  +    struct irq_domain *domain =3D intc->domain;
>>>       uint32_t irq_reg;
>>>       unsigned i;
>>>
>>>  @@ -43,7 +45,8 @@ static irqreturn_t intc_cascade(int irq, void *data)
>>>           if (!irq_reg)
>>>               continue;
>>>
>>>  -        generic_handle_irq(__fls(irq_reg) + (i * 32) +=20
>>> JZ4740_IRQ_BASE);
>>>  +        irq =3D irq_find_mapping(domain, __fls(irq_reg) + (i * 32));
>>>  +        generic_handle_irq(irq);
>>>       }
>>>
>>>       return IRQ_HANDLED;
>>>  @@ -95,6 +98,8 @@ static int __init ingenic_intc_of_init(struct=20
>>> device_node *node,
>>>           goto out_unmap_base;
>>>       }
>>>
>>>  +    intc->domain =3D domain;
>>>  +
>>>       for (i =3D 0; i < num_chips; i++) {
>>>           /* Mask all irqs */
>>>           writel(0xffffffff, intc->base + (i * CHIP_SIZE) +
>>>
>>
>> This is likely to conflict with this[1] series, which turns the
>> intc_cascade function into a chained handler (which it should have been
>> from the start). Can you please work with Zhou to post a unified series?
>>
>> Having two people working independently on the same file is likely to
>> end badly otherwise.
>
> I'm registered as maintainer for Ingenic SoCs (including ingenic-irq.c)
> and Zhou didn't Cc me on his patchset... And if he did I'd have a few
> comments on his patches that would have to be addressed in a V5.
>
> If you think my patchset is fine, then maybe merge it then Zhou can just
> rebase on top?
>
> Cheers,
> -Paul
>
>> Thanks,
>>
>>     M.
>>
>> [1]
>> https://lore.kernel.org/lkml/1564335273-22931-1-git-send-email-zhouyanji=
e@zoho.com/=20
>>
>> --=20
>> Jazz is not dead. It just smells funny...
>
>



