Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57E4C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909452171F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfGVPqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfGVPqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:46:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BC5F3082AF2;
        Mon, 22 Jul 2019 15:46:06 +0000 (UTC)
Received: from [10.36.116.45] (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6C3E5C21F;
        Mon, 22 Jul 2019 15:46:01 +0000 (UTC)
Subject: Re: [PATCH 1/2] dma-mapping: Protect dma_addressing_limited against
 NULL dma_mask
To:     Christoph Hellwig <hch@lst.de>
Cc:     eric.auger.pro@gmail.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190722145509.1284-1-eric.auger@redhat.com>
 <20190722145509.1284-2-eric.auger@redhat.com> <20190722152637.GA3780@lst.de>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <e1e02286-ccf9-3335-28c8-0c6b122b05a1@redhat.com>
Date:   Mon, 22 Jul 2019 17:46:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190722152637.GA3780@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 22 Jul 2019 15:46:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 7/22/19 5:26 PM, Christoph Hellwig wrote:
>>  static inline bool dma_addressing_limited(struct device *dev)
>>  {
>> -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
>> -		dma_get_required_mask(dev);
>> +	return WARN_ON_ONCE(!dev->dma_mask) ? false :
>> +		min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
>> +			dma_get_required_mask(dev);
> 
> This should really use a separate if statement, but I can fix that
> up when applying it.
> 
Just wondering why we don't use the dma_get_mask() accessor which
returns DMA_BIT_MASK(32) in case the dma_mask is not set.

Do you foresee any issue and would it still mandate to add dma_mask
checks on each call sites?

Thanks

Eric
