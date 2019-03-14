Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C4FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A332087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l2SUsPKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfCNLPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:15:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38830 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfCNLPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:15:46 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2EBFdUZ016408;
        Thu, 14 Mar 2019 06:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552562139;
        bh=XCk+tUpWlzDckkUEmJMy7of0nNF6zHtXf1ZGww3V2C0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l2SUsPKg+ybYdy59nJKJ/0ymuB/dwwwI0MRx39M8MJCWwjz5qc+3QBCegFvIihp0Z
         +VZUX+IRhCJq0g6ghz2bjksqGHrENPRHz4WYP2ytsTIsq+DHRmgQ+P3dooLHCLdgtY
         LG7BEJmMOlq+jG7VZshbkbfCInJsEGcT5dlQud1w=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2EBFd2I090274
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 06:15:39 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Mar 2019 06:15:39 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Mar 2019 06:15:38 -0500
Received: from [172.22.128.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2EBFZGL001452;
        Thu, 14 Mar 2019 06:15:35 -0500
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
To:     "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kishon@ti.com>, <zhang.chunyan@linaro.org>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-2-faiz_abbas@ti.com>
 <abcc1506-cd38-5ff4-aaeb-57e9a9622e90@intel.com>
 <8d72ff93-e07f-52b9-da85-acd54f046694@ti.com>
 <63b6631d-86e7-b8ef-ffaf-40e7d4e96cfb@intel.com>
 <842caafd-1547-1ea6-faf0-27a85a912622@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <2a74ed21-2e6f-1ba3-3d49-6826a5ab3e66@ti.com>
Date:   Thu, 14 Mar 2019 13:15:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <842caafd-1547-1ea6-faf0-27a85a912622@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.03.19 19:30, Rizvi, Mohammad Faiz Abbas wrote:
> Hi Adrian,
> 
> On 3/8/2019 7:06 PM, Adrian Hunter wrote:
>> On 6/03/19 12:00 PM, Faiz Abbas wrote:
>>> Adrian,
>>>
>>> On 25/02/19 1:47 PM, Adrian Hunter wrote:
>>>> On 15/02/19 9:20 PM, Faiz Abbas wrote:
>>>>> sdhci.c has two bottom halves implemented. A threaded_irq for handling
>>>>> card insert/remove operations and a tasklet for finishing mmc requests.
>>>>> With the addition of external dma support, dmaengine APIs need to
>>>>> terminate in non-atomic context before unmapping the dma buffers.
>>>>>
>>>>> To facilitate this, remove the finish_tasklet and move the call of
>>>>> sdhci_request_done() to the threaded_irq() callback.
>>>>
>>>> The irq thread has a higher latency than the tasklet.  The performance drop
>>>> is measurable on the system I tried:
>>>>
>>>> Before:
>>>>
>>>> # dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
>>>> 1+0 records in
>>>> 1+0 records out
>>>> 1073741824 bytes (1.1 GB) copied, 4.44502 s, 242 MB/s
>>>>
>>>> After:
>>>>
>>>> # dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
>>>> 1+0 records in
>>>> 1+0 records out
>>>> 1073741824 bytes (1.1 GB) copied, 4.50898 s, 238 MB/s
>>>>
>>>> So we only want to resort to the thread for the error case.
>>>>
>>>
>>> Sorry for the late response here, but this is about 1.6% decrease. I
>>> tried out the same commands on a dra7xx board here (with about 5
>>> consecutive dd of 1GB) and the average decrease was 0.3%. I believe you
>>> will also find a lesser percentage change if you average over multiple
>>> dd commands.
>>>
>>> Is this really so significant that we have to maintain two different
>>> bottom halves and keep having difficulty with adding APIs that can sleep?
>>
>> It is a performance drop that can be avoided, so it might as well be.
>> Splitting the success path from the failure path is common for I/O drivers
>> for similar reasons as here: the success path can be optimized whereas the
>> failure path potentially needs to sleep.
> 
> Understood. You wanna keep the success path as fast as possible.

Sry, I've not completely followed this series, but I'd like to add 5c

It's good thing to get rid of tasklets hence RT Linux kernel is actively moving towards to LKML
and there everything handled in threads (even networking trying to get rid of softirqs).

Performance is pretty relative thing here - just try to run network traffic in parallel, and
there are no control over it comparing to threads. Now way to assign priority or pin to CPU.


-- 
Best regards,
grygorii
