Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E0DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCDD217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfEVNZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:25:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51378 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbfEVNZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26F9615AB;
        Wed, 22 May 2019 06:25:46 -0700 (PDT)
Received: from [10.1.26.184] (unknown [10.1.26.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA7E43F73F;
        Wed, 22 May 2019 06:25:44 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20190522072018.10660-1-horia.geanta@nxp.com>
 <20190522123243.GA26390@lst.de>
 <6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
 <20190522130921.GA26874@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fdfd7318-7999-1fe6-01b6-ae1fb7ba8c30@arm.com>
Date:   Wed, 22 May 2019 14:25:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522130921.GA26874@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-22 2:09 pm, Christoph Hellwig wrote:
> On Wed, May 22, 2019 at 01:50:47PM +0100, Robin Murphy wrote:
>> Would that work out any different from the existing DMA_ATTR_SKIP_CPU_SYNC?
>>
>> If drivers are prepared to handle this issue from their end, they can
>> already do so for single mappings by using that attr along with explicit
>> partial syncs via dma_sync_single(). For page/sg mappings we'd still have
>> the problem of identifying what part of "partial" actually matters, and
>> probably having to add some additional new sync operations to cope.
> 
> Except that the same optimization we are tripping over here is also
> present in dma_sync_* - dma_sync_*_to_device with DMA_FROM_DEVICE is a
> no-op in swiotlb.

Sure, but that should be irrelevant since the effective problem here is 
in the sync_*_for_cpu direction, and it's the unmap which nobbles the 
buffer. If the driver does this:

	dma_map_single(whole buffer);
	<device writes to part of buffer>
	dma_unmap_single(whole buffer);
	<contents of rest of buffer now undefined>

then it could instead do this and be happy:

	dma_map_single(whole buffer, SKIP_CPU_SYNC);
	<device writes to part of buffer>
	dma_sync_single_for_cpu(updated part of buffer);
	dma_unmap_single(whole buffer, SKIP_CPU_SYNC);
	<contents of rest of buffer still valid>

Robin.
