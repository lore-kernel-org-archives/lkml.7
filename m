Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3559CC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6133217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="EnKY2EUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfDYH66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:58:58 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52302 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbfDYH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:58:58 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P7kUsv028244;
        Thu, 25 Apr 2019 09:58:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=IvsHaaSIMlxl18/hQm1gg52lY0Z93obL0eK66HuX8Tk=;
 b=EnKY2EUp/xh/t5Xc2qWEbEfPcn6/iLL9+qjctaDNkIpmOM3CNfYL0H/44hwg6m/vT5Fe
 6ueMtCeDGCqAtvXKt9RwW/MfuMUaYeJ+iQ3IVqCWL2+yJhftpJU1K2P0wU0fontTWoma
 1cXmNdmKqBtb0AhVn4/nW1a9SPU7whpV34E4EGzOXFZW/KZdpWiuv6ZflUJuiJbDTcDg
 /vwG58OcL22W+B2qXLWCNeCQDIw1j9CpRC7l7223RPh41w5mPuhGb8Q32YR2HyWNUOcx
 OO2zzlKLgEK+akUgwjjw9A2Zg/e4zqX4Fm/AcJ7Js97c1b6ksJWcF+MNokMZw1wNL48H oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxj7jp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 09:58:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CF07D31;
        Thu, 25 Apr 2019 07:58:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5032114A2;
        Thu, 25 Apr 2019 07:58:28 +0000 (GMT)
Received: from [10.201.23.29] (10.75.127.44) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 25 Apr
 2019 09:58:27 +0200
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: manage the get_irq error case
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1556117346-5608-1-git-send-email-fabien.dessenne@st.com>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <1812f1d3-da71-4c62-d289-e08d742c2932@st.com>
Date:   Thu, 25 Apr 2019 09:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556117346-5608-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/19 4:49 PM, Fabien Dessenne wrote:
> During probe, check the "get_irq" error value.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Acked-by: Christophe Kerello <christophe.kerello@st.com>

> ---
>   drivers/mtd/nand/raw/stm32_fmc2_nand.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index 999ca6a..4aabea2 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -1909,6 +1909,12 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>   	}
>   
>   	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(dev, "IRQ error missing or invalid\n");
> +		return irq;
> +	}
> +
>   	ret = devm_request_irq(dev, irq, stm32_fmc2_irq, 0,
>   			       dev_name(dev), fmc2);
>   	if (ret) {
> 
