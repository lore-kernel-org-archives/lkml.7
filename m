Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEABCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C423021906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MfQV+IGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbfJWIJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:09:44 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40028 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfJWIJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:09:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N89gbD078048;
        Wed, 23 Oct 2019 03:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571818182;
        bh=ZfP9BharqnfDDOfH8UAQbM0m+BiwuI/R1NAozBclods=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MfQV+IGFnagRc37Yi3oA1t489rrWR+PifzaYeEqhPSInDKnmFFIehc5PYJhtN52Vh
         l973nGx6TCeNB71RwACtmzpcckT7ONmHWF11KPP8FaurYTPBwamUf67huBOdeRVTvn
         L2xeiJjQbWE0Z6PNf/WpXp5+qDeA9CVXPArh/Gyw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N89bdd088759;
        Wed, 23 Oct 2019 03:09:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 03:08:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 03:08:40 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N88lhF120094;
        Wed, 23 Oct 2019 03:08:47 -0500
Subject: Re: [PATCH 1/3] phy: cadence: Sierra: add phy_reset hook
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191022132249.869-1-rogerq@ti.com>
 <20191022132249.869-2-rogerq@ti.com>
 <3d261add-8fa8-13b8-a42b-8662fcbe4b23@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <1956da9e-ec5f-ce68-25ea-1d570e1f7b54@ti.com>
Date:   Wed, 23 Oct 2019 11:08:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3d261add-8fa8-13b8-a42b-8662fcbe4b23@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On 23/10/2019 10:36, Kishon Vijay Abraham I wrote:
> Roger,
> 
> On 22/10/19 6:52 PM, Roger Quadros wrote:
>> This is required if type C driver needs to hold
>> global reset on J7ES to perform LN10 swap.
> 
> Can you replace "This" with something more specific.

I meant this patch, but I will revise the commit message.

cheers,
-roger
> 
> Thanks
> Kishon
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>   drivers/phy/cadence/phy-cadence-sierra.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
>> index affede8c4368..e6d27bdec22a 100644
>> --- a/drivers/phy/cadence/phy-cadence-sierra.c
>> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
>> @@ -339,10 +339,20 @@ static int cdns_sierra_phy_off(struct phy *gphy)
>>   	return reset_control_assert(ins->lnk_rst);
>>   }
>>   
>> +static int cdns_sierra_phy_reset(struct phy *gphy)
>> +{
>> +	struct cdns_sierra_phy *sp = dev_get_drvdata(gphy->dev.parent);
>> +
>> +	reset_control_assert(sp->phy_rst);
>> +	reset_control_deassert(sp->phy_rst);
>> +	return 0;
>> +};
>> +
>>   static const struct phy_ops ops = {
>>   	.init		= cdns_sierra_phy_init,
>>   	.power_on	= cdns_sierra_phy_on,
>>   	.power_off	= cdns_sierra_phy_off,
>> +	.reset		= cdns_sierra_phy_reset,
>>   	.owner		= THIS_MODULE,
>>   };
>>   
>>

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
