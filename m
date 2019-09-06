Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CBDC00306
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B56206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nV14H9on"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391567AbfIFAgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 20:36:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33944 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390137AbfIFAgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:36:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so2438102pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 17:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=XGrs3zKsFjlZSZ99C8s6sJjUrU3wy1rabuuaViSwzsY=;
        b=nV14H9on5xvo2rClhm31u7GROgaQnL48oFKwFoeb1X3ekfXK3WAJlgeTZoIOqi906S
         JR+cGRU+g2hHG3GUakJ7pH9+M+LXFORZQeiWZkhsxvHhmHSculzfLCjmxlKKMUPLHmCF
         v1+Tx/lw0Q6cuLT1qIHOCeEPvY9t2HIUMqr2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=XGrs3zKsFjlZSZ99C8s6sJjUrU3wy1rabuuaViSwzsY=;
        b=Fpf3pZZhicTvLUZJbBYXprQMd5ge0vBK+GaeAawCUI8Age0VAvWQLDWFudZgJ1foGu
         HEHXLev3E6ynZWTO5uCoNBXukPr6ZeT702QA1bOTGJ3eyXmpcOpkBAJSkMVy1CqqpYEQ
         RbM1fMHjAaTaVGQAZkFMFyDnx1fkxP0iPTz5sVYYUrEMig1Ju2QHMJzTO7q56Nh4CnsD
         3+nL6D9VhWHKVKV66+6H9q0u2WyMaSvsY9pzdcm63j9IaH9PD0s9E9O6BXAjSxXeQRJr
         K/2NKvWL++Xd+UB/HMHof/iiEOq7Zf8OvKJ61iERGXRU94iuXgFLvn8LAEWaXMMhXz06
         s/sw==
X-Gm-Message-State: APjAAAWUzTZE4r+SVAmslluEl1egy3TjSicITOjxaQL2Cc70pOVBLOSV
        04eHd48oJylcclP9hfQXEciXbw==
X-Google-Smtp-Source: APXvYqyeIQEnulmoqJMFz91dhuRMwrBWrdXyLOyfrPiPa6L3ba/p7c6ISBV8gn+QMzNVQdyUJOTF0g==
X-Received: by 2002:a63:60a:: with SMTP id 10mr5596338pgg.381.1567730159909;
        Thu, 05 Sep 2019 17:35:59 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r185sm5696226pfr.68.2019.09.05.17.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 17:35:59 -0700 (PDT)
Message-ID: <5d71a9ef.1c69fb81.c5fbe.e477@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829181203.2660-8-ilina@codeaurora.org>
References: <20190829181203.2660-1-ilina@codeaurora.org> <20190829181203.2660-8-ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, rnayak@codeaurora.org
Subject: Re: [PATCH RFC 07/14] genirq: Introduce irq_chip_get/set_parent_state calls
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 17:35:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-08-29 11:11:56)
> From: Maulik Shah <mkshah@codeaurora.org>
>=20
> On certain QTI chipsets some GPIOs are direct-connect interrupts
> to the GIC.
>=20
> Even when GPIOs are not used for interrupt generation and interrupt
> line is disabled, it does not prevent interrupt to get pending at
> GIC_ISPEND. When drivers call enable_irq unwanted interrupt occures.

Inidicate functions with parenthesis like enable_irq().

>=20
> Introduce irq_chip_get/set_parent_state calls to clear pending irq
> which can get called within irq_enable of child irq chip to clear
> any pending irq before enabling.

This sentence is hard to read.

>=20
> index b76703b2c0af..6bb5b22bb0a7 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1297,6 +1297,50 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_mask_irq);
> =20
>  #endif /* CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS */
> =20
> +/**
> + *     irq_chip_set_parent_state - set the state of a parent interrupt.
> + *     @data: Pointer to interrupt specific data
> + *     @which: State to be restored (one of IRQCHIP_STATE_*)
> + *     @val: Value corresponding to @which
> + *
> + */
> +int irq_chip_set_parent_state(struct irq_data *data,
> +                             enum irqchip_irq_state which,
> +                             bool val)
> +{
> +       data =3D data->parent_data;
> +       if (!data)
> +               return 0;
> +
> +       if (data->chip->irq_set_irqchip_state)
> +               return data->chip->irq_set_irqchip_state(data, which, val=
);
> +
> +       return 0;

How about=20

	if (!data || !data->chip->irq_set_irqchip_state)
		return 0;
=09
	return data->chip->irq_set_irqchip_state(...)

> +}
> +EXPORT_SYMBOL(irq_chip_set_parent_state);
> +
> +/**
> + *     irq_chip_get_parent_state - get the state of a parent interrupt.

Why is this indented so much?

> + *     @data: Pointer to interrupt specific data
> + *     @which: one of IRQCHIP_STATE_* the caller wants to know
> + *     @state: a pointer to a boolean where the state is to be stored
> + *

Document return value?

> + */
> +int irq_chip_get_parent_state(struct irq_data *data,
> +                             enum irqchip_irq_state which,
> +                             bool *state)
> +{
> +       data =3D data->parent_data;
> +       if (!data)
> +               return 0;
> +
> +       if (data->chip->irq_get_irqchip_state)
> +               return data->chip->irq_get_irqchip_state(data, which, sta=
te);
> +

Same comment here about collapsing logic.

> +       return 0;
> +}
> +EXPORT_SYMBOL(irq_chip_get_parent_state);

Please make these symbols _GPL.

> +
>  /**
>   * irq_chip_enable_parent - Enable the parent interrupt (defaults to unm=
ask if
>   * NULL)
