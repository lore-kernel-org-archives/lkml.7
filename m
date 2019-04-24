Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71262C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317C2218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfDXIrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:47:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52384 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbfDXIre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:47:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CDD7D1EBDC12C0F9947D;
        Wed, 24 Apr 2019 16:47:32 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 16:47:29 +0800
Subject: Re: [PATCH] soc: imx: Fix build error without CONFIG_SOC_BUS
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
References: <20190424075946.23124-1-yuehaibing@huawei.com>
 <AM0PR04MB6434F319FA56FE9A1AC0572FEE3C0@AM0PR04MB6434.eurprd04.prod.outlook.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <2f2b461f-2ad3-c81e-0826-ed7819de5518@huawei.com>
Date:   Wed, 24 Apr 2019 16:47:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB6434F319FA56FE9A1AC0572FEE3C0@AM0PR04MB6434.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/24 16:11, Leonard Crestez wrote:
> On 4/24/2019 11:00 AM, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> During randconfig builds, I occasionally run into an invalid configuration
>>
>> drivers/soc/imx/soc-imx8.o: In function `imx8_soc_init':
>> soc-imx8.c:(.init.text+0x144): undefined reference to `soc_device_register'
>>
>> while CONFIG_SOC_BUS is not set, the building failed like this. This patch
>> selects SOC_BUS to fix it.
>>
>> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
>> @@ -5,6 +5,7 @@ config IMX_GPCV2_PM_DOMAINS
>>   	depends on ARCH_MXC || (COMPILE_TEST && OF)
>>   	depends on PM
>>   	select PM_GENERIC_DOMAINS
>> +	select SOC_BUS
>>   	default y if SOC_IMX7D
> 
> You should "select SOC_BUS" from "config ARCH_MXC" in arm64 
> Kconfig.platforms, not from a power domain implementation.
> 
> Your patch works because arm64 ARCH_MXC currently does "select 
> IMX_GPCV2_PM_DOMAINS" but it's silly to use this intermediary.

Yes, you are right, thanks!

> 
> --
> Regards,
> Leonard
> 
> 

