Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75ECC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAD921849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CV5RjjFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfGQRu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:50:26 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12191 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfGQRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:50:26 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2f5fdf0000>; Wed, 17 Jul 2019 10:50:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 17 Jul 2019 10:50:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 17 Jul 2019 10:50:25 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 17 Jul
 2019 17:50:21 +0000
Subject: Re: [PATCH 1/3] mm: document zone device struct page reserved fields
To:     Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
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
References: <20190717001446.12351-1-rcampbell@nvidia.com>
 <20190717001446.12351-2-rcampbell@nvidia.com>
 <26a47482-c736-22c4-c21b-eb5f82186363@nvidia.com>
 <20190717042233.GA4529@lst.de>
 <ae3936eb-2c08-c4a4-f670-10f25c7e0ed8@nvidia.com>
 <20190717043824.GA4755@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <4295112b-e5ff-f9ad-defc-597ad3bc49a1@nvidia.com>
Date:   Wed, 17 Jul 2019 10:50:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717043824.GA4755@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563385823; bh=SWBqWTLtRGRFAUZCgh3lTPUjJRJ6jQ100pAZoV0UM5g=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CV5RjjFYrtxJBPx50YvgVwuu37aXkSWSWDX7gZc9Perx7pREk/ltNltuoF01N12nF
         fbcGNahPv9Pu7cj2VWx7kgYouKXYLs74/GvanmWlQgzAEpDd+r92oWoAmxifsQSOjY
         IZCfGm6yu8dITo783GAtU7Q+sH2EPk3XJuBReBiHhao9nODGOnDHYbAxPp59+502lb
         1vSZkgb7BwefFsx24B8sNYTUZW17BtBCGEjl7ecTuX83NvLUYsDv8AWDDqHZBPf1J2
         lV2g4EFQ6YMntYjOwT54R0Kw2q3EvgtT+HYCrx1u69MVIzVv+IMtetkOAJZcos5+bY
         UxIthrioLOHeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/16/19 9:38 PM, Christoph Hellwig wrote:
> On Tue, Jul 16, 2019 at 09:31:33PM -0700, John Hubbard wrote:
>> OK, so just delete all the _zd_pad_* fields? Works for me. It's misleading to
>> calling something padding, if it's actually unavailable because it's used
>> in the other union, so deleting would be even better than commenting.
>>
>> In that case, it would still be nice to have this new snippet, right?:
> 
> I hope willy can chime in a bit on his thoughts about how the union in
> struct page should look like.  The padding at the end of the sub-structs
> certainly looks pointless, and other places don't use it either.  But if
> we are using the other fields it almost seems to me like we only want to
> union the lru field in the first sub-struct instead of overlaying most
> of it.
>

I like this approach.
I'll work on an updated patch that makes "struct list_head lru" part
of a union with the ZONE_DEVICE struct without the padding and update
the comments and change log.

I will also wait a day or two for others to add their comments.
