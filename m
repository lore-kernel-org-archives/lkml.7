Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF237C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C696D20659
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rI6tcfKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391402AbfGYRuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:50:04 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7666 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387988AbfGYRuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:50:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d39ebc90001>; Thu, 25 Jul 2019 10:50:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 10:50:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 10:50:03 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jul
 2019 17:49:59 +0000
Subject: Re: [PATCH v3 1/3] mm: document zone device struct page field usage
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Christoph Lameter" <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190724232700.23327-1-rcampbell@nvidia.com>
 <20190724232700.23327-2-rcampbell@nvidia.com>
 <20190725012225.GB32003@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <131f7c2d-704e-6f58-a330-e62d2ef5539e@nvidia.com>
Date:   Thu, 25 Jul 2019 10:49:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190725012225.GB32003@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564077001; bh=oG7iW18JoTbi7qpLIpRxo4HqaxvkInQKbpTpVVtqeEU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rI6tcfKjR1LQ254m/IBmbYjmdPRO+O414xxVE9H4xpU4Cf8g4LrW5czg2J7R/E9UK
         IuCJmkMOGHg5UbU9py+N6/OsZqu0i3kxRiq72lxvyBAr4R/SRk3Ph9b4cPcj0+1LeQ
         HcTMy4xeIFVIAR/fE4ZXX5aJEY1rtnMNaOKBxofLLtl/zXXuVCCDs4bXhLpGBDLgQt
         jjmro4lglHz8GYKuKJiGVMABgSpyow5/WGddYIcOrx8yIJ0mqOfTMoW7AvMdQppRqc
         XVh3RCs98U6YxWpnWEHvzQGz1G2j+AT6dv7iCO4T/AZ4bzZCYxC97uD7qOLtgfVRr8
         Xb1mVLma/E6qQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/24/19 6:22 PM, Jason Gunthorpe wrote:
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
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Christoph Lameter <cl@linux.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Pekka Enberg <penberg@kernel.org>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>   include/linux/mm_types.h | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> Ralph, you marked some of thes patches as mm/hmm, but I feel it is
> best if Andrew takes them through the normal -mm path.
>=20
> They don't touch hmm.c or mmu notifiers so I don't forsee conflicts,
> and I don't feel comfortable to review this code.
>=20
> Regards,
> Jason
>=20

Fine with me. I should have been clear in the cover letter which
tree to target.
