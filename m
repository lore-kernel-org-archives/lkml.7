Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0348C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C004820828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b2F7jM51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfCFKpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:45:12 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42864 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCFKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:45:11 -0500
Received: by mail-qt1-f195.google.com with SMTP id u7so12244619qtg.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNSPJGPmkoollA8NTevZ2GaPbN7nenvhe4n6FeTqTvA=;
        b=b2F7jM51eWgcHZ4B+fOyHa1OOUeIGW5UMdjDNGVAUvN/5N8O0R2o+o/AppdUBOKDC/
         GXMJ/LMNtMtGyL6bSOdf8IjC9Bj+xY2jE2lBsTgINXDGI+4nzeD9s85wjTQ37VhaAPLY
         omddHBUZWqIukLE2pXKEtke+qF19oZt892bRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNSPJGPmkoollA8NTevZ2GaPbN7nenvhe4n6FeTqTvA=;
        b=Qvy1pWBzpxdH10bN7zxBmaLVF+s4urJIsTSkTvr3ot7SQLXk5w9ZOG92ZFVuJzS1V+
         sriFWRQkg724B7i75ROcyldgmm1Ttea1PLjLoMxb4qkoa09VIYfXQipIKgEmo+wLr4E8
         1xDWiyMxwW8G8qe0v5irb1sFjrIi9++kr/tbzcw2wrJQoclQ1gK6lr+LzJfsebu28mDJ
         49dQwFLr+XgBlKglsyqt/owpFlJOZZTQxjg9JYwXEJP0PrOcN8cLx6CqoRbxHqtGrdB7
         va/M0slS6jRJI+o7Nk2ZmgYWPiF25cRlqWcch1hwTUYbD5vrJQubCdamxQoy3W299FUV
         S8vQ==
X-Gm-Message-State: APjAAAVHjsmP7XzJs+h3xt4Gps2hc8xPUNkhPIabvrj7+yD/x3CVa1I5
        ZXbcX+XrXJ7v+RllASISG6rd+ZDhtG3m/x+fm878Pw==
X-Google-Smtp-Source: APXvYqyjhbrsB/5FeE+smE+ukOXlgZ7BkENj+OagbKJ2p173fHbJojnP21h+i7hbZ6+ydpUlUIUmOxEdRoLScviQ50M=
X-Received: by 2002:aed:2a2f:: with SMTP id c44mr5171308qtd.144.1551869109701;
 Wed, 06 Mar 2019 02:45:09 -0800 (PST)
MIME-Version: 1.0
References: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com> <1551186660-16902-5-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1551186660-16902-5-git-send-email-qii.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 6 Mar 2019 18:44:58 +0800
Message-ID: <CANMq1KDc9mvhAhUg5Cdv5zQN8Rbv884vSCy4kVK81tES4rMCJw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] i2c: mediatek: Add i2c and apdma sync in i2c driver
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Leilk Liu <leilk.liu@mediatek.com>, xinping.qian@mediatek.com,
        liguo.zhang@mediatek.com, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 9:11 PM Qii Wang <qii.wang@mediatek.com> wrote:
>
> When i2c and apdma use different source clocks, we should enable
> synchronization between them.
>
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 14d6b38..75d88e1 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -77,6 +77,8 @@
>  #define I2C_CONTROL_DIR_CHANGE          (0x1 << 4)
>  #define I2C_CONTROL_ACKERR_DET_EN       (0x1 << 5)
>  #define I2C_CONTROL_TRANSFER_LEN_CHANGE (0x1 << 6)
> +#define I2C_CONTROL_DMAACK_EN           (0x1 << 8)
> +#define I2C_CONTROL_ASYNC_MODE          (0x1 << 9)
>  #define I2C_CONTROL_WRAPPER             (0x1 << 0)
>
>  #define I2C_DRV_NAME           "i2c-mt65xx"
> @@ -169,6 +171,7 @@ struct mtk_i2c_compatible {
>         unsigned char aux_len_reg: 1;
>         unsigned char support_33bits: 1;
>         unsigned char timing_adjust: 1;
> +       unsigned char dma_sync: 1;
>  };
>
>  struct mtk_i2c {
> @@ -218,6 +221,7 @@ struct mtk_i2c {
>         .aux_len_reg = 1,
>         .support_33bits = 1,
>         .timing_adjust = 1,
> +       .dma_sync = 0,
>  };
>
>  static const struct mtk_i2c_compatible mt6577_compat = {
> @@ -229,6 +233,7 @@ struct mtk_i2c {
>         .aux_len_reg = 0,
>         .support_33bits = 0,
>         .timing_adjust = 0,
> +       .dma_sync = 0,
>  };
>
>  static const struct mtk_i2c_compatible mt6589_compat = {
> @@ -240,6 +245,7 @@ struct mtk_i2c {
>         .aux_len_reg = 0,
>         .support_33bits = 0,
>         .timing_adjust = 0,
> +       .dma_sync = 0,
>  };
>
>  static const struct mtk_i2c_compatible mt7622_compat = {
> @@ -251,6 +257,7 @@ struct mtk_i2c {
>         .aux_len_reg = 1,
>         .support_33bits = 0,
>         .timing_adjust = 0,
> +       .dma_sync = 0,
>  };
>
>  static const struct mtk_i2c_compatible mt8173_compat = {
> @@ -261,6 +268,7 @@ struct mtk_i2c {
>         .aux_len_reg = 1,
>         .support_33bits = 1,
>         .timing_adjust = 0,
> +       .dma_sync = 0,
>  };
>
>  static const struct of_device_id mtk_i2c_of_match[] = {
> @@ -360,6 +368,9 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>
>         control_reg = I2C_CONTROL_ACKERR_DET_EN |
>                       I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
> +       if (i2c->dev_comp->dma_sync)
> +               control_reg |= I2C_CONTROL_DMAACK_EN | I2C_CONTROL_ASYNC_MODE;
> +
>         mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
>         mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
>
> --
> 1.7.9.5
>
