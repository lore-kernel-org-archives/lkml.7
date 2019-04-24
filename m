Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0DCC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAA6218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kPXPWp25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfDXMzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:55:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43448 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729032AbfDXMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:55:42 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OCpv9C009383;
        Wed, 24 Apr 2019 14:55:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=dOnUJ8y4kZt0z4pcCjl7ndBW0lumY8hiF8KW8Mdlx6Y=;
 b=kPXPWp258yiEPV9ouU2l8i+0UDG8ZrqyJGsu2E8ht5JDyulonWwMLpY05P7Ew5sYihoA
 oF0XIpQxRoxlnmeLTAyiDpGcJUGlmZf+Uhgx8T3vptxWD1h129DhVM1LNf5pxiuml35+
 2Ne84nPn78BA4yw1kBbn9Ri/ePL3uokgc77Zci8NavveNiXgjzG5fiT790gFrjD03LXk
 Z/MnIz7/mHiY8Xc5rSYMdLzjhC2y5CWlAuInOAiodlxCSTgC6dD8/9d3qSmBqBkx46tJ
 9R5TY1b9em76/tvkf49nPS1U0j/WeDockSG4AOuLlACD9dmHmrqiM5df6b+nloKnDlPj 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxdk04-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 14:55:12 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0A9AA3D;
        Wed, 24 Apr 2019 12:55:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB6A611B5;
        Wed, 24 Apr 2019 12:55:10 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.51) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Apr
 2019 14:55:10 +0200
Subject: Re: [PATCH 1/2] iio: adc: stm32-dfsdm: manage the get_irq error case
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
 <1556110286-1526-2-git-send-email-fabien.dessenne@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b53b8078-e5ef-1b38-771f-3e34d387c790@st.com>
Date:   Wed, 24 Apr 2019 14:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556110286-1526-2-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 2:51 PM, Fabien Dessenne wrote:
> During probe, check the "get_irq" error value.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---

Hi Fabien,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice

>  drivers/iio/adc/stm32-dfsdm-adc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 19adc2b..588907c 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1456,6 +1456,12 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  	 * So IRQ associated to filter instance 0 is dedicated to the Filter 0.
>  	 */
>  	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get IRQ: %d\n", irq);
> +		return irq;
> +	}
> +
>  	ret = devm_request_irq(dev, irq, stm32_dfsdm_irq,
>  			       0, pdev->name, adc);
>  	if (ret < 0) {
> 
