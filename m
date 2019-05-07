Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEE6C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A13C205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uaAdpacX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfEGQ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:27:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59890 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfEGQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:27:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x47GR8hw033836;
        Tue, 7 May 2019 11:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557246428;
        bh=P9OKlobsMuFk7eV/sCL4oYA9ZbX2O0+AEbA1PMWuJag=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uaAdpacX8LV5aJrKTlHW/sebP6Gdva1LW0wIc0ec9AccICX1k/qVxqvEzuYuDYWv1
         kLICOGTT/w1WzFZvJNg7EjI6/fLhAscx3S3j9J7/Vs24YumCxETQXka1LDDeLUPQU8
         6AKaoP7Z84Mi7tCEvuZjz0k+YBNCAyQxunu4QORU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x47GR8IN110351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 May 2019 11:27:08 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 7 May
 2019 11:27:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 7 May 2019 11:27:07 -0500
Received: from [10.250.139.87] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x47GR5X6108985;
        Tue, 7 May 2019 11:27:06 -0500
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Fix SLOTTYPE write
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>
References: <20190425155727.20010-1-faiz_abbas@ti.com>
 <20190425155727.20010-3-faiz_abbas@ti.com>
 <c2dcc343-395f-03a2-67a8-d89ab6a6b192@intel.com>
From:   Faiz Abbas <a0230074@ti.com>
Message-ID: <db0b0790-4556-8a3b-2ae1-fcb4b1beb4b3@ti.com>
Date:   Tue, 7 May 2019 21:57:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c2dcc343-395f-03a2-67a8-d89ab6a6b192@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 26/04/19 11:30 AM, Adrian Hunter wrote:
> On 25/04/19 6:57 PM, Faiz Abbas wrote:
>> In the call to regmap_update_bits() for SLOTTYPE, the mask and value
>> fields are exchanged. Fix this.
> 
> Could you also comment on whether this has any known effect on the driver.
> 

This call was basically a NOP but it was the correct way around in
u-boot so it was just taking that value instead. No effect that was
known to me. Found this out just by inspection.

Thanks,
Faiz
