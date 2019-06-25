Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14386C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C393320656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HOgXmJYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfFYFVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:21:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55620 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfFYFVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:21:48 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5P5LbtN116561;
        Tue, 25 Jun 2019 00:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561440097;
        bh=9F8HTAfQZLe8MRr2+hW7iIFR3FLEFhyWWylUj5bW8XI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HOgXmJYFcuWOQyAJM0HpBVeN7etxOVRkfo6bN5X1+G8Bw9x++7ZPIM8UUUkjCxOKW
         Ktql0ZfDsmrS+9MfboHxuQOKzaS9LyLi6a5qY9HcMbIe0X+o1gDurCFP/t/ajCAN7E
         0Qs4pDXjUyZNiU8/9cJd34P8SQlA4iWA8lVA0f8Y=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5P5La1a008858
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jun 2019 00:21:37 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 25
 Jun 2019 00:21:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 25 Jun 2019 00:21:36 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5P5LYAR122424;
        Tue, 25 Jun 2019 00:21:35 -0500
Subject: Re: [PATCH v2] phy: meson-g12a-usb3-pcie: disable locking for
 cr_regmap
To:     Neil Armstrong <narmstrong@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
References: <20190605090215.29905-1-narmstrong@baylibre.com>
 <990fd423-fe01-0c35-1ec9-99b43e1d9bc0@baylibre.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fbec0de6-bd42-7cee-29ba-a07cc7c2b974@ti.com>
Date:   Tue, 25 Jun 2019 10:50:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <990fd423-fe01-0c35-1ec9-99b43e1d9bc0@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/06/19 6:30 PM, Neil Armstrong wrote:
> Hi Kishon,
> 
> On 05/06/2019 11:02, Neil Armstrong wrote:
>> Locking is not needed for the phy_g12a_usb3_pcie_cr_bus_read/write() and
>> currently it causes the following BUG because of the usage of the
>> regmap_read_poll_timeout() running in spinlock_irq, configured by regmap fast_io.
>>
>> Simply disable locking in the cr_regmap config since it's only used from the
>> PHY init callback function.
> 
> Gentle ping,
> Is the commit log right now ?

merged now, thanks!

-Kishon

> 
> Thanks,
> Neil
> 
>>
>> BUG: sleeping function called from invalid context at drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c:85
>> in_atomic(): 1, irqs_disabled(): 128, pid: 60, name: kworker/3:1
>> [snip]
>> Workqueue: events deferred_probe_work_func
>> Call trace:
>>  dump_backtrace+0x0/0x190
>>  show_stack+0x14/0x20
>>  dump_stack+0x90/0xb4
>>  ___might_sleep+0xec/0x110
>>  __might_sleep+0x50/0x88
>>  phy_g12a_usb3_pcie_cr_bus_addr.isra.0+0x80/0x1a8
>>  phy_g12a_usb3_pcie_cr_bus_read+0x34/0x1d8
>>  _regmap_read+0x60/0xe0
>>  _regmap_update_bits+0xc4/0x110
>>  regmap_update_bits_base+0x60/0x90
>>  phy_g12a_usb3_pcie_init+0xdc/0x210
>>  phy_init+0x74/0xd0
>>  dwc3_meson_g12a_probe+0x2cc/0x4d0
>>  platform_drv_probe+0x50/0xa0
>>  really_probe+0x20c/0x3b8
>>  driver_probe_device+0x68/0x150
>>  __device_attach_driver+0xa8/0x170
>>  bus_for_each_drv+0x64/0xc8
>>  __device_attach+0xd8/0x158
>>  device_initial_probe+0x10/0x18
>>  bus_probe_device+0x90/0x98
>>  deferred_probe_work_func+0x94/0xe8
>>  process_one_work+0x1e0/0x338
>>  worker_thread+0x230/0x458
>>  kthread+0x134/0x138
>>  ret_from_fork+0x10/0x1con,
>>
>> Fixes: 36077e16c050 ("phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
>> index 6233a7979a93..ac322d643c7a 100644
>> --- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
>> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
>> @@ -188,7 +188,7 @@ static const struct regmap_config phy_g12a_usb3_pcie_cr_regmap_conf = {
>>  	.reg_read = phy_g12a_usb3_pcie_cr_bus_read,
>>  	.reg_write = phy_g12a_usb3_pcie_cr_bus_write,
>>  	.max_register = 0xffff,
>> -	.fast_io = true,
>> +	.disable_locking = true,
>>  };
>>  
>>  static int phy_g12a_usb3_init(struct phy *phy)
>>
> 
