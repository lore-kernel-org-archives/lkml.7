Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36339ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0935B2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TppyX6Z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbfJOO75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:59:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50074 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbfJOO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:59:57 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9FEvRei023441;
        Tue, 15 Oct 2019 16:59:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ZetKudQ2sfe6J5BtXSBRemg7eHjvahDr8UoMKz5mnns=;
 b=TppyX6Z+3StUwAPJ7jfWlDH85TwzGIkl+GtKiFshem6T1VptXvNyLd1m24M3yeXt+wcZ
 EY0XhsgrM0h7Ta02AdRTi7Kqc164eCZTuP6XdJNecyXTxFdjPtHHSAxV6h8nczf6y3DW
 vBQzfSAFId6x0p50srti3GzTrQZrIHaDEoqyVEryAZAc+DiO1IlCGFdwtuXsk7fh/wX8
 OJ96p962gcRTqSmxnGYDBojowakjwRTK2BbMQv9ZA1wkNKjwv0mxXBspcyIpMBIFzEfn
 3HrReYFQx6nBN3qMo9fSe9EPrvO7QWQ3OMF6pebitPjnK2rzHQoD5T9KR0KYk8tlI9rA 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vk5qj8vx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 16:59:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E77B100034;
        Tue, 15 Oct 2019 16:59:33 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9B5782CD079;
        Tue, 15 Oct 2019 16:59:33 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 15 Oct
 2019 16:59:33 +0200
Subject: Re: [Linux-stm32] [PATCH] phy: stm32: fix use of integer as pointer
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        <linux-kernel@lists.codethink.co.uk>
CC:     <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191015135148.28508-1-ben.dooks@codethink.co.uk>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <fc837347-c2da-5550-0027-99bd3328e83f@st.com>
Date:   Tue, 15 Oct 2019 16:59:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015135148.28508-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_05:2019-10-15,2019-10-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 3:51 PM, Ben Dooks wrote:
> The calls devm_clk_get() and devm_reset_control_get()
> take pointers so change the 0 to NULl to fix the
> following sparse warnings:
> 
> drivers/phy/st/phy-stm32-usbphyc.c:330:42: warning: Using plain integer as NULL pointer
> drivers/phy/st/phy-stm32-usbphyc.c:343:52: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>

> ---
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/phy/st/phy-stm32-usbphyc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
> index 56bdea4b0bd9..2b3639cba51a 100644
> --- a/drivers/phy/st/phy-stm32-usbphyc.c
> +++ b/drivers/phy/st/phy-stm32-usbphyc.c
> @@ -327,7 +327,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
>   	if (IS_ERR(usbphyc->base))
>   		return PTR_ERR(usbphyc->base);
>   
> -	usbphyc->clk = devm_clk_get(dev, 0);
> +	usbphyc->clk = devm_clk_get(dev, NULL);
>   	if (IS_ERR(usbphyc->clk)) {
>   		ret = PTR_ERR(usbphyc->clk);
>   		dev_err(dev, "clk get failed: %d\n", ret);
> @@ -340,7 +340,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	usbphyc->rst = devm_reset_control_get(dev, 0);
> +	usbphyc->rst = devm_reset_control_get(dev, NULL);
>   	if (!IS_ERR(usbphyc->rst)) {
>   		reset_control_assert(usbphyc->rst);
>   		udelay(2);
> 
