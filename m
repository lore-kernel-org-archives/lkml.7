Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B053C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFF720835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfCTBcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:32:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:47656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfCTBcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:32:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 18:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,246,1549958400"; 
   d="scan'208";a="128456918"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2019 18:32:29 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
To:     James Sewart <jamessewart@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <0e74cc54-bb90-a620-5763-466cb11aaef7@linux.intel.com>
 <94706334-3DE4-4964-8FDD-125C58D493A0@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <418d1432-2036-3f6f-48de-77005807e350@linux.intel.com>
Date:   Wed, 20 Mar 2019 09:26:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <94706334-3DE4-4964-8FDD-125C58D493A0@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/19/19 9:35 PM, James Sewart wrote:
> Hey Lu,
> 
>> On 15 Mar 2019, at 03:13, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi James,
>>
>> On 3/14/19 7:56 PM, James Sewart wrote:
>>> Patches 1 and 2 are the same as v1.
>>> v1-v2:
>>>    Refactored ISA direct mappings to be returned by iommu_get_resv_regions.
>>>    Integrated patch by Lu to defer turning on DMAR until iommu.c has mapped
>>> reserved regions.
>>>    Integrated patches by Lu to remove more unused code in cleanup.
>>> Lu: I didn't integrate your patch to set the default domain type as it
>>> isn't directly related to the aim of this patchset. Instead patch 4
>>
>> Without those patches, user experience will be affected and some devices
>> will not work on Intel platforms anymore.
>>
>> For a long time, Intel IOMMU driver has its own logic to determine
>> whether a device requires an identity domain. For example, when user
>> specifies "iommu=pt" in kernel parameter, all device will be attached
>> with the identity domain. Further more, some quirky devices require
>> an identity domain to be used before enabling DMA remapping, otherwise,
>> it will not work. This was done by adding quirk bits in Intel IOMMU
>> driver.
>>
>> So from my point of view, one way is porting all those quirks and kernel
>> parameters into IOMMU generic layer, or opening a door for vendor IOMMU
>> driver to determine the default domain type by their own. I prefer the
>> latter option since it will not impact any behaviors on other
>> architectures.
> 
> I see your point. I’m not confident that using the proposed door to set a
> groups default domain has the desired behaviour. As discussed before the
> default domain type will be set based on the desired type for only the
> first device attached to a group. I think to change the default domain
> type you would need a slightly different door that wasn’t conditioned on
> device.

I think this as another problem. Just a summarize for the ease of
discussion. We saw two problems:

1. When allocating a new group for a device, how should we determine the
type of the default domain? This is what my proposal patches trying to
address.

2. If we need to put a device into an existing group which uses a
different type of domain from what the device desires to use, we might
break the functionality of the device. For this problem I'd second your
proposal below if I get your point correctly.

> 
> For situations where individual devices require an identity domain because
> of quirks then maybe calling is_identity_map per device in
> iommu_group_get_for_dev is a better solution than the one I proposed.
> 

Do you mean if we see a quirky device requires a different domain type
other than the default domain type of the group, we will assign a new
group to it? That looks good to me as far as I can see. I suppose this
should be done in vt-d's ops callback.

Best regards,
Lu Baolu
