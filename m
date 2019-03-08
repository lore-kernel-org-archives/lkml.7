Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9645FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D49120811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJTlAohP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCHGRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:17:25 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44539 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCHGRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:17:24 -0500
Received: by mail-qt1-f196.google.com with SMTP id d2so20072448qti.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 22:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tfklw04YElPKo/ltOTPzY7ncocSoVunPe04Hgo3Zxw0=;
        b=TJTlAohPw0rak7Vp8souKZsJ105+gE3OfszpT5uuT8qS9NuQlmdALaF9sXFihncH0R
         k/JJ37y6wg71SGg/mK1FNRmiM3N1rO1bSEcnPMJbaNtg+cbOHjvemD55vVq348u/vft7
         SH9lY36g4JEtQmkvToJSkqFL20A7bVnRWmG4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tfklw04YElPKo/ltOTPzY7ncocSoVunPe04Hgo3Zxw0=;
        b=CjCbiR8dVSBOHmyC3RqS1MoPPXBcav/MkyM3AgVo9mdGdANqVGA6ac5axC/Uwa87mc
         aNpYmqo5mFmq4ZnjescWRG65n2s/K/TKcp54NwosV5WRCNoN7gS2f9wznZxD5NpCgRYr
         SBUyt1D4uDtrGkhZEB6K45/4bg21pLaYVIYCcW+Q77ytua2wUCfjFKPF02oT49VuQdoY
         /fKyrWXqdhTkM0i8bdAxpglQSjsN5uQkIk4iUvbZkWaNTHRrxBN4VUoocc88U9LGj5Cf
         UGQz0Awx4WgK1wr7uWRoJ2wYy+anPkTeEl5h/iaqmvfu3Rb0h34KVctnUyfnYilBRgGU
         +yOA==
X-Gm-Message-State: APjAAAWvvHNOA8Z8+c1sfb0DO5PPYkQg5WD11UXPLtAqNae/Glk/Choh
        KDP1sGCOgBBgZrqpZ+17KD/lfjh25jqMW0RPzLNH9g==
X-Google-Smtp-Source: APXvYqxsaWTdK5X+EYC+A/qv1iRuz8LyPzqsYrX5liWkUuVQE/7SIr8kaK/N8243AyqYpygD7OEH+4nFR//1pagSvlY=
X-Received: by 2002:aed:253a:: with SMTP id v55mr13764944qtc.339.1552025842753;
 Thu, 07 Mar 2019 22:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-4-weiyi.lu@mediatek.com>
