Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85057CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206D020578
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="my0RNJHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfKDGiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:38:51 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:40732 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfKDGiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:38:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 5640F41AFC;
        Mon,  4 Nov 2019 07:38:47 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=my0RNJHJ;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pK6rnnTSfQBb; Mon,  4 Nov 2019 07:38:46 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id B34E641AFA;
        Mon,  4 Nov 2019 07:38:45 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id F237236012A;
        Mon,  4 Nov 2019 07:38:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1572849525; bh=ydDZUZ35VQE4vWMXu02FIV1ozT0iHAO9SLQ7IoS/ubY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=my0RNJHJsk6/dLj4EG+CvrhDf/re4in48FYJE2/MIvfNMztiDK5Bvr145799JT+it
         yVeZi+1zBWDJBd6IO3gbJ26E8YOHB/Xbh7hBXNCgoG+JwI4KffkGWPxF6EdAA/kVbS
         H4UgawSszoGdpMvTXIoJ3phEzwNdYqxeFGUUM1hs=
Subject: Re: dma coherent memory user-space maps
To:     Christoph Hellwig <hch@infradead.org>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <b811f66d-2353-23c6-c9fa-e279cdb0f832@shipmail.org>
 <20191031215415.GA9809@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <7d5f8ec3-41a2-2ceb-aaa1-0bf3aa03d9a1@shipmail.org>
Date:   Mon, 4 Nov 2019 07:38:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191031215415.GA9809@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Crhistoph,

On 10/31/19 10:54 PM, Christoph Hellwig wrote:
> Hi Thomas,
>
> sorry for the delay.  I've been travelling way to much laterly and had
> a hard time keeping up.
>
> On Tue, Oct 08, 2019 at 02:34:17PM +0200, Thomas Hellström (VMware) wrote:
>> /* Obtain struct dma_pfn pointers from a dma coherent allocation */
>> int dma_get_dpfns(struct device *dev, void *cpu_addr, dma_addr_t dma_addr,
>>            pgoff_t offset, pgoff_t num, dma_pfn_t dpfns[]);
>>
>> I figure, for most if not all architectures we could use an ordinary pfn as
>> dma_pfn_t, but the dma layer would still have control over how those pfns
>> are obtained and how they are used in the kernel's mapping APIs.
>>
>> If so, I could start looking at this, time permitting,  for the cases where
>> the pfn can be obtained from the kernel address or from
>> arch_dma_coherent_to_pfn(), and also the needed work to have a tailored
>> vmap_pfn().
> I'm not sure that infrastructure is all that helpful unfortunately, even
> if it ended up working.  The problem with the 'coherent' DMA mappings
> is that we they have a few different backends.  For architectures that
> are DMA coherent everything is easy and we use the normal page
> allocator, and your above is trivially doable as wrappers around the
> existing functionality.  Other remap ptes to be uncached, either
> in-place or using vmap, and the remaining ones use weird special
> allocators for which almost everything we can mormally do in the VM
> will fail.

Hmm, yes I was hoping one could hide that behind the dma_pfn_t and the 
interface, so that non-trivial backends would be able to define the 
dma_pfn_t as needed and also if needed have their own special 
implementation of the interface functions. The interface was spec'ed 
from the user's (TTM) point of view assuming that with a page-prot and 
an opaque dma_pfn_t we'd be able to support most non-trivial backends, 
but that's perhaps not the case?

>
> I promised Christian an uncached DMA allocator a while ago, and still
> haven't finished that either unfortunately.  But based on looking at
> the x86 pageattr code I'm now firmly down the road of using the
> set_memory_* helpers that change the pte attributes in place, as
> everything else can't actually work on x86 which doesn't allow
> aliasing of PTEs with different caching attributes.  The arm64 folks
> also would prefer in-place remapping even if they don't support it
> yet, and that is something the i915 code already does in a somewhat
> hacky way, and something the msm drm driver wants.  So I decided to
> come up with an API that gives back 'coherent' pages on the
> architectures that support it and otherwise just fail.
>
> Do you care about architectures other than x86 and arm64?  If not I'll
> hopefully have something for you soon.

For VMware we only care about x86 and arm64, but i think Christian needs 
to fill in here.

Thanks,

Thomas



