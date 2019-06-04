Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5032CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C3A24BA5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="esUE5NN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfFDMlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:41:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15574 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfFDMlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:41:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf666e60000>; Tue, 04 Jun 2019 05:41:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 05:41:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Jun 2019 05:41:23 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 12:41:22 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 5CB9740609; Tue,  4 Jun 2019 15:41:20 +0300 (EEST)
Date:   Tue, 4 Jun 2019 15:41:20 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH V2 06/12] clk: tegra: add suspend resume support for DFLL
 clock
Message-ID: <20190604124120.GD29894@pdeschrijver-desktop.Nvidia.com>
References: <1559084936-4610-1-git-send-email-skomatineni@nvidia.com>
 <1559084936-4610-7-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1559084936-4610-7-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559652070; bh=eYlU/EiszkB9G/gXKiyqydlxvhzbz9Z6m/D0NdsuBOk=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=esUE5NN/po/BVVuGgXZj6/xY8iQFNYfEOb8bOaIfgqDg7+xR5PSCikiNVn22FYDuE
         p1+7DJQUheTr5EkYYqL2NyeXrCyncRGRZhXe1jGDl63d7hFLjGWFxVtpmsQzFDk4PE
         yWr2NmC3oSdqPZOkJqOTaD1+vv02ASYmqOOnLs6cgfBJBoEm+BabGSTnrv2BrXmACP
         XrJ++f/Kp7mLLxVDO/gz1QOFscuSUJo/H2zgiPpCO/vNF3h3VDWSUVmODpmgwShoV9
         i0G/wo0avsjzadfiIXVRNB6admgk7KcyKPj53CWF7oZxukhfPjsrIGWaIsWgb22gZo
         hEU26H/y00CRg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 04:08:50PM -0700, Sowjanya Komatineni wrote:
> This patch adds support for suspend and resume for DFLL clock.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-dfll.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/tegra/clk-dfll.h |  2 ++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index 1fc71baae13b..d92a5a05fbbc 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -286,6 +286,7 @@ struct tegra_dfll {
>  	unsigned long			dvco_rate_min;
>  
>  	enum dfll_ctrl_mode		mode;
> +	enum dfll_ctrl_mode		resume_mode;
>  	enum dfll_tune_range		tune_range;
>  	struct dentry			*debugfs_dir;
>  	struct clk_hw			dfll_clk_hw;
> @@ -1873,6 +1874,87 @@ static int dfll_fetch_common_params(struct tegra_dfll *td)
>  }
>  
>  /*
> + * tegra_dfll_suspend
> + * @pdev: DFLL instance
> + *
> + * dfll controls clock/voltage to other devices, including CPU. Therefore,
> + * dfll driver pm suspend callback does not stop cl-dvfs operations. It is
> + * only used to enforce cold voltage limit, since SoC may cool down during
> + * suspend without waking up. The correct temperature zone after suspend will
> + * be updated via dfll cooling device interface during resume of temperature
> + * sensor.

Temperature dependent cl-dvfs is not yet implemented in upstream, so
leave out the part about cold voltage limits and temperature zones.

Peter.
