Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A41206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PLJ8W6IL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfCFKwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:52:49 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35177 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfCFKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:52:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so12278372qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDBjFKRP18AwFmD+CDBABvKYQ2A+ib44WHtjn9kffM0=;
        b=PLJ8W6ILVaCVRC9tJ8ORusygjM0wnXY3v2Vvd/ENKc/KyDJsfBDzKy7RjrlRB/+yzV
         x4xt/PVN6R8BG3yJWvnFSpoaHbc6LbpOQIomudCcD1XMWNX4iiNmoYk4/7v5EUActAL5
         JpyglhA4RlDoNl6J/ehNiKHulpkD/oboyBsbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDBjFKRP18AwFmD+CDBABvKYQ2A+ib44WHtjn9kffM0=;
        b=ctUg4sQKwywJlei3OmaoksLgn8TX7l81jkiH6HmzjVl/TKrxTtsqPP980wFx3uQAfc
         r/SflEonAknNGdOal00ieEkASPoO7qPZdZWaNoLox3TZskuI4oeErSjtb+NgNQNeBw2K
         WICeEW+pXW66/bKB2r7CQv20wbUTd6mRyi+MIW/H31rUNLWNhL3zUM1UVYedba335AHo
         pvcWG5XAh0IU8hOziHJnEr1UVV/q1mNLYud6lfIwVMSmVWaILfeXedqi2LTrfA6WSxRg
         6B54Rty6lZH8NKzTFlJSr6kEP9M+E+UUsPDuI0Qzl7j4C/YkB5LoloWHGEHtjdxcuNaQ
         KxOQ==
X-Gm-Message-State: APjAAAUcB+vf6BV5TNspj9VSoght3l9zfFC8mr5KiE/a3V1yJI/0E3KG
        QQmJ518ZnhFF9vmJovPUBncV9TJr9lSAhtc3gDt55A==
X-Google-Smtp-Source: APXvYqxXlSKsqcP3sGzrX5r4LV4w6OzS2uSxTuHzuBbPiT8OyDvGTqP4N9Aw3PVg+rWHzSViTiZHIuR+MPuCRJ+Dgig=
X-Received: by 2002:aed:2a2f:: with SMTP id c44mr5192298qtd.144.1551869566953;
 Wed, 06 Mar 2019 02:52:46 -0800 (PST)
