Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808BFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7432339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKgu0Jl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfH2NhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:37:05 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43791 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfH2NhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:37:05 -0400
Received: by mail-ua1-f65.google.com with SMTP id y7so1146405uae.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoycuwM03PAMoYB7LC8b4YSa3oTRgt158KShkM1cXKQ=;
        b=zKgu0Jl4DlvWeQzglf9VPPVkVjkJuw4LSkmT+pELc19VL8JHSvF1cXxTazR+CrZKKr
         kCKva4b0mB1m11diTo57wSNo45Olb6PZAJ9MJQFkQ9yVFAuSd2k0u3LBqbauDprRPNQ/
         aJIlTmkMU61yn3ZDe4r1wBrDPkK9guE6hwr+NIl8Z8P1Ql0aZaijF0sATF21E99eR39v
         WrYTJUr3d3ot/wHi7f49JTlZhShwYMK1yvSVT9G3kmmwWgzaIUFbdbuq98bWRlS4/55u
         6C4AqN2+/uw0MAuG40eXp0w6XNwSJ1YHaW+xBYhE0f0VcARxF6IRgR4b2ubMxBBfGaOc
         sRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoycuwM03PAMoYB7LC8b4YSa3oTRgt158KShkM1cXKQ=;
        b=JKMPpLrMMPBS3wRJADLb2qgtT2cuUe6FndiQIXEdnL9tgT3N8cW1unZf98m1U3mCRj
         pUwy8B0KeQqjEaOi0ZL8fkVHHtZiTg/6qr925czqOpdLBGzR5RVTkFXkxJJLG8QC4BX8
         hgUUNjLVqhQQgYPViPm4C6QzK0BJEXCQNJDENU+LOiNWCaOKpmhTi/C06fKydZmD6bPo
         zdyIklM0D2Yj2l2K50fm9whAX0GIptq+A3Bs12GBwnPq3QYV1a6hu7lcWY7DUTYZXCP5
         TnXT1l4eT7RfWeZaJmc+hokx5O+VUKGuAD45B2PajDIzNPuMQ3TSTP3bC+1ZOV+bLIZC
         h2IA==
X-Gm-Message-State: APjAAAXEFmhhcyrkLggiDUU3lsC5U68aI6fE3OwX+wbSQ1QPcPBw699j
        6J9zfmisr3+5YHPDXIdBILyUYqh+yp/GrWH8cKfbfQ==
X-Google-Smtp-Source: APXvYqw5PMEM/AaXKseVFjiJDB4qE632N2Eh8ohpX17hqRNF3TeDatpY+W6xb/csgdhA+MJBYjRRNsuLKGcO5K48bSs=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr4939055uar.104.1567085824135;
 Thu, 29 Aug 2019 06:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <1566985524-22749-1-git-send-email-yong.mao@mediatek.com> <1566985524-22749-2-git-send-email-yong.mao@mediatek.com>
In-Reply-To: <1566985524-22749-2-git-send-email-yong.mao@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 15:36:28 +0200
Message-ID: <CAPDyKFqgO7fwybn1nYcf14jiHswM+T7fqY1BuSvx5AubYA6F=A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mediatek: enable SDIO IRQ low level trigger function
To:     Yong Mao <yong.mao@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 at 11:45, Yong Mao <yong.mao@mediatek.com> wrote:
>
> From: yong mao <yong.mao@mediatek.com>
>
> SDIO IRQ is not defaultly triggered by low level,
> but by falling edge. It needs to set related register
> to enable SDIO IRQ low level trigger function.
> Otherwise the SDIO IRQ may be lost in some specail condition.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 33f4b63..585f0c7 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -192,6 +192,7 @@
>  #define SDC_STS_CMDBUSY         (0x1 << 1)     /* RW */
>  #define SDC_STS_SWR_COMPL       (0x1 << 31)    /* RW */
>
> +#define SDC_DAT1_IRQ_TRIGGER   (0x1 << 19)     /* RW */
>  /* SDC_ADV_CFG0 mask */
>  #define SDC_RX_ENHANCE_EN      (0x1 << 20)     /* RW */
>
> @@ -1568,6 +1569,7 @@ static void msdc_init_hw(struct msdc_host *host)
>
>         /* Config SDIO device detect interrupt function */
>         sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_DAT1_IRQ_TRIGGER);
>
>         /* Configure to default data timeout */
>         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> --
> 1.9.1
>
