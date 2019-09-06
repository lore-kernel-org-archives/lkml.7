Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91023C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672C020693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RAnuLOvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391903AbfIFKab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:30:31 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18796 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389180AbfIFKab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:30:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d7235470000>; Fri, 06 Sep 2019 03:30:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 06 Sep 2019 03:30:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 06 Sep 2019 03:30:30 -0700
Received: from [10.24.193.88] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Sep
 2019 10:30:21 +0000
Subject: Re: [Patch V8 7/8] usb: gadget: Add UDC driver for tegra XUSB device
 mode controller
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1567585440-13751-1-git-send-email-nkristam@nvidia.com>
 <1567585440-13751-8-git-send-email-nkristam@nvidia.com>
 <1567593053.7317.64.camel@mhfsdcap03>
 <36447248-1ddb-ff1d-a731-de6afb445a9d@nvidia.com>
 <1567734192.7317.68.camel@mhfsdcap03>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <7f24dbd0-e556-20c1-7aeb-5ddbdbe0349c@nvidia.com>
Date:   Fri, 6 Sep 2019 16:01:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567734192.7317.68.camel@mhfsdcap03>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567765831; bh=GDwZRdU/ebDm6QGvl1AQvTRJ+y6qnAjAmrni9fQPdbk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RAnuLOvDRvT807o+zmhO3KzFV4brOuwDo83FN/pGnxgMqFNUS7zi+TRtGt70xks1w
         IgidSlmXvdDXw3ti8ktszIa+5BZe7baY3kAEERvowCas/sBR43DEh9NmptYLYx7jTg
         1F1qE8qr4o6BZHV91AJ1cAlZT7RKAszgIp1RLp3n7qcPg/58jAQBqbsfpKeTxMgIrS
         Hj4ttHhLpUkFEJH3wqpcNIKyP56rIn6B/kDGv6iqjKTIb8G4muUw13hX29pixpofYb
         mSbruqdDb+FRHotj9gHDT3868DoG5nMGENI0NnNugy8exg4IBcqCgW6W2uZ7iFYb2I
         gF0bP8fj0mGAQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06-09-2019 07:13, Chunfeng Yun wrote:
> On Thu, 2019-09-05 at 09:57 +0530, Nagarjuna Kristam wrote:
>>
>> On 04-09-2019 16:00, Chunfeng Yun wrote:
>>> On Wed, 2019-09-04 at 13:53 +0530, Nagarjuna Kristam wrote:
>>>> This patch adds UDC driver for tegra XUSB 3.0 device mode controller.
>>>> XUSB device mode controller supports SS, HS and FS modes
>>>>
>>>> Based on work by:
>>>>   Mark Kuo <mkuo@nvidia.com>
>>>>   Hui Fu <hfu@nvidia.com>
>>>>   Andrew Bresticker <abrestic@chromium.org>
>>>>
>>>> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>> ---
>>>>  drivers/usb/gadget/udc/Kconfig      |   12 +
>>>>  drivers/usb/gadget/udc/Makefile     |    1 +
>>>>  drivers/usb/gadget/udc/tegra-xudc.c | 3791 +++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 3804 insertions(+)
>>>>  create mode 100644 drivers/usb/gadget/udc/tegra-xudc.c
>>>>
>>>> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
>>>> index d354036..0fe7577 100644
>>>> --- a/drivers/usb/gadget/udc/Kconfig
>>>> +++ b/drivers/usb/gadget/udc/Kconfig
>>>> @@ -441,6 +441,18 @@ config USB_GADGET_XILINX
>>>>  	  dynamically linked module called "udc-xilinx" and force all
>>>>  	  gadget drivers to also be dynamically linked.
>>>>  
>>>> +config USB_TEGRA_XUDC
>>>> +	tristate "NVIDIA Tegra Superspeed USB 3.0 Device Controller"
>>>> +	depends on ARCH_TEGRA || COMPILE_TEST
>>>> +	depends on PHY_TEGRA_XUSB
>>>> +	select USB_CONN_GPIO
>>> To me, needn't select this driver, without it, the driver still build
>>> pass
>>>
>> Yes compilation passes with out this. Added select for getting USB_CONN_GPIO
>> driver functionality.
> We can enable it in defconfig, think about one day use type-c to do
> dual-role switch, or other ways, will needn't select it then.
> 

Thanks for details, will get it enabled via defconfig instead.

- Nagarjuna
>>
>>>> +	help
>>>> +	 Enables NVIDIA Tegra USB 3.0 device mode controller driver.
>>>> +
>>>> +	 Say "y" to link the driver statically, or "m" to build a
>>>> +	 dynamically linked module called "tegra_xudc" and force all
>>>> +	 gadget drivers to also be dynamically linked.
>>>> +
>>>>  source "drivers/usb/gadget/udc/aspeed-vhub/Kconfig"
>>>>  
> 
> 