In-Reply-To: <20190305050546.23431-4-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 8 Mar 2019 14:17:11 +0800
Message-ID: <CANMq1KB-Uybvf0Su4KFBOB45s4V8F58R71YMFwZzXUyNwwha_w@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] clk: mediatek: Add new clkmux register API
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        stable@vger.kernel.org, Owen Chen <owen.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 1:06 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> From: Owen Chen <owen.chen@mediatek.com>
>
> On both MT8183 & MT6765, there add "set/clr" register for
> each clkmux setting, and one update register to trigger value change.
> It is designed to prevent read-modify-write racing issue.
> The sw design need to add a new API to handle this hw change with
> a new mtk_clk_mux/mtk_mux struct in new file "clk-mux.c", "clk-mux.h".
>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Reviewed-and-tested-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/clk/mediatek/Makefile  |   3 +-
>  drivers/clk/mediatek/clk-mux.c | 223 +++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-mux.h |  89 +++++++++++++
>  3 files changed, 314 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mux.c
>  create mode 100644 drivers/clk/mediatek/clk-mux.h
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index ee4410ff43ab..20cf9eea4171 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o
> +obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
> +
>  obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
>  obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
>  obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> new file mode 100644
> index 000000000000..877a883fa616
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <owen.chen@mediatek.com>
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-mux.h"
> +
> +static inline struct mtk_clk_mux *to_mtk_clk_mux(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct mtk_clk_mux, hw);
> +}
> +
> +static int mtk_clk_mux_enable(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 mask = BIT(mux->data->gate_shift);
> +
> +       return regmap_update_bits(mux->regmap, mux->data->mux_ofs,
> +                       mask, ~mask);
> +}
> +
> +static void mtk_clk_mux_disable(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 mask = BIT(mux->data->gate_shift);
> +
> +       regmap_update_bits(mux->regmap, mux->data->mux_ofs, mask, mask);
> +}
> +
> +static int mtk_clk_mux_enable_setclr(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +
> +       return regmap_write(mux->regmap, mux->data->clr_ofs,
> +                       BIT(mux->data->gate_shift));
> +}
> +
> +static void mtk_clk_mux_disable_setclr(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +
> +       regmap_write(mux->regmap, mux->data->set_ofs,
> +                       BIT(mux->data->gate_shift));
> +}
> +
> +static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 val;
> +
> +       regmap_read(mux->regmap, mux->data->mux_ofs, &val);
> +
> +       return (val & BIT(mux->data->gate_shift)) == 0;
> +}
> +
> +static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 mask = GENMASK(mux->data->mux_width - 1, 0);
> +       u32 val;
> +
> +       regmap_read(mux->regmap, mux->data->mux_ofs, &val);
> +       val = (val >> mux->data->mux_shift) & mask;
> +
> +       return val;
> +}
> +
> +static int mtk_clk_mux_set_parent_lock(struct clk_hw *hw, u8 index)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 mask = GENMASK(mux->data->mux_width - 1, 0);
> +       unsigned long flags;
> +
> +       if (mux->lock)
> +               spin_lock_irqsave(mux->lock, flags);
> +       else
> +               __acquire(mux->lock);
> +
> +       regmap_update_bits(mux->regmap, mux->data->mux_ofs, mask,
> +               index << mux->data->mux_shift);
> +
> +       if (mux->lock)
> +               spin_unlock_irqrestore(mux->lock, flags);
> +       else
> +               __release(mux->lock);
> +
> +       return 0;
> +}
> +
> +static int mtk_clk_mux_set_parent_setclr_lock(struct clk_hw *hw, u8 index)
> +{
> +       struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
> +       u32 mask = GENMASK(mux->data->mux_width - 1, 0);
> +       u32 val, orig;
> +       unsigned long flags;
> +
> +       if (mux->lock)
> +               spin_lock_irqsave(mux->lock, flags);
> +       else
> +               __acquire(mux->lock);
> +
> +       regmap_read(mux->regmap, mux->data->mux_ofs, &orig);
> +       val = (orig & ~(mask << mux->data->mux_shift))
> +                       | (index << mux->data->mux_shift);
> +
> +       if (val != orig) {
> +               regmap_write(mux->regmap, mux->data->clr_ofs,
> +                               mask << mux->data->mux_shift);
> +               regmap_write(mux->regmap, mux->data->set_ofs,
> +                               index << mux->data->mux_shift);
> +
> +               if (mux->data->upd_shift >= 0)
> +                       regmap_write(mux->regmap, mux->data->upd_ofs,
> +                                       BIT(mux->data->upd_shift));
> +       }
> +
> +       if (mux->lock)
> +               spin_unlock_irqrestore(mux->lock, flags);
> +       else
> +               __release(mux->lock);
> +
> +       return 0;
> +}
> +
> +const struct clk_ops mtk_mux_ops = {
> +       .get_parent = mtk_clk_mux_get_parent,
> +       .set_parent = mtk_clk_mux_set_parent_lock,
> +};
> +
> +const struct clk_ops mtk_mux_clr_set_upd_ops = {
> +       .get_parent = mtk_clk_mux_get_parent,
> +       .set_parent = mtk_clk_mux_set_parent_setclr_lock,
> +};
> +
> +const struct clk_ops mtk_mux_gate_ops = {
> +       .enable = mtk_clk_mux_enable,
> +       .disable = mtk_clk_mux_disable,
> +       .is_enabled = mtk_clk_mux_is_enabled,
> +       .get_parent = mtk_clk_mux_get_parent,
> +       .set_parent = mtk_clk_mux_set_parent_lock,
> +};
> +
> +const struct clk_ops mtk_mux_gate_clr_set_upd_ops = {
> +       .enable = mtk_clk_mux_enable_setclr,
> +       .disable = mtk_clk_mux_disable_setclr,
> +       .is_enabled = mtk_clk_mux_is_enabled,
> +       .get_parent = mtk_clk_mux_get_parent,
> +       .set_parent = mtk_clk_mux_set_parent_setclr_lock,
> +};
> +
> +struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
> +                                struct regmap *regmap,
> +                                spinlock_t *lock)
> +{
> +       struct mtk_clk_mux *clk_mux;
> +       struct clk_init_data init;
> +       struct clk *clk;
> +
> +       clk_mux = kzalloc(sizeof(*clk_mux), GFP_KERNEL);
> +       if (!clk_mux)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = mux->name;
> +       init.flags = mux->flags | CLK_SET_RATE_PARENT;
> +       init.parent_names = mux->parent_names;
> +       init.num_parents = mux->num_parents;
> +       init.ops = mux->ops;
> +
> +       clk_mux->regmap = regmap;
> +       clk_mux->data = mux;
> +       clk_mux->lock = lock;
> +       clk_mux->hw.init = &init;
> +
> +       clk = clk_register(NULL, &clk_mux->hw);
> +       if (IS_ERR(clk)) {
> +               kfree(clk_mux);
> +               return clk;
> +       }
> +
> +       return clk;
> +}
> +
> +int mtk_clk_register_muxes(const struct mtk_mux *muxes,
> +                          int num, struct device_node *node,
> +                          spinlock_t *lock,
> +                          struct clk_onecell_data *clk_data)
> +{
> +       struct regmap *regmap;
> +       struct clk *clk;
> +       int i;
> +
> +       regmap = syscon_node_to_regmap(node);
> +       if (IS_ERR(regmap)) {
> +               pr_err("Cannot find regmap for %pOF: %ld\n", node,
> +                      PTR_ERR(regmap));
> +               return PTR_ERR(regmap);
> +       }
> +
> +       for (i = 0; i < num; i++) {
> +               const struct mtk_mux *mux = &muxes[i];
> +
> +               if (IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
> +                       clk = mtk_clk_register_mux(mux, regmap, lock);
> +
> +                       if (IS_ERR(clk)) {
> +                               pr_err("Failed to register clk %s: %ld\n",
> +                                      mux->name, PTR_ERR(clk));
> +                               continue;
> +                       }
> +
> +                       clk_data->clks[mux->id] = clk;
> +               }
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> new file mode 100644
> index 000000000000..f5625f4d9e6c
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mux.h
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <owen.chen@mediatek.com>
> + */
> +
> +#ifndef __DRV_CLK_MTK_MUX_H
> +#define __DRV_CLK_MTK_MUX_H
> +
> +#include <linux/clk-provider.h>
> +
> +struct mtk_clk_mux {
> +       struct clk_hw hw;
> +       struct regmap *regmap;
> +       const struct mtk_mux *data;
> +       spinlock_t *lock;
> +};
> +
> +struct mtk_mux {
> +       int id;
> +       const char *name;
> +       const char * const *parent_names;
> +       unsigned int flags;
> +
> +       u32 mux_ofs;
> +       u32 set_ofs;
> +       u32 clr_ofs;
> +       u32 upd_ofs;
> +
> +       u8 mux_shift;
> +       u8 mux_width;
> +       u8 gate_shift;
> +       s8 upd_shift;
> +
> +       const struct clk_ops *ops;
> +
> +       signed char num_parents;
> +};
> +
> +extern const struct clk_ops mtk_mux_ops;
> +extern const struct clk_ops mtk_mux_clr_set_upd_ops;
> +extern const struct clk_ops mtk_mux_gate_ops;
> +extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
> +
> +#define GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,         \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       _gate, _upd_ofs, _upd, _flags, _ops) {          \
> +               .id = _id,                                              \
> +               .name = _name,                                          \
> +               .mux_ofs = _mux_ofs,                                    \
> +               .set_ofs = _mux_set_ofs,                                \
> +               .clr_ofs = _mux_clr_ofs,                                \
> +               .upd_ofs = _upd_ofs,                                    \
> +               .mux_shift = _shift,                                    \
> +               .mux_width = _width,                                    \
> +               .gate_shift = _gate,                                    \
> +               .upd_shift = _upd,                                      \
> +               .parent_names = _parents,                               \
> +               .num_parents = ARRAY_SIZE(_parents),                    \
> +               .flags = _flags,                                        \
> +               .ops = &_ops,                                           \
> +       }
> +
> +#define MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,     \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       _gate, _upd_ofs, _upd, _flags)                  \
> +               GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,  \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       _gate, _upd_ofs, _upd, _flags,                  \
> +                       mtk_mux_gate_clr_set_upd_ops)
> +
> +#define MUX_GATE_CLR_SET_UPD(_id, _name, _parents, _mux_ofs,           \
> +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +                       _gate, _upd_ofs, _upd)                          \
> +               MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents,        \
> +                       _mux_ofs, _mux_set_ofs, _mux_clr_ofs, _shift,   \
> +                       _width, _gate, _upd_ofs, _upd,                  \
> +                       CLK_SET_RATE_PARENT)
> +
> +struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
> +                                struct regmap *regmap,
> +                                spinlock_t *lock);
> +
> +int mtk_clk_register_muxes(const struct mtk_mux *muxes,
> +                          int num, struct device_node *node,
> +                          spinlock_t *lock,
> +                          struct clk_onecell_data *clk_data);
> +
> +#endif /* __DRV_CLK_MTK_MUX_H */
> --
> 2.18.0
>
