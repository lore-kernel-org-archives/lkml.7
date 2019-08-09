Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D588C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D195208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nktvAwFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406398AbfHIKb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:31:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43300 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfHIKb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:31:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79AVNBF054950;
        Fri, 9 Aug 2019 05:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565346683;
        bh=PaGvXL+jFcPb4Nr5wkFP8Iz5YbwTuScL/oOSQEj3g74=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nktvAwFwZjYUDSf4eu0gS+Tq/TsETd5wR0LFkEEdluqwWk9/zxNYqIDbhxCsLmTAd
         7AlZkrtOPpOB9Iq18g9qOnuZ4CrehZJ2KXhZKzS7l17Dp4+fzkXzU5ghsKQHJaLYki
         zQU4oqLsea9yyj7m2WJHABePzxhSeOf6GHzKcrH8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79AVNo9128199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 05:31:23 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 05:31:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 05:31:22 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79AVKoe110112;
        Fri, 9 Aug 2019 05:31:20 -0500
Subject: Re: [PATCH] usb: dwc3: remove generic PHYs forwarding for XHCI device
To:     Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <CGME20190719093045eucas1p1a1c6f26ae4103e9ed283fff2396beaef@eucas1p1.samsung.com>
 <20190719093037.16181-1-m.szyprowski@samsung.com> <87h86rn7r9.fsf@gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <754c3127-dd78-3afd-e047-68404d6ebec5@ti.com>
Date:   Fri, 9 Aug 2019 13:31:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87h86rn7r9.fsf@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/08/2019 15:47, Felipe Balbi wrote:
> 
> Hi,
> 
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> 
>> Commit 08f871a3aca2 ("usb: dwc3: host: convey the PHYs to xhci") added
>> forwarding of the generic PHYs from DWC3 core to the instantiated XHCI-plat
>> device. However XHCI(-plat) driver never gained support for generic PHYs,
>> thus the lookup added by that commit is never used. In meantime the commit
>> d64ff406e51e ("usb: dwc3: use bus->sysdev for DMA configuration")
>> incorrectly changed the device used for creating lookup, making the lookup
>> useless and generic PHYs inaccessible from XHCI device.
>>
>> However since commit 178a0bce05cb ("usb: core: hcd: integrate the PHY
>> wrapper into the HCD core") USB HCD already handles generic PHYs acquired
>> from the HCD's 'sysdev', which in this case is DWC3 core device. This means
>> that creating any custom lookup entries for XHCI driver is no longer needed
>> and can be simply removed.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/usb/dwc3/host.c | 22 ++++------------------
>>  1 file changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>> index f55947294f7c..8deea8c91e03 100644
>> --- a/drivers/usb/dwc3/host.c
>> +++ b/drivers/usb/dwc3/host.c
>> @@ -85,7 +85,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>>  						DWC3_XHCI_RESOURCES_NUM);
>>  	if (ret) {
>>  		dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
>> -		goto err1;
>> +		goto err;
>>  	}
>>  
>>  	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
>> @@ -112,37 +112,23 @@ int dwc3_host_init(struct dwc3 *dwc)
>>  		ret = platform_device_add_properties(xhci, props);
>>  		if (ret) {
>>  			dev_err(dwc->dev, "failed to add properties to xHCI\n");
>> -			goto err1;
>> +			goto err;
>>  		}
>>  	}
>>  
>> -	phy_create_lookup(dwc->usb2_generic_phy, "usb2-phy",
>> -			  dev_name(dwc->dev));
>> -	phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
>> -			  dev_name(dwc->dev));
>> -
>>  	ret = platform_device_add(xhci);
>>  	if (ret) {
>>  		dev_err(dwc->dev, "failed to register xHCI device\n");
>> -		goto err2;
>> +		goto err;
>>  	}
>>  
>>  	return 0;
>> -err2:
>> -	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
>> -			  dev_name(dwc->dev));
>> -	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
>> -			  dev_name(dwc->dev));
>> -err1:
>> +err:
>>  	platform_device_put(xhci);
>>  	return ret;
>>  }
>>  
>>  void dwc3_host_exit(struct dwc3 *dwc)
>>  {
>> -	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
>> -			  dev_name(dwc->dev));
>> -	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
>> -			  dev_name(dwc->dev));
>>  	platform_device_unregister(dwc->xhci);
>>  }
> 
> Roger, could you verify that this doesn't regress any of your platforms?

Patch is fine with our platforms.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
