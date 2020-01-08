Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D9AC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28612087F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P+4dJJNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgAHHk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:40:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49892 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgAHHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:40:28 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0087eRqe108249;
        Wed, 8 Jan 2020 01:40:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578469227;
        bh=t6kH3Q6Cv8V4dWBay2w80i2s3pxJj3Q2bnCsRXtwt2c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=P+4dJJNWga11VNKjPOfoOM+txkip/5P9ESxlGOxXSyomKGbuSAaTkD4ee+kJD9kLz
         5kcDXAm/70kphh+Gud0ILws0Ev5aDTwxoBc21aKSkBqgNs1yIKnfc4UDJdD3DhEQ9G
         DGiwWbW6EJJ9+ytRhcHrU9s8pyYMGBAr8J6NK4Qo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0087eRUt029953
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 01:40:27 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 01:40:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 01:40:27 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0087ePIs129435;
        Wed, 8 Jan 2020 01:40:25 -0600
Subject: Re: [PATCH v5 0/3] phy: cadence: j721e-wiz: Add Type-C plug flip
 support
To:     Roger Quadros <rogerq@ti.com>
CC:     <nsekhar@ti.com>, <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20200106130622.29703-1-rogerq@ti.com>
 <6390dd78-92bd-711b-f153-ae73c959a665@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <952bd59a-5998-9cc2-d438-4a7185ad480f@ti.com>
Date:   Wed, 8 Jan 2020 13:12:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6390dd78-92bd-711b-f153-ae73c959a665@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/01/20 6:37 PM, Roger Quadros wrote:
> 
> 
> On 06/01/2020 15:06, Roger Quadros wrote:
>> Hi,
>>
>> On J721e platform, the 2 lanes of SERDES PHY are used to achieve
>> USB Type-C plug flip support without any additional MUX component
>> by using a lane swap feature.
>>
>> However, the driver needs to know the Type-C plug orientation before
>> it can decide whether to swap the lanes or not. This is achieved via a
>> GPIO named DIR.
>>
>> Another constraint is that the lane swap must happen only when the PHY
>> is in inactive state. This is achieved by sampling the GPIO and
>> programming the lane swap before bringing the PHY out of reset.
>>
>> This series adds support to read the GPIO and accordingly program
>> the Lane swap for Type-C plug flip support.
>>
>> Series must be applied on top of
>> https://patchwork.kernel.org/cover/11293671/
>>
>> cheers,
>> -roger
>>
>> Changelog:
> v5
>  - rebased on phy/next

merged now, thanks!

-Kishon

> 
>> v4
>> - fixes in dt-binding document
>>    - fix typo
>>    - change to typec-dir-debounce-ms and add min/max/default values
>>    - drop reference to uint32 type
>> - fixes in driver
>>    - change to updated typec-dir-debounce-ms property
>>    - add limit checks and use default value if not specified
>>
>> v3
>> - Rebase on v2 of PHY series and update DT binding to yaml
>>
>> v2
>> - revise commit log of patch 1
>> - use regmap_field in patch 3
>>
>>
>> Roger Quadros (3):
>>    phy: cadence: Sierra: add phy_reset hook
>>    dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
>>    phy: ti: j721e-wiz: Manage typec-gpio-dir
>>
>>   .../bindings/phy/ti,phy-j721e-wiz.yaml        | 17 ++++++
>>   drivers/phy/cadence/phy-cadence-sierra.c      | 10 +++
>>   drivers/phy/ti/phy-j721e-wiz.c                | 61 +++++++++++++++++++
>>   3 files changed, 88 insertions(+)
>>
> 