MIME-Version: 1.0
References: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com> <1551186660-16902-6-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1551186660-16902-6-git-send-email-qii.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 6 Mar 2019 18:52:35 +0800
Message-ID: <CANMq1KBMwWEegui9439q2wVVLRyp6XT8=Om8H7EYGCR6bJw=eg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] i2c: mediatek: Add i2c support for MediaTek MT8183
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
> Add i2c compatible for MT8183. Compare to MT2712 i2c controller,
> MT8183 has different register offsets. Ltiming_reg is added to
> adjust low width of SCL. Arb clock and dma_sync are needed.
>
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---
>  drivers/i2c/busses/i2c-mt65xx.c |   53 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 75d88e1..82eedbd 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -133,6 +133,8 @@ enum I2C_REGS_OFFSET {
>         OFFSET_DEBUGCTRL,
>         OFFSET_TRANSFER_LEN_AUX,
>         OFFSET_CLOCK_DIV,
> +       /* MT8183 only regs */
> +       OFFSET_LTIMING,
>  };
>
>  static const u16 mt_i2c_regs_v1[] = {
> @@ -162,6 +164,32 @@ enum I2C_REGS_OFFSET {
>         [OFFSET_CLOCK_DIV] = 0x70,
>  };
>
> +static const u16 mt_i2c_regs_v2[] = {
> +       [OFFSET_DATA_PORT] = 0x0,
> +       [OFFSET_SLAVE_ADDR] = 0x4,
> +       [OFFSET_INTR_MASK] = 0x8,
> +       [OFFSET_INTR_STAT] = 0xc,
> +       [OFFSET_CONTROL] = 0x10,
> +       [OFFSET_TRANSFER_LEN] = 0x14,
> +       [OFFSET_TRANSAC_LEN] = 0x18,
> +       [OFFSET_DELAY_LEN] = 0x1c,
> +       [OFFSET_TIMING] = 0x20,
> +       [OFFSET_START] = 0x24,
> +       [OFFSET_EXT_CONF] = 0x28,
> +       [OFFSET_LTIMING] = 0x2c,
> +       [OFFSET_HS] = 0x30,
> +       [OFFSET_IO_CONFIG] = 0x34,
> +       [OFFSET_FIFO_ADDR_CLR] = 0x38,
> +       [OFFSET_TRANSFER_LEN_AUX] = 0x44,
> +       [OFFSET_CLOCK_DIV] = 0x48,
> +       [OFFSET_SOFTRESET] = 0x50,
> +       [OFFSET_DEBUGSTAT] = 0xe0,
> +       [OFFSET_DEBUGCTRL] = 0xe8,
> +       [OFFSET_FIFO_STAT] = 0xf4,
> +       [OFFSET_FIFO_THRESH] = 0xf8,
> +       [OFFSET_DCM_EN] = 0xf88,
> +};
> +
>  struct mtk_i2c_compatible {
>         const struct i2c_adapter_quirks *quirks;
>         const u16 *regs;
> @@ -195,6 +223,7 @@ struct mtk_i2c {
>         enum mtk_trans_op op;
>         u16 timing_reg;
>         u16 high_speed_reg;
> +       u16 ltiming_reg;
>         unsigned char auto_restart;
>         bool ignore_restart_irq;
>         const struct mtk_i2c_compatible *dev_comp;
> @@ -271,12 +300,24 @@ struct mtk_i2c {
>         .dma_sync = 0,
>  };
>
> +static const struct mtk_i2c_compatible mt8183_compat = {
> +       .regs = mt_i2c_regs_v2,
> +       .pmic_i2c = 0,
> +       .dcm = 0,
> +       .auto_restart = 1,
> +       .aux_len_reg = 1,
> +       .support_33bits = 1,
> +       .timing_adjust = 1,
> +       .dma_sync = 1,
> +};
> +
>  static const struct of_device_id mtk_i2c_of_match[] = {
>         { .compatible = "mediatek,mt2712-i2c", .data = &mt2712_compat },
>         { .compatible = "mediatek,mt6577-i2c", .data = &mt6577_compat },
>         { .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
>         { .compatible = "mediatek,mt7622-i2c", .data = &mt7622_compat },
>         { .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
> +       { .compatible = "mediatek,mt8183-i2c", .data = &mt8183_compat },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
> @@ -361,6 +402,8 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>
>         mtk_i2c_writew(i2c, i2c->timing_reg, OFFSET_TIMING);
>         mtk_i2c_writew(i2c, i2c->high_speed_reg, OFFSET_HS);
> +       if (i2c->dev_comp->regs == mt_i2c_regs_v2)
> +               mtk_i2c_writew(i2c, i2c->ltiming_reg, OFFSET_LTIMING);

Matthias wasn't super happy with this. One way is to add another field
in the compatible string. Another may be to have
mt_i2c_regs_v1[OFFSET_LTIMING] point at, say 0xffff (#define this as
I2C_REG_INVALID or something), and test for that?

Either way would scale better if we end up with more than 2 versions
of the register set in the future.

>         /* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first */
>         if (i2c->have_pmic)
> @@ -460,6 +503,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>         unsigned int clk_src;
>         unsigned int step_cnt;
>         unsigned int sample_cnt;
> +       unsigned int l_step_cnt;
> +       unsigned int l_sample_cnt;
>         unsigned int target_speed;
>         int ret;
>
> @@ -469,11 +514,11 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>         if (target_speed > MAX_FS_MODE_SPEED) {
>                 /* Set master code speed register */
>                 ret = mtk_i2c_calculate_speed(i2c, clk_src, MAX_FS_MODE_SPEED,
> -                                             &step_cnt, &sample_cnt);
> +                                             &l_step_cnt, &l_sample_cnt);
>                 if (ret < 0)
>                         return ret;
>
> -               i2c->timing_reg = (sample_cnt << 8) | step_cnt;
> +               i2c->timing_reg = (l_sample_cnt << 8) | l_step_cnt;
>
>                 /* Set the high speed mode register */
>                 ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
> @@ -483,6 +528,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>
>                 i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
>                         (sample_cnt << 12) | (step_cnt << 8);
> +               i2c->ltiming_reg = (l_sample_cnt << 6) | l_step_cnt |
> +                                  (sample_cnt << 12) | (step_cnt << 9);
>         } else {
>                 ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
>                                               &step_cnt, &sample_cnt);
> @@ -493,6 +540,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>
>                 /* Disable the high speed transaction */
>                 i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
> +
> +               i2c->ltiming_reg = (sample_cnt << 6) | step_cnt;
>         }
>
>         return 0;
> --
> 1.7.9.5
>
