Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F63C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F78217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfHBJYv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:24:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfHBJYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:24:50 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 019EAF6DE9A988D003C9;
        Fri,  2 Aug 2019 10:24:49 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.132]) by
 LHREML711-CAH.china.huawei.com ([10.201.108.34]) with mapi id 14.03.0415.000;
 Fri, 2 Aug 2019 10:24:44 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Eric Auger <eric.auger@redhat.com>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH v2] iommu: revisit iommu_insert_resv_region()
 implementation
Thread-Topic: [PATCH v2] iommu: revisit iommu_insert_resv_region()
 implementation
Thread-Index: AQHVSIIup689t4891UmSCB5f6rEStabnlaaA
Date:   Fri, 2 Aug 2019 09:24:43 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F340516@lhreml524-mbs.china.huawei.com>
References: <20190801155946.20645-1-eric.auger@redhat.com>
In-Reply-To: <20190801155946.20645-1-eric.auger@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: 01 August 2019 17:00
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; joro@8bytes.org;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> dwmw2@infradead.org; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; alex.williamson@redhat.com;
> robin.murphy@arm.com; hch@infradead.org
> Subject: [PATCH v2] iommu: revisit iommu_insert_resv_region()
> implementation
> 
> Current implementation is recursive and in case of allocation
> failure the existing @regions list is altered. A non recursive
> version looks better for maintainability and simplifies the
> error handling. We use a separate stack for overlapping segment
> merging. The elements are sorted by start address and then by
> type, if their start address match.
> 
> Note this new implementation may change the region order of
> appearance in /sys/kernel/iommu_groups/<n>/reserved_regions
> files but this order has never been documented, see
> commit bc7d12b91bd3 ("iommu: Implement reserved_regions
> iommu-group sysfs file").

I rerun this on D05 and seems to retain the order for msi type as before.

estuary:/$ cat /sys/kernel/iommu_groups/3/reserved_regions
0x0000000008000000 0x00000000080fffff msi
0x00000000c6010000 0x00000000c601ffff msi

FWIW,

Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Cheers,
Shameer

 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - adapt the algo so that we don't need to move elements of
>   other types to different list and sort by address and then by
>   type
> ---
>  drivers/iommu/iommu.c | 107 +++++++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0c674d80c37f..4257b179fa54 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -229,60 +229,71 @@ static ssize_t iommu_group_show_name(struct
> iommu_group *group, char *buf)
>   * @new: new region to insert
>   * @regions: list of regions
>   *
> - * The new element is sorted by address with respect to the other
> - * regions of the same type. In case it overlaps with another
> - * region of the same type, regions are merged. In case it
> - * overlaps with another region of different type, regions are
> - * not merged.
> + * Elements are sorted by start address and overlapping segments
> + * of the same type are merged.
>   */
> -static int iommu_insert_resv_region(struct iommu_resv_region *new,
> -				    struct list_head *regions)
> +int iommu_insert_resv_region(struct iommu_resv_region *new,
> +			     struct list_head *regions)
>  {
> -	struct iommu_resv_region *region;
> -	phys_addr_t start = new->start;
> -	phys_addr_t end = new->start + new->length - 1;
> -	struct list_head *pos = regions->next;
> +	struct iommu_resv_region *iter, *tmp, *nr, *top;
> +	struct list_head stack;
> +	bool added = false;
> 
> -	while (pos != regions) {
> -		struct iommu_resv_region *entry =
> -			list_entry(pos, struct iommu_resv_region, list);
> -		phys_addr_t a = entry->start;
> -		phys_addr_t b = entry->start + entry->length - 1;
> -		int type = entry->type;
> +	INIT_LIST_HEAD(&stack);
> 
> -		if (end < a) {
> -			goto insert;
> -		} else if (start > b) {
> -			pos = pos->next;
> -		} else if ((start >= a) && (end <= b)) {
> -			if (new->type == type)
> -				return 0;
> -			else
> -				pos = pos->next;
> -		} else {
> -			if (new->type == type) {
> -				phys_addr_t new_start = min(a, start);
> -				phys_addr_t new_end = max(b, end);
> -				int ret;
> -
> -				list_del(&entry->list);
> -				entry->start = new_start;
> -				entry->length = new_end - new_start + 1;
> -				ret = iommu_insert_resv_region(entry, regions);
> -				kfree(entry);
> -				return ret;
> -			} else {
> -				pos = pos->next;
> -			}
> -		}
> -	}
> -insert:
> -	region = iommu_alloc_resv_region(new->start, new->length,
> -					 new->prot, new->type);
> -	if (!region)
> +	nr = iommu_alloc_resv_region(new->start, new->length,
> +				     new->prot, new->type);
> +	if (!nr)
>  		return -ENOMEM;
> 
> -	list_add_tail(&region->list, pos);
> +	/* First add the new elt based on start address sorting */
> +	list_for_each_entry(iter, regions, list) {
> +		if (nr->start < iter->start) {
> +			list_add_tail(&nr->list, &iter->list);
> +			added = true;
> +			break;
> +		} else if (nr->start == iter->start && nr->type <= iter->type) {
> +			list_add_tail(&nr->list, &iter->list);
> +			added = true;
> +			break;
> +		}
> +	}
> +	if (!added)
> +		list_add_tail(&nr->list, regions);
> +
> +	/* Merge overlapping segments of type nr->type, if any */
> +	list_for_each_entry_safe(iter, tmp, regions, list) {
> +		phys_addr_t top_end, iter_end = iter->start + iter->length - 1;
> +		bool found = false;
> +
> +		/* no merge needed on elements of different types than @nr */
> +		if (iter->type != nr->type) {
> +			list_move_tail(&iter->list, &stack);
> +			continue;
> +		}
> +
> +		/* look for the last stack element of same type as @iter */
> +		list_for_each_entry_reverse(top, &stack, list)
> +			if (top->type == iter->type) {
> +				found = true;
> +				break;
> +			}
> +		if (!found) {
> +			list_move_tail(&iter->list, &stack);
> +			continue;
> +		}
> +
> +		top_end = top->start + top->length - 1;
> +
> +		if (iter->start > top_end + 1) {
> +			list_move_tail(&iter->list, &stack);
> +		} else {
> +			top->length = max(top_end, iter_end) - top->start + 1;
> +			list_del(&iter->list);
> +			kfree(iter);
> +		}
> +	}
> +	list_splice(&stack, regions);
>  	return 0;
>  }
> 
> --
> 2.20.1

