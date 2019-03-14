Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D7720854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="we2TluHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCNLlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:41:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57734 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfCNLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:41:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2EBfTPi000599;
        Thu, 14 Mar 2019 06:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552563689;
        bh=YievU1VLeC1+DrIa0xM6OPkS7VGiHM9hNIxkrSRAVV4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=we2TluHKtXdnIMT6sjh4w4S45lOidYitrnIugwZ9r6xaLeUwt+iN8wRrveJV7l0dV
         e3r1aIbzRA8JSphgz/Mj0G+HsK2GZ5rFL0T4rKlQUZ2oCrQVIJaD6ZgtQE0WgxdjVf
         UsdrKCnYeFRMHy3ybCnWZPuYm5dgzFPeBbAG2VD0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2EBfT8E086710
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 06:41:29 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Mar 2019 06:41:29 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Mar 2019 06:41:29 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2EBfP1S025709;
        Thu, 14 Mar 2019 06:41:26 -0500
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
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
 <2a74ed21-2e6f-1ba3-3d49-6826a5ab3e66@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <b8d12a8a-2eed-bee9-2421-d8560b99703b@ti.com>
Date:   Thu, 14 Mar 2019 17:11:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2a74ed21-2e6f-1ba3-3d49-6826a5ab3e66@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/03/19 4:45 PM, Grygorii Strashko wrote:
> 
> 
> On 12.03.19 19:30, Rizvi, Mohammad Faiz Abbas wrote:
>> Hi Adrian,
>>
>> On 3/8/2019 7:06 PM, Adrian Hunter wrote:
>>> On 6/03/19 12:00 PM, Faiz Abbas wrote:
>>>> Adrian,
>>>>
>>>> On 25/02/19 1:47 PM, Adrian Hunter wrote:
>>>>> On 15/02/19 9:20 PM, Faiz Abbas wrote:
>>>>>> sdhci.c has two bottom halves implemented. A threaded_irq for handling
>>>>>> card insert/remove operations and a tasklet for finishing mmc requests.
>>>>>> With the addition of external dma support, dmaengine APIs need to
>>>>>> terminate in non-atomic context before unmapping the dma buffers.
>>>>>>
>>>>>> To facilitate this, remove the finish_tasklet and move the call of
>>>>>> sdhci_request_done() to the threaded_irq() callback.
>>>>>
>>>>> The irq thread has a higher latency than the tasklet.  The performance drop
>>>>> is measurable on the system I tried:
>>>>>
>>>>> Before:
>>>>>
>>>>> # dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
>>>>> 1+0 records in
>>>>> 1+0 records out
>>>>> 1073741824 bytes (1.1 GB) copied, 4.44502 s, 242 MB/s
>>>>>
>>>>> After:
>>>>>
>>>>> # dd if=/dev/mmcblk1 of=/dev/null bs=1G count=1 &
>>>>> 1+0 records in
>>>>> 1+0 records out
>>>>> 1073741824 bytes (1.1 GB) copied, 4.50898 s, 238 MB/s
>>>>>
>>>>> So we only want to resort to the thread for the error case.
>>>>>
>>>>
>>>> Sorry for the late response here, but this is about 1.6% decrease. I
>>>> tried out the same commands on a dra7xx board here (with about 5
>>>> consecutive dd of 1GB) and the average decrease was 0.3%. I believe you
>>>> will also find a lesser percentage change if you average over multiple
>>>> dd commands.
>>>>
>>>> Is this really so significant that we have to maintain two different
>>>> bottom halves and keep having difficulty with adding APIs that can sleep?
>>>
>>> It is a performance drop that can be avoided, so it might as well be.
>>> Splitting the success path from the failure path is common for I/O drivers
>>> for similar reasons as here: the success path can be optimized whereas the
>>> failure path potentially needs to sleep.
>>
>> Understood. You wanna keep the success path as fast as possible.
> 
> Sry, I've not completely followed this series, but I'd like to add 5c
> 
> It's good thing to get rid of tasklets hence RT Linux kernel is actively moving towards to LKML
> and there everything handled in threads (even networking trying to get rid of softirqs).
> 
> Performance is pretty relative thing here - just try to run network traffic in parallel, and
> there are no control over it comparing to threads. Now way to assign priority or pin to CPU.

There is a 2007 LWN article(https://lwn.net/Articles/239633/) which
talks about removing tasklets altogether. I wonder what happened after that.

Thanks,
Faiz
