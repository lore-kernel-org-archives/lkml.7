Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC8C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A39218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HTBAoz1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbfGWVZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:25:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11035 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfGWVZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:25:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d377b5a0000>; Tue, 23 Jul 2019 14:25:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Jul 2019 14:25:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Jul 2019 14:25:49 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jul
 2019 21:25:44 +0000
Subject: Re: [PATCH v2 1/3] mm: document zone device struct page field usage
To:     Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190719192955.30462-1-rcampbell@nvidia.com>
 <20190719192955.30462-2-rcampbell@nvidia.com>
 <20190721160204.GB363@bombadil.infradead.org>
 <20190722051345.GB6157@iweiny-DESK2.sc.intel.com>
 <20190722110825.GD363@bombadil.infradead.org>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <80dbf7fc-5c13-f43f-7b87-8273126562e9@nvidia.com>
Date:   Tue, 23 Jul 2019 14:25:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190722110825.GD363@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563917146; bh=ScttwGqLrhEb0twi6RY7tFc+yqiFYp5H9qvTzCFtqzA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HTBAoz1a35vMm9dEfCZ9ucGpRtfWn50k5XdHWQVnukyE3m4YsOS4KQVKIsztIfDG9
         Jr0YpCMG6BmNA6okSTPpFptOsHIM0sypKIueyTnOAfpztK5966N2vMbYPQmDP4B/Y7
         nM8KL1CHebF5U+sP0Ndew6xc0qN4osk2ZJYTr2Ag/Igr6KRGSfW5rniAruh3Y2bbV5
         0UxiCI+wk73K5fjrq9UsYu+brV/O+JnzOO6nCO2lRcCAyYpfjvNrXVVWHOjhoNc0jA
         tgK7zRpvNHjr24v+oVtRKra2bSx28Xtg/4UpRVPaLqu+X/p0Tjb0chqcVlzoG6WqNC
         GYZ89VE/Dp4sA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/19 4:08 AM, Matthew Wilcox wrote:
> On Sun, Jul 21, 2019 at 10:13:45PM -0700, Ira Weiny wrote:
>> On Sun, Jul 21, 2019 at 09:02:04AM -0700, Matthew Wilcox wrote:
>>> On Fri, Jul 19, 2019 at 12:29:53PM -0700, Ralph Campbell wrote:
>>>> Struct page for ZONE_DEVICE private pages uses the page->mapping and
>>>> and page->index fields while the source anonymous pages are migrated to
>>>> device private memory. This is so rmap_walk() can find the page when
>>>> migrating the ZONE_DEVICE private page back to system memory.
>>>> ZONE_DEVICE pmem backed fsdax pages also use the page->mapping and
>>>> page->index fields when files are mapped into a process address space.
>>>>
>>>> Restructure struct page and add comments to make this more clear.
>>>
>>> NAK.  I just got rid of this kind of foolishness from struct page,
>>> and you're making it harder to understand, not easier.  The comments
>>> could be improved, but don't lay it out like this again.
>>
>> Was V1 of Ralphs patch ok?  It seemed ok to me.
> 
> Yes, v1 was fine.  This seems like a regression.
> 

This is about what people find "easiest to understand" and so
I'm not surprised that opinions differ.
What if I post a v3 based on v1 but remove the _zd_pad_* variables
that Christoph found misleading and add some more comments
about how the different ZONE_DEVICE types use the 3 remaining
words (basically the comment from v2)?
