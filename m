Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DABC2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D11920717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DtWiSVkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfLPH3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 02:29:11 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39827 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfLPH3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 02:29:10 -0500
Received: by mail-qv1-f65.google.com with SMTP id y8so2342663qvk.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 23:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dV2vlOFsb8F1dAAOKXkJvVUNN8FBypx/gfjiA3eTMEk=;
        b=DtWiSVkzUKVe/+yccfzUw4WSKnnZtLyFCqfBtFPkSMldVlhuvwOPUyS3ok/mY4XPAF
         PHC1IMbSqaHlr4Hh5oFyoIovVNdsI1TN66gV/B7nWVJSXuKWQgYaJFdCbhAg0Rlu7mRD
         3qHcptFRU6nlSJeHsmFWtsqh6MrCKNSH1Nv9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dV2vlOFsb8F1dAAOKXkJvVUNN8FBypx/gfjiA3eTMEk=;
        b=LZ4QR81Gtwtiqpo/wsJWfh0Pc/Fok+VO71dltVm/OozVkdjnJYjTerCnyhqViIVF7q
         2fI1a6Oyn23Xw7yQfLJpRPxuzyD8s9tATfeRpQlsbmppgzZ636VBOVmYzuXCiLhvzI74
         F6UNSpGfsH8+aqvAkoEIVnk8hIIe/Df8mZhy6KzcWyvK+ffKAx0YroS2yCVWPEcnAszv
         WeV21PvKUG9r0UH8KdRCn9PgyxSWeKWDnEzDRS7A0rD2RI555UU7L74JWZ4tbz8JZf6N
         dImgQbKpeZy/rJLeGdD7UHQJC7I9ADA5ts7YuP212Qy/LqAuN5Or33cXbu9RI5uK2fNq
         62vQ==
X-Gm-Message-State: APjAAAXTSfsIBL5AceAMvEd06ORlfTJC5qoTN+g3h5QbRGVVPvb753Md
        d9C1CfcDYFyTRt6kxMkjzphJVYFk5C9Y72K+4rtAYA==
X-Google-Smtp-Source: APXvYqwq88sA56fSNNx0AkPlWaUiYAr/DCMmo6+DmdP4m8AvPhTWR6m3PCZRTb+X+AY/KsJkRJPt4zf5ONRH+6KvmMI=
X-Received: by 2002:a0c:f703:: with SMTP id w3mr25474009qvn.6.1576481349748;
 Sun, 15 Dec 2019 23:29:09 -0800 (PST)
MIME-Version: 1.0
References: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com> <1575960413-6900-7-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1575960413-6900-7-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 16 Dec 2019 15:28:58 +0800
Message-ID: <CANMq1KDkywkPBDK9bbKqDcYser-QiXV-XSuDmVCqnkh6Su9Awg@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] soc: mediatek: Add extra sram control
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 2:47 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> For some power domains like vpu_core on MT8183 whose sram need to
> do clock and internal isolation while power on/off sram.
> We add a flag "sram_iso_ctrl" in scp_domain_data to judge if we
> need to do the extra sram isolation control or not.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 2bbf907..0676b46 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -57,6 +57,8 @@
>  #define PWR_ON_BIT                     BIT(2)
>  #define PWR_ON_2ND_BIT                 BIT(3)
>  #define PWR_CLK_DIS_BIT                        BIT(4)
> +#define PWR_SRAM_CLKISO_BIT            BIT(5)
> +#define PWR_SRAM_ISOINT_B_BIT          BIT(6)
>
>  #define PWR_STATUS_CONN                        BIT(1)
>  #define PWR_STATUS_DISP                        BIT(3)
> @@ -115,6 +117,8 @@ enum clk_id {
>   * @name: The domain name.
>   * @sta_mask: The mask for power on/off status bit.
>   * @ctl_offs: The offset for main power control register.
> + * @sram_iso_ctrl: The flag to judge if the power domain need to do
> + *                 the extra sram isolation control.
>   * @sram_pdn_bits: The mask for sram power control bits.
>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>   * @bus_prot_mask: The mask for single step bus protection.
> @@ -130,6 +134,7 @@ struct scp_domain_data {
>         const char *name;
>         u32 sta_mask;
>         int ctl_offs;
> +       bool sram_iso_ctrl;
>         u32 sram_pdn_bits;
>         u32 sram_pdn_ack_bits;
>         u32 bus_prot_mask;
> @@ -269,6 +274,14 @@ static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
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
> @@ -278,8 +291,16 @@ static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
>         u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>         int tmp;
>
> -       val = readl(ctl_addr);
> -       val |= scpd->data->sram_pdn_bits;
> +       if (scpd->data->sram_iso_ctrl)  {
> +               val = readl(ctl_addr);
> +               val |= PWR_SRAM_CLKISO_BIT;

You do this in 1 line above. I don't really care, but be consistent?
e.g. val = readl(ctl_addr) | PWR_SRAM_CLKISO_BIT;

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
