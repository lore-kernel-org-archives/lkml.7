Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99035C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF7D233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pTCIk/NQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391270AbfHWClY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:41:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57654 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389719AbfHWClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:41:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7N2fHnn040351;
        Thu, 22 Aug 2019 21:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566528077;
        bh=pG93l+RMglvDxl8bb0IbXg5xaVYgCMI7e0/JyG61YKY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pTCIk/NQVNBCsLX4tPCJ9C5QZvRxRtoQVQ+Z4Jq1c049w3QRhK+bo34Z/Rzikz9tT
         1KA2dlPAJVQ4E7mSA1wOfNhZCzju70n9ztDlEUO3BkqYzXgbyUsqeYaWRLWSCntK8N
         nCF4xJD1zd85qZKHgP7CsNhhgvPrYF1G967mwOy0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7N2fGVu096937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Aug 2019 21:41:16 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 22
 Aug 2019 21:41:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 22 Aug 2019 21:41:16 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7N2fDl8119839;
        Thu, 22 Aug 2019 21:41:14 -0500
Subject: Re: [PATCH 10/12] phy: amlogic: G12A: Fix misuse of GENMASK macro
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Hilman <khilman@baylibre.com>
CC:     <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1562734889.git.joe@perches.com>
 <d149d2851f9aa2425c927cb8e311e20c4b83e186.1562734889.git.joe@perches.com>
 <c6cabf9c-7edd-eea8-3388-df781163cddd@baylibre.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6d7abb4d-fe68-8d02-d985-7214118be126@ti.com>
Date:   Fri, 23 Aug 2019 08:11:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c6cabf9c-7edd-eea8-3388-df781163cddd@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/07/19 12:53 PM, Neil Armstrong wrote:
> On 10/07/2019 07:04, Joe Perches wrote:
>> Arguments are supposed to be ordered high then low.
>>
>> Signed-off-by: Joe Perches <joe@perches.com>
>> ---
>>  drivers/phy/amlogic/phy-meson-g12a-usb2.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
>> index 9065ffc85eb4..cd7eccab2649 100644
>> --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
>> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
>> @@ -66,7 +66,7 @@
>>  #define PHY_CTRL_R14						0x38
>>  	#define PHY_CTRL_R14_I_RDP_EN				BIT(0)
>>  	#define PHY_CTRL_R14_I_RPU_SW1_EN			BIT(1)
>> -	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(2, 3)
>> +	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(3, 2)
>>  	#define PHY_CTRL_R14_PG_RSTN				BIT(4)
>>  	#define PHY_CTRL_R14_I_C2L_DATA_16_8			BIT(5)
>>  	#define PHY_CTRL_R14_I_C2L_ASSERT_SINGLE_EN_ZERO	BIT(6)
>>
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Shouldn't this go to stable trees as well?

-Kishon
