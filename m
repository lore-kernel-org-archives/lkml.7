Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1364C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0FD23AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfE2Pi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2Pi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:38:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D31F30C0DC4;
        Wed, 29 May 2019 15:38:26 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D53DE5C64D;
        Wed, 29 May 2019 15:38:16 +0000 (UTC)
Subject: Re: [PATCH v5 1/7] iommu: Fix a leak in iommu_insert_resv_region
To:     Christoph Hellwig <hch@infradead.org>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, alex.williamson@redhat.com
References: <20190528115025.17194-1-eric.auger@redhat.com>
 <20190528115025.17194-2-eric.auger@redhat.com>
 <20190529061756.GB26055@infradead.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c4edcb80-4003-7a1c-fca1-cad25436a5ad@redhat.com>
Date:   Wed, 29 May 2019 17:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190529061756.GB26055@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 29 May 2019 15:38:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 5/29/19 8:17 AM, Christoph Hellwig wrote:
>>  		} else if ((start >= a) && (end <= b)) {
>>  			if (new->type == type)
>> -				goto done;
>> +				return 0;
>>  			else
>>  				pos = pos->next;
> 
> Please remove the pointless else after the return statement.
Sorry I don't get your point here. For both cases, we only return if
both types match. Otherwise we continue parsing the list as there may be
a region of the same type as @new following the current interval that
may need to be merged with @new. Let's consider the insertion of those
resv regions:

add_resv(head, 0xa001000, 0xa001FFF, IOMMU_RESV_TYPE1);
head -> 0x000000000a001000 0x000000000a001fff type1

add_resv(head, 0xa003000, 0xa003FFF, IOMMU_RESV_TYPE1);
head ->
0x000000000a001000 0x000000000a001fff type1 ->
0x000000000a003000 0x000000000a003fff type1

add_resv(head, 0xa002000, 0xa004FFF, IOMMU_RESV_TYPE2);
head ->
0x000000000a001000 0x000000000a001fff type1 ->
0x000000000a003000 0x000000000a003fff type1 ->
0x000000000a002000 0x000000000a004fff type2 ->

add_resv(head, 0xa0010FF, 0xa003000, IOMMU_RESV_TYPE2);

head ->
0x000000000a001000 0x000000000a001fff type1 ->
0x000000000a003000 0x000000000a003fff type1 ->
0x000000000a0010ff 0x000000000a004fff type2 <- merge

Or maybe I simply missed your point. Please let me know.

Thanks

Eric

> 
>>  		} else {
>>  			if (new->type == type) {
>>  				phys_addr_t new_start = min(a, start);
>>  				phys_addr_t new_end = max(b, end);
>> +				int ret;
>>  
>>  				list_del(&entry->list);
>>  				entry->start = new_start;
>>  				entry->length = new_end - new_start + 1;
>> -				iommu_insert_resv_region(entry, regions);
>> +				ret = iommu_insert_resv_region(entry, regions);
>> +				kfree(entry);
>> +				return ret;
>>  			} else {
>>  				pos = pos->next;
>>  			}
> 
> Same here.
> 
