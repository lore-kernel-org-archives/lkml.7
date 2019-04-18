Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9843BC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA542183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UMpAUoP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbfDRHvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:51:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35812 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387971AbfDRHvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:51:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so1234129qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QO1iSRDlcNOl22A4/YfeKOusfnOAy/j21lUNnn3Rjhw=;
        b=UMpAUoP+8BmHlrChsvm22sad51bHm0B0HHD37cvDQbB5764YayjmU0lycXYtiAgins
         iQsx+DlLMyab4AQKCh/Sp2dtDUzIa2t7qsoxj3YDRqBVhsoHAZNCWk5C2VvcquDfeqZ8
         YhrPbQNXlsJN9ePOey8SHHsejkUw0JQJsw9Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QO1iSRDlcNOl22A4/YfeKOusfnOAy/j21lUNnn3Rjhw=;
        b=ToLLZ5b4syAxap/EuX4dLOJTX/y6CSM2ySxqiKMVt01LDChfIrBN58IDS62yJ0WufD
         xbV9plV7iKKxI9apMu5nAT3Adlaku2nOXvqeHB5KvA4PsiZkZGoGqLWwyuerQS7MbjU9
         A7W4SpBvbvAUhsoWbeg1tQezmSQ3cKTfpgyFQFhbPkfsEgOPxb/VIX58+LnQT6dnAOxj
         /TCnSv3EXUuOPa0w/yTzhwrSnrfSuGSH8RH1ii8JZ9S2wMFzu9YEKTeX0+aqxly+cOMc
         tl6g1G7YjacD7hKoJSONPaczSyKnMH8btDRVw+f+hRWorDpGkYW5aX+bNOE0N/cEbOUt
         l0Mw==
X-Gm-Message-State: APjAAAV5ikWamau/JO1L2p8i4toOr21FA0Sa5hhqm8djJkSuHG3HJr5d
        JwdndynJax54SEKr7hTgYXq2UWy6pQqI1SE6cC8Ijw==
X-Google-Smtp-Source: APXvYqyACxlPXnKiJcy9QU+c7HF0WEm34lLj/4GbymVqieRN50kH4onSs4AkHyNHzdlSu1oO8cnQo/3PTFKRxgKmEpA=
X-Received: by 2002:ac8:f3c:: with SMTP id e57mr70948443qtk.75.1555573875417;
 Thu, 18 Apr 2019 00:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190416060501.76276-1-jitao.shi@mediatek.com> <20190416060501.76276-3-jitao.shi@mediatek.com>
In-Reply-To: <20190416060501.76276-3-jitao.shi@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 18 Apr 2019 15:51:03 +0800
Message-ID: <CANMq1KBpi-O=XMBcc8QKN+2SNDvHaiHdUNX0La_ZuPMWx_tNMg@mail.gmail.com>
Subject: Re: [v2 2/5] drm/mediatek: CMDQ reg address of mt8173 is different
 with mt2701
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>, stonea168@163.com,
        dri-devel@lists.freedesktop.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        cawa cheng <cawa.cheng@mediatek.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 2:05 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> Config the different CMDQ reg address in driver data.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 39 +++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 6c4ac37f983d..573e6bec6d36 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -131,7 +131,6 @@
>  #define VM_CMD_EN                      BIT(0)
>  #define TS_VFP_EN                      BIT(5)
>
> -#define DSI_CMDQ0              0x180
>  #define CONFIG                         (0xff << 0)
>  #define SHORT_PACKET                   0
>  #define LONG_PACKET                    2
> @@ -156,6 +155,10 @@
>
>  struct phy;
>
> +struct mtk_dsi_driver_data {
> +       const u32 reg_cmdq_off;
> +};
> +
>  struct mtk_dsi {
>         struct mtk_ddp_comp ddp_comp;
>         struct device *dev;
> @@ -182,6 +185,7 @@ struct mtk_dsi {
>         bool enabled;
>         u32 irq_data;
>         wait_queue_head_t irq_wait_queue;
> +       struct mtk_dsi_driver_data *driver_data;

As highlighted by kbuild, you're missing a const here.

>  };
>
>  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> @@ -934,6 +938,7 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
>         const char *tx_buf = msg->tx_buf;
>         u8 config, cmdq_size, cmdq_off, type = msg->type;
>         u32 reg_val, cmdq_mask, i;
> +       u32 reg_cmdq_off = dsi->driver_data->reg_cmdq_off;
>
>         if (MTK_DSI_HOST_IS_READ(type))
>                 config = BTA;
> @@ -953,9 +958,11 @@ static void mtk_dsi_cmdq(struct mtk_dsi *dsi, const struct mipi_dsi_msg *msg)
>         }
>
>         for (i = 0; i < msg->tx_len; i++)
> -               writeb(tx_buf[i], dsi->regs + DSI_CMDQ0 + cmdq_off + i);
> +               mtk_dsi_mask(dsi, (reg_cmdq_off + cmdq_off + i) & (~0x3U),
> +                            (0xffUL << (((i + cmdq_off) & 3U) * 8U)),
> +                            tx_buf[i] << (((i + cmdq_off) & 3U) * 8U));

The writeb call looked significantly cleaner...

writeb(tx_buf[i], dsi->regs + reg_cmdq_off + cmdq_off + i);
should just work, right?

>
> -       mtk_dsi_mask(dsi, DSI_CMDQ0, cmdq_mask, reg_val);
> +       mtk_dsi_mask(dsi, reg_cmdq_off, cmdq_mask, reg_val);
>         mtk_dsi_mask(dsi, DSI_CMDQ_SIZE, CMDQ_SIZE, cmdq_size);
>  }
>
> @@ -1074,10 +1081,27 @@ static const struct component_ops mtk_dsi_component_ops = {
>         .unbind = mtk_dsi_unbind,
>  };
>
> +static const struct mtk_dsi_driver_data mt8173_dsi_driver_data = {
> +       .reg_cmdq_off = 0x200,
> +};
> +
> +static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
> +       .reg_cmdq_off = 0x180,
> +};
> +
> +static const struct of_device_id mtk_dsi_of_match[] = {
> +       { .compatible = "mediatek,mt2701-dsi",
> +         .data = &mt2701_dsi_driver_data },
> +       { .compatible = "mediatek,mt8173-dsi",
> +         .data = &mt8173_dsi_driver_data },
> +       { },
> +};
> +
>  static int mtk_dsi_probe(struct platform_device *pdev)
>  {
>         struct mtk_dsi *dsi;
>         struct device *dev = &pdev->dev;
> +       const struct of_device_id *of_id;
>         struct resource *regs;
>         int irq_num;
>         int comp_id;
> @@ -1101,6 +1125,9 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_unregister_host;
>
> +       of_id = of_match_device(mtk_dsi_of_match, &pdev->dev);
> +       dsi->driver_data = of_id->data;
> +
>         dsi->engine_clk = devm_clk_get(dev, "engine");
>         if (IS_ERR(dsi->engine_clk)) {
>                 ret = PTR_ERR(dsi->engine_clk);
> @@ -1193,12 +1220,6 @@ static int mtk_dsi_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static const struct of_device_id mtk_dsi_of_match[] = {
> -       { .compatible = "mediatek,mt2701-dsi" },
> -       { .compatible = "mediatek,mt8173-dsi" },
> -       { },
> -};
> -
>  struct platform_driver mtk_dsi_driver = {
>         .probe = mtk_dsi_probe,
>         .remove = mtk_dsi_remove,
> --
> 2.21.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
