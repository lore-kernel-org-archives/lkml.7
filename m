Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973F7C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCC5206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eE4pqTBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfHPVKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:10:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19894 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:10:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d571be40000>; Fri, 16 Aug 2019 14:11:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 14:10:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 14:10:48 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 21:10:48 +0000
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
 <20190815194339.GC9253@redhat.com>
 <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com>
 <20190815203306.GB25517@redhat.com> <20190815204128.GI22970@mellanox.com>
 <CAPcyv4j_Mxbw+T+yXTMdkrMoS_uxg+TXXgTM_EPBJ8XfXKxytA@mail.gmail.com>
 <20190816004053.GB9929@mellanox.com>
 <CAPcyv4gMPVmY59aQAT64jQf9qXrACKOuV=DfVs4sNySCXJhkdA@mail.gmail.com>
 <20190816122414.GC5412@mellanox.com>
 <CAPcyv4jgHF05gdRoOFZORqeOBE9Z7PhagsSD+LVnjH2dc3mrFg@mail.gmail.com>
 <20190816172846.GJ5398@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <c679d6b2-e7f6-3980-6905-94d48bfb056d@nvidia.com>
Date:   Fri, 16 Aug 2019 14:10:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190816172846.GJ5398@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565989860; bh=PJd/tDuHjDQeAiJVFqvLpPZ32U3ebbqcCpFuKHXBESc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eE4pqTBhvF6Jo8/onIHf7UdJEMa+f38IaiV8IGyr6VH7sjC6/U7NDUidvZNZrPxGi
         IWqO/9fzHXHdrzVt8mWRqyLtMRcwigQV5w8yH7jqzlnp/q4jIk+1eFwNzlZBsNe1NB
         oPhq4ZrJ8F3y8HabI5/23apg9QjOZvNlVAY4CtZWixb7IRHsZJPoCiKvJXP/lQxFz2
         wdzux9+eXoGrD7TafNg4FaiE1QOgPnlD97QPQs0F0HaZzmUKDI4WRI9CpmvKshvUrP
         ddi04plRaD3gWIBjv3Ah3JRRCsNodqPudA276IOtp9tVqGFsfBROvB1prYQhrsbnah
         NYPaeCyBQzF8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/16/19 10:28 AM, Jason Gunthorpe wrote:
> On Fri, Aug 16, 2019 at 10:21:41AM -0700, Dan Williams wrote:
> 
>>> We can do a get_dev_pagemap inside the page_walk and touch the pgmap,
>>> or we can do the 'device mutex && retry' pattern and touch the pgmap
>>> in the driver, under that lock.
>>>
>>> However in all cases the current get_dev_pagemap()'s in the page walk
>>> are not necessary, and we can delete them.
>>
>> Yes, as long as 'struct page' instances resulting from that lookup are
>> not passed outside of that lock.
> 
> Indeed.
> 
> Also, I was reflecting over lunch that the hmm_range_fault should only
> return DEVICE_PRIVATE pages for the caller's device (see other thread
> with HCH), and in this case, the caller should also be responsible to
> ensure that the driver is not calling hmm_range_fault at the same time
> it is deleting it's own DEVICE_PRIVATE mapping - ie by fencing its
> page fault handler.

Yes, that would make it a one step process to access another
device's migrated memory pages.
Right now, it has to be a two step process where the caller calls
hmm_range_fault, check the struct page to see if it is device
private and not owned, then call hmm_range_fault again with
range->pfns[i] |= range->flags[HMM_PFN_DEVICE_PRIVATE] to cause
the other device to migrate the page back to system memory.
