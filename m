Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD7DC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C481F22C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OrB98rUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfGYSTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:19:10 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16404 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGYSTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:19:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d39f2a50000>; Thu, 25 Jul 2019 11:19:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 11:19:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 25 Jul 2019 11:19:09 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jul
 2019 18:19:08 +0000
Subject: Re: [PATCH v3 1/3] mm: document zone device struct page field usage
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190724232700.23327-1-rcampbell@nvidia.com>
 <20190724232700.23327-2-rcampbell@nvidia.com> <20190725053821.GA24527@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <8acce6b0-7e84-9dc6-9268-eaf0e814d994@nvidia.com>
Date:   Thu, 25 Jul 2019 11:19:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190725053821.GA24527@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564078757; bh=Qao2t1CrfNdMKoMvCh94dTKdtpC+EI45d5wLIIGgET0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OrB98rUKTadk/d8iIGA0ZOIqqnVmAn2Gd/fFnuSL26pd/r5Tax28SSiAFMrnrbU+D
         SInaELtAsdLvh1iYAAkif/sblYyfYzv3b9qGdoSGaZtsLotIAi/jJoglZpjOHgjsi1
         Yn51vJ4bQCcYhCTwfcnYmvTNgvpkQOXXM8nWn+wuYBisyfzkxHWVL+79VJum4Mj5Pf
         w3GDnLSrvzxCgFScHswqu3fju9uqDWp9eZW4sqcsystYZL0gCfffYhsaaDPtEdGcCJ
         kWJq0QuG2fd9qi5LuW+Pa2TavLm2wnyDUWnB4mFBBnEFSdaKiSwy51ELb249H9GSRf
         +KQD6RUNBkkoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/24/19 10:38 PM, Christoph Hellwig wrote:
> On Wed, Jul 24, 2019 at 04:26:58PM -0700, Ralph Campbell wrote:
>> Struct page for ZONE_DEVICE private pages uses the page->mapping and
>> and page->index fields while the source anonymous pages are migrated to
>> device private memory. This is so rmap_walk() can find the page when
>> migrating the ZONE_DEVICE private page back to system memory.
>> ZONE_DEVICE pmem backed fsdax pages also use the page->mapping and
>> page->index fields when files are mapped into a process address space.
>>
>> Add comments to struct page and remove the unused "_zd_pad_1" field
>> to make this more clear.
> 
> I still think we should also fix up the layout, and I haven't seen
> a reply from Matthew justifying his curses for your patch that makes
> the struct page layout actually match how it is used.
> 

Well, I can kind of see this both ways since ZONE_DEVICE
MEMORY_DEVICE_DEVDAX and MEMORY_DEVICE_PCI_P2PDMA don't
seem to use the 3 words like MEMORY_DEVICE_PRIVATE and
MEMORY_DEVICE_FS_DAX.

I like v3 because not all of the ZONE_DEVICE types are handled
the same in regards to using the 3 words and there may be future
ZONE_DEVICE types that use the 3 words differently which might
require a union.

I agree, I would like to hear from Matthew on his thoughts.
