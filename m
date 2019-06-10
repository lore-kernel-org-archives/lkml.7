Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0135EC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84D7208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TnsY2gy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbfFJVBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:01:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43490 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389549AbfFJVBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:01:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so5395889qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UqCgGQyZZlSxx5SgJW9SrUIoWnGDiskvMNV5Y6IzA5U=;
        b=TnsY2gy2t8T6oJR2NI5rn0xrKFn8c83sE2FbHV4Ff7/yiofHRTC4PlxeqE0xkSP30Y
         2dKRFGZifb57Ttg0K8kBpbpKl39O0xbA0jBuspRFuDN3YI3iPfQWVmdJH5nn9snV3lra
         qKkENSOtOoT86TybIPkSWlcNvkyLD1dtG3oz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UqCgGQyZZlSxx5SgJW9SrUIoWnGDiskvMNV5Y6IzA5U=;
        b=QO91g4K6LEnMc1Pt5CmRI5U+/h0DTK2vUSyzOTlhoFbNWQ99iYk7DXGNoPLjXnwq/8
         ORzZH9xcbUjJRvfVa9OhF6IA7vZXVSz9cunZfUwgu/LQfK6zRPMNvf2T7EHCi9OsT0QC
         kgkBagmeaYJ/6XYlaWqoPwsVa2C6Mw+u4E32Qlxwnmkk7rQj4twIiU4cDXacTnkmJI9j
         3pIOWUoQDkxORiXBOY0eKADMAXidKl30N47i9XPiW8XjJUArhO29NuqE+SWSrFOmaSGK
         abjBwLi9/4T+Hh+4VtGBosB5UCx/IMywxWd1y3lqS0lUpHrmsAebsCy29ZBilRIRW0m0
         DVhw==
X-Gm-Message-State: APjAAAXjOGj1LnwzysnXU3+1vYpQjYKEkuACGwX16mZ6lDpFhGTJK/Rt
        s4dcD90R2bhwYSImT9Lir/0kKtwcAJSET324vZE83w==
X-Google-Smtp-Source: APXvYqw48s3xmxnU0Sti89BGxqH6rlI/mLADpu1pFANnjJcaFHMMf7NvGi7oEGbnHPNOpkV5DH+MmrBr4pLVvqZiDBg=
X-Received: by 2002:ac8:1a1c:: with SMTP id v28mr58301398qtj.270.1560200468411;
 Mon, 10 Jun 2019 14:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com> <1556614265-12745-7-git-send-email-henryc.chen@mediatek.com>
In-Reply-To: <1556614265-12745-7-git-send-email-henryc.chen@mediatek.com>
From:   Ryan Case <ryandcase@chromium.org>
Date:   Mon, 10 Jun 2019 14:00:57 -0700
Message-ID: <CACjz--=OPx06-pLdoKv_h+y=4nSW0O7zrHM5=hPqTBvMAfmpWA@mail.gmail.com>
Subject: Re: [RFC V2 06/11] soc: mediatek: add MT8183 dvfsrc support
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henry,

