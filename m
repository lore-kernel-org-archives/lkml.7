Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6AAC2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BF424676
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cBmImDjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFRt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:49:57 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7881 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfLFRt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:49:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dea94be0000>; Fri, 06 Dec 2019 09:49:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 06 Dec 2019 09:49:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 06 Dec 2019 09:49:55 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 17:49:55 +0000
Received: from [10.2.168.155] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec 2019
 17:49:53 +0000
Subject: Re: [PATCH v3 09/15] ASoC: tegra: Add fallback for audio mclk
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <tglx@linutronix.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexios.zavras@intel.com>, <alsa-devel@alsa-project.org>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <e94e56bc-2b4c-5d95-002a-073c9272537d@nvidia.com>
Date:   Fri, 6 Dec 2019 09:49:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575654591; bh=YAKMdzUBMPWAB8WxEd9kdEtmiQZK+fcXFtpn3WK3zFI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=cBmImDjj+dyCqtopez7WVPM/iJlu/l28OHqHjZChjD+Mp3OVTNm+RP4BLaBZxlohg
         jFLvRr6hs8CbAP4rCu9sBsol/cIJ+dbyjva75W8ULSHpS/Rvjq5GzesL+Mkyv4naYx
         kyfjyPy/qUh3C0V+QFgUfjGznstU32zWVzd63IucFk7Ur1IT6eBYp9mDP9u4hw8KP8
         VZ3xpAjo5jE+VbRZYIm7dbXZ0Dd74f3QkSWOl74lw+OfiDrxBRHjVctdtn1Ci5s/pk
         nJbKMH+1enbKMJpfYA9EsGB4KExgGuhOBCDBDNSX/4wJsj7F46XH41pBmMyIuTOlUm
         fcDubePTSjzBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Greg.

Sorry, Will send this patch separately (out of this series) with stable 
tag to get this applied to stable kernels once review is done for this 
series.

On 12/5/19 6:48 PM, Sowjanya Komatineni wrote:
> mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
> are moved to Tegra PMC driver with pmc as clock provider and using pmc
> clock ids.
>
> New device tree uses clk_out_1 from pmc clock provider.
>
> So, this patch adds fallback to extern1 in case of retrieving mclk fails
> to be backward compatible of new device tree with older kernels.
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>   sound/soc/tegra/tegra_asoc_utils.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
> index 8e3a3740df7c..f7408d5240c0 100644
> --- a/sound/soc/tegra/tegra_asoc_utils.c
> +++ b/sound/soc/tegra/tegra_asoc_utils.c
> @@ -211,8 +211,14 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>   	data->clk_cdev1 = clk_get(dev, "mclk");
>   	if (IS_ERR(data->clk_cdev1)) {
>   		dev_err(data->dev, "Can't retrieve clk cdev1\n");
> -		ret = PTR_ERR(data->clk_cdev1);
> -		goto err_put_pll_a_out0;
> +		data->clk_cdev1 = clk_get_sys("clk_out_1", "extern1");
> +		if (IS_ERR(data->clk_cdev1)) {
> +			dev_err(data->dev, "Can't retrieve clk extern1\n");
> +			ret = PTR_ERR(data->clk_cdev1);
> +			goto err_put_pll_a_out0;
> +		}
> +
> +		dev_err(data->dev, "Falling back to extern1\n");
>   	}
>   
>   	/*
