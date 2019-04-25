Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00287C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4860C206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556219281;
	bh=n1XacDQSZkIHcOl4KDxvF+mtyxMvHgv1v1cEjOLiHlk=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=UpyKKnQtXPKtpOGuLVp5HzfAayMy9lTe17smvGyC2tLHZd3IT6LSw01DsJGCVGYGk
	 MmlfHSrLMn0U2sWCG7b/KVZum2vK+hcFX9sUvBXal3/wJtgR32QQtXdNJLgjXikBg8
	 mKCZ8usHB+YJw4lm61KUfWk5LYnLqJu9S4x8AWY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfDYTH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfDYTH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:07:59 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A09D206A3;
        Thu, 25 Apr 2019 19:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556219278;
        bh=n1XacDQSZkIHcOl4KDxvF+mtyxMvHgv1v1cEjOLiHlk=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=D1+W4uaX0FJhWFWv2rfanhVDPGKf2C0GU8/Sl8TfwpNf0Ugl+nUJroarUCCLhpSFU
         Xn58i2HZjegdu9q8j645ardBebJjLxeK7vSiHWfQIngISl614pRSmECpOJx1m1M9Za
         bA+f2diCytBz1JXdg3unFCpmYITogw/czyi4xKfo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190414202009.31268-2-digetx@gmail.com>
References: <20190414202009.31268-1-digetx@gmail.com> <20190414202009.31268-2-digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/4] clk: tegra20/30: Add custom EMC clock implementation
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Message-ID: <155621927685.15276.16453873579880842057@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 12:07:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-14 13:20:06)
> diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-=
tegra20-emc.c
> new file mode 100644
> index 000000000000..35b67a9989c8
> --- /dev/null
> +++ b/drivers/clk/tegra/clk-tegra20-emc.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bits.h>
> +#include <linux/clk/tegra.h>

Include clk-provider.h as this is a clk provider driver.

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +#define CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK     GENMASK(7, 0)
> +#define CLK_SOURCE_EMC_2X_CLK_SRC_MASK         GENMASK(31, 30)
[...]
> +
> +static const struct clk_ops tegra_clk_emc_ops =3D {
> +       .recalc_rate =3D emc_recalc_rate,
> +       .get_parent =3D emc_get_parent,
> +       .set_parent =3D emc_set_parent,
> +       .set_rate =3D emc_set_rate,
> +       .set_rate_and_parent =3D emc_set_rate_and_parent,
> +       .determine_rate =3D emc_determine_rate,
> +};
> +
> +void tegra20_clk_set_emc_round_callback(void *round_cb, void *arg_cb)

Why can't we have type safety on these function pointers?

> +{
> +       struct clk *clk =3D __clk_lookup("emc");
> +       struct tegra_clk_emc *emc;
> +       struct clk_hw *hw;
> +
> +       if (clk) {
> +               hw =3D __clk_get_hw(clk);
> +               emc =3D to_tegra_clk_emc(hw);
> +
> +               emc->round_cb =3D round_cb;
> +               emc->arg_cb =3D arg_cb;
> +       }
> +}
> +
> +bool tegra20_clk_emc_driver_available(void)
> +{
> +       struct clk *clk =3D __clk_lookup("emc");

Can we avoid using __clk_lookup()? Maybe by having the clk_hw pointer in
this driver somehow?

> +       struct tegra_clk_emc *emc;
> +       struct clk_hw *hw;
> +
> +       if (clk) {
> +               hw =3D __clk_get_hw(clk);

This gets further to the point, we don't prefer to see drivers use
__clk_get_hw() unless they absolutely need to. Maybe I don't understand
the driver structure, but it seems like maybe the driver that's
providing the callbacks could be the same driver that's registering
these clks, and thus everything could be inside one file so that we
don't have to pass around callbacks and clk_hw pointers? Commit text
says "this is how it's been" but that's not a reason to keep doing it.

> +               emc =3D to_tegra_clk_emc(hw);
> +
