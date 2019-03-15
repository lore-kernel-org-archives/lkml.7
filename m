Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09899C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23C6218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eIaNRY1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfCOQ2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:28:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39211 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbfCOQ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:28:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id i20so6702330pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=ryn2HuBLRDdXhxdMYCTHR5hokUvhIsJ3bzEMu+X6BsA=;
        b=eIaNRY1OCfLNKbdfr2kofNCyMXhfeuv5vt8/UeHe52Q6N8x4DXCQETpgvjJFr/f0LL
         DAQMAS9Av6HBvT/+BTtn/UZOtdTt4ec1Gvhm9YcMgP4FfMaWjQ86gUoKYI2fr7F4dIWv
         lGfA+RzhEvMIgxxUTjPSBg8LV47OFcNfmqZ/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=ryn2HuBLRDdXhxdMYCTHR5hokUvhIsJ3bzEMu+X6BsA=;
        b=IkKgLXAGLEOX+xlrk9VMVBA+nemP5fUCkB5iRBAjz2xMJPAIEAcNsiY0kNYIXByUoQ
         HwoBCBhvuq6fN789OsC1c5ScRGG6jEFplErVVSt2abQyaOsirVblQcroWRUEQ7tFvi9J
         6N4y6Ndc8/wkO6I+wwfqkybZyb/zbKaAY8AKUxJlZi2xcUvVL1m8SPEVY824c5b1meB7
         NW/Z1hcNNcHLVs8QR0l9ovZ6rm8QDBkeenI5FyHyEJxU0cHiLhplDLKT5Dp35/QNLBVT
         KW0hpcL8gbtyQBgGgDm9+y1MfgWbTJJ8NvPXzkVSQl12fMosc1wV4jKUJEECcSGNiLSg
         qrlg==
X-Gm-Message-State: APjAAAVf/iOYsD8INzHBjp2iVciSBZXBuOt0XntKm/PPfJaKWdv0Au/q
        pv2Y+wU7rSI8otcC6N0vkf+1Z3CJJTU+7w==
X-Google-Smtp-Source: APXvYqy6S04oZw+IIGLCsJ3If6KumN9Fh88iepJZ4I3BXx5fvq8U2mSCZFp9nTeQzr6XdBKncLeQUw==
X-Received: by 2002:aa7:8ac8:: with SMTP id b8mr3891643pfd.87.1552667312968;
        Fri, 15 Mar 2019 09:28:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f2sm3423829pgn.43.2019.03.15.09.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 09:28:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190313211844.29416-8-ilina@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org> <20190313211844.29416-8-ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 07/10] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        marc.zyngier@arm.com
Message-ID: <155266731117.20095.4543997300651173812@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 15 Mar 2019 09:28:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-03-13 14:18:41)
> ---
> Changes in v4:
>         - Remove irq_set_wake() on summary IRQ interrupt
> Changes in v3:
>         - Use of_irq_domain_map() and pass PDC pin to parent irqdomain
> Changes in v2:
>         - Call parent mask when masking GPIO interrupt
> Changes in v1:
>         - Fix bug when unmasking PDC interrupt
[...]
> +}
> +
> +/*
> + * TODO: Get rid of this and push it into gpiochip_to_irq()
> + */

Any chance this TODO can be resolved?

> @@ -994,6 +1092,22 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>         pctrl->irq_chip.irq_request_resources =3D msm_gpio_irq_reqres;
>         pctrl->irq_chip.irq_release_resources =3D msm_gpio_irq_relres;
> =20
> +       chip->irq.chip =3D &pctrl->irq_chip;
> +       chip->irq.domain_ops =3D &msm_gpio_domain_ops;
> +       chip->irq.handler =3D handle_edge_irq;
> +       chip->irq.default_type =3D IRQ_TYPE_EDGE_RISING;

This also changed from v3. It used to be IRQ_TYPE_NONE. Specifying this
here seems to cause gpiolib to print a WARN.


        /*
         * Specifying a default trigger is a terrible idea if DT or ACPI is
         * used to configure the interrupts, as you may end up with
         * conflicting triggers. Tell the user, and reset to NONE.
         */
        if (WARN(np && type !=3D IRQ_TYPE_NONE,
                 "%s: Ignoring %u default trigger\n", np->full_name, type))
                type =3D IRQ_TYPE_NONE;


So I guess this change should be dropped. Or at the least, it should be
split out to it's own patch and the motivations can be discussed in the
commit text.

