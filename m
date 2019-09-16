Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261C2C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB38E206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568656854;
	bh=dMVZGCnsh4fILPwk9WjxtUMiqu6/4VUD7cpn/PynxBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X5SY97D/KNaeQN78lc5MaMTV0KSJ1p1FdFYKUkG+l5XwU64GQyKRaogafPMS6RmE3
	 sRx43V1JjSdZBJ4SX4nfA/KLZlGZ8v9XaepnuuBdibv62Y/HQfrWYa9WFFWUcvqRwA
	 xJsnA8PaFIhp3bd6iJxHKNBc4GCzv1Zei+bUifjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbfIPSAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfIPSAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:00:52 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A967B21852;
        Mon, 16 Sep 2019 18:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568656851;
        bh=dMVZGCnsh4fILPwk9WjxtUMiqu6/4VUD7cpn/PynxBU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dA+WUt4bl+6RjbJXd6HF1hu64FfIcM9QX9YW4t2hzTazyLV/Iaoca7f3s5hvMGRfX
         dUkMCuyYjsg7LbTHbUT4NtHLI1jntNf386bm+W+Sn/j/D/cwc/e5hXg3YRgLTnilsp
         ekJXXM1ZL9uIJUpxuj4/0YcEw835CHNKr6fffgxY=
Received: by mail-qt1-f171.google.com with SMTP id j31so931613qta.5;
        Mon, 16 Sep 2019 11:00:51 -0700 (PDT)
X-Gm-Message-State: APjAAAVsDqTzLINh9ipHMcOIavKoReorSFevySVF7khyAZPMXSyS1ElA
        ALHHzDV/7sA+cWyqzxLHH1/zHIzsBDFmmTUaGA==
X-Google-Smtp-Source: APXvYqyf350ByfqcVlNXWlnTIksw+7j/6O4GUGxPPUMBxsS6Jl38vpunqWIRMsPX1zJ/s4uT+gn50ziIwq/u9H4MMs4=
X-Received: by 2002:ac8:444f:: with SMTP id m15mr938733qtn.110.1568656850832;
 Mon, 16 Sep 2019 11:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org> <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 16 Sep 2019 13:00:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJP6JiZTV=DwuSQLLEv9dMST82Xkrb5AnqREjR5hk5=7Q@mail.gmail.com>
Message-ID: <CAL_JsqJP6JiZTV=DwuSQLLEv9dMST82Xkrb5AnqREjR5hk5=7Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Thomas Liau <thomas.liau@actions-semi.com>,
        linux-actions@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:46 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add devicetree YAML binding for Actions Semi Owl SoC's SD/MMC/SDIO
> controller.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/mmc/owl-mmc.yaml      | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
