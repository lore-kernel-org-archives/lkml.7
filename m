Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17756C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D232D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B0RJ73yG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDLEIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:08:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37442 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfDLEIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:08:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3C48VmC080407;
        Thu, 11 Apr 2019 23:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555042111;
        bh=+1Vslevu6ugpmdOGljCOkiKev4xk0y0cVIbkx7aJAww=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=B0RJ73yGwmAbbMLW7g0x8yEX1u1D6ZHrrtTOY2f+9Tk90g0sxLMmExgYPCKJjQRNz
         WBz11bYGj+XaifvlL/rr1wiPacihHDcoRLu38yIk1SoVClbMylnQFy2e3X30cwwJkA
         ewjKlAiUyGt16kmvwDhErOeylSQfM6vZuGeH31J0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3C48VGM072081
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 23:08:31 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 23:08:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 23:08:31 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3C48QGY021121;
        Thu, 11 Apr 2019 23:08:27 -0500
Subject: Re: [PATCH v6 04/12] firmware: ti_sci: Add RM mapping table for am654
To:     Tony Lindgren <tony@atomide.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20190410041358.16809-1-lokeshvutla@ti.com>
 <20190410041358.16809-5-lokeshvutla@ti.com>
 <20190411145416.GP2839@atomide.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <49dd19bf-f5bd-e048-75ad-2d4cb708bcf9@ti.com>
Date:   Fri, 12 Apr 2019 09:38:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190411145416.GP2839@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/19 8:24 PM, Tony Lindgren wrote:
> Hi,
> 
> * Lokesh Vutla <lokeshvutla@ti.com> [190410 04:15]:
>> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> index b56a02c10ae6..6f0cd31c1520 100644
>> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>> @@ -24,7 +24,8 @@ relationship between the TI-SCI parent node to the child node.
>>  
>>  Required properties:
>>  -------------------
>> -- compatible: should be "ti,k2g-sci"
>> +- compatible:	should be "ti,k2g-sci" for TI 66AK2G SoC
>> +		should be "ti,am654-sci" for for TI AM654 SoC
>>  - mbox-names:
>>  	"rx" - Mailbox corresponding to receive path
>>  	"tx" - Mailbox corresponding to transmit path
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index d303f5a14da9..88e461498def 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -2297,10 +2297,33 @@ static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
>>  	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
>>  	.max_msgs = 20,
>>  	.max_msg_size = 64,
>> +	.rm_type_map = NULL,
>> +};
>> +
>> +static struct ti_sci_rm_type_map ti_sci_am654_rm_type_map[] = {
>> +	{.dev_id = 56, .type = 0x00b}, /* GIC_IRQ */
>> +	{.dev_id = 179, .type = 0x000}, /* MAIN_NAV_UDMASS_IA0 */
>> +	{.dev_id = 187, .type = 0x009}, /* MAIN_NAV_RA */
>> +	{.dev_id = 188, .type = 0x006}, /* MAIN_NAV_UDMAP */
>> +	{.dev_id = 194, .type = 0x007}, /* MCU_NAV_UDMAP */
>> +	{.dev_id = 195, .type = 0x00a}, /* MCU_NAV_RA */
>> +	{.dev_id = 0, .type = 0x000}, /* end of table */
>> +};
>> +
>> +/* Description for AM654 */
>> +static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
>> +	.default_host_id = 12,
>> +	/* Conservative duration */
>> +	.max_rx_timeout_ms = 10000,
>> +	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
>> +	.max_msgs = 20,
>> +	.max_msg_size = 60,
>> +	.rm_type_map = ti_sci_am654_rm_type_map,
>>  };
>>  
>>  static const struct of_device_id ti_sci_of_match[] = {
>>  	{.compatible = "ti,k2g-sci", .data = &ti_sci_pmmc_k2g_desc},
>> +	{.compatible = "ti,am654-sci", .data = &ti_sci_pmmc_am654_desc},
>>  	{ /* Sentinel */ },
>>  };
>>  MODULE_DEVICE_TABLE(of, ti_sci_of_match);
> 
> Great, this approach with mapping table in the driver based on
> the compatible looks good to me and avoids stuffing the IDs
> into device tree:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 

Thanks, but I don't think you understood what the patch is actually doing.
Please look at the rest of the series on how this table is being used.

Thanks and regards,
Lokesh
