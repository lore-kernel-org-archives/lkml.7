Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D0C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1642C206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6NvvxGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfIMV5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:57:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37862 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIMV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:57:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id i1so28301290edv.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXBmtndFJEiSa/yuibypv1aaQRLxwTUng1HNafafXIY=;
        b=k6NvvxGL20jhmIbQNZHUehQSfjwxafrfGKMF+7Mszkt2KZeb4LPp0Qqy1S5zFk0q2g
         W6ia+WdiQXO0gCeeGWwHmfghLR7pCB7YngFyIumjsinbmjC4BXPxsslVr5ZiqPTNoBTs
         bgG+9M9HwwMQbSp38i5i1GVBel+ddoouQXqL2Y3Se+UftarnUzjcavmSfgACwzE3qvY1
         rc1p3phfC5r/lTr5tMmJjop4Dr8eq3CwItaBifLeW2tIkNr3J7ulrfUiEJ1dBY6aD/Qy
         kzLa1aIt4bO38Yj9rVet++7TvFTf55KnSeVY9lBRG67Vhc1UphXi+blm2RdyfoUXY81N
         pr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXBmtndFJEiSa/yuibypv1aaQRLxwTUng1HNafafXIY=;
        b=Ic7ti15LrSqHcn6Bo4LfrUXyt8PleTixyBFpwyF5dtozlHJczKn8Y+85G3TgAI+E6k
         wmTAHsEM/pnmNz4govFTULdFiYap5UPGhX0hBL1ZMVRmIbAyHsYyYlO/BqWoKuuf9oMr
         eBrw+HYvGlmj5AofXCva/sZNnWdtGck5I2MEy7+RRueNU7le4rzn4wjyCMJL3d2tQTnx
         ls9R6OVdy3/oGu1gK9PMb7LJ/wv9fg/F/3Ob6Idcf+467rqkO/pHooj9aYTwjkAsbNvP
         UkMtwaUfajoisPU9uUttVtBJFTcXEOQktm2XZonTn2jToiKen0AmhiB0R1dLQ480XVfX
         vwqg==
X-Gm-Message-State: APjAAAUXA2XNpEIo488tBhi2cyb+8Hk0YOrlo7ZHnRejLXP8YChlpHR8
        FbfUtvAUkqkn1rKf7OC/p7ODMfJRN2xv2MGJxCSDBw==
X-Google-Smtp-Source: APXvYqyNOjOgrj3kaKKwB1QlWHXqQvBx4UDlJrb7HS+QDlZNVYw6g1q/V0tb1aYTJy5+4lGg4Xvm/wSth0HRmECmTt0=
X-Received: by 2002:a50:9512:: with SMTP id u18mr49332377eda.182.1568411853796;
 Fri, 13 Sep 2019 14:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190904160339.2800-1-niklas.cassel@linaro.org>
In-Reply-To: <20190904160339.2800-1-niklas.cassel@linaro.org>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Fri, 13 Sep 2019 14:57:23 -0700
Message-ID: <CAOCOHw7+0t-HPY5t8EA+vZ_A-CTt1m8V1KNUvTS7zz_3wFwhNw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: fix find_next_bit() usage
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 9:03 AM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> find_next_bit() takes a parameter of size long, and performs arithmetic
> that assumes that the argument is of size long.
>
> Therefore we cannot pass a u32, since this will cause find_next_bit()
> to read outside the stack buffer and will produce the following print:
> BUG: KASAN: stack-out-of-bounds in find_next_bit+0x38/0xb0
>
> Fixes: 1b497e6493c4 ("PCI: dwc: Fix uninitialized variable in dw_handle_msi_irq()")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d3156446ff27..45f21640c977 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -78,7 +78,8 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
>         int i, pos, irq;
> -       u32 val, num_ctrls;
> +       unsigned long val;
> +       u32 status, num_ctrls;
>         irqreturn_t ret = IRQ_NONE;
>
>         num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> @@ -86,14 +87,14 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>         for (i = 0; i < num_ctrls; i++) {
>                 dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>                                         (i * MSI_REG_CTRL_BLOCK_SIZE),
> -                                   4, &val);
> -               if (!val)
> +                                   4, &status);
> +               if (!status)
>                         continue;
>
>                 ret = IRQ_HANDLED;
> +               val = status;
>                 pos = 0;
> -               while ((pos = find_next_bit((unsigned long *) &val,
> -                                           MAX_MSI_IRQS_PER_CTRL,
> +               while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
>                                             pos)) != MAX_MSI_IRQS_PER_CTRL) {
>                         irq = irq_find_mapping(pp->irq_domain,
>                                                (i * MAX_MSI_IRQS_PER_CTRL) +
> --
> 2.21.0
>
