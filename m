Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BEFC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E664F20678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgAGKzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:55:02 -0500
Received: from verein.lst.de ([213.95.11.211]:43807 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgAGKzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:55:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE1FD68AFE; Tue,  7 Jan 2020 11:54:58 +0100 (CET)
Date:   Tue, 7 Jan 2020 11:54:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc] dma-mapping: preallocate unencrypted DMA atomic pool
Message-ID: <20200107105458.GA3139@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <3213a6ac-5aad-62bc-bf95-fae8ba088b9e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3213a6ac-5aad-62bc-bf95-fae8ba088b9e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 05:34:00PM +0000, Robin Murphy wrote:
> On 01/01/2020 1:54 am, David Rientjes via iommu wrote:
>> Christoph, Thomas, is something like this (without the diagnosic
>> information included in this patch) acceptable for these allocations?
>> Adding expansion support when the pool is half depleted wouldn't be *that*
>> hard.
>>
>> Or are there alternatives we should consider?  Thanks!
>
> Are there any platforms which require both non-cacheable remapping *and* 
> unencrypted remapping for distinct subsets of devices?
>
> If not (and I'm assuming there aren't, because otherwise this patch is 
> incomplete in covering only 2 of the 3 possible combinations), then 
> couldn't we keep things simpler by just attributing both properties to the 
> single "atomic pool" on the basis that one or the other will always be a 
> no-op? In other words, basically just tweaking the existing "!coherent" 
> tests to "!coherent || force_dma_unencrypted()" and doing 
> set_dma_unencrypted() unconditionally in atomic_pool_init().

I think that would make most sense.
