Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEC3C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA26E20659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575410934;
	bh=6PSVahxJVhz0cExddxVYD59tVZAiFyByptvoAe29BE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1SstSUkCZm4Gw7tGQUNFR95XgDTmz+EqVHTlW8pUiw8hjE91XzbuUQ9GMr5zq//Pm
	 w9WK6K0KBwYuAq0VI7VQKs3iRfetFfbJtGj+4n6WGRuYsjJ6Tn+CSIyMktf/JuI/Aw
	 wAs+9OMXkXZ0mKBx6JH3fZxR6ZdtVDMozc7aTKmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfLCWIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:08:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39509 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfLCWIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:08:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so4440789oty.6;
        Tue, 03 Dec 2019 14:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sZSEyNMhlnvTODh/Dzk1OL0mgOPADvbuG7TDe97dXpg=;
        b=lF5FQi3KJf4YdyrXVxNHu09mQWjg2/hAebLN9+2rE+IeO3XN1KJoR9gyC3j6aIFT3P
         ZhrJvqAy9iYwjzBK6OT+EfyDGJuFwmWJxGV+A/u9BW6xtbzYN2fv+5ObFB/7KlxwaJ3o
         4Bc4A3miLEvo/o+61AP6EN1nz16RS2sYW6o7n7hTj6sOLWNPEyw7Mqu4EXLYC93VmKIo
         flcyeTw1nHcbsyu7AJtvkFoddVtHd+FlkBNUcreXeQvSGdH4cqhVUiKdEGGpmxgvjcBZ
         TpJhpmgPGKPsV/D5iyFcIsndI9ww8GE5pm2HicoVXrCjVDthXdRv7CChkFnzv/6srwzy
         G8LQ==
X-Gm-Message-State: APjAAAX3ldQxxGszWP1kw6n5GDtFsuluOW2wBFU2NGx/ME1bM1CO90tD
        OEEeFWXtg6jXnY8mj50dSw==
X-Google-Smtp-Source: APXvYqz+spF9crZkJb7aFq4Od/HWX5LxZsgAanqY1RB5HuHt0Q6YDaWEARPcPrgcEjgE+1jA3LKq4A==
X-Received: by 2002:a05:6830:4a7:: with SMTP id l7mr78129otd.372.1575410932229;
        Tue, 03 Dec 2019 14:08:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v24sm1483990ote.38.2019.12.03.14.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 14:08:51 -0800 (PST)
Date:   Tue, 3 Dec 2019 16:08:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
        allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/17] dt-bindings: soc: tegra-pmc: Add Tegra PMC
 clock ids
Message-ID: <20191203220850.GB22716@bogus>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574146234-3871-4-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:50:20PM -0800, Sowjanya Komatineni wrote:
> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 clocks and each of
> these clocks has mux and a gate as a part of PMC controller.
> 
> This patch adds ids for each of these PMC clock mux and gates to
> use with the devicetree.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  include/dt-bindings/soc/tegra-pmc.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 include/dt-bindings/soc/tegra-pmc.h

This should be part of the binding patch.

> 
> diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/soc/tegra-pmc.h
> new file mode 100644
> index 000000000000..fa1ccfc2514b
> --- /dev/null
> +++ b/include/dt-bindings/soc/tegra-pmc.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2019-2020, NVIDIA CORPORATION.  All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_SOC_TEGRA_PMC_H
> +#define _DT_BINDINGS_SOC_TEGRA_PMC_H
> +
> +#define TEGRA_PMC_CLK_OUT_1_MUX		0
> +#define TEGRA_PMC_CLK_OUT_1		1
> +#define TEGRA_PMC_CLK_OUT_2_MUX		2
> +#define TEGRA_PMC_CLK_OUT_2		3
> +#define TEGRA_PMC_CLK_OUT_3_MUX		4
> +#define TEGRA_PMC_CLK_OUT_3		5
> +
> +#endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
> -- 
> 2.7.4
> 
