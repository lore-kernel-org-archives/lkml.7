Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FBC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67B520717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NdwBkCpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLPHWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 02:22:09 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38713 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfLPHWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 02:22:09 -0500
Received: by mail-qv1-f66.google.com with SMTP id t6so1908314qvs.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 23:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLwYMou2QNNU+Bbtah+RA9oMWQD3BzPPJMlbiXBB1/I=;
        b=NdwBkCpbFJPMTNXk1ad0cpoBUAQZkJQHe3BmSg/COwJPa4xK4FCqULVmhzW+w0p9QV
         WfA/rygfsNE9cJTi/rTiHAYH1q7LZBaiqM4NOW+fQnEh1X69F9UITrKFWqL1qvBRxMsO
         7H5ksoQkI9T9j2yk7ASRdZGIp+SDj+Kyj9kSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLwYMou2QNNU+Bbtah+RA9oMWQD3BzPPJMlbiXBB1/I=;
        b=MG95GG3Zo5gbvmZ0SV0RaKfLGyd6EECE0Bh7/ELVvYITPQ/EJgkYd8DRBpCN8oEBPe
         6FMpb+O796ue+y1VuFHW6B0iARHc4oxQw6HI/YfIUJR0xO2ApOVoNBHJv9guFyDiTFIf
         eVn3vMRuEbcXtulAwHgdilrPalHlMFidolCWG/918IK36Wq7pKhYXaZPK+j93DULD5wz
         HhjELzXXj1f23j87KggBxfDfOTcNhcVoS22b9tM8ZUWRZqglfoVu69UrXg18X96kW94Q
         apJWxMUqneVflLduPbWquBIxPZwIJpzX74emLryvlYLmdBIwe1L+ZiATWrsV2AIEh9W9
         NlDw==
X-Gm-Message-State: APjAAAVXGdE21AbKG/VBHkFQfmvjNT/HpVlZx+vN92R2E+graDDRMf7Y
        xbghWngCwTv+GjVfNv0oujhLgPuJ36A/wRmxJZcrzA==
X-Google-Smtp-Source: APXvYqzFEIcrFrTNSr7HVqHHexEeQiAhr3dYzHFBq8Zo3RyDvXHnBPRwSaHHZt0irz/WjMERV0dX2mrxOBMgRWyFvzA=
X-Received: by 2002:a0c:f703:: with SMTP id w3mr25457091qvn.6.1576480928001;
 Sun, 15 Dec 2019 23:22:08 -0800 (PST)
MIME-Version: 1.0
References: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com> <1575960413-6900-5-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1575960413-6900-5-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 16 Dec 2019 15:21:57 +0800
Message-ID: <CANMq1KA4KL=ZpU=cQtw3LV79DKRdG3Eb16og6vU1SdsnnL=0CA@mail.gmail.com>
Subject: Re: [PATCH v9 4/9] soc: mediatek: Add multiple step bus protection control
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
> Both MT8183 & MT6765 have more control steps of bus protection
> than previous project. And there add more bus protection registers
> reside at infracfg & smi-common. Also add new APIs for multiple
> step bus protection control with more customized arguments.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/Makefile           |  2 +-
>  drivers/soc/mediatek/mtk-scpsys-ext.c   | 99 +++++++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-scpsys.c       | 39 +++++++++----
>  include/linux/soc/mediatek/scpsys-ext.h | 39 +++++++++++++
>  4 files changed, 168 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
>  create mode 100644 include/linux/soc/mediatek/scpsys-ext.h
>
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index b017330..b442be9 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> -obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
> new file mode 100644
> index 0000000..4f1adda
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <Owen.Chen@mediatek.com>
> + */
> +#include <linux/ktime.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/soc/mediatek/scpsys-ext.h>
> +
> +#define MTK_POLL_DELAY_US   10
> +#define MTK_POLL_TIMEOUT    USEC_PER_SEC
> +
> +static int set_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
> +               u32 reg_set, u32 reg_sta, u32 reg_en)
> +{
> +       u32 val;
> +
> +       if (reg_set)
> +               regmap_write(map, reg_set, mask);
> +       else
> +               regmap_update_bits(map, reg_en, mask, mask);

At least for 8183, we never seen to use the reg_set case, can we
simplify this function?

> +
> +       return regmap_read_poll_timeout(map, reg_sta,
> +                       val, (val & ack_mask) == ack_mask,
> +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);

From 8183, I see that you have either:
 1. mask == ack_mask
 2. ack_mask == 0 (essentially this skips this test)

Would it be simpler to just skip this test if reg_sta == 0, and always
assume mask == ack_mask otherwise?

e.g.
if (reg_sta == 0)
   return 0;

return regmap_read_poll_timeout(map, reg_sta,
                       val, (val & mask) == mask,
                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);

> +}
> +
> [snip]
> +
> +int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
> +       struct regmap *infracfg, struct regmap *smi_common)
> +{
> +       int i;
> +
> +       for (i = 0; i < MAX_STEPS; i++) {
> +               struct regmap *map = NULL;
> +               int ret;
> +
> +               if (bp_table[i].type == INVALID_TYPE)
> +                       continue;

break? (but yes the one below in mtk_scpsys_ext_clear_bus_protection
has to be continue).

> +               else if (bp_table[i].type == IFR_TYPE)
> +                       map = infracfg;
> +               else if (bp_table[i].type == SMI_TYPE)
> +                       map = smi_common;
> +
> +               ret = set_bus_protection(map,
> +                               bp_table[i].mask, bp_table[i].mask,
> +                               bp_table[i].set_ofs, bp_table[i].sta_ofs,
> +                               bp_table[i].en_ofs);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
> +       struct regmap *infracfg, struct regmap *smi_common)
> +{
> +       int i;
> +
> +       for (i = MAX_STEPS - 1; i >= 0; i--) {
> +               struct regmap *map = NULL;
> +               int ret;
> +
> +               if (bp_table[i].type == INVALID_TYPE)
> +                       continue;
> +               else if (bp_table[i].type == IFR_TYPE)
> +                       map = infracfg;
> +               else if (bp_table[i].type == SMI_TYPE)
> +                       map = smi_common;
> +
> +               ret = clear_bus_protection(map,
> +                               bp_table[i].mask, bp_table[i].clr_ack_mask,
> +                               bp_table[i].clr_ofs, bp_table[i].sta_ofs,
> +                               bp_table[i].en_ofs);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 915d635..466bb749 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -12,6 +12,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/soc/mediatek/infracfg.h>
> +#include <linux/soc/mediatek/scpsys-ext.h>
>
>  #include <dt-bindings/power/mt2701-power.h>
>  #include <dt-bindings/power/mt2712-power.h>
> @@ -120,6 +121,7 @@ enum clk_id {
>   * @basic_clk_id: provide the same purpose with field "clk_id"
>   *                by declaring basic clock prefix name rather than clk_id.
>   * @caps: The flag for active wake-up action.
> + * @bp_table: The mask table for multiple step bus protection.
>   */
>  struct scp_domain_data {
>         const char *name;
> @@ -131,6 +133,7 @@ struct scp_domain_data {
>         enum clk_id clk_id[MAX_CLKS];
>         const char *basic_clk_id[MAX_CLKS];
>         u8 caps;
> +       struct bus_prot bp_table[MAX_STEPS];

As with the previous patch, I'm not a big fan of having 2 approaches
for something similar (bus_prot_mask vs bp_table), can we define a
simple macro for this?
e.g.:
.bp_table = BUS_PROT_SINGLE(mask)
