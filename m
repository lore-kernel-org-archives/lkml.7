Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BA3C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A4A206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbfHONu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:50:56 -0400
Received: from foss.arm.com ([217.140.110.172]:44456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732426AbfHONu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:50:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C6D344;
        Thu, 15 Aug 2019 06:50:56 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068C83F694;
        Thu, 15 Aug 2019 06:50:54 -0700 (PDT)
Subject: Re: DMA-API: cacheline tracking ENOMEM, dma-debug disabled due to
 nouveau ?
To:     Christoph Hellwig <hch@lst.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>, bskeggs@redhat.com,
        airlied@linux.ie, m.szyprowski@samsung.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20190814145033.GA11190@Red>
 <20190814174927.GT7444@phenom.ffwll.local> <20190815133554.GE12036@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cdb43f4b-55ff-80c3-8d27-56238b2ab1a1@arm.com>
Date:   Thu, 15 Aug 2019 14:50:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190815133554.GE12036@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2019 14:35, Christoph Hellwig wrote:
> On Wed, Aug 14, 2019 at 07:49:27PM +0200, Daniel Vetter wrote:
>> On Wed, Aug 14, 2019 at 04:50:33PM +0200, Corentin Labbe wrote:
>>> Hello
>>>
>>> Since lot of release (at least since 4.19), I hit the following error message:
>>> DMA-API: cacheline tracking ENOMEM, dma-debug disabled
>>>
>>> After hitting that, I try to check who is creating so many DMA mapping and see:
>>> cat /sys/kernel/debug/dma-api/dump | cut -d' ' -f2 | sort | uniq -c
>>>        6 ahci
>>>      257 e1000e
>>>        6 ehci-pci
>>>     5891 nouveau
>>>       24 uhci_hcd
>>>
>>> Does nouveau having this high number of DMA mapping is normal ?
>>
>> Yeah seems perfectly fine for a gpu.
> 
> That is a lot and apparently overwhelm the dma-debug tracking.  Robin
> rewrote this code in Linux 4.21 to work a little better, so I'm curious
> why this might have changes in 4.19, as dma-debug did not change at
> all there.

FWIW, the cacheline tracking entries are a separate thing from the 
dma-debug entries that I rejigged - judging by those numbers there 
should still be plenty of free dma-debug entries, but for some reason it 
has failed to extend the radix tree :/

Robin.
