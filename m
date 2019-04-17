Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ED2C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7486E20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxK5Shjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbfDQRi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:38:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44343 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQRiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:38:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id y5so14842817qkc.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyMyLpFzUvqjrCI5PfsxatUNaANGE/GxQwSe6mOnjeE=;
        b=WxK5Shjo0AblZGGwkBXiJ/taEiCHHvZyVDSvM9GQ1YkoV5W0ChIZOTDTTIlkDXnfpV
         Wq1OuElEuDxMCdYDA1ohIRVAdjSIX6/gCIXB+1RYHkEoLF4ii2mv1QpwKh+Y/20ii3hf
         zqPR9tmCfkyRVEoHmIpy+aWN8ox4Sx8Oul+QZ/aam1wgIBYMz7xnvGndmqCfT9kbAYlf
         emzfVNz4saaDB6Z4DvI5m9TinzqkqAj1nly4lMZ2NjCxYVmU8a5538P5G9B+P/BytGG3
         Y9FgC+TIvOvsvTBlphNK1YXp0EEXCMQ27saqbbaylq/zmYAMVtx11rZbcams1aS/uxfP
         TgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyMyLpFzUvqjrCI5PfsxatUNaANGE/GxQwSe6mOnjeE=;
        b=tRYIwU8oHw+47+AmSHuxxMxj9v4xKTmhzuaTtAdYtYAUFCDEZze/XwODpt5FSB1siS
         ea7+NA/qfS4snLqR1TD0uCnBqAVFWkSy8nEG7wbDn0BJfLYGIH6UwDZ7U+EggBbf2CbZ
         km67U1WslG4M++r83vMLjVIEJPhTup/v5CmJR/h8DGXami6vfAhhsYRs3DJY+bowK/YV
         iGs/oOB8af6A5FnTUb0k8rn1gk3n+a5oFZM12ttcGxCxtRF07NBxolTRRkXZjIvsFqcb
         nNG1oG/fg/gy1woi5NTJi28LPEpWe6tJTrv2PDSY4wqTT3c2NKxiEvDyH2ZTfZhLDrQ2
         V7eg==
X-Gm-Message-State: APjAAAVhny6uKtfP8vgd+M4Xge0nOa23jQ5kY1//iSrRpfBsdnkae+8X
        goqG5LKAn27m71cjsyXD+nejyGCFOetGdtrc2+0fqg==
X-Google-Smtp-Source: APXvYqxrW7n4zlDP9YlLTuZ5daLm1uVtI56EJmB8KCTfUF3MLaElk9AkzfPctcMTmaX7rxMxrun+pF79MlHGy1C7Ds8=
X-Received: by 2002:a05:620a:166b:: with SMTP id d11mr69408158qko.1.1555522704751;
 Wed, 17 Apr 2019 10:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190313211844.29416-1-ilina@codeaurora.org> <20190313211844.29416-8-ilina@codeaurora.org>
 <155266731117.20095.4543997300651173812@swboyd.mtv.corp.google.com> <20190417160813.GE16124@codeaurora.org>
In-Reply-To: <20190417160813.GE16124@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 Apr 2019 19:38:12 +0200
Message-ID: <CACRpkdZ=QKyKZHNL+hH+d8QVPKuXo+=8eQu-MOBV2wCzourwVQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 6:08 PM Lina Iyer <ilina@codeaurora.org> wrote:

> I am thinking of something like this. Would there be any issue in
> setting the type to IRQ_TYPE_SENSE_MASK instead of any one particular
> type?
>
> ---8<-----
> static int gpiochip_to_irq(struct gpio_chip *chip, unsigned offset)
> {
> #ifdef CONFIG_OF_GPIO
>         struct irq_fwspec fwspec;
>
>         if (chip->of_node) {
>                fwspec.fwnode = of_node_to_fwnode(chip->of_node);
>                fwspec.param[0] = offset;
>                fwspec.param[1] = IRQ_TYPE_SENSE_MASK;
>                fwspec.param_count = 2;
>                return irq_create_fwspec_mapping(&fwspec);
>         }
> #endif
>
>         if (!gpiochip_irqchip_irq_valid(chip, offset))
>                 return -ENXIO;
>
>         return irq_create_mapping(chip->irq.domain, offset);

Isn't the real problem that irq_create_mapping() isn't already doing this
for you?

chip->irq.domain is created with irq_domain_add_simple() and after
Thierrys patch with irq_domain_add_hierarchy(), so I think it is simply
that the hierarchical irqdomain helper code needs to go deeper here.

gpiolib needs struct irq_domain_ops for the hierarchical irqdomain
which implements generic versions of .translate(), .alloc() and .free().
I am working on this... albeit slowly :/

Yours,
Linus Walleij
