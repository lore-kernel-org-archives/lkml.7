Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A05AC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B17E206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Pk51j2EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfLIG0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:26:02 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2520 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfLIG0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:26:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dede8f30000>; Sun, 08 Dec 2019 22:25:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 08 Dec 2019 22:26:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 08 Dec 2019 22:26:01 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Dec
 2019 06:26:00 +0000
Received: from [10.24.193.46] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Dec 2019
 06:25:57 +0000
Subject: Re: [PATCH 05/18] phy: tegra: xusb: Add support to get companion USB
 3 port
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
 <1575629421-7039-6-git-send-email-nkristam@nvidia.com>
 <20191206145740.GE2085684@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <9c93d4ff-29aa-0a59-c667-643939c46c5a@nvidia.com>
Date:   Mon, 9 Dec 2019 11:57:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206145740.GE2085684@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575872755; bh=0DnxoHmVITIxx4h5aZuGgGhKbqv7i4rF32jKL7JlfcQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Pk51j2EPm2iQ6FZZ1kgnH7zz9zsW+yZOHRhwtuWClOuwX2cUAtiOVRuZ/PA/rXldK
         F5msMJAgIdkDCFc3z24CxouQ2b2pxajthmutBL/xTn2N/BcSu/F9yYMbe+cZCX8faz
         ZS0fQlT1Ko0Ypd14VGlMGVYeo5HmfHhN2BpdIgATggDVyvGKFpR4NO+wRHn2dT0Ih3
         8iX2R/OQStyHEiG5F1d8X0YrBkbxpwwOpClAFGizEUaoCiOw0/354E+B04uUjpKgSj
         zWpL63KBqjJXVI81lkQIh4pU5AZCcbpfsj+LJHsuxLuEpWPzo/Jb+QEX8KMmnKC027
         U3ZogvHr6bRwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06-12-2019 20:27, Thierry Reding wrote:
> On Fri, Dec 06, 2019 at 04:20:08PM +0530, Nagarjuna Kristam wrote:
>> Tegra XUSB host, device mode driver requires the USB 3 companion port
>> number for corresponding USB 2 port. Add API to retrieve the same.
>>
>> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
>> ---
>>  drivers/phy/tegra/xusb.c       | 21 +++++++++++++++++++++
>>  include/linux/phy/tegra/xusb.h |  2 ++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>> index 4c86c99..2e73cf8 100644
>> --- a/drivers/phy/tegra/xusb.c
>> +++ b/drivers/phy/tegra/xusb.c
>> @@ -1254,6 +1254,27 @@ int tegra_phy_xusb_utmi_port_reset(struct phy *phy)
>>  }
>>  EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_port_reset);
>>  
>> +int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
>> +				    unsigned int port)
>> +{
>> +	struct tegra_xusb_usb2_port *usb2 = tegra_xusb_find_usb2_port(padctl,
>> +								      port);
>> +	struct tegra_xusb_usb3_port *usb3;
>> +	int i;
>> +
>> +	if (!usb2)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < padctl->soc->ports.usb3.count; i++) {
>> +		usb3 = tegra_xusb_find_usb3_port(padctl, i);
>> +		if (usb3 && usb3->port == usb2->base.index)
>> +			return usb3->base.index;
>> +	}
>> +
>> +	return -1;
> Since you return -EINVAL above, callers will have to interpret negative
> return values as standard errors, which would make this EPERM. That does
> not really make sense. Perhaps something like -ENODEV would be more
> appropriate in this case?
> 
> Thierry
> 
Yes, making -ENODEV instead of -1 makes it inline with generic error codes.
Will update accordingly.

-Nagarjuna
>> +}
>> +EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_usb3_companion);
>> +
>>  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
>>  MODULE_DESCRIPTION("Tegra XUSB Pad Controller driver");
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
>> index 1235865..71d9569 100644
>> --- a/include/linux/phy/tegra/xusb.h
>> +++ b/include/linux/phy/tegra/xusb.h
>> @@ -21,4 +21,6 @@ int tegra_xusb_padctl_usb3_set_lfps_detect(struct tegra_xusb_padctl *padctl,
>>  int tegra_xusb_padctl_set_vbus_override(struct tegra_xusb_padctl *padctl,
>>  					bool val);
>>  int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
>> +int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
>> +					 unsigned int port);
>>  #endif /* PHY_TEGRA_XUSB_H */
>> -- 
>> 2.7.4
>>
