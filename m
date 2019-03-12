Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB5EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF9C2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i0Q6/irM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfCLRGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:06:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45046 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:06:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2CH5nKK071489;
        Tue, 12 Mar 2019 12:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552410349;
        bh=DM2GNiTdlezc0jl7RbEUe8Q6lZEriQmM/kPozEGEYNA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i0Q6/irMMgFTetVEcySTvpu8/a2hmgR5zWwGH4JW/bHsNj3CIypLqm/GYBSDAl2L+
         dxdlhCKebgdtolVR/QaL4cTATFUUo+UlaPWW7/gTM/+/KCVpmyFj/7jJHTJGWByfle
         jE4YMPjiAepzxgxNU3V0JOJYkIu0J4kIaMxvp91g=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2CH5nFe088521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 12:05:49 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 12:05:48 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 12:05:48 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2CH5ibf009486;
        Tue, 12 Mar 2019 12:05:44 -0500
Subject: Re: [RFC PATCH 2/2] spi: spi-mem: Add support for Zynq QSPI
 controller
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
References: <1551337361-11665-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <48dafcc4-1b9d-9ce2-9228-78e73252781f@ti.com>
 <MWHPR02MB262310CF8152AE170FE7443CAF760@MWHPR02MB2623.namprd02.prod.outlook.com>
 <602dd5ed-48b6-2098-fc2a-e36192b6a8e7@ti.com>
 <MWHPR02MB262362EC0116C64B84874740AF480@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1f4df1cc-7a2f-1601-0553-1db5d69b492d@ti.com>
Date:   Tue, 12 Mar 2019 22:36:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <MWHPR02MB262362EC0116C64B84874740AF480@MWHPR02MB2623.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/03/19 10:02 AM, Naga Sureshkumar Relli wrote:
> Hi Vignesh,
> 
>> -----Original Message-----
>> From: linux-spi-owner@vger.kernel.org <linux-spi-owner@vger.kernel.org> On Behalf Of
>> Vignesh Raghavendra
>> Sent: Friday, March 8, 2019 10:20 AM
>> To: Naga Sureshkumar Relli <nagasure@xilinx.com>; broonie@kernel.org;
>> bbrezillon@kernel.org
>> Cc: linux-spi@vger.kernel.org; dwmw2@infradead.org; marek.vasut@gmail.com;
>> richard@nod.at; linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek
>> <michals@xilinx.com>; nagasuresh12@gmail.com
>> Subject: Re: [RFC PATCH 2/2] spi: spi-mem: Add support for Zynq QSPI controller
>>
>>
>>
>> On 01/03/19 4:32 PM, Naga Sureshkumar Relli wrote:
>>>>> +static bool zynq_qspi_supports_op(struct spi_mem *mem,
>>>>> +				  const struct spi_mem_op *op)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = zynq_qspi_check_buswidth(op->cmd.buswidth);
>>>>> +
>>>>> +	if (op->addr.nbytes)
>>>>> +		ret |= zynq_qspi_check_buswidth(op->addr.buswidth);
>>>>> +
>>>>> +	if (op->dummy.nbytes)
>>>>> +		ret |= zynq_qspi_check_buswidth(op->dummy.buswidth);
>>>>> +
>>>>> +	if (op->data.nbytes)
>>>>> +		ret |= zynq_qspi_check_buswidth(op->data.buswidth);
>>>>> +
>>>>> +	if (ret)
>>>>> +		return false;
>>>>> +
>>>> spi_mem_default_supports_op() already has this code.
>>>> Could you change, spi_mem_supports_op() to call
>>>> spi_mem_default_supports_op() first before controller specific
>>>> ->supports_op()? So that, above code can be dropped.
>>> Ok, I will update it.
>>>>> +	/*
>>>>> +	 * The number of address bytes should be equal to or less than 3 bytes.
>>>>> +	 */
>>>>> +	if (op->addr.nbytes > 3)
>>>>> +		return false;
>>>>> +
>>>> Hmm, how does the driver handle flash devices >16MB in size? Not supported?
>>> Zynq QSPI controller doesn't support 4 byte addressing.
>>> So to support > 16MB size, we have to use EAR(extended address register).
>>> As it is initial version of driver, I haven't added this code. This needs to be added in spi-nor.c.
>>> Previously I have sent an RFC patch to support all these.
>>> But Boris suggested to upstream the basic one first under spi-mem frame work.
>>> Not only this support, there are other features like dual parallel and dual stacked.
>>> All these features require additional support from spi-nor framework.
>>> We have another QSPI controller on ZynqMP SOC, which is also similar(but it supports
>> 4Byte addressing).
>>> So by consolidating all these, I sent this patch.
>>>
>>> Please let me know your suggestion on this.
>>
>> Sounds fine to me. Support for > 16MB flash using EAR can come later.
> Thanks.
> Shall I wait for others to review or go ahead by addressing your previous comments?
> 

Typically, for a new driver, I would wait at least 2 weeks from date of
posting so that other reviewers have sufficient time to look into the patch.


-- 
Regards
Vignesh
