Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDEBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23B120652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZQVxtU4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLJDuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:50:35 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7373 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJDuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:50:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5def16040000>; Mon, 09 Dec 2019 19:50:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 09 Dec 2019 19:50:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 09 Dec 2019 19:50:34 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Dec
 2019 03:50:33 +0000
Received: from [10.24.193.46] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Dec
 2019 03:50:30 +0000
Subject: Re: [PATCH 03/18] phy: tegra: xusb: Add usb-role-switch support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
 <1575629421-7039-4-git-send-email-nkristam@nvidia.com>
 <20191206145445.GD2085684@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <9ce40f6c-e742-79f0-ee99-517571c46bc3@nvidia.com>
Date:   Tue, 10 Dec 2019 09:22:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206145445.GD2085684@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575949828; bh=aIFYXzL74CPu1pOPMHd8motPMl3uNcZkSE0kei/OXaE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZQVxtU4Mh0l2o2B8MfVPxBw8aF1y6zRSLnWEkqN6KX5J9iB+2eR4fdcF2SW7O1o7c
         pmr9ZarKPuitlQ6MaKsgaRA0p949nstsW1za16xvtp8Av5qH+kb0kq2zokfdJe9in1
         hma/T05tg9T+1/ZqJ8WewV7I6lwD1+Ol0LkwpwsAt5zICIKN97lVFUwb79/LKtlAYp
         J+MyIm+/Lx7ow9OkP+0GsMp+f0z4/3sYJuvCRmIcLL/v5mTYKsX0xsWnV2mNCTkaog
         zHMbwqJGYWWEQsCLziqvkebPduYJLDHAh/LCRG1GjWFT0RwqYg9EQxBqy6Y59rOJG8
         Q7lnJr9hZMq0w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06-12-2019 20:24, Thierry Reding wrote:
> On Fri, Dec 06, 2019 at 04:20:06PM +0530, Nagarjuna Kristam wrote:
>> If usb-role-switch property is present in USB 2 port, register
>> usb-role-switch to receive usb role changes.
>>
>> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
>> ---
>>  drivers/phy/tegra/Kconfig |  1 +
>>  drivers/phy/tegra/xusb.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/phy/tegra/xusb.h  |  3 +++
>>  3 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>> index f9817c3..df07c4d 100644
>> --- a/drivers/phy/tegra/Kconfig
>> +++ b/drivers/phy/tegra/Kconfig
>> @@ -2,6 +2,7 @@
>>  config PHY_TEGRA_XUSB
>>  	tristate "NVIDIA Tegra XUSB pad controller driver"
>>  	depends on ARCH_TEGRA
>> +	select USB_CONN_GPIO
>>  	help
>>  	  Choose this option if you have an NVIDIA Tegra SoC.
>>  
>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>> index f98ec39..da60a63 100644
>> --- a/drivers/phy/tegra/xusb.c
>> +++ b/drivers/phy/tegra/xusb.c
>> @@ -523,6 +523,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
>>  	port->dev.type = &tegra_xusb_port_type;
>>  	port->dev.of_node = of_node_get(np);
>>  	port->dev.parent = padctl->dev;
>> +	port->dev.driver = padctl->dev->driver;
>>  
>>  	err = dev_set_name(&port->dev, "%s-%u", name, index);
>>  	if (err < 0)
>> @@ -532,6 +533,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
>>  	if (err < 0)
>>  		goto unregister;
>>  
>> +	dev_set_drvdata(&port->dev, port);
> You never seem to use dev_get_drvdata() to get at this. Also, you can
> get at it via container_of(), so this is only marginally useful to begin
> with.
> 
Its actually used in API tegra_xusb_role_sw_set, but thats in patch 0004.
Will move this line to 0004 patch to align with the usage.

>>  	return 0;
>>  
>>  unregister:
>> @@ -541,6 +543,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
>>  
>>  static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
>>  {
>> +	usb_role_switch_unregister(port->usb_role_sw);
>>  	device_unregister(&port->dev);
>>  }
>>  
>> @@ -551,11 +554,39 @@ static const char *const modes[] = {
>>  	[USB_DR_MODE_OTG] = "otg",
>>  };
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
>> +	return err;
>> +}
>> +
>>  static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
>>  {
>>  	struct tegra_xusb_port *port = &usb2->base;
>>  	struct device_node *np = port->dev.of_node;
>>  	const char *mode;
>> +	int err;
>>  
>>  	usb2->internal = of_property_read_bool(np, "nvidia,internal");
>>  
>> @@ -572,6 +603,15 @@ static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
>>  		usb2->mode = USB_DR_MODE_HOST;
>>  	}
>>  
>> +	if (of_property_read_bool(np, "usb-role-switch")) {
>> +		/* populate connector entry */
>> +		of_platform_populate(np, NULL, NULL, &port->dev);
> I think we want to clean this up on failure, don't we? Otherwise we
> might end up trying to register the same platform device multiple times.
> Also, do we want to depopulate when the port is removed again?
> 
> Have you tried unloading and loading the driver to see if that works?
> 
> Thierry
> 
platform needs to be depopulate on error/remove and will add corresponding code.
padctl driver can be unloaded after unloading all dependent drivers. re-loading
caused failure of usb role switch due to missing depopulate. Will update changes
to consider the same.

Thanks,
Nagarjuna
>> +
>> +		err = tegra_xusb_setup_usb_role_switch(port);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +
>>  	usb2->supply = devm_regulator_get(&port->dev, "vbus");
>>  	return PTR_ERR_OR_ZERO(usb2->supply);
>>  }
>> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
>> index da94fcc..9f27899 100644
>> --- a/drivers/phy/tegra/xusb.h
>> +++ b/drivers/phy/tegra/xusb.h
>> @@ -12,6 +12,7 @@
>>  #include <linux/workqueue.h>
>>  
>>  #include <linux/usb/otg.h>
>> +#include <linux/usb/role.h>
>>  
>>  /* legacy entry points for backwards-compatibility */
>>  int tegra_xusb_padctl_legacy_probe(struct platform_device *pdev);
>> @@ -266,6 +267,8 @@ struct tegra_xusb_port {
>>  	struct list_head list;
>>  	struct device dev;
>>  
>> +	struct usb_role_switch *usb_role_sw;
>> +
>>  	const struct tegra_xusb_port_ops *ops;
>>  };
>>  
>> -- 
>> 2.7.4
>>
