Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C99FC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006E220705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GZuc0rwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAHFe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:34:58 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15278 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgAHFe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:34:57 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1569ef0000>; Tue, 07 Jan 2020 21:34:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 21:34:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 21:34:56 -0800
Received: from [10.24.44.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 05:34:50 +0000
Subject: Re: [PATCH v7 15/21] ASoC: tegra: Add fallback implementation for
 audio mclk
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <josephl@nvidia.com>, <daniel.lezcano@linaro.org>,
        <mmaddireddy@nvidia.com>, <markz@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-16-git-send-email-skomatineni@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <f3f550a2-c6e0-7a78-5c83-da3e54dab309@nvidia.com>
Date:   Wed, 8 Jan 2020 11:04:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1578457515-3477-16-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578461679; bh=ooJxGk1Mj4xaggKc+sBCL1z4jOUVJa4U4iUSojVi5Pc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=GZuc0rwo2hc8I1wHVYCC44JBPoD1pyB+PuI2wWCn5ErgMpXDuZctfA22ZZmFmDzXJ
         H6jaH0bnOh5sPy2XvJkLRF8xr7kmn9CPhxBgKBYoIXl9Bw3un8hYQtMmdQ9RFGViX1
         0epv7NMFAcF//b8SY6CfgZh7PQe7Ttihomu7WYr7I9e1+q+A5FMCdOsvA3qmKys58u
         FdTrNm7FrryoDjlf1CL8HGr6w1u8JOjf1+Sc91ZAwQRFZFU/43xDdpgolxgDMYj/Gr
         15AvZvhiUciGg4rT/rFJtw7jer4DOM5IaNjP8Ke9vo7UmO5+3IMEFud65EVi/z7s2N
         Zk5bRaxCnBEnA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/8/2020 9:55 AM, Sowjanya Komatineni wrote:
> mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
> are moved to Tegra PMC driver with pmc as clock provider and using pmc
> clock ids.
>
> New device tree uses clk_out_1 from pmc clock provider.
>
> So, this patch adds implementation for mclk fallback to extern1 when
> retrieving mclk returns -ENOENT to be backward compatible of new device
> tree with older kernels.
>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>   sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
> index 9cfebef74870..9a5f81039491 100644
> --- a/sound/soc/tegra/tegra_asoc_utils.c
> +++ b/sound/soc/tegra/tegra_asoc_utils.c
> @@ -183,7 +183,16 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>   	data->clk_cdev1 = devm_clk_get(dev, "mclk");
>   	if (IS_ERR(data->clk_cdev1)) {
>   		dev_err(data->dev, "Can't retrieve clk cdev1\n");

This error print can be moved inside below if, when this actually meant 
to be an error condition.

> -		return PTR_ERR(data->clk_cdev1);
> +		if (PTR_ERR(data->clk_cdev1) != -ENOENT)
> +			return PTR_ERR(data->clk_cdev1);
> +		/* Fall back to extern1 */
> +		data->clk_cdev1 = devm_clk_get(dev, "extern1");
> +		if (IS_ERR(data->clk_cdev1)) {
> +			dev_err(data->dev, "Can't retrieve clk extern1\n");
> +			return PTR_ERR(data->clk_cdev1);
> +		}
> +
> +		dev_err(data->dev, "Falling back to extern1\n");

This can be a info print?

>   	}
>   
>   	/*
