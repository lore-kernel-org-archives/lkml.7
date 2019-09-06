Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3153DC43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D66D206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="StCAfb2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391542AbfIFAWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 20:22:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43166 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391513AbfIFAWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:22:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id d15so3037039pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=MPDWtahInu0EL/Ywfs85W/c8rw7VGUzH6mYW6IduHVo=;
        b=StCAfb2AiqD8Ue3i9/QI4bpVf/OWZ286AN1LOQL2HLVx0V3VRyFDprvRadL0U790Iy
         4vGCpclo1d6hoYw8GYf8EGw8r7PCB9VLmNFaruJFxZLEht1Wfv1rij2uywO62jUbAu4K
         HO1r3hANXe6deztEoqZXXBxJ7mLDcjgE27KHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=MPDWtahInu0EL/Ywfs85W/c8rw7VGUzH6mYW6IduHVo=;
        b=MPpDoLPNj8GHwzIx8LZ6VfiafRoUD+et+OvWqGH0D8Zp79bT7a5Qgo5ksIEjMRFz2s
         5dWSGnOMkyAWhm0aclgJk6cWXFukk0izvco5QKxstdJRLAmwOmACD6/aIFBh3VieHDfC
         FwEDBTKMLNg0qqP7HIK7G3NbV7qYBJFyASOea7Gof07l9Aj5Q/GewlIZh1Sg06qpM2sT
         UrAK7v2ApWaYaTRZlEIW4mEMSIJX19JdBWJ7uKA1UJg/cngFX/Fk47x3hbUCgozgFEW+
         8rotzHnqQ5Fn520pbhObAqUvlv4TSYtEH2AcmRnU6Qc8SZYTfMBJghiOf1R3YPPQqjQa
         +tqQ==
X-Gm-Message-State: APjAAAWVKaJDfx4wnfDI0NE3gOgNNTRMBtHWAIcgM1nlW8rzV/Y6YLTr
        vPpkz99nE5JMAiITrE1pl67Dxg==
X-Google-Smtp-Source: APXvYqyPAzRHOCF66O88q/1xZ1v7Uq+Z7TZEGqx/dnTiXiGD00folZPLr/+XxSEuNGZyohJIeuldtA==
X-Received: by 2002:aa7:8219:: with SMTP id k25mr7365951pfi.72.1567729371874;
        Thu, 05 Sep 2019 17:22:51 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k31sm3495752pjb.14.2019.09.05.17.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 17:22:51 -0700 (PDT)
Message-ID: <5d71a6db.1c69fb81.1bc1c.9225@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829181203.2660-7-ilina@codeaurora.org>
References: <20190829181203.2660-1-ilina@codeaurora.org> <20190829181203.2660-7-ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, rnayak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RFC 06/14] drivers: irqchip: pdc: additionally set type in SPI config registers
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 17:22:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-08-29 11:11:55)
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index ad1faf634bcf..bf5f98bb4d2b 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -100,6 +112,57 @@ static void qcom_pdc_gic_unmask(struct irq_data *d)
>         irq_chip_unmask_parent(d);
>  }
> =20
> +static u32 __spi_pin_read(unsigned int pin)
> +{
> +       void __iomem *cfg_reg =3D spi_cfg->base + pin * 4;
> +       u64 scm_cfg_reg =3D spi_cfg->start + pin * 4;
> +
> +       if (spi_cfg->scm_io) {
> +               unsigned int val;
> +
> +               qcom_scm_io_readl(scm_cfg_reg, &val);
> +               return val;
> +       } else {
> +               return readl(cfg_reg);
> +       }

Please remove the else and just return readl() result instead.

> +}
> +
> +static void __spi_pin_write(unsigned int pin, unsigned int val)
> +{
> +       void __iomem *cfg_reg =3D spi_cfg->base + pin * 4;
> +       u64 scm_cfg_reg =3D spi_cfg->start + pin * 4;
> +
> +       if (spi_cfg->scm_io)
> +               qcom_scm_io_writel(scm_cfg_reg, val);
> +       else
> +               writel(val, cfg_reg);
> +}
> +
> +static int spi_configure_type(irq_hw_number_t hwirq, unsigned int type)
> +{
> +       int spi =3D hwirq - 32;
> +       u32 pin =3D spi / 32;
> +       u32 mask =3D BIT(spi % 32);
> +       u32 val;
> +       unsigned long flags;
> +
> +       if (!spi_cfg)
> +               return 0;
> +
> +       if (pin * 4 > spi_cfg->size)
> +               return -EFAULT;
> +
> +       raw_spin_lock_irqsave(&pdc_lock, flags);

Ah I don't think the regmap would use a raw spinlock, so that's another
hurdle to get over here.

> +       val =3D __spi_pin_read(pin);
> +       val &=3D ~mask;
> +       if (type & IRQ_TYPE_LEVEL_MASK)
> +               val |=3D mask;
> +       __spi_pin_write(pin, val);

Does monitoring level triggered interrupts matter? I'm asking if the
whole thing can be configured to monitor for edges regardless of trigger
type and then let the level handling be done by the GIC after the wakeup
or when the device is active.

> +       raw_spin_unlock_irqrestore(&pdc_lock, flags);
> +
> +       return 0;
> +}
> +
>  /*
>   * GIC does not handle falling edge or active low. To allow falling edge=
 and
>   * active low interrupts to be handled at GIC, PDC has an inverter that =
inverts
