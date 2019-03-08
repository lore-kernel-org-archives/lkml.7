Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B62C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C095320855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fazASvyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCHEuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:50:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53866 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCHEuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:50:02 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x284nOiB011454;
        Thu, 7 Mar 2019 22:49:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552020564;
        bh=uGRaHYapBdXIGFku6nPczsHx6Vq+BiijTZE0oeCxb0c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fazASvyOrnksD1qMw/nEilUBTNLStWO0RM/1ODsSkCLBXp3ZnN/5rcSj7AO6ZClp/
         nikykZ285FESOpJD1O4cS6mxpPBLlYIJu8ZYyPOruzMVwi5LhlN0MVmJKrd+kBlo1T
         rqlYcXJkVk4WU7ApWBJUWv00oe4Nz1zwkwcwg5PM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x284nOeH072111
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Mar 2019 22:49:24 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Mar 2019 22:49:23 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Mar 2019 22:49:23 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x284nJTb007686;
        Thu, 7 Mar 2019 22:49:20 -0600
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
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <602dd5ed-48b6-2098-fc2a-e36192b6a8e7@ti.com>
Date:   Fri, 8 Mar 2019 10:20:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <MWHPR02MB262310CF8152AE170FE7443CAF760@MWHPR02MB2623.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/19 4:32 PM, Naga Sureshkumar Relli wrote:
>>> +static bool zynq_qspi_supports_op(struct spi_mem *mem,
>>> +				  const struct spi_mem_op *op)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = zynq_qspi_check_buswidth(op->cmd.buswidth);
>>> +
>>> +	if (op->addr.nbytes)
>>> +		ret |= zynq_qspi_check_buswidth(op->addr.buswidth);
>>> +
>>> +	if (op->dummy.nbytes)
>>> +		ret |= zynq_qspi_check_buswidth(op->dummy.buswidth);
>>> +
>>> +	if (op->data.nbytes)
>>> +		ret |= zynq_qspi_check_buswidth(op->data.buswidth);
>>> +
>>> +	if (ret)
>>> +		return false;
>>> +
>> spi_mem_default_supports_op() already has this code.
>> Could you change, spi_mem_supports_op() to call
>> spi_mem_default_supports_op() first before controller specific
>> ->supports_op()? So that, above code can be dropped.
> Ok, I will update it.
>>> +	/*
>>> +	 * The number of address bytes should be equal to or less than 3 bytes.
>>> +	 */
>>> +	if (op->addr.nbytes > 3)
>>> +		return false;
>>> +
>> Hmm, how does the driver handle flash devices >16MB in size? Not supported?
> Zynq QSPI controller doesn't support 4 byte addressing.
> So to support > 16MB size, we have to use EAR(extended address register).
> As it is initial version of driver, I haven't added this code. This needs to be added in spi-nor.c.
> Previously I have sent an RFC patch to support all these.
> But Boris suggested to upstream the basic one first under spi-mem frame work.
> Not only this support, there are other features like dual parallel and dual stacked.
> All these features require additional support from spi-nor framework.
> We have another QSPI controller on ZynqMP SOC, which is also similar(but it supports 4Byte addressing).
> So by consolidating all these, I sent this patch.
> 
> Please let me know your suggestion on this.

Sounds fine to me. Support for > 16MB flash using EAR can come later.

-- 
Regards
Vignesh
