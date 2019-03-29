Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3947C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB93218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfC2Ipt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:45:49 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:29686 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729096AbfC2Ips (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:45:48 -0400
Received: by suse.de (Postfix, from userid 1000)
        id A0F54473E; Fri, 29 Mar 2019 09:45:47 +0100 (CET)
Date:   Fri, 29 Mar 2019 09:45:47 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm,memory_hotplug: allocate memmap from hotadded
 memory
Message-ID: <20190329084547.5k37xjwvkgffwajo@d104.suse.de>
References: <20190328134320.13232-1-osalvador@suse.de>
 <cc68ec6d-3ad2-a998-73dc-cb90f3563899@redhat.com>
 <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb08377-ca5d-4110-d7ae-04a0d61ac294@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:31:44PM +0100, David Hildenbrand wrote:
> Correct me if I am wrong. I think I was confused - vmemmap data is still
> allocated *per memory block*, not for the whole added memory, correct?

No, vmemap data is allocated per memory-resource added.
In case a DIMM, would be a DIMM, in case a qemu memory-device, would be that
memory-device.
That is counting that ACPI does not split the DIMM/memory-device in several memory
resources.
If that happens, then acpi_memory_enable_device() calls __add_memory for every
memory-resource, which means that the vmemmap data will be allocated per
memory-resource.
I did not see this happening though, and I am not sure under which circumstances
can happen (I have to study the ACPI code a bit more).

The problem with allocating vmemmap data per memblock, is the fragmentation.
Let us say you do the following:

* memblock granularity 128M

(qemu) object_add memory-backend-ram,id=ram0,size=256M
(qemu) device_add pc-dimm,id=dimm0,memdev=ram0,node=1

This will create two memblocks (2 sections), and if we allocate the vmemmap
data for each corresponding section within it section(memblock), you only get
126M contiguous memory.

So, the taken approach is to allocate the vmemmap data corresponging to the
whole DIMM/memory-device/memory-resource from the beginning of its memory.

In the example from above, the vmemmap data for both sections is allocated from
the beginning of the first section:

memmap array takes 2MB per section, so 512 pfns.
If we add 2 sections:

[  pfn#0  ]  \
[  ...    ]  |  vmemmap used for memmap array
[pfn#1023 ]  /  

[pfn#1024 ]  \
[  ...    ]  |  used as normal memory
[pfn#65536]  /

So, out of 256M, we get 252M to use as a real memory, as 4M will be used for
building the memmap array.

Actually, it can happen that depending on how big a DIMM/memory-device is,
the first/s memblock is fully used for the memmap array (of course, this
can only be seen when adding a huge DIMM/memory-device).

-- 
Oscar Salvador
SUSE L3
