Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1822EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC60821773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Uj3v2seB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfDQFed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:34:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38044 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQFed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:34:33 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3H5YBhr110461;
        Wed, 17 Apr 2019 00:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555479251;
        bh=QQaQTIX19bhhkSjOWo6RemiLytFCFIgwsm+/+DooSCc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Uj3v2seBbkl4rMcNtJymt4jsz8Rgea9IV/60c9Zyr9mhpnik+39A6qViod6C24yHx
         7nBKv+F3vZ4Ih/eENhuctHxvOYE2hPvao9KnIn2SgErRi4Dz2Thj1okPk8Xq5w+jH8
         fdP4UwHIdzWtR+isrFAbyO2ucnaIOzg36YQAJjM0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3H5YBcN064043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Apr 2019 00:34:11 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Apr 2019 00:34:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Apr 2019 00:34:10 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3H5Y4o8077054;
        Wed, 17 Apr 2019 00:34:08 -0500
Subject: Re: [PATCH] phy: sun4i-usb: Make sure to disable PHY0 passby for
 peripheral mode
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@googlegroups.com>
CC:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jagan Teki <jagan@openedev.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20190314130518.2892-1-paul.kocialkowski@bootlin.com>
 <30b3c2548772d13f54284fcf16ed941de88f72cc.camel@bootlin.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <63a12a83-8ea8-40de-d086-9971c93d57f6@ti.com>
Date:   Wed, 17 Apr 2019 11:02:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <30b3c2548772d13f54284fcf16ed941de88f72cc.camel@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/04/19 4:47 PM, Paul Kocialkowski wrote:
> Hi,
> 
> Le jeudi 14 mars 2019 à 14:05 +0100, Paul Kocialkowski a écrit :
>> On platforms where the MUSB and HCI controllers share PHY0, PHY passby
>> is required when using the HCI controller with the PHY, but it must be
>> disabled when the MUSB controller is used instead.
>>
>> Without this, PHY0 passby is always enabled, which results in broken
>> peripheral mode on such platforms (e.g. H3/H5).
>>
>> Fixes: ba4bdc9e1dc0 ("PHY: sunxi: Add driver for sunxi usb phy")
> 
> Does anyone have feedback about this? I was hoping to get it merged
> rather soon since it pretty much fixes USB gadget on H3/R40/V3/V3s.

merged now, thanks.

-Kishon
> 
> Cheers,
> 
> Paul
> 
>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> ---
>>  drivers/phy/allwinner/phy-sun4i-usb.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
>> index 5163097b43df..7b23920e0068 100644
>> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
>> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
>> @@ -551,6 +551,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
>>  	struct sun4i_usb_phy_data *data =
>>  		container_of(work, struct sun4i_usb_phy_data, detect.work);
>>  	struct phy *phy0 = data->phys[0].phy;
>> +	struct sun4i_usb_phy *phy = phy_get_drvdata(phy0);
>>  	bool force_session_end, id_notify = false, vbus_notify = false;
>>  	int id_det, vbus_det;
>>  
>> @@ -607,6 +608,9 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
>>  			mutex_unlock(&phy0->mutex);
>>  		}
>>  
>> +		/* Enable PHY0 passby for host mode only. */
>> +		sun4i_usb_phy_passby(phy, !id_det);
>> +
>>  		/* Re-route PHY0 if necessary */
>>  		if (data->cfg->phy0_dual_route)
>>  			sun4i_usb_phy0_reroute(data, id_det);
