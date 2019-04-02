Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A222C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032B4206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfDBNNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:13:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:46880 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbfDBNNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:13:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 06:13:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,300,1549958400"; 
   d="scan'208";a="147363778"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga002.jf.intel.com with ESMTP; 02 Apr 2019 06:13:48 -0700
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
To:     Faiz Abbas <faiz_abbas@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 <987a3616-8530-7247-ce00-6513a6c2d4bc@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <99e1b9cb-8eef-9ef2-4caa-3d5c98e9c6f3@intel.com>
Date:   Tue, 2 Apr 2019 16:12:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <987a3616-8530-7247-ce00-6513a6c2d4bc@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/04/19 10:59 AM, Faiz Abbas wrote:
> Hi Adrian,
> 
> On 26/03/19 1:03 PM, Adrian Hunter wrote:
>> On 18/03/19 11:33 AM, Ulf Hansson wrote:
>>> + Arnd, Grygorii
>>>
>>> On Fri, 15 Feb 2019 at 20:17, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>>
>>>> sdhci.c has two bottom halves implemented. A threaded_irq for handling
>>>> card insert/remove operations and a tasklet for finishing mmc requests.
>>>> With the addition of external dma support, dmaengine APIs need to
>>>> terminate in non-atomic context before unmapping the dma buffers.
>>>>
>>>> To facilitate this, remove the finish_tasklet and move the call of
>>>> sdhci_request_done() to the threaded_irq() callback. Also move the
>>>> interrupt result variable to sdhci_host so it can be populated from
>>>> anywhere inside the sdhci_irq handler.
>>>>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>
>>> Adrian, I think it makes sense to apply this patch, even if there is
>>> very minor negative impact throughput wise.
>>>
>>> To me, it doesn't seems like MMC/SD/SDIO has good justification for
>>> using tasklets, besides from the legacy point of view, of course.
>>> Instead, I think we should try to move all mmc hosts into using
>>> threaded IRQs.
>>>
>>> So, what do you think? Can you overlook the throughput drop and
>>> instead we can try to recover this on top with other optimizations?
>>
>> I tend to favour good results as expressed here:
>>
>> 	https://lkml.org/lkml/2007/6/22/360
>>
>> So I want to do optimization first.
>>
>> But performance is not the only problem with the patch.  Give me a few
>> days and I will see what I can come up with.
>>
> 
> Gentle ping on this.

Working on it :-)
