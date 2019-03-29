Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29874C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB202217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QeRKX8L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfC2LBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:01:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34824 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfC2LBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:01:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TB0qeU027878;
        Fri, 29 Mar 2019 06:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553857252;
        bh=2AkFXzQTC8Jq8dwmKEW+lcJdOPiO6BSO3NKklfNCNts=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QeRKX8L2NtbBHNSFQfp8UDPvxNiHTLkFR4/15reOhsfSju/EoAHKBuU4tvQAeTtjK
         D4KK7UQdy0LG1UeFcQ2ww/gmbQwy0TJLrIqLJBhgs0z5z4SZt2zvEB4LUJXm0Pvek+
         J9n2T9wQ9LMulRMbZm/OugUpR1oAGXHT93xzpLGQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TB0qfs087710
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 06:00:52 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 06:00:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 06:00:51 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TB0l7Q076024;
        Fri, 29 Mar 2019 06:00:48 -0500
Subject: Re: [LINUX PATCH 2/3] spi: spi-mem: call
 spi_mem_default_supports_op() first
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
References: <1553771784-3364-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190328205522.272e1da6@collabora.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <cf7c971c-4b58-e965-3ca7-b72239772737@ti.com>
Date:   Fri, 29 Mar 2019 16:31:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328205522.272e1da6@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga Sureshkumar

On 29/03/19 1:25 AM, Boris Brezillon wrote:
> On Thu, 28 Mar 2019 16:46:24 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> 
>> Call spi_mem_default_supports_op() first, before calling controller
>> specific ctlr->supports_op().
>> With this, controller drivers can drop checking the buswidths again.
> 
> No, this was done on purpose, in case the controller does not want the
> default check to be applied (say it does not need bus-width props to
> be defined and has another way to check if a device can be accessed in
> dual, quad or octal mode).
> Just call spi_mem_default_supports_op() from your driver
> ->supports_op() hook if needed.
> 

Could you rework to follow Boris's suggestion here?

>>
>> Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
>> ---
>> Details can be found at https://lkml.org/lkml/2019/3/1/183
>> ---
>>  drivers/spi/spi-mem.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index 5217a56..56aa158 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -189,11 +189,14 @@ static bool spi_mem_internal_supports_op(struct spi_mem *mem,
>>  					 const struct spi_mem_op *op)
>>  {
>>  	struct spi_controller *ctlr = mem->spi->controller;
>> +	bool ret;
>> +
>> +	ret = spi_mem_default_supports_op(mem, op);
>>  
>>  	if (ctlr->mem_ops && ctlr->mem_ops->supports_op)
>> -		return ctlr->mem_ops->supports_op(mem, op);
>> +		ret =  ctlr->mem_ops->supports_op(mem, op);
>>  
>> -	return spi_mem_default_supports_op(mem, op);
>> +	return ret;
>>  }
>>  
>>  /**
> 

-- 
Regards
Vignesh
