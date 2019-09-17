Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B0DC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB9F214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfIQJ6U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:58:20 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:46802 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfIQJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:58:19 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x8H9vshM011512
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Sep 2019 18:57:54 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x8H9vsdV024649;
        Tue, 17 Sep 2019 18:57:54 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x8H9uoda001377;
        Tue, 17 Sep 2019 18:57:54 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-1171633; Tue, 17 Sep 2019 18:32:44 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0439.000; Tue,
 17 Sep 2019 18:32:44 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [RFC PATCH v2] mm: initialize struct pages reserved by
 ZONE_DEVICE driver.
Thread-Topic: [RFC PATCH v2] mm: initialize struct pages reserved by
 ZONE_DEVICE driver.
Thread-Index: AQHVZIp2xk1cU6nEkk+ez7kL5reVFKcdvuyAgAAVnwCAAAk8gIAEZuMAgAAgogCADDvdgIAATZsAgAAnMAA=
Date:   Tue, 17 Sep 2019 09:32:43 +0000
Message-ID: <3d27953a-88b8-5a7c-de3c-041f8b4436f6@vx.jp.nec.com>
References: <20190906081027.15477-1-t-fukasawa@vx.jp.nec.com>
 <b7732a55-4a10-2c1d-c2f5-ca38ee60964d@redhat.com>
 <e762ee45-43e3-975a-ad19-065f07d1440f@vx.jp.nec.com>
 <40a1ce2e-1384-b869-97d0-7195b5b47de0@redhat.com>
 <6a99e003-e1ab-b9e8-7b25-bc5605ab0eb2@vx.jp.nec.com>
 <e4e54258-e83b-cf0b-b66e-9874be6b5122@redhat.com>
 <31fd3c86-5852-1863-93bd-8df9da9f95b4@vx.jp.nec.com>
 <38e58d23-c20b-4e68-5f56-20bba2be2d6c@redhat.com>
In-Reply-To: <38e58d23-c20b-4e68-5f56-20bba2be2d6c@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <AD3069ADF1FE3147AE36DB50024CF9EB@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/17 16:13, David Hildenbrand wrote:
> On 17.09.19 04:34, Toshiki Fukasawa wrote:
>> On 2019/09/09 16:46, David Hildenbrand wrote:
>>> Let's take a step back here to understand the issues I am aware of. I
>>> think we should solve this for good now:
>>>
>>> A PFN walker takes a look at a random PFN at a random point in time. It
>>> finds a PFN with SECTION_MARKED_PRESENT && !SECTION_IS_ONLINE. The
>>> options are:
>>>
>>> 1. It is buddy memory (add_memory()) that has not been online yet. The
>>> memmap contains garbage. Don't access.
>>>
>>> 2. It is ZONE_DEVICE memory with a valid memmap. Access it.
>>>
>>> 3. It is ZONE_DEVICE memory with an invalid memmap, because the section
>>> is only partially present: E.g., device starts at offset 64MB within a
>>> section or the device ends at offset 64MB within a section. Don't access it.
>>
>> I don't agree with case #3. In the case, struct page area is not allocated on
>> ZONE_DEVICE, but is allocated on system memory. So I think we can access the
>> struct pages. What do you mean "invalid memmap"?
> No, that's not the case. There is no memory, especially not system
> memory. We only allow partially present sections (sub-section memory
> hotplug) for ZONE_DEVICE.

Let me clear my thoughts. If I read correctly, the struct pages for sections
(including partially present sections) on ZONE_DEVICE are allocated by
vmemmap_populate(). And all the struct pages except (altmap->base_pfn) to
(altmap->base_pfn + altmap->reserve) are initialized by memmap_init_zone()
and memmap_init_zone_device().

Do struct pages for partially present sections go through a different process?

Thanks,
Toshiki Fukasawa
> 
> invalid memmap == memmap was not initialized == struct pages contains
> garbage. There is a memmap, but accessing it (e.g., pfn_to_nid()) will
> trigger a BUG.
> 
