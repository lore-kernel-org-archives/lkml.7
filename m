Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D796C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0DC20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i+yvDK9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfGSM1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:27:16 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57240 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfGSM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:27:16 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6JCRCNo066325;
        Fri, 19 Jul 2019 07:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563539232;
        bh=C15ifLtTMW9RCLd4ICeuIimwJTRxzJ3T1kPA7gs2at4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i+yvDK9DowbNnToFTY2uhYAJFMgC9FT/7LU+DEsyksjJMyP7FwphYoe1o5U02HSaN
         0evBtBW23LW+BU10aPFaNcHvagrNmYAvVTm2bm/jT/mCGCKAS3qiyNN1G3fYs31iAG
         5q3DRtiM5dWpYD+J4PyElilDtWbLKN4J8dNMqsTg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6JCRCuq044990
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jul 2019 07:27:12 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 19
 Jul 2019 07:27:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 19 Jul 2019 07:27:11 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6JCR98S005093;
        Fri, 19 Jul 2019 07:27:10 -0500
Subject: Re: [PATCH] phy: core: document calibrate() method
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485@eucas1p2.samsung.com>
 <20190719095245.17401-1-m.szyprowski@samsung.com>
 <085b8093-d7bc-d960-f0d8-8776818ebab0@ti.com>
 <1865da50-000f-e235-4090-1058d2aa217b@samsung.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6345ff36-9ee3-fe41-e416-a1178087b2c7@ti.com>
Date:   Fri, 19 Jul 2019 17:55:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1865da50-000f-e235-4090-1058d2aa217b@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 19/07/19 5:51 PM, Marek Szyprowski wrote:
> Hi Kishon,
> 
> On 2019-07-19 12:04, Kishon Vijay Abraham I wrote:
>> Hi Marek,
>>
>> On 19/07/19 3:22 PM, Marek Szyprowski wrote:
>>> Commit 36914111e682 ("drivers: phy: add calibrate method") added support
>>> for generic phy_calibrate() method, but it didn't explain in detail when
>>> such method is supposed to be called. Add some more documentation directly
>>> to the phy.h to make it clean that it is intended to be called after every
>>> host controller reset.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>   include/linux/phy/phy.h | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>>> index 15032f145063..46775e8b0ed9 100644
>>> --- a/include/linux/phy/phy.h
>>> +++ b/include/linux/phy/phy.h
>>> @@ -101,6 +101,18 @@ struct phy_ops {
>>>   	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
>>>   			    union phy_configure_opts *opts);
>>>   	int	(*reset)(struct phy *phy);
>>> +
>>> +	/**
>>> +	 * @calibrate:
>>> +	 *
>>> +	 * Optional.
>>> +	 *
>>> +	 * Used to calibrate phy, typically by adjusting some parameters
>>> +	 * in runtime, which are otherwise lost after host controller
>>> +	 * reset and cannot be set in phy_init() and phy_power_on().
>>> +	 *
>>> +	 * Returns: 0 if successful, an negative error code otherwise
>>> +	 */
>>>   	int	(*calibrate)(struct phy *phy);
>> This should be added in drivers/phy/phy-core.c before phy_calibrate()?
> 
> Okay. Do you want to keep it also in phy.h (like for validate and 
> configure)?

No. Adding in phy.txt and before phy_calibrate() should suffice IMO.

Thanks
Kishon
