Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1714BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D257C20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sZJsNgsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfDBH7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:59:43 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58428 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:59:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x327xXLK091080;
        Tue, 2 Apr 2019 02:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554191973;
        bh=4IAx569BJpLqMRnkl/74xkVsHrXMbC8VE2otIjWxnaQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sZJsNgsMr4QQdpNQQnEGSxD2ooynhz/LdsBBB+oFLoYddRbQQ7T3xSsmX16qkSO3v
         6bZofQ7MBIlHv4N0DUm3TiI49N8dYpXgt566aJtQw1EknMuABEaX8400ZKKC9osEAt
         IuGKnguVzWyvPSfxWob9vqI0FHU4VRMiJLasjlow=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x327xXQw110303
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 02:59:33 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 02:59:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 02:59:32 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x327xSTa019623;
        Tue, 2 Apr 2019 02:59:29 -0500
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kishon <kishon@ti.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-2-faiz_abbas@ti.com>
 <CAPDyKFqN4s1CZa9z5C3YzCUO01V-=Xhtao5352Pmytd-Tusv9A@mail.gmail.com>
 <65f24027-005a-4372-8819-45e6a360bfce@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <987a3616-8530-7247-ce00-6513a6c2d4bc@ti.com>
Date:   Tue, 2 Apr 2019 13:29:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <65f24027-005a-4372-8819-45e6a360bfce@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 26/03/19 1:03 PM, Adrian Hunter wrote:
> On 18/03/19 11:33 AM, Ulf Hansson wrote:
>> + Arnd, Grygorii
>>
>> On Fri, 15 Feb 2019 at 20:17, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>
>>> sdhci.c has two bottom halves implemented. A threaded_irq for handling
>>> card insert/remove operations and a tasklet for finishing mmc requests.
>>> With the addition of external dma support, dmaengine APIs need to
>>> terminate in non-atomic context before unmapping the dma buffers.
>>>
>>> To facilitate this, remove the finish_tasklet and move the call of
>>> sdhci_request_done() to the threaded_irq() callback. Also move the
>>> interrupt result variable to sdhci_host so it can be populated from
>>> anywhere inside the sdhci_irq handler.
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>
>> Adrian, I think it makes sense to apply this patch, even if there is
>> very minor negative impact throughput wise.
>>
>> To me, it doesn't seems like MMC/SD/SDIO has good justification for
>> using tasklets, besides from the legacy point of view, of course.
>> Instead, I think we should try to move all mmc hosts into using
>> threaded IRQs.
>>
>> So, what do you think? Can you overlook the throughput drop and
>> instead we can try to recover this on top with other optimizations?
> 
> I tend to favour good results as expressed here:
> 
> 	https://lkml.org/lkml/2007/6/22/360
> 
> So I want to do optimization first.
> 
> But performance is not the only problem with the patch.  Give me a few
> days and I will see what I can come up with.
> 

Gentle ping on this.

Thanks,
Faiz
