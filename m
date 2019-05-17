Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AAEC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4866A20833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfEQHIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfEQHIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:08:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE18081DE6;
        Fri, 17 May 2019 07:07:42 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 274AC5D9C4;
        Fri, 17 May 2019 07:07:31 +0000 (UTC)
Subject: Re: [PATCH v3 7/7] iommu/vt-d: Differentiate relaxable and non
 relaxable RMRRs
To:     Lu Baolu <baolu.lu@linux.intel.com>, eric.auger.pro@gmail.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
References: <20190516100817.12076-1-eric.auger@redhat.com>
 <20190516100817.12076-8-eric.auger@redhat.com>
 <2ebc33ed-ded6-0eee-96ef-84e6f61f692e@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <65852894-2525-e67e-5fd3-55ba4a323c2f@redhat.com>
Date:   Fri, 17 May 2019 09:07:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2ebc33ed-ded6-0eee-96ef-84e6f61f692e@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 17 May 2019 07:08:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On 5/17/19 6:46 AM, Lu Baolu wrote:
> Hi Eric,
> 
> On 5/16/19 6:08 PM, Eric Auger wrote:
>> Now we have a new IOMMU_RESV_DIRECT_RELAXABLE reserved memory
>> region type, let's report USB and GFX RMRRs as relaxable ones.
>>
>> This allows to have a finer reporting at IOMMU API level of
>> reserved memory regions. This will be exploitable by VFIO to
>> define the usable IOVA range and detect potential conflicts
>> between the guest physical address space and host reserved
>> regions.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index a36604f4900f..af1d65fdedfc 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5493,7 +5493,9 @@ static void intel_iommu_get_resv_regions(struct
>> device *device,
>>       for_each_rmrr_units(rmrr) {
>>           for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>>                         i, i_dev) {
>> +            struct pci_dev *pdev = to_pci_dev(device);
> 
> Probably should be:
> 
> struct pci_dev *pdev = dev_is_pci(device) ? to_pci_dev(device) : NULL;

That's correct. I will fix that asap.

Thanks!

Eric
> 
> Best regards,
> Lu Baolu
> 