On Tue, Apr 30, 2019 at 2:45 AM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> Add dvfsrc driver for MT8183
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig      |  15 ++
>  drivers/soc/mediatek/Makefile     |   1 +
>  drivers/soc/mediatek/mtk-dvfsrc.c | 347 ++++++++++++++++++++++++++++++++++++++
>  include/soc/mediatek/mtk_dvfsrc.h |  22 +++
>  4 files changed, 385 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
>  create mode 100644 include/soc/mediatek/mtk_dvfsrc.h
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 17bd759..2721fd6 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -24,6 +24,21 @@ config MTK_INFRACFG
>           INFRACFG controller contains various infrastructure registers not
>           directly associated to any device.
>
> +config MTK_DVFSRC
> +       bool "MediaTek DVFSRC Support"
> +       depends on ARCH_MEDIATEK
> +       default ARCH_MEDIATEK
> +       select MTK_INFRACFG
> +       select PM_GENERIC_DOMAINS if PM
> +       depends on MTK_SCPSYS
> +       help
> +         Say yes here to add support for the MediaTek DVFSRC (dynamic voltage
> +         and frequency scaling resource collector) found
> +         on different MediaTek SoCs. The DVFSRC is a proprietary
> +         hardware which is used to collect all the requests from
> +         system and turn into the decision of minimum Vcore voltage
> +         and minimum DRAM frequency to fulfill those requests.
> +
>  config MTK_PMIC_WRAP
>         tristate "MediaTek PMIC Wrapper Support"
>         depends on RESET_CONTROLLER
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index b9dbad6..cd9d63f 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> +obj-$(CONFIG_MTK_DVFSRC) += mtk-dvfsrc.o
>  obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
> new file mode 100644
> index 0000000..e54a654
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-dvfsrc.c
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 MediaTek Inc.
> + */
> +#include <linux/arm-smccc.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <soc/mediatek/mtk_dvfsrc.h>
> +#include <soc/mediatek/mtk_sip.h>
> +#include <dt-bindings/power/mt8183-power.h>
> +#include <dt-bindings/soc/mtk,dvfsrc.h>
> +#include <dt-bindings/soc/mtk,dvfsrc.h>
> +#include "mtk-scpsys.h"
> +
> +#define DVFSRC_IDLE            0x00
> +#define DVFSRC_GET_TARGET_LEVEL(x)     (((x) >> 0) & 0x0000ffff)
> +#define DVFSRC_GET_CURRENT_LEVEL(x)    (((x) >> 16) & 0x0000ffff)
> +
> +#define MT8183_DVFSRC_OPP_LP4  0
> +#define MT8183_DVFSRC_OPP_LP4X 1
> +#define MT8183_DVFSRC_OPP_LP3  2
> +
> +struct dvfsrc_opp {
> +       u32 vcore_opp;
> +       u32 dram_opp;
> +};
> +
> +struct dvfsrc_domain {
> +       u32 id;
> +       u32 state;
> +};
> +
> +struct mtk_dvfsrc;
> +struct dvfsrc_soc_data {
> +       const int *regs;
> +       u32 num_opp;
> +       u32 num_domains;
> +       const struct dvfsrc_opp **opps;
> +       struct dvfsrc_domain *domains;
> +       int (*get_target_level)(struct mtk_dvfsrc *dvfsrc);
> +       int (*get_current_level)(struct mtk_dvfsrc *dvfsrc);
> +       void (*set_dram_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
> +       void (*set_opp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
> +};
> +
> +struct mtk_dvfsrc {
> +       struct device *dev;
> +       struct clk *clk_dvfsrc;
> +       const struct dvfsrc_soc_data *dvd;
> +       int dram_type;
> +       void __iomem *regs;
> +       struct mutex lock;
> +       struct notifier_block scpsys_notifier;
> +};
> +
> +static u32 dvfsrc_read(struct mtk_dvfsrc *dvfs, u32 offset)
> +{
> +       return readl(dvfs->regs + dvfs->dvd->regs[offset]);
> +}
> +
> +static void dvfsrc_write(struct mtk_dvfsrc *dvfs, u32 offset, u32 val)
> +{
> +       writel(val, dvfs->regs + dvfs->dvd->regs[offset]);
> +}
> +
> +enum dvfsrc_regs {
> +       DVFSRC_SW_REQ,
> +       DVFSRC_LEVEL,
> +       DVFSRC_SW_BW_0,
> +       DVFSRC_LAST,
> +};
> +
> +static const int mt8183_regs[] = {
> +       [DVFSRC_SW_REQ] =       0x4,
> +       [DVFSRC_LEVEL] =        0xDC,
> +       [DVFSRC_SW_BW_0] =      0x160,
> +       [DVFSRC_LAST] =         0x308,
> +};
> +
> +static bool dvfsrc_is_idle(struct mtk_dvfsrc *dvfsrc)
> +{
> +       if (!dvfsrc->dvd->get_target_level)
> +               return true;
> +
> +       return dvfsrc->dvd->get_target_level(dvfsrc) == DVFSRC_IDLE;
> +}
> +
> +static int dvfsrc_wait_for_idle(struct mtk_dvfsrc *dvfsrc)
> +{
> +       unsigned long timeout;
> +
> +       timeout = jiffies + usecs_to_jiffies(1000);
> +
> +       do {
> +               if (dvfsrc_is_idle(dvfsrc))
> +                       return 0;
> +       } while (!time_after(jiffies, timeout));

This all seems like it would be better handled by readx_poll_timeout
rather than rolling your own.

> +
> +       return -ETIMEDOUT;
> +}
> +
> +static int mt8183_get_target_level(struct mtk_dvfsrc *dvfsrc)
> +{
> +       return DVFSRC_GET_TARGET_LEVEL(dvfsrc_read(dvfsrc, DVFSRC_LEVEL));
> +}
> +
> +static int mt8183_get_current_level(struct mtk_dvfsrc *dvfsrc)
> +{
> +       return ffs(DVFSRC_GET_CURRENT_LEVEL(dvfsrc_read(dvfsrc, DVFSRC_LEVEL)));
> +}
> +
> +static void mt8183_set_dram_bw(struct mtk_dvfsrc *dvfsrc, u64 bw)
> +{
> +       dvfsrc_write(dvfsrc, DVFSRC_SW_BW_0, bw);
> +}
> +
> +static void mt8183_set_opp_level(struct mtk_dvfsrc *dvfsrc, u32 level)
> +{
> +       int vcore_opp, dram_opp;
> +       const struct dvfsrc_opp *opp;
> +
> +       /* translate pstate to dvfsrc level, and set it to DVFSRC HW */
> +       opp = &dvfsrc->dvd->opps[dvfsrc->dram_type][level - 1];
> +       vcore_opp = opp->vcore_opp;
> +       dram_opp = opp->dram_opp;
> +
> +       dev_dbg(dvfsrc->dev, "vcore_opp: %d, dram_opp: %d\n",
> +               vcore_opp, dram_opp);
> +       dvfsrc_write(dvfsrc, DVFSRC_SW_REQ, dram_opp | vcore_opp << 2);
> +}
> +
> +void mtk_dvfsrc_send_request(const struct device *dev, u32 cmd, u64 data)
> +{
> +       struct mtk_dvfsrc *dvfsrc = dev_get_drvdata(dev);
> +
> +       dev_dbg(dvfsrc->dev, "cmd: %d, data: %llu\n", cmd, data);
> +
> +       mutex_lock(&dvfsrc->lock);
> +
> +       if (dvfsrc_wait_for_idle(dvfsrc)) {
> +               dev_warn(dvfsrc->dev, "[%s] wait idle, last: %d -> %d\n",
> +                        __func__, dvfsrc_read(dvfsrc, DVFSRC_LEVEL),
> +               dvfsrc_read(dvfsrc, DVFSRC_LAST));
> +               goto out;
> +       }
> +
> +       switch (cmd) {
> +       case MTK_DVFSRC_CMD_BW_REQUEST:
> +               dvfsrc->dvd->set_dram_bw(dvfsrc, data);
> +               goto out;
> +       case MTK_DVFSRC_CMD_OPP_REQUEST:
> +               dvfsrc->dvd->set_opp_level(dvfsrc, data);
> +               break;
> +       default:
> +               dev_err(dvfsrc->dev, "unknown command: %d\n", cmd);
> +               break;
> +       }
> +
> +       if (dvfsrc_wait_for_idle(dvfsrc)) {
> +               dev_warn(dvfsrc->dev, "[%s] wait idle, last: %d -> %d\n",
> +                        __func__, dvfsrc_read(dvfsrc, DVFSRC_LEVEL),
> +                        dvfsrc_read(dvfsrc, DVFSRC_LAST));
> +               goto out;
> +       }
> +
> +out:
> +       mutex_unlock(&dvfsrc->lock);
> +}
> +EXPORT_SYMBOL(mtk_dvfsrc_send_request);
> +
> +static int dvfsrc_set_performance(struct notifier_block *b,
> +                                 unsigned long l, void *v)
> +{
> +       int i, val, highest;

Variable names could be improved. "val" is only ever used to store the
current level, would be nice to make the name more specific. Similarly
"l" looks like it would be better as something state related.

val and highest at least should be u32.

> +       struct mtk_dvfsrc *dvfsrc;
> +       struct scp_event_data *sc = v;
> +       struct dvfsrc_domain *d;
> +
> +       if (sc->event_type != MTK_SCPSYS_PSTATE)
> +               return 0;
> +
> +       dvfsrc = container_of(b, struct mtk_dvfsrc, scpsys_notifier);
> +
> +       d = dvfsrc->dvd->domains;
> +
> +       if (l > dvfsrc->dvd->num_opp) {
> +               dev_err(dvfsrc->dev, "pstate out of range = %ld\n", l);
> +               goto out;

Can just return 0;

> +       }
> +
> +       for (i = 0, highest = 0; i < dvfsrc->dvd->num_domains - 1; i++, d++) {

It's not immediately clear to me why a domain is skipped (the -1).
This is either worth a comment or it may be a bug?

> +               if (sc->domain_id == d->id)
> +                       d->state = l;
> +               if (d->state > highest)
> +                       highest = d->state;
> +       }
> +
> +       if (highest == 0) {
> +               dev_err(dvfsrc->dev, "domain not match\n");

This text is incorrect. You're checking whether all domains had a
state of zero, not whether you found a domain match. Is this check
actually needed?

> +               goto out;

return 0;

> +       }
> +
> +       mtk_dvfsrc_send_request(dvfsrc->dev, MTK_DVFSRC_CMD_OPP_REQUEST,
> +                               highest);
> +
> +       val = dvfsrc->dvd->get_current_level(dvfsrc);
> +
> +       dev_dbg(dvfsrc->dev, "DVFSRC_LEVEL: %x, val: %x, DVFSRC_SW_REQ: %x\n",
> +               dvfsrc_read(dvfsrc, DVFSRC_LEVEL), val,
> +               dvfsrc_read(dvfsrc, DVFSRC_SW_REQ));

"val:" to "current level:" or something similarly descriptive.

> +
> +       if (val < highest) {
> +               dev_err(dvfsrc->dev, "current: %d < highest: %x\n",
> +                       val, highest);

This message isn't clear and should be more explicit. Something like
"Current level %d < highest requested %d"

> +               goto out;

return 0;

> +       }
> +
> +out:

Out label no longer needed.

> +       return 0;
> +}
> +
> +static void pstate_notifier_register(struct mtk_dvfsrc *dvfsrc)
> +{
> +       dvfsrc->scpsys_notifier.notifier_call = dvfsrc_set_performance;
> +       register_scpsys_notifier(&dvfsrc->scpsys_notifier);
> +}
> +
> +static int mtk_dvfsrc_probe(struct platform_device *pdev)
> +{
> +       struct arm_smccc_res ares;
> +       struct resource *res;
> +       struct mtk_dvfsrc *dvfsrc;
> +       int ret;
> +
> +       dvfsrc = devm_kzalloc(&pdev->dev, sizeof(*dvfsrc), GFP_KERNEL);
> +       if (!dvfsrc)
> +               return -ENOMEM;
> +
> +       dvfsrc->dvd = of_device_get_match_data(&pdev->dev);
> +       dvfsrc->dev = &pdev->dev;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       dvfsrc->regs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(dvfsrc->regs))
> +               return PTR_ERR(dvfsrc->regs);
> +
> +       dvfsrc->clk_dvfsrc = devm_clk_get(dvfsrc->dev, "dvfsrc");
> +       if (IS_ERR(dvfsrc->clk_dvfsrc)) {
> +               dev_err(dvfsrc->dev, "failed to get clock: %ld\n",
> +                       PTR_ERR(dvfsrc->clk_dvfsrc));
> +               return PTR_ERR(dvfsrc->clk_dvfsrc);
> +       }
> +
> +       ret = clk_prepare_enable(dvfsrc->clk_dvfsrc);
> +       if (ret)
> +               return ret;
> +
> +       mutex_init(&dvfsrc->lock);
> +
> +       arm_smccc_smc(MTK_SIP_SPM, MTK_SIP_SPM_DVFSRC_INIT, 0, 0, 0, 0, 0, 0,
> +                     &ares);
> +
> +       if (!ares.a0) {
> +               dvfsrc->dram_type = ares.a1;
> +       } else {
> +               dev_err(dvfsrc->dev, "init fails: %lu\n", ares.a0);
> +               clk_disable_unprepare(dvfsrc->clk_dvfsrc);
> +               return ares.a0;
> +       }
> +
> +       platform_set_drvdata(pdev, dvfsrc);
> +       pstate_notifier_register(dvfsrc);
> +
> +       return devm_of_platform_populate(&pdev->dev);
> +}
> +
> +static const struct dvfsrc_opp dvfsrc_opp_mt8183_lp4[] = {
> +       {0, 0}, {0, 1}, {0, 2}, {1, 2},
> +};
> +
> +static const struct dvfsrc_opp dvfsrc_opp_mt8183_lp3[] = {
> +       {0, 0}, {0, 1}, {1, 1}, {1, 2},
> +};
> +
> +static const struct dvfsrc_opp *dvfsrc_opp_mt8183[] = {
> +       [MT8183_DVFSRC_OPP_LP4] = dvfsrc_opp_mt8183_lp4,
> +       [MT8183_DVFSRC_OPP_LP4X] = dvfsrc_opp_mt8183_lp3,
> +       [MT8183_DVFSRC_OPP_LP3] = dvfsrc_opp_mt8183_lp3,
> +};
> +
> +static struct dvfsrc_domain dvfsrc_domains_mt8183[] = {
> +       { MT8183_POWER_DOMAIN_MFG_ASYNC, 0 },
> +       { MT8183_POWER_DOMAIN_MFG, 0 },
> +       { MT8183_POWER_DOMAIN_CAM, 0 },
> +       { MT8183_POWER_DOMAIN_DISP, 0 },
> +       { MT8183_POWER_DOMAIN_ISP, 0 },
> +       { MT8183_POWER_DOMAIN_VDEC, 0 },
> +       { MT8183_POWER_DOMAIN_VENC, 0 },
> +};
> +
> +static const struct dvfsrc_soc_data mt8183_data = {
> +       .opps = dvfsrc_opp_mt8183,
> +       .num_opp = ARRAY_SIZE(dvfsrc_opp_mt8183_lp4),
> +       .regs = mt8183_regs,
> +       .domains = dvfsrc_domains_mt8183,
> +       .num_domains = ARRAY_SIZE(dvfsrc_domains_mt8183),
> +       .get_target_level = mt8183_get_target_level,
> +       .get_current_level = mt8183_get_current_level,
> +       .set_dram_bw = mt8183_set_dram_bw,
> +       .set_opp_level = mt8183_set_opp_level,
> +};
> +
> +static int mtk_dvfsrc_remove(struct platform_device *pdev)
> +{
> +       struct mtk_dvfsrc *dvfsrc = platform_get_drvdata(pdev);
> +
> +       clk_disable_unprepare(dvfsrc->clk_dvfsrc);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mtk_dvfsrc_of_match[] = {
> +       {
> +               .compatible = "mediatek,mt8183-dvfsrc",
> +               .data = &mt8183_data,
> +       }, {
> +               /* sentinel */
> +       },
> +};
> +
> +static struct platform_driver mtk_dvfsrc_driver = {
> +       .probe  = mtk_dvfsrc_probe,
> +       .remove = mtk_dvfsrc_remove,
> +       .driver = {
> +               .name = "mtk-dvfsrc",
> +               .of_match_table = of_match_ptr(mtk_dvfsrc_of_match),
> +       },
> +};
> +
> +builtin_platform_driver(mtk_dvfsrc_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MTK DVFSRC driver");
> diff --git a/include/soc/mediatek/mtk_dvfsrc.h b/include/soc/mediatek/mtk_dvfsrc.h
> new file mode 100644
> index 0000000..e759a65
> --- /dev/null
> +++ b/include/soc/mediatek/mtk_dvfsrc.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + */
> +#ifndef __SOC_MTK_DVFSRC_H
> +#define __SOC_MTK_DVFSRC_H
> +
> +#define MTK_DVFSRC_CMD_BW_REQUEST      0
> +#define MTK_DVFSRC_CMD_OPP_REQUEST     1
> +
> +#if IS_ENABLED(CONFIG_MTK_DVFSRC)
> +void mtk_dvfsrc_send_request(const struct device *dev, u32 cmd, u64 data);
> +
> +#else
> +
> +static inline void mtk_dvfsrc_send_request(const struct device *dev, u32 cmd,
> +                                          u64 data)
> +{ return -ENODEV; }
> +
> +#endif /* CONFIG_MTK_DVFSRC */
> +
> +#endif
> --
> 1.9.1
>
