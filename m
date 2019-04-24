Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8982BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D23218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="o462nhkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfDXMz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:55:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1356 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727518AbfDXMz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:55:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OCpuFo009380;
        Wed, 24 Apr 2019 14:55:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=zol7OW64xrjcKVIMxusswaeJEktyZ1QS682qLDhJgi0=;
 b=o462nhkcj6jkUZFSEqHNOHExTnKK+wEn0haXzg9+4B4ASOpMUNOLzb4sTBLI+u7o/fLw
 NWEQeCcK9a0qKu+1N/K11GK0gRErceo+Gw3wFNeGDYyH309Nao+/YaK1eZklgbZkeYyS
 0vf7s4YuMq+YeDQVKAFmZWcpX5hVEe24BNkP+4OoXdbW/Izig+LZq0iKXAd4cW8vNbw6
 PIdjOjzdY4/0wABiss//ekJ7ia16t/CSYUt3d/ZpD5hgcufaoH3iWeeTZw1K+OSSKRWp
 2bZrorifbk/1PK13vfhoG1v2Ek/J9qeaLm8v88g9ko9xs5TalajX0W5bRofaupUd8kRy Hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxdk1m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 14:55:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E75531;
        Wed, 24 Apr 2019 12:55:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E9AC2473;
        Wed, 24 Apr 2019 12:55:29 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.51) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Apr
 2019 14:55:28 +0200
Subject: Re: [PATCH 2/2] iio: adc: stm32-dfsdm: missing error case during
 probe
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1556110286-1526-1-git-send-email-fabien.dessenne@st.com>
 <1556110286-1526-3-git-send-email-fabien.dessenne@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b46f9525-53c0-d874-c88f-c6e351736b04@st.com>
Date:   Wed, 24 Apr 2019 14:55:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556110286-1526-3-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 2:51 PM, Fabien Dessenne wrote:
> During probe, check the devm_ioremap_resource() error value.
> Also return the devm_clk_get() error value instead of -EINVAL.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---


Hi Fabien,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice

>  drivers/iio/adc/stm32-dfsdm-core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 0a4d374..26e2011 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -233,6 +233,8 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>  	}
>  	priv->dfsdm.phys_base = res->start;
>  	priv->dfsdm.base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->dfsdm.base))
> +		return PTR_ERR(priv->dfsdm.base);
>  
>  	/*
>  	 * "dfsdm" clock is mandatory for DFSDM peripheral clocking.
> @@ -242,8 +244,10 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>  	 */
>  	priv->clk = devm_clk_get(&pdev->dev, "dfsdm");
>  	if (IS_ERR(priv->clk)) {
> -		dev_err(&pdev->dev, "No stm32_dfsdm_clk clock found\n");
> -		return -EINVAL;
> +		ret = PTR_ERR(priv->clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get clock (%d)\n", ret);
> +		return ret;
>  	}
>  
>  	priv->aclk = devm_clk_get(&pdev->dev, "audio");
> 
