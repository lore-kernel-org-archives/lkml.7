Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28791C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ADF21655
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hqFkhfDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLSD6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:58:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44720 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLSD6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:58:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id w127so3511779qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 19:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gW5SNpt87UiG+lsIdrY5UhkxjdU7rCSW5a9k6JS9SRk=;
        b=hqFkhfDzCCKIUTBL6FeQxUmjvs91e8R1WmNH0Vumuze6UR95Wrm3Tm7TSP/G5+p2yi
         NcohuQv4yW/e/F73o9/U/0brsCCYjDSsFJ0FzHUZUJ7Y3w8xzUwKwuVzwHyodCdvvRTY
         xPQFXPHStersJiiwdEMwbEwdFJOsf8FM7ID0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gW5SNpt87UiG+lsIdrY5UhkxjdU7rCSW5a9k6JS9SRk=;
        b=L+Qw3PLkmRGCmlCWuxzPbz9/5gqniV8u/bqf3g3yxhZUa5MuXsvmMda+6h/99x00Wb
         UfLnmAfJiRd4GpqWOExLp12FlXyzZISCIcfwp8FtAaGyHrjeK8tfxJp2OF7QmfvPJXDR
         AFz9j9CeksOdRzdff7jPGNvnm4O95oPvTpItXogz28m6B9WRwVxU9XrfVFMcHJAdBPPT
         wP9IhtaaZi3AzkWDPLWiujOd5pJl2Kejgm/Df/XAqLkMQjRLnzA5/pG8cmkL7KzsCITa
         ODAsTme+DB974A/NkanZi+TxrFu4PpzOkDot08xGuwgq9kGSzX91H9ricyvo5FZpXJly
         6qJQ==
X-Gm-Message-State: APjAAAWuYWb/wgqNkSWYNbWg1mcySBjqbIjHcoDlTPnbdY+L+rxEJeq1
        NG8eQTnMvKx86mvIBJr73ZP8T3cy2RwbdwKKqsUuKA==
X-Google-Smtp-Source: APXvYqyXidRE2qnvUa+RAtayNDFWnB5o5tPU43BxSLYWf08arGF8HAOG7Pl7mstZLKWLgHOqgzccqGmeitfLHhV35Sk=
X-Received: by 2002:ae9:f003:: with SMTP id l3mr6202689qkg.457.1576727881256;
 Wed, 18 Dec 2019 19:58:01 -0800 (PST)
MIME-Version: 1.0
References: <1576657848-14711-1-git-send-email-weiyi.lu@mediatek.com> <1576657848-14711-10-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1576657848-14711-10-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 19 Dec 2019 11:57:50 +0800
Message-ID: <CANMq1KB_YFUg34UJ_-uaOgrr_UDig5GkZrtMWKTD-qxg=+GRmg@mail.gmail.com>
Subject: Re: [PATCH v10 09/12] soc: mediatek: Add extra sram control
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 4:31 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> For some power domains like vpu_core on MT8183 whose sram need to
> do clock and internal isolation while power on/off sram.
> We add a flag "sram_iso_ctrl" in scp_domain_data to judge if we
> need to do the extra sram isolation control or not.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 9f06f17..e010fb3 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -56,6 +56,8 @@
>  #define PWR_ON_BIT                     BIT(2)
>  #define PWR_ON_2ND_BIT                 BIT(3)
>  #define PWR_CLK_DIS_BIT                        BIT(4)
> +#define PWR_SRAM_CLKISO_BIT            BIT(5)
> +#define PWR_SRAM_ISOINT_B_BIT          BIT(6)
>
>  #define PWR_STATUS_CONN                        BIT(1)
>  #define PWR_STATUS_DISP                        BIT(3)
> @@ -86,6 +88,8 @@
>   * @name: The domain name.
>   * @sta_mask: The mask for power on/off status bit.
>   * @ctl_offs: The offset for main power control register.
> + * @sram_iso_ctrl: The flag to judge if the power domain need to do
> + *                 the extra sram isolation control.
>   * @sram_pdn_bits: The mask for sram power control bits.
>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>   * @basic_clk_name: The basic clocks required by this power domain.
> @@ -98,6 +102,7 @@ struct scp_domain_data {
>         const char *name;
>         u32 sta_mask;
>         int ctl_offs;
> +       bool sram_iso_ctrl;
>         u32 sram_pdn_bits;
>         u32 sram_pdn_ack_bits;
>         const char *basic_clk_name[MAX_CLKS];
> @@ -233,6 +238,14 @@ static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
>                         return ret;
>         }
>
> +       if (scpd->data->sram_iso_ctrl)  {
> +               val = readl(ctl_addr) | PWR_SRAM_ISOINT_B_BIT;
> +               writel(val, ctl_addr);
> +               udelay(1);
> +               val &= ~PWR_SRAM_CLKISO_BIT;
> +               writel(val, ctl_addr);
> +       }
> +
>         return 0;
>  }
>
> @@ -242,8 +255,15 @@ static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
>         u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>         int tmp;
>
> -       val = readl(ctl_addr);
> -       val |= scpd->data->sram_pdn_bits;
> +       if (scpd->data->sram_iso_ctrl)  {
> +               val = readl(ctl_addr) | PWR_SRAM_CLKISO_BIT;
> +               writel(val, ctl_addr);
> +               val &= ~PWR_SRAM_ISOINT_B_BIT;
> +               writel(val, ctl_addr);
> +               udelay(1);
> +       }
> +
> +       val = readl(ctl_addr) | scpd->data->sram_pdn_bits;
>         writel(val, ctl_addr);
>
>         /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> --
> 1.8.1.1.dirty
