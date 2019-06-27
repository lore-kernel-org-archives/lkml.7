Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60131C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F1E2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nW6rZQeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfF0O6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:58:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36357 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF0O6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:58:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so1809415lfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NY6E3pRbAeGkJX9wIK/Nm1oM3Y/QGiVQ3g92XbhUcPI=;
        b=nW6rZQeCtWoyBm/C2/PgUsVj+WtjyS61O4kx+GtOpcXfcX7/axr5e62sd79lEVqg4Z
         PcHMo7wCJPGl3d59Pe7MFmWIbDmHBHDkMmlgAL3rQtmDoc3pn85lxNKKQ5V4jrSQA8Ce
         i6cVSFr9oyr/x65ELltX+Lk4HC4eBZMLzoyUA/LauWQXCWiE6U2UTklQDxNOCQMDpucg
         xnudwd14X9Upm6uxl5fGJygFr2dfB0as2tCqLB5DkXNOM1/EvZtn0Q/HfxS8lSzs1osF
         mEKNLoCw/DcBOzkPFLKxfieQjG7GBwoCgzwEZe5QbP52V9GXw/WUMb6rEJt5m1qGCquR
         6MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NY6E3pRbAeGkJX9wIK/Nm1oM3Y/QGiVQ3g92XbhUcPI=;
        b=NgmZN+sFAC9DvVizN2S340G19bKEmzMrGL9hixqGcSdcgjWq/o8PpIrOY2pECnpt/y
         bUlfbUrUCO5Jwm/2p6RQp1YAq3haeMBkI3nfyHrhPFxqYA2cqgw+ZIknCPxcdU6pJAAu
         PmOH4D4KDaVpZX49fyJ1gqLaHn5hjETuwxmhdCbebqqz3AFtAVlr6PT8l791r/Mhq89Q
         omqc95Uvsqr5t8zeWHZdeZKIPilhe1aPfx1vYTPciK8awzIRO6vkYqs9dkUVV00ORKSG
         O58cOu1LAbm7RmHrNo0vC2ZQPs+AqtBogMOnWnx2q1y7+JgLvYWUuHhrsKxrOYAg4I0N
         7jyQ==
X-Gm-Message-State: APjAAAVtoadptR2Tt3Te6MK7ohvbyNs1R7LMt2E/ba5ONGoK87eglkvh
        pJOfiD1OX9r3LPOytO2hXZWAFdW6BlLcKiGV0pqdLyjlMl8=
X-Google-Smtp-Source: APXvYqwPnv0vTnR6pIWZAn8g7t0sJZ5O7W58stX5I1NFpECaW1P5djVIeS/ctdViHMxD+FrzPeodPIw75oRBFzHewfI=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr2219936lfh.92.1561647478479;
 Thu, 27 Jun 2019 07:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190627181941.1222cb9c@canb.auug.org.au>
In-Reply-To: <20190627181941.1222cb9c@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Jun 2019 15:57:46 +0100
Message-ID: <CACRpkda1EgeRqgRZgNn+F7RSHonPE=s8c15uiKYtzg8NOWqvYw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the gpio tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Enrico Weigelt <info@metux.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 9:20 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the gpio tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> drivers/gpio/gpio-amd-fch.c: In function 'amd_fch_gpio_probe':
> drivers/gpio/gpio-amd-fch.c:171:49: warning: passing argument 2 of 'devm_ioremap_resource' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   priv->base = devm_ioremap_resource(&pdev->dev, &amd_fch_gpio_iores);
>                                                  ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/platform_device.h:13,
>                  from drivers/gpio/gpio-amd-fch.c:15:
> include/linux/device.h:708:15: note: expected 'struct resource *' but argument is of type 'const struct resource *'
>  void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
>                ^~~~~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>   9bb2e0452508 ("gpio: amd: Make resource struct const")

OK I dropped this commit until Enrico get some time to figure out
what's going wrong here.

Yours,
Linus Walleij
