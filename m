Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE698C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B006A20718
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfKSRmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:42:01 -0500
Received: from foss.arm.com ([217.140.110.172]:56044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfKSRmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:42:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A951FB;
        Tue, 19 Nov 2019 09:42:00 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D3FC3F703;
        Tue, 19 Nov 2019 09:41:59 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: generic DMA bypass flag
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20191113133731.20870-1-hch@lst.de>
 <d27b7b29-df78-4904-8002-b697da5cb013@arm.com>
 <20191114074105.GC26546@lst.de>
 <9c8f4d7b-43e0-a336-5d93-88aef8aae716@arm.com> <20191116062258.GA8913@lst.de>
Message-ID: <f2335431-8cd4-e1ab-013d-573d163f4067@arm.com>
Date:   Tue, 19 Nov 2019 17:41:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191116062258.GA8913@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2019 6:22 am, Christoph Hellwig wrote:
> On Fri, Nov 15, 2019 at 06:12:48PM +0000, Robin Murphy wrote:
>> And is that any different from where you would choose to "just" set a
>> generic bypass flag?
> 
> Same spots, as intel-iommu moves from the identify to a dma domain when
> setting a 32-bit mask.  But that means once a 32-bit mask is set we can't
> ever go back to the 64-bit one.

Is that a problem though? It's not safe in general to rewrite the 
default domain willy-nilly, so if it's a concern that drivers get stuck 
having to use a translation domain if they do something dumb like:

	if (!dma_set_mask(DMA_BIT_MASK(32))
		dma_set_mask(DMA_BIT_MASK(64));

then the simple solution is "don't do that" - note that this doesn't 
affect overriding of the default 32-bit mask, because we don't use the 
driver API to initialise those.

>  And we had a couple drivers playing
> interesting games there.

If the games you're worried about are stuff like:

	dma_set_mask(dev, DMA_BIT_MASK(64));
	high_buf = dma_alloc_coherent(dev, ...);
	dma_set_mask(dev, DMA_BIT_MASK(32));
	low_buf = dma_alloc_coherent(dev, ...);

then iommu_need_mapping() already ensures that will end spectacularly 
badly. Unless we can somehow log when a mask has been "committed" by a 
mapping operation, I don't think any kind of opportunistic bypass 
mechanism is ever not going to blow up that case.

>  FYI, this is the current intel-iommu
> WIP conversion to the dma bypass flag:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-bypass

Having thought a bit more, I guess my idea does end up with one slightly 
ugly corner wherein dma_direct_supported() has to learn to look for an 
IOMMU default domain and try iommu_dma_supported() before saying no, 
even if it's clean everywhere else. The bypass flag is more 'balanced' 
in terms of being equally invasive everywhere and preserving abstraction 
a bit better. Plus I think it might let us bring back the default 
assignment of dma_dummy_ops, which I do like the thought of :D

Either way, making sure that the fundamental bypass decision is correct 
and robust is still far more important than the implementation details.

Robin.
