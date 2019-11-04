Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C633CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA02222C1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfKDKuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:50:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfKDKuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:50:13 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DE46E2099A79968604F1;
        Mon,  4 Nov 2019 18:50:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 18:50:07 +0800
Subject: Re: [PATCH -next] usb: gadget: Add dependency for USB_TEGRA_XUDC
To:     Thierry Reding <treding@nvidia.com>
CC:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <nkristam@nvidia.com>, <arnd@arndb.de>, <johan@kernel.org>,
        <krzk@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20191104025945.172620-1-maowenan@huawei.com>
 <20191104100410.GB996639@ulmo>
From:   maowenan <maowenan@huawei.com>
Message-ID: <51315499-99d0-eca3-a7df-b8dd84628bbd@huawei.com>
Date:   Mon, 4 Nov 2019 18:50:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191104100410.GB996639@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/4 18:04, Thierry Reding wrote:
> On Mon, Nov 04, 2019 at 10:59:45AM +0800, Mao Wenan wrote:
>> If CONFIG_USB_TEGRA_XUDC=y and CONFIG_USB_ROLE_SWITCH=m,
>> below erros can be seen:
>> drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_remove':
>> tegra-xudc.c:(.text+0x6b0): undefined reference to `usb_role_switch_unregister'
>> drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_probe':
>> tegra-xudc.c:(.text+0x1b88): undefined reference to `usb_role_switch_register'
>> drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_usb_role_sw_work':
>> tegra-xudc.c:(.text+0x5ecc): undefined reference to `usb_role_switch_get_role'
>>
>> This patch add dependency USB_ROLE_SWITCH for UDC driver.
>>
>> Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  drivers/usb/gadget/udc/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
>> index acaec3a..d103154 100644
>> --- a/drivers/usb/gadget/udc/Kconfig
>> +++ b/drivers/usb/gadget/udc/Kconfig
>> @@ -445,6 +445,7 @@ config USB_TEGRA_XUDC
>>  	tristate "NVIDIA Tegra Superspeed USB 3.0 Device Controller"
>>  	depends on ARCH_TEGRA || COMPILE_TEST
>>  	depends on PHY_TEGRA_XUSB
>> +	depends on USB_ROLE_SWITCH
> 
> It looks like most other drivers that use the USB role switch class do
> "select" here. Now, that's suboptimal because USB_ROLE_SWITCH is a user-
> visible symbol, which can lead to conflicts, so it should be avoided. I
> think that in this case it might make sense to hide USB_ROLE_SWITCH and
> then convert all "depends on USB_ROLE_SWITCH" occurrences to "select
> USB_ROLE_SWITCH". The USB role switch class is, after all, not useful by
> itself. It always needs a host and/or gadget driver to make use of it.
> 

Thanks, I send v2 and change 'depends on' to 'select' for this patch.

> Thierry
> 

