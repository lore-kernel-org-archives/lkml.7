Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9E4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B22621773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="CCWLpbwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfDXPgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:36:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35336 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731197AbfDXPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:36:10 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OFVHvu011482;
        Wed, 24 Apr 2019 17:35:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=o5690a6N7UlqqweMDZW/2I4CJGOdIFlBW+/7u7Dqs3A=;
 b=CCWLpbwhEQ9AwmbuT6HCU0SMFnUDYgapBXohYThusKHYkfnfPGMh+9sgqhQwFpz4Rufz
 jieh79mF2ikEZ9tYb8CaLJ+RpbqrbOsp3FbKy5qaP/DimEVWjXld+28lKvuWscv/tOzR
 0qOroWLGCIygmJkzgxsdoUwLrubLsJw8/gqFL3AV5ElHNqRYm8+xPBSGNsdEGx90mZZT
 F39XFo8qi3G2YBckrfFuZEkwPYNSQZrtPJOkSK7pMArfUtrBDikV5JaLVkMXZZSxd+NR
 NXqRTOybzVVly03R/lCq09VdUvSrHJr5ssfjd98HddkQ54NtyASs51dbTEKkYjiShX3I Ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad7faf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 17:35:57 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 38A5F31;
        Wed, 24 Apr 2019 15:35:55 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A2F02948;
        Wed, 24 Apr 2019 15:35:55 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.44) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Apr
 2019 17:35:54 +0200
Subject: Re: [PATCH] spi: stm32-qspi: manage the get_irq error case
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1556119140-3319-1-git-send-email-fabien.dessenne@st.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <a8f7a11e-5aa9-8d91-ac57-641fec2ca899@st.com>
Date:   Wed, 24 Apr 2019 17:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556119140-3319-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/19 5:19 PM, Fabien Dessenne wrote:
> During probe, check the "get_irq" error value.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Acked-by: Ludovic Barre <ludovic.barre@st.com>

> ---
>   drivers/spi/spi-stm32-qspi.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index 11a89aa..42f8e3c 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -574,6 +574,12 @@ static int stm32_qspi_probe(struct platform_device *pdev)
>   	}
>   
>   	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(dev, "IRQ error missing or invalid\n");
> +		return irq;
> +	}
> +
>   	ret = devm_request_irq(dev, irq, stm32_qspi_irq, 0,
>   			       dev_name(dev), qspi);
>   	if (ret) {
> 
