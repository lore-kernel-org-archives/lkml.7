Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B47C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2172184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfHSFj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:39:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:54028 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfHSFj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:39:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 22:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="378083046"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2019 22:39:53 -0700
Subject: Re: [RFC PATCH 08/15] drivers/acrn: add VM memory management for ACRN
 char device
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Li@osuosl.org, Fei <lei1.li@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-9-git-send-email-yakui.zhao@intel.com>
 <20190816124757.GW1974@kadam>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <8b909c22-3873-2b5d-4845-1fee1a5d81ce@intel.com>
Date:   Mon, 19 Aug 2019 13:32:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190816124757.GW1974@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月16日 20:58, Dan Carpenter wrote:
> On Fri, Aug 16, 2019 at 10:25:49AM +0800, Zhao Yakui wrote:
>> +int hugepage_map_guest(struct acrn_vm *vm, struct vm_memmap *memmap)
>> +{
>> +	struct page *page = NULL, *regions_buf_pg = NULL;
>> +	unsigned long len, guest_gpa, vma;
>> +	struct vm_memory_region *region_array;
>> +	struct set_regions *regions;
>> +	int max_size = PAGE_SIZE / sizeof(struct vm_memory_region);
>> +	int ret;
>> +
>> +	if (!vm || !memmap)
>> +		return -EINVAL;
>> +
>> +	len = memmap->len;
>> +	vma = memmap->vma_base;
>> +	guest_gpa = memmap->gpa;
>> +
>> +	/* prepare set_memory_regions info */
>> +	regions_buf_pg = alloc_page(GFP_KERNEL);
>> +	if (!regions_buf_pg)
>> +		return -ENOMEM;
>> +
>> +	regions = kzalloc(sizeof(*regions), GFP_KERNEL);
>> +	if (!regions) {
>> +		__free_page(regions_buf_pg);
>> +		return -ENOMEM;
> 
> It's better to do a goto err_free_regions_buf here.  More comments
> below.
> 
>> +	}
>> +	regions->mr_num = 0;
>> +	regions->vmid = vm->vmid;
>> +	regions->regions_gpa = page_to_phys(regions_buf_pg);
>> +	region_array = page_to_virt(regions_buf_pg);
>> +
>> +	while (len > 0) {
>> +		unsigned long vm0_gpa, pagesize;
>> +
>> +		ret = get_user_pages_fast(vma, 1, 1, &page);
>> +		if (unlikely(ret != 1) || (!page)) {
>> +			pr_err("failed to pin huge page!\n");
>> +			ret = -ENOMEM;
>> +			goto err;
> 
> goto err is a red flag.  It's better if error labels do one specific
> named thing like:
> 
> err_regions:
> 	kfree(regions);
> err_free_regions_buf:
> 	__free_page(regions_buf_pg);
> 
> We should unwind in the opposite/mirror order from how things were
> allocated.  Then we can remove the if statements in the error handling.

Thanks for the review.

Will follow your suggestion to unwind the error handling.

> 
> In this situation, say the user triggers an -EFAULT in
> get_user_pages_fast() in the second iteration through the loop.  That
> means that "page" is the non-NULL page from the previous iteration.  We
> have already added it to add_guest_map().  But now we're freeing it
> without removing it from the map so probably it leads to a use after
> free.
> 
> The best way to write the error handling in a loop like this is to
> clean up the partial iteration that has succeed (nothing here), and then
> unwind all the successful iterations at the bottom of the function.
> "goto unwind_loop;"
> 

In theory we should cleanup the previous success iteration if it 
encounters one error in the current iteration.
But it will be quite complex to cleanup up the previous iteration.
call the set_memory_regions for MR_DEL op.
call the remove_guest_map for the added hash item
call the put_page for returned page in get_user_pages_fast.

In fact as this driver is mainly used for embedded IOT usage, it doesn't 
handle the complex cleanup when such error is encountered. Instead the 
clean up is handled in free_guest_vm.

>> +		}
>> +
>> +		vm0_gpa = page_to_phys(page);
>> +		pagesize = PAGE_SIZE << compound_order(page);
>> +
>> +		ret = add_guest_map(vm, vm0_gpa, guest_gpa, pagesize);
>> +		if (ret < 0) {
>> +			pr_err("failed to add memseg for huge page!\n");
>> +			goto err;
> 
> So then here, it would be:
> 
> 			pr_err("failed to add memseg for huge page!\n");
> 			put_page(page);
> 			goto unwind_loop;
> 
> regards,
> dan carpenter
> 
>> +		}
>> +
>> +		/* fill each memory region into region_array */
>> +		region_array[regions->mr_num].type = MR_ADD;
>> +		region_array[regions->mr_num].gpa = guest_gpa;
>> +		region_array[regions->mr_num].vm0_gpa = vm0_gpa;
>> +		region_array[regions->mr_num].size = pagesize;
>> +		region_array[regions->mr_num].prot =
>> +				(MEM_TYPE_WB & MEM_TYPE_MASK) |
>> +				(memmap->prot & MEM_ACCESS_RIGHT_MASK);
>> +		regions->mr_num++;
>> +		if (regions->mr_num == max_size) {
>> +			pr_debug("region buffer full, set & renew regions!\n");
>> +			ret = set_memory_regions(regions);
>> +			if (ret < 0) {
>> +				pr_err("failed to set regions,ret=%d!\n", ret);
>> +				goto err;
>> +			}
>> +			regions->mr_num = 0;
>> +		}
>> +
>> +		len -= pagesize;
>> +		vma += pagesize;
>> +		guest_gpa += pagesize;
>> +	}
>> +
>> +	ret = set_memory_regions(regions);
>> +	if (ret < 0) {
>> +		pr_err("failed to set regions, ret=%d!\n", ret);
>> +		goto err;
>> +	}
>> +
>> +	__free_page(regions_buf_pg);
>> +	kfree(regions);
>> +
>> +	return 0;
>> +err:
>> +	if (regions_buf_pg)
>> +		__free_page(regions_buf_pg);
>> +	if (page)
>> +		put_page(page);
>> +	kfree(regions);
>> +	return ret;
>> +}
>> +
> 
