Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06F7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE3F21897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfIRCnz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:43:55 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:57287 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIRCnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 22:43:55 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x8I2hZUN003725
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 Sep 2019 11:43:35 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x8I2hZOM024135;
        Wed, 18 Sep 2019 11:43:35 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x8I2h1PV029819;
        Wed, 18 Sep 2019 11:43:35 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-8629292; Wed, 18 Sep 2019 11:28:45 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Wed,
 18 Sep 2019 11:28:44 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     Waiman Long <longman@redhat.com>, Qian Cai <cai@lca.pw>,
        David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [RFC PATCH v2] mm: initialize struct pages reserved by
 ZONE_DEVICE driver.
Thread-Topic: [RFC PATCH v2] mm: initialize struct pages reserved by
 ZONE_DEVICE driver.
Thread-Index: AQHVZIp2xk1cU6nEkk+ez7kL5reVFKcdvuyAgAAVnwCAAAk8gIAEZuMAgAAgogCADDvdgIAATZsAgACQNwCAAAkNAIAAC/EAgACd24A=
Date:   Wed, 18 Sep 2019 02:28:44 +0000
Message-ID: <bc8719ed-3624-ad57-4c92-f1d1e1a43321@vx.jp.nec.com>
References: <20190906081027.15477-1-t-fukasawa@vx.jp.nec.com>
 <b7732a55-4a10-2c1d-c2f5-ca38ee60964d@redhat.com>
 <e762ee45-43e3-975a-ad19-065f07d1440f@vx.jp.nec.com>
 <40a1ce2e-1384-b869-97d0-7195b5b47de0@redhat.com>
 <6a99e003-e1ab-b9e8-7b25-bc5605ab0eb2@vx.jp.nec.com>
 <e4e54258-e83b-cf0b-b66e-9874be6b5122@redhat.com>
 <31fd3c86-5852-1863-93bd-8df9da9f95b4@vx.jp.nec.com>
 <38e58d23-c20b-4e68-5f56-20bba2be2d6c@redhat.com>
 <59c946f8-843d-c017-f342-d007a5e14a85@redhat.com>
 <1568737304.5576.162.camel@lca.pw>
 <bd6ea535-b228-8de0-1454-e512ccbfb4fa@redhat.com>
In-Reply-To: <bd6ea535-b228-8de0-1454-e512ccbfb4fa@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <89A9A5B4A12A6343BA851F1A768C718D@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/18 2:04, Waiman Long wrote:
> On 9/17/19 12:21 PM, Qian Cai wrote:
>> On Tue, 2019-09-17 at 11:49 -0400, Waiman Long wrote:
>>> On 9/17/19 3:13 AM, David Hildenbrand wrote:
>>>> On 17.09.19 04:34, Toshiki Fukasawa wrote:
>>>>> On 2019/09/09 16:46, David Hildenbrand wrote:
>>>>>> Let's take a step back here to understand the issues I am aware of. I
>>>>>> think we should solve this for good now:
>>>>>>
>>>>>> A PFN walker takes a look at a random PFN at a random point in time. It
>>>>>> finds a PFN with SECTION_MARKED_PRESENT && !SECTION_IS_ONLINE. The
>>>>>> options are:
>>>>>>
>>>>>> 1. It is buddy memory (add_memory()) that has not been online yet. The
>>>>>> memmap contains garbage. Don't access.
>>>>>>
>>>>>> 2. It is ZONE_DEVICE memory with a valid memmap. Access it.
>>>>>>
>>>>>> 3. It is ZONE_DEVICE memory with an invalid memmap, because the section
>>>>>> is only partially present: E.g., device starts at offset 64MB within a
>>>>>> section or the device ends at offset 64MB within a section. Don't access it.
>>>>> I don't agree with case #3. In the case, struct page area is not allocated on
>>>>> ZONE_DEVICE, but is allocated on system memory. So I think we can access the
>>>>> struct pages. What do you mean "invalid memmap"?
>>>> No, that's not the case. There is no memory, especially not system
>>>> memory. We only allow partially present sections (sub-section memory
>>>> hotplug) for ZONE_DEVICE.
>>>>
>>>> invalid memmap == memmap was not initialized == struct pages contains
>>>> garbage. There is a memmap, but accessing it (e.g., pfn_to_nid()) will
>>>> trigger a BUG.
>>>>
>>> As long as the page structures exist, they should be initialized to some
>>> known state. We could set PagePoison for those invalid memmap. It is the
>> Sounds like you want to run page_init_poison() by default.
> 
> Yes for those pages that are not initialized otherwise. I don't want to
> run page_init_poison() for the whole ZONE_DEVICE memory range as it can
> take a while if we are talking about TBs of persistent memory. Also most
> of the pages will be reinitialized anyway in the init process. So it is
> mostly a wasted effort. However, for those reserved pages that are not
> being exported to the memory management layer, having them initialized
> to a known state will cause less problem down the road.
> 
The same can be said about altmap->reserve. I think it should be initialized
since the struct page exists.

Thanks,
Toshiki Fukasawa
