Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75CBC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB20E20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vydhvi9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbfIEWuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:50:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34154 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfIEWuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:50:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id a13so4941358qtj.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 15:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mt9CnpWDYE9AuIn/hMdu40hiJSofbzdMOkAcHsCIv0A=;
        b=Vydhvi9xtxhqe5HoBNZPhdiSWovcw1HFQTA8soQuoeVMc6pIcQ5l37oQ3SalYjcgjm
         TrbR2gyQ0J8Z5UPkHYElYPnXXieZeIn8ra2Lk7QRG5pG5hbOY9DVaX9uLAGALyg85Txg
         Es6trlS030XfryZ7vU/40X/oGNBbzuCH/ebqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mt9CnpWDYE9AuIn/hMdu40hiJSofbzdMOkAcHsCIv0A=;
        b=lDuwbLtWUSpyUbKXUKaunu5CbfFQ44LwGXgGJlpyb5ZI+OWKUggX/aRw0x9Zt+IoNZ
         F3mafTB1DjbU1TLq5SVbuYYHJkt30KrsnWbOFjGnbMR1tYSl9psTHFTtMHSyVokOtQk2
         qgwodI8bHRpE/xLNpxGEcA9Xf50cnW/CASmXUYOHVh9q48KgeLzndJBINbsYeNX+3Onp
         RyVRuTbx+0FAUvShuqCglBxZ98ONq/Fmip28SQMphPBeJoPMW9n+coVBV2OIDOKyqjyc
         TxJ6+pFyA62GomxdJ+Axk4izGr6N2Lx5kFHi5Gu0hZS0Yl0cmqIr/KF5OM8iyK2iTL0C
         6K3A==
X-Gm-Message-State: APjAAAVIOzYOceWSkIk47wlnQVLkvOnr5WMLB3FOMWLt2PQnCUE+irvX
        oJsufP1k9xI7F8T1GFwdhblF/Of45USXn6iR9sK87w==
X-Google-Smtp-Source: APXvYqx+KZU9zIaMUMZ+jLWYnGv8HnZ+gqwV0E2600/1VRfMon8nX6vFFavjV+luTwMIWxrqVykRIXpwOLTFiFRi94I=
X-Received: by 2002:ac8:434e:: with SMTP id a14mr6318575qtn.278.1567723810989;
 Thu, 05 Sep 2019 15:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190830074103.16671-1-bibby.hsieh@mediatek.com> <20190830074103.16671-2-bibby.hsieh@mediatek.com>
In-Reply-To: <20190830074103.16671-2-bibby.hsieh@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 6 Sep 2019 06:49:59 +0800
Message-ID: <CANMq1KDUR2cFrQC0NdfvLD=0QDiYoyOTGMf3RWyg5PPSURhGMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mediatek: Support CMDQ interface in ddp component
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 3:41 PM Bibby Hsieh <bibby.hsieh@mediatek.com> wrote:
>
> The CMDQ (Command Queue) in MT8183 is used to help
> update all relevant display controller registers
> with critical time limation.
> This patch add cmdq interface in ddp_comp interface,
> let all ddp_comp interface can support cpu/cmdq function
> at the same time.
>
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> --- [snip]
>  static void mtk_gamma_set(struct mtk_ddp_comp *comp,
> -                         struct drm_crtc_state *state)
> +                         struct drm_crtc_state *state,
> +                         struct cmdq_pkt *cmdq_pkt)
>  {
> -       unsigned int i, reg;
> +       unsigned int i;
>         struct drm_color_lut *lut;
>         void __iomem *lut_base;
>         u32 word;
>
>         if (state->gamma_lut) {
> -               reg = readl(comp->regs + DISP_GAMMA_CFG);
> -               reg = reg | GAMMA_LUT_EN;
> -               writel(reg, comp->regs + DISP_GAMMA_CFG);
> +               mtk_ddp_write_mask(cmdq_pkt, GAMMA_LUT_EN, comp,
> +                                  DISP_GAMMA_CFG, GAMMA_LUT_EN);
>                 lut_base = comp->regs + DISP_GAMMA_LUT;
>                 lut = (struct drm_color_lut *)state->gamma_lut->data;
>                 for (i = 0; i < MTK_LUT_SIZE; i++) {
>                         word = (((lut[i].red >> 6) & LUT_10BIT_MASK) << 20) +
>                                 (((lut[i].green >> 6) & LUT_10BIT_MASK) << 10) +
>                                 ((lut[i].blue >> 6) & LUT_10BIT_MASK);
> -                       writel(word, (lut_base + i * 4));
> +                       mtk_ddp_write(cmdq_pkt, word, comp,
> +                                     (unsigned int)(lut_base + i * 4));

Guenter pointed out that this looks quite wrong. We should have:
unsigned int lut_base;
lut_base = DISP_GAMMA_LUT;
mtk_ddp_write(cmdq_pkt, word, comp, lut_base + i * 4);

Or more simply:
mtk_ddp_write(cmdq_pkt, word, comp, DISP_GAMMA_LUT + i * 4);

>                 }
>         }
