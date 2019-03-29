Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183D1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAB32173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866967;
	bh=w3sRlgzv+egbWX4gWGBtnhARudPy0d1LEW3qaTB/GOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JpxpTxpROZavTj+zyf1et4OLCU42cu78rm4lCuH520vRTzZVu97Vd7xqbW1P+u/1L
	 lQGBcIDZLXC3z/qD5NZzghhnIvEgT5timNnA3LDwcQq+m+T22RR9t5ZkhqUCWiaXrr
	 ob9kCMRtrLWQnC+Txnh9jSpxnHXgwd78f7WQlDCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfC2Nmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:42:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:60992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729483AbfC2Nmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:42:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8E5CB00F;
        Fri, 29 Mar 2019 13:42:44 +0000 (UTC)
Date:   Fri, 29 Mar 2019 14:42:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190329134243.GA30026@dhcp22.suse.cz>
References: <20190328134320.13232-1-osalvador@suse.de>
 <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
 <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
 <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-03-19 09:45:47, Oscar Salvador wrote:
[...]
> * memblock granularity 128M
> 
> (qemu) object_add memory-backend-ram,id=ram0,size=256M
> (qemu) device_add pc-dimm,id=dimm0,memdev=ram0,node=1
> 
> This will create two memblocks (2 sections), and if we allocate the vmemmap
> data for each corresponding section within it section(memblock), you only get
> 126M contiguous memory.
> 
> So, the taken approach is to allocate the vmemmap data corresponging to the
> whole DIMM/memory-device/memory-resource from the beginning of its memory.
> 
> In the example from above, the vmemmap data for both sections is allocated from
> the beginning of the first section:
> 
> memmap array takes 2MB per section, so 512 pfns.
> If we add 2 sections:
> 
> [  pfn#0  ]  \
> [  ...    ]  |  vmemmap used for memmap array
> [pfn#1023 ]  /  
> 
> [pfn#1024 ]  \
> [  ...    ]  |  used as normal memory
> [pfn#65536]  /
> 
> So, out of 256M, we get 252M to use as a real memory, as 4M will be used for
> building the memmap array.

Having a larger contiguous area is definitely nice to have but you also
have to consider the other side of the thing. If we have a movable
memblock with unmovable memory then we are breaking the movable
property. So there should be some flexibility for caller to tell whether
to allocate on per device or per memblock. Or we need something to move
memmaps during the hotremove.
-- 
Michal Hocko
SUSE Labs
