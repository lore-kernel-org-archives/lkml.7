Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26749C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC4F2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ox7ixcP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfDXJsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:48:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9372 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726274AbfDXJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:48:19 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O9hjCd003172;
        Wed, 24 Apr 2019 11:48:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=3+3Yo1fAoPpKDIIXEhQxba/BGRXMf3UPLyV6NgXqTag=;
 b=ox7ixcP7S/CETT3szdR/P5tn2by6I0EEdb6QolNiBHRYMrz+O/ofbn3dYZmwhZBAzYsf
 VrXuf8RkiWvmOdDf5YvGKF3pkUyrac3ole8vYmtUV7Hkls2jR/J/rFkUB2pa0f0gfg+m
 smIVZ4BmZ04MOIdHOvCSbMTew/ZHAixkFgNQZlLMG9E1yIdk9icr7xAu2XxB2J+77Cdf
 mLSxjIlheB6LRjHaAiE0R91/PTAyY3ZA2TjBeR/bqmZcz1Eql4rWoRkzAHClVTY99yDV
 krp1+xHdTRDRbPd4XL9KX+fmINUX5STkeDUzy0zWEZysZEpLJQfcBL24abc2glJ8ojZ6 WQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxcptq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 11:48:09 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B5D03F;
        Wed, 24 Apr 2019 09:48:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E19915D4;
        Wed, 24 Apr 2019 09:48:07 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Apr
 2019 11:48:06 +0200
Subject: Re: [PATCH] net: ethernet: stmmac: manage the get_irq probe defer
 case
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Roullier <christophe.roullier@st.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1556098549-18385-1-git-send-email-fabien.dessenne@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f35582e5-35cd-e5d1-9f53-7e7efa7a08b6@st.com>
Date:   Wed, 24 Apr 2019 11:48:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556098549-18385-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 4/24/19 11:35 AM, Fabien Dessenne wrote:
> Manage the -EPROBE_DEFER error case for "stm32_pwr_wakeup"  IRQ.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index 062a600f..2142853 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -333,6 +333,9 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
>   	 */
>   	dwmac->irq_pwr_wakeup = platform_get_irq_byname(pdev,
>   							"stm32_pwr_wakeup");
> +	if (dwmac->irq_pwr_wakeup == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
>   	if (!dwmac->clk_eth_ck && dwmac->irq_pwr_wakeup >= 0) {
>   		err = device_init_wakeup(&pdev->dev, true);
>   		if (err) {
> 

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
