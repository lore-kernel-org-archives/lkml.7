Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8BAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EC420872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="RbgKb2UY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfIJIhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:37:25 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:60792 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfIJIhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:37:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 67BB13F63C;
        Tue, 10 Sep 2019 10:37:20 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=RbgKb2UY;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7X0L3ZDda6NP; Tue, 10 Sep 2019 10:37:19 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 8976F3F5F5;
        Tue, 10 Sep 2019 10:37:18 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id BF7C1360195;
        Tue, 10 Sep 2019 10:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568104635; bh=Exy62JteIIiFDqg9sDFhMjGz8fW5liamcWBqhMgS7H4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RbgKb2UYsm52plgagsbzNnxLaOFs/XpgtVEtv3poLUqni6TZimS9f1juiS4q34dsf
         CdfdckLJrfqwlxGT52303uayAfk70Lh6kDC39W+CuA2pxVcZpl+9/Dk20Dm/ePcP65
         5so/uC8HxRDvD7xziLyXIwl0jW/n4o0/AJx3uOsM=
Subject: Re: dma_mmap_fault discussion
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
 <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <20190905152438.GA18286@infradead.org>
 <cbbb0e95-8df1-9ab8-59ad-81bd7f3933fa@shipmail.org>
 <20190906063203.GA25415@infradead.org>
 <fcb71585-7fae-c6a0-81f0-1aa632ea621b@shipmail.org>
 <20190906072037.GA29459@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <611166e3-bb9a-d42c-fb98-18846dfefb8f@shipmail.org>
Date:   Tue, 10 Sep 2019 10:37:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190906072037.GA29459@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/19 9:20 AM, Christoph Hellwig wrote:
> On Fri, Sep 06, 2019 at 09:10:08AM +0200, Thomas Hellström (VMware) wrote:
>> It's definitely possible. I was just wondering whether it was necessary, but
>> it seems like it.
> Yepp.
>
> I've pushed a new version out (even hotter off the press) that doesn't
> require the region for dma_mmap_prepare, and also uses PAGE_SIZE units
> for the offset / length in dma_mmap_fault, which simplifies a few
> things.

Hi, Christoph,

I've been looking into this a bit, and while it's possible to make it 
work for fault, (and for single page kmaps of course, since we have the 
kernel virtual address already), I run into problems with vmaps, since 
we basically need to vmap a set of consecutive coherent allocations 
obtained from the coherent pool.

Also, at mmap time, we need in theory to call dma_mmap_prepare() and 
save the page_prot for all attrs we might be using at fault time...

I did some thinking into whether we could perhaps cover all or at least 
the vast majority of architectures and awkward devices more generally 
with a  page prot and a set of pfns. So I looked at how 
remap_pfn_range() and io_remap_pfn_range() was implemented across 
architectures, and it turns out that all archs implementing a special 
io_remap_pfn_range() (sparc and mips) end up calling remap_pfn_range(), 
and that should mean that any arch that's currently capable of doing 
fault() should in principle be capable of using vmf_insert_pfn_prot() 
with a suitable pfn that in most (if not all) cases should be obtainable 
from the kernel virtual address.

So do you think a way forward could perhaps be to have a 
dma_common_get_pfn_sgtable() and add a generic vmap_pfn_prot()?

Thanks,

Thomas





