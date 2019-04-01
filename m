Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE97C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34222086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qYW6Ho2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfDAKop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:44:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52580 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfDAKoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:44:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31Aig5u067303;
        Mon, 1 Apr 2019 05:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554115482;
        bh=s77Ke2iQ9H0VvaFF6VK8wUjY4kw8zs9d4kiLLx66BUA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qYW6Ho2CssdMyCvHFcgwq0VCHQkvJg4KDso5nxl34LwPzj9iyV1ag+63Am6zphCOh
         /e4g8qosSITuQEzyU33+thFmDzygIMYVezKI/W+PO9wDvU7tAzfEIsTSEnx3EVr0xL
         TdnwShtxirjnyjgRyPaiyK9QuOp7xq40qdpxhHgM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31AifSY021034
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 05:44:42 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 05:44:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 05:44:41 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31AicBp097064;
        Mon, 1 Apr 2019 05:44:40 -0500
Subject: Re: [PATCH 1/2] mmc: sdhci: Add Quirk for enabling HISPD under
 special conditions
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>
References: <20190329142202.15000-1-faiz_abbas@ti.com>
 <20190329142202.15000-2-faiz_abbas@ti.com>
 <f1417015-0e78-6df5-7917-a33e235fa1a9@intel.com>
 <350cd133-302f-4002-4b54-d95e7e5d3500@ti.com>
 <6d8f9b8c-dd5c-a091-7a82-10e5f6606b4e@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <51104203-068b-a25c-299b-ac9a2f720680@ti.com>
Date:   Mon, 1 Apr 2019 16:14:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6d8f9b8c-dd5c-a091-7a82-10e5f6606b4e@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 01/04/19 2:42 PM, Adrian Hunter wrote:
> On 1/04/19 12:01 PM, Faiz Abbas wrote:
>> Hi Adrian,
>>
>> On 01/04/19 2:21 PM, Adrian Hunter wrote:
>>> On 29/03/19 4:22 PM, Faiz Abbas wrote:
>>>> Some controllers on TI devices requires the HISPD bit to be cleared
>>>> even in some high speed modes. Add a quirk that facilitates this
>>>> requirement.
>>>
>>> Could you use sdhci I/O accessors for this?
>>
>> Can you elaborate? Not sure how this would be solved with
>> CONFIG_MMC_SDHCI_IO_ACCESSORS.
> 
> In ->writeb()
> 
> if (reg == SDHCI_HOST_CONTROL) {
> 	if (host->mmc->ios->timing == whatever)
> 		val &= ~SDHCI_CTRL_HISPD;
> }
> 
> writeb(val, host->ioaddr + reg);

This is a really good idea. Will use it in v2. Thanks.

Regards,
Faiz
