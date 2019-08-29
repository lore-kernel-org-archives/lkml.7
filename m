Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036B0C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B552073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfH2JJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:09:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:1913 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfH2JJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:09:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 02:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="380707285"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2019 02:09:36 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Micha=c5=82_Wajdeczko?= <michal.wajdeczko@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device
 hot re-plug
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
 <3275480.HMaYE7B3nd@jkrzyszt-desk.ger.corp.intel.com>
 <0cf4e930-1132-1e7f-815b-57a08a1fe5de@linux.intel.com>
 <3255251.C7nBVfOIaa@jkrzyszt-desk.ger.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ccb1434d-281c-abae-0726-7fd924041315@linux.intel.com>
Date:   Thu, 29 Aug 2019 17:08:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3255251.C7nBVfOIaa@jkrzyszt-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/29/19 3:58 PM, Janusz Krzysztofik wrote:
> Hi Baolu,
> 
> On Thursday, August 29, 2019 3:43:31 AM CEST Lu Baolu wrote:
>> Hi Janusz,
>>
>> On 8/28/19 10:17 PM, Janusz Krzysztofik wrote:
>>>> We should avoid kernel panic when a intel_unmap() is called against
>>>> a non-existent domain.
>>> Does that mean you suggest to replace
>>> 	BUG_ON(!domain);
>>> with something like
>>> 	if (WARN_ON(!domain))
>>> 		return;
>>> and to not care of orphaned mappings left allocated?  Is there a way to
> inform
>>> users that their active DMA mappings are no longer valid and they
> shouldn't
>>> call dma_unmap_*()?
>>>
>>>> But we shouldn't expect the IOMMU driver not
>>>> cleaning up the domain info when a device remove notification comes and
>>>> wait until all file descriptors being closed, right?
>>> Shouldn't then the IOMMU driver take care of cleaning up resources still
>>> allocated on device remove before it invalidates and forgets their
> pointers?
>>>
>>
>> You are right. We need to wait until all allocated resources (iova and
>> mappings) to be released.
>>
>> How about registering a callback for BUS_NOTIFY_UNBOUND_DRIVER, and
>> removing the domain info when the driver detachment completes?
> 
> Device core calls BUS_NOTIFY_UNBOUND_DRIVER on each driver unbind, regardless
> of a device being removed or not.  As long as the device is not unplugged and
> the BUS_NOTIFY_REMOVED_DEVICE notification not generated, an unbound driver is
> not a problem here.
> Morever, BUS_NOTIFY_UNBOUND_DRIVER  is called even before
> BUS_NOTIFY_REMOVED_DEVICE so that wouldn't help anyway.
> Last but not least, bus events are independent of the IOMMU driver use via
> DMA-API it exposes.

Fair enough.

> 
> If keeping data for unplugged devices and reusing it on device re-plug is not
> acceptable then maybe the IOMMU driver should perform reference counting of
> its internal resources occupied by DMA-API users and perform cleanups on last
> release?

I am not saying that keeping data is not acceptable. I just want to
check whether there are any other solutions.

Best regards,
Baolu
