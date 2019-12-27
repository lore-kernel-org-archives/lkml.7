Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B70C2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE23420882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JsINGrCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfL0GQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 01:16:57 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3768 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfL0GQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 01:16:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e05a1ca0000>; Thu, 26 Dec 2019 22:16:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 26 Dec 2019 22:16:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Dec 2019 22:16:56 -0800
Received: from [10.24.192.96] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Dec
 2019 06:16:52 +0000
Subject: Re: [Patch V2 03/18] phy: tegra: xusb: Add usb-role-switch support
To:     JC Kuo <jckuo@nvidia.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-4-git-send-email-nkristam@nvidia.com>
 <3f02b1c8-0d2e-700c-d1f5-80f9655f62e0@nvidia.com>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <5fc4c7b7-0005-2b55-71ed-92c249aa35d8@nvidia.com>
Date:   Fri, 27 Dec 2019 11:48:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <3f02b1c8-0d2e-700c-d1f5-80f9655f62e0@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577427403; bh=lspnrc2CBLB6URvouestBX0L08KJ5pMq/n+NcpkMWcw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JsINGrCx41ms2ZJQcHJDxvZVJQH7iTCTHYI7dWhg3aUEVCNjgP5G9fM6s8Z+UuZXx
         har9IArQEy67gcYXcHZztpeOhNTXRLvJSOsCelN6egZFPXac6oszcfrDXqxprmNEop
         hXYAebDXYdtbieCFmkG2bBex7IrKolUDmvNezXgwD6secct/2Nr+cD818KmkjDvjnt
         lk1aFUzK/15BC/d+K819/IwS3MoGDUpE517YgJ0clUyXFDXv7z7TZTvbATk8ndTxza
         teBmYRJnaSkyfoBvBR+FogEi/KSfsUtUsVFatkrPhLb0ZhKvzebmHXMcSmMJ8vGxV6
         WNvlmsC5rFEUA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-12-2019 12:12, JC Kuo wrote:
> 
> On 12/18/19 5:16 PM, Nagarjuna Kristam wrote:
>> If usb-role-switch property is present in USB 2 port, register
>> usb-role-switch to receive usb role changes.
>>
>> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
>> ---
>> V2:
>>   - Removed dev_set_drvdata for port->dev.
>>   - Added of_platform_depopulate during error handling and driver removal.
>> ---
>>   drivers/phy/tegra/Kconfig |  1 +
>>   drivers/phy/tegra/xusb.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/phy/tegra/xusb.h  |  3 +++
>>   3 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>> index f9817c3..df07c4d 100644
>> --- a/drivers/phy/tegra/Kconfig
>> +++ b/drivers/phy/tegra/Kconfig
>> @@ -2,6 +2,7 @@
>>   config PHY_TEGRA_XUSB
>>   	tristate "NVIDIA Tegra XUSB pad controller driver"
>>   	depends on ARCH_TEGRA
>> +	select USB_CONN_GPIO
>>   	help
>>   	  Choose this option if you have an NVIDIA Tegra SoC.
>>   
>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>> index f98ec39..dc00b42 100644
>> --- a/drivers/phy/tegra/xusb.c
>> +++ b/drivers/phy/tegra/xusb.c
>> @@ -523,6 +523,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
>>   	port->dev.type = &tegra_xusb_port_type;
>>   	port->dev.of_node = of_node_get(np);
>>   	port->dev.parent = padctl->dev;
>> +	port->dev.driver = padctl->dev->driver;
>>   
>>   	err = dev_set_name(&port->dev, "%s-%u", name, index);
>>   	if (err < 0)
>> @@ -541,6 +542,10 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
>>   
>>   static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
>>   {
>> +	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
>> +		of_platform_depopulate(&port->dev);
>> +		usb_role_switch_unregister(port->usb_role_sw);
>> +	}
>>   	device_unregister(&port->dev);
>>   }
>>   
>> @@ -551,11 +556,42 @@ static const char *const modes[] = {
>>   	[USB_DR_MODE_OTG] = "otg",
>>   };
>>   
>> +static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
>> +{
>> +	dev_dbg(dev, "%s calling notifier for role is %d\n", __func__, role);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>> +{
>> +	int err = 0;
>> +	struct usb_role_switch_desc role_sx_desc = {
>> +					.set = tegra_xusb_role_sw_set,
>> +					.fwnode = dev_fwnode(&port->dev),
>> +						   };
>> +
>> +	port->usb_role_sw = usb_role_switch_register(&port->dev,
>> +						&role_sx_desc);
>> +	if (IS_ERR(port->usb_role_sw)) {
>> +		err = PTR_ERR(port->usb_role_sw);
>> +		if (err != EPROBE_DEFER)
>> +			dev_err(&port->dev, "Failed to register USB role SW: %d",
>> +				err);
>> +	}
>> +
>> +	/* populate connector entry */
>> +	of_platform_populate(port->dev.of_node, NULL, NULL, &port->dev);
>> +
>> +	return err;
>> +}
>> +
>>   static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
>>   {
>>   	struct tegra_xusb_port *port = &usb2->base;
>>   	struct device_node *np = port->dev.of_node;
>>   	const char *mode;
>> +	int err;
>>   
>>   	usb2->internal = of_property_read_bool(np, "nvidia,internal");
>>   
>> @@ -572,6 +608,12 @@ static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
>>   		usb2->mode = USB_DR_MODE_HOST;
>>   	}
>>   
> "usb-role-switch" is not required for host mode port. If a otg or a peripheral
> port doesn't have "usb-role-switch" property, .probe() should abort.
> 
> Thanks,
> JC
> 

Yes, will add the checks accordingly.
-nagarjuna

>> +	if (of_property_read_bool(np, "usb-role-switch")) {
>> +		err = tegra_xusb_setup_usb_role_switch(port);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +
>>   	usb2->supply = devm_regulator_get(&port->dev, "vbus");
>>   	return PTR_ERR_OR_ZERO(usb2->supply);
>>   }
>> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
>> index da94fcc..9f27899 100644
>> --- a/drivers/phy/tegra/xusb.h
>> +++ b/drivers/phy/tegra/xusb.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/workqueue.h>
>>   
>>   #include <linux/usb/otg.h>
>> +#include <linux/usb/role.h>
>>   
>>   /* legacy entry points for backwards-compatibility */
>>   int tegra_xusb_padctl_legacy_probe(struct platform_device *pdev);
>> @@ -266,6 +267,8 @@ struct tegra_xusb_port {
>>   	struct list_head list;
>>   	struct device dev;
>>   
>> +	struct usb_role_switch *usb_role_sw;
>> +
>>   	const struct tegra_xusb_port_ops *ops;
>>   };
>>   
>>
