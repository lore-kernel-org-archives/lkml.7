Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C7FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA83218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9anAuH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfDYHJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:09:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43495 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfDYHJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:09:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id k2so4991313lje.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/L2wknJxv6J3HhquDS95slc5Q003Es6Yvja4wKDWL4=;
        b=R9anAuH03YEokzCL95yrjGWJYldsVyIg8C0oQWh1sHOfaGOt2JaZb4NYRl3sXp9kKC
         tc3z74UU6z4qVj274Wo5ruP6chbMT4NKrJauvBXUqKdGDkbWHofpxviCPYta9RU2lrV5
         1CIIUVKHoCyTgWoOZFCotMyBHUafriF1MePRnpGtd3VUKXDr3vrYnaO1gOhjug2ccVCJ
         bVas9m/WlSzCCrod8HFTJysU/Zf1RU/ithD69GwGRCyB2Lv5E9m+Ra9aOtvwMAMz+dZ9
         Vs/kzkTbKKKR3TLui4/a+a3Bd8+XWgytjXwiDGtXXdu5+cAp6+dTMWfxi+YurURbx5lq
         DMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/L2wknJxv6J3HhquDS95slc5Q003Es6Yvja4wKDWL4=;
        b=TA5Ty50kih30/VpI//FLLPYQ2etGTIkr9nHwHh9bVnRTnz9MSFfD6Rpqh/ht8uCGrs
         kNNiNJFkRLBfIFTDGDXQ7W8O1tKMplshLdnppcMvpZJy6tOxBzQnROCE7Bm5tJ5yleeC
         Az3WYcMzB58Jjv7ImP5XOclCTbyimh6SGIFcXkUmRz7uQ01m3os4nGTAEl6aJJWhEO50
         CeEaV8tbG1OQq/zhRCIc0T+o6ejowDIy0pSLedyvtzZ5/R5IQ9pCJANDJqYZ42pMfEtP
         3rhq7eIl/WLSyjOUP8fXbnPjzwaE7OfQa02bYKFFVHInF+T49MmzAVUA8yQMhSffcMaW
         oXug==
X-Gm-Message-State: APjAAAXJ7YTjyXML1XcSNmVwj7VOIlPEvXje1BJ+hthtgPB+1zAqy8Lf
        mUxoouZiZpmQoMvFbmz0MSj9vQGJ6vm3XqZjePivWg==
X-Google-Smtp-Source: APXvYqw32Pu6FHrS9T+i/2TjYtQ+otk6j1fgJSWEE8eWoDYL5B9OxQ1m0MPz6dJNjutCAvQFfvzUS5miNJ7mQ/VqIw8=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr19623310ljh.135.1556176181632;
 Thu, 25 Apr 2019 00:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org> <20190424120224.22660-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190424120224.22660-5-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Apr 2019 09:09:28 +0200
Message-ID: <CACRpkdZJweCPs096r6LJJTUSmPYViPDV_rBJ8NWbHzx96xEfsw@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: Add pinctrl support for BM1880 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 2:03 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add pinctrl support for Bitmain BM1880 SoC. The driver only handles
> pinmuxing as the SoC is not capable of handling pinconf.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied, because there is no reason to hold back this clean
and important infrastructure for the platform. Minor nits can be
considered for follow-up patches.

> +config PINCTRL_BM1880
> +       bool "Bitmain BM1880 Pinctrl driver"
> +       depends on ARCH_BITMAIN

Could we do:

depends on ARCH_BITMAIN || COMPILE_TEST

to get some compiler coverage?

> +       select PINMUX
> +       help
> +         Pinctrl driver for Bitmain BM1880 SoC.

I think the platform always want this driver enabled, so I would either
select it from arch/arm/mach-foo/Kconfig or add a row like this:

default ARCH_BITMAIN

Either defaulting it to 'y'.

> +       F_nand, F_spi, F_emmc, F_sdio, F_eth0, F_pwm0, F_pwm1, F_pwm2,
> +       F_pwm3, F_pwm4, F_pwm5, F_pwm6, F_pwm7, F_pwm8, F_pwm9, F_pwm10,
> +       F_pwm11, F_pwm12, F_pwm13, F_pwm14, F_pwm15, F_pwm16, F_pwm17,
> +       F_pwm18, F_pwm19, F_pwm20, F_pwm21, F_pwm22, F_pwm23, F_pwm24,
> +       F_pwm25, F_pwm26, F_pwm27, F_pwm28, F_pwm29, F_pwm30, F_pwm31,
> +       F_pwm32, F_pwm33, F_pwm34, F_pwm35, F_pwm36, F_pwm37, F_i2c0, F_i2c1,


Wow 38 individual PWMs. This platform must really have good use for PWM.
I wonder why they hardcoded so many of them into the hardware...

> +static int __init bm1880_pinctrl_init(void)
> +{
> +       return platform_driver_register(&bm1880_pinctrl_driver);
> +}
> +arch_initcall(bm1880_pinctrl_init);

driver_initcall() also known as module_builtin_driver() doesn't work?

Do you plan to add GPIO (and interrupts) and pin config to this driver as well?

Yours,
Linus Walleij
