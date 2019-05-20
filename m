Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25EEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD02620645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391466AbfETMpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:45:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389437AbfETMpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:45:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F5FE5946F;
        Mon, 20 May 2019 12:45:19 +0000 (UTC)
Received: from [10.36.116.113] (ovpn-116-113.ams2.redhat.com [10.36.116.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A652D5DE77;
        Mon, 20 May 2019 12:45:09 +0000 (UTC)
Subject: Re: [PATCH v3 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE
 reserved memory regions
To:     Robin Murphy <robin.murphy@arm.com>, eric.auger.pro@gmail.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        lorenzo.pieralisi@arm.com, will.deacon@arm.com,
        hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
References: <20190516100817.12076-1-eric.auger@redhat.com>
 <20190516100817.12076-7-eric.auger@redhat.com>
 <ad8a99fa-b98a-14d3-12be-74df0e6eb8f8@arm.com>
 <57db1955-9d19-7c0b-eca3-37cc0d7d745b@redhat.com>
 <fb9cd4ef-d91e-e526-fc6f-6cee43e70bb7@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <84cbb905-f413-7d14-eab5-3744b016b08f@redhat.com>
Date:   Mon, 20 May 2019 14:45:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fb9cd4ef-d91e-e526-fc6f-6cee43e70bb7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 20 May 2019 12:45:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 5/16/19 7:53 PM, Robin Murphy wrote:
> On 16/05/2019 14:23, Auger Eric wrote:
>> Hi Robin,
>> On 5/16/19 2:46 PM, Robin Murphy wrote:
>>> On 16/05/2019 11:08, Eric Auger wrote:
>>>> Introduce a new type for reserved region. This corresponds
>>>> to directly mapped regions which are known to be relaxable
>>>> in some specific conditions, such as device assignment use
>>>> case. Well known examples are those used by USB controllers
>>>> providing PS/2 keyboard emulation for pre-boot BIOS and
>>>> early BOOT or RMRRs associated to IGD working in legacy mode.
>>>>
>>>> Since commit c875d2c1b808 ("iommu/vt-d: Exclude devices using RMRRs
>>>> from IOMMU API domains") and commit 18436afdc11a ("iommu/vt-d: Allow
>>>> RMRR on graphics devices too"), those regions are currently
>>>> considered "safe" with respect to device assignment use case
>>>> which requires a non direct mapping at IOMMU physical level
>>>> (RAM GPA -> HPA mapping).
>>>>
>>>> Those RMRRs currently exist and sometimes the device is
>>>> attempting to access it but this has not been considered
>>>> an issue until now.
>>>>
>>>> However at the moment, iommu_get_group_resv_regions() is
>>>> not able to make any difference between directly mapped
>>>> regions: those which must be absolutely enforced and those
>>>> like above ones which are known as relaxable.
>>>>
>>>> This is a blocker for reporting severe conflicts between
>>>> non relaxable RMRRs (like MSI doorbells) and guest GPA space.
>>>>
>>>> With this new reserved region type we will be able to use
>>>> iommu_get_group_resv_regions() to enumerate the IOVA space
>>>> that is usable through the IOMMU API without introducing
>>>> regressions with respect to existing device assignment
>>>> use cases (USB and IGD).
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> Note: At the moment the sysfs ABI is not changed. However I wonder
>>>> whether it wouldn't be preferable to report the direct region as
>>>> "direct_relaxed" there. At the moment, in case the same direct
>>>> region is used by 2 devices, one USB/GFX and another not belonging
>>>> to the previous categories, the direct region will be output twice
>>>> with "direct" type.
>>>
>>> Hmm, that sounds a bit off - if we have overlapping regions within the
>>> same domain, then we need to do some additional pre-processing to adjust
>>> them anyway, since any part of a relaxable region which overlaps a
>>> non-relaxable region cannot actually be relaxed, and so really should
>>> never be described as such.
>> In iommu_insert_resv_region(), we are overlapping regions of the same
>> type. So iommu_get_group_resv_regions() should return both the relaxable
>> region and non relaxable one. I should test this again using a hacked
>> kernel though.
> 
> We should still consider relaxable regions as being able to merge back
> in to regular direct regions to a degree - If a relaxable region falls
> entirely within a direct one then there's no point exposing it because
> the direct region *has* to take precedence and be enforced. If there is
> an incomplete overlap then we could possibly just trust consumers to see
> it and give the direct region precedence themselves, but since the
> relaxable region is our own in-kernel invention rather than firmware
> gospel I think it would be safer to truncate it to just its
> non-overlapping part.

While I understand your reasoning above, and I tend to agree this would
be nice to have, I have spent some time looking at the algo to
merge/split/overlay regions and I am afraid that this will bring a huge
complexity in the insertion function (I am also afraid the existing data
structs may not be well adapted overall). So I am now a bit reluctant to
add such complexty for shrinking relaxable regions that we will
eventually ignore in any case.

Thanks

Eric
> 
> Robin.
