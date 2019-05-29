Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E4CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A5E23AFA
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfE2PlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:41:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfE2PlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:41:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DD88F0D15;
        Wed, 29 May 2019 15:41:02 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41CEB1019612;
        Wed, 29 May 2019 15:40:53 +0000 (UTC)
Subject: Re: [PATCH v5 2/7] iommu/vt-d: Duplicate iommu_resv_region objects
 per device list
To:     Lu Baolu <baolu.lu@linux.intel.com>, eric.auger.pro@gmail.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        robin.murphy@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jean-philippe.brucker@arm.com
References: <20190528115025.17194-1-eric.auger@redhat.com>
 <20190528115025.17194-3-eric.auger@redhat.com>
 <e22ccc46-7c37-c8d2-784b-3d4168512772@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <a4b991b1-53c8-bb72-a981-67d02763873e@redhat.com>
Date:   Wed, 29 May 2019 17:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e22ccc46-7c37-c8d2-784b-3d4168512772@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 29 May 2019 15:41:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On 5/29/19 4:04 AM, Lu Baolu wrote:
> Hi Eric,
> 
> On 5/28/19 7:50 PM, Eric Auger wrote:
>> intel_iommu_get_resv_regions() aims to return the list of
>> reserved regions accessible by a given @device. However several
>> devices can access the same reserved memory region and when
>> building the list it is not safe to use a single iommu_resv_region
>> object, whose container is the RMRR. This iommu_resv_region must
>> be duplicated per device reserved region list.
>>
>> Let's remove the struct iommu_resv_region from the RMRR unit
>> and allocate the iommu_resv_region directly in
>> intel_iommu_get_resv_regions(). We hold the dmar_global_lock instead
>> of the rcu-lock to allow sleeping.
>>
>> Fixes: 0659b8dc45a6 ("iommu/vt-d: Implement reserved region get/put
>> callbacks")
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v4 -> v5
>> - replace rcu-lock by the dmar_global_lock
>> ---
>>   drivers/iommu/intel-iommu.c | 34 +++++++++++++++++-----------------
>>   1 file changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index a209199f3af6..5ec8b5bd308f 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -322,7 +322,6 @@ struct dmar_rmrr_unit {
>>       u64    end_address;        /* reserved end address */
>>       struct dmar_dev_scope *devices;    /* target devices */
>>       int    devices_cnt;        /* target device count */
>> -    struct iommu_resv_region *resv; /* reserved region handle */
>>   };
>>     struct dmar_atsr_unit {
>> @@ -4205,7 +4204,6 @@ static inline void init_iommu_pm_ops(void) {}
>>   int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void
>> *arg)
>>   {
>>       struct acpi_dmar_reserved_memory *rmrr;
>> -    int prot = DMA_PTE_READ|DMA_PTE_WRITE;
>>       struct dmar_rmrr_unit *rmrru;
>>       size_t length;
>>   @@ -4219,22 +4217,16 @@ int __init dmar_parse_one_rmrr(struct
>> acpi_dmar_header *header, void *arg)
>>       rmrru->end_address = rmrr->end_address;
>>         length = rmrr->end_address - rmrr->base_address + 1;
>> -    rmrru->resv = iommu_alloc_resv_region(rmrr->base_address, length,
>> prot,
>> -                          IOMMU_RESV_DIRECT);
>> -    if (!rmrru->resv)
>> -        goto free_rmrru;
>>         rmrru->devices = dmar_alloc_dev_scope((void *)(rmrr + 1),
>>                   ((void *)rmrr) + rmrr->header.length,
>>                   &rmrru->devices_cnt);
>>       if (rmrru->devices_cnt && rmrru->devices == NULL)
>> -        goto free_all;
>> +        goto free_rmrru;
>>         list_add(&rmrru->list, &dmar_rmrr_units);
>>         return 0;
>> -free_all:
>> -    kfree(rmrru->resv);
>>   free_rmrru:
>>       kfree(rmrru);
>>   out:
>> @@ -4452,7 +4444,6 @@ static void intel_iommu_free_dmars(void)
>>       list_for_each_entry_safe(rmrru, rmrr_n, &dmar_rmrr_units, list) {
>>           list_del(&rmrru->list);
>>           dmar_free_dev_scope(&rmrru->devices, &rmrru->devices_cnt);
>> -        kfree(rmrru->resv);
>>           kfree(rmrru);
>>       }
>>   @@ -5470,22 +5461,33 @@ static void intel_iommu_remove_device(struct
>> device *dev)
>>   static void intel_iommu_get_resv_regions(struct device *device,
>>                        struct list_head *head)
>>   {
>> +    int prot = DMA_PTE_READ|DMA_PTE_WRITE;
> 
> I know this is moved from above. How about adding spaces around the '|'?
sure
> 
>>       struct iommu_resv_region *reg;
>>       struct dmar_rmrr_unit *rmrr;
>>       struct device *i_dev;
>>       int i;
>>   -    rcu_read_lock();
>> +    down_write(&dmar_global_lock);
> 
> Just out of curiosity, why not down_read()? We don't change the rmrr
> list here, right?
you're right, my mistake.
> 
>>       for_each_rmrr_units(rmrr) {
>>           for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>>                         i, i_dev) {
>> +            struct iommu_resv_region *resv;
>> +            size_t length;
>> +
>>               if (i_dev != device)
>>                   continue;
>>   -            list_add_tail(&rmrr->resv->list, head);
>> +            length = rmrr->end_address - rmrr->base_address + 1;
>> +            resv = iommu_alloc_resv_region(rmrr->base_address,
>> +                               length, prot,
>> +                               IOMMU_RESV_DIRECT);
>> +            if (!resv)
>> +                break;
>> +
>> +            list_add_tail(&resv->list, head);
>>           }
>>       }
>> -    rcu_read_unlock();
>> +    up_write(&dmar_global_lock);
>>         reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>>                         IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
>> @@ -5500,10 +5502,8 @@ static void intel_iommu_put_resv_regions(struct
>> device *dev,
>>   {
>>       struct iommu_resv_region *entry, *next;
>>   -    list_for_each_entry_safe(entry, next, head, list) {
>> -        if (entry->type == IOMMU_RESV_MSI)
>> -            kfree(entry);
>> -    }
>> +    list_for_each_entry_safe(entry, next, head, list)
>> +        kfree(entry);
>>   }
>>     int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct
>> device *dev)
>>
> 
> Other looks good to me.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Thanks!

Eric
> 
> Best regards,
> Baolu
