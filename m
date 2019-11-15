Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31FAC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B8E20730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKOSMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:12:51 -0500
Received: from foss.arm.com ([217.140.110.172]:34782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfKOSMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:12:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D89830E;
        Fri, 15 Nov 2019 10:12:50 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B52B93F534;
        Fri, 15 Nov 2019 10:12:49 -0800 (PST)
Subject: Re: generic DMA bypass flag
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20191113133731.20870-1-hch@lst.de>
 <d27b7b29-df78-4904-8002-b697da5cb013@arm.com>
 <20191114074105.GC26546@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9c8f4d7b-43e0-a336-5d93-88aef8aae716@arm.com>
Date:   Fri, 15 Nov 2019 18:12:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114074105.GC26546@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2019 7:41 am, Christoph Hellwig wrote:
> On Wed, Nov 13, 2019 at 02:45:15PM +0000, Robin Murphy wrote:
>> In all honesty, this seems silly. If we can set a per-device flag to say
>> "oh, bypass these ops and use some other ops instead", then we can just as
>> easily simply give the device the appropriate ops in the first place.
>> Because, y'know, the name of the game is "per-device ops".
> 
> Except that we can't do it _that_ easily.  The problem is that for both
> the powerpc and intel case the selection is dynamic.  If a device is in
> the identify domain with intel-iommu (or the equivalent on powerpc which
> doesn't use the normal iommu framework), we still want to use the iommu
> to be able to map memory for devices with a too small dma mask using
> the iommu instead of using swiotlb bouncing.  So to "just" use the
> per-device dma ops we'd need:
> 
>    a) a hook in dma_direct_supported to pick another set of ops for
>       small dma masks
>    b) a hook in the IOMMU ops to propagate to the direct ops for full
>       64-bit masks

And is that any different from where you would choose to "just" set a 
generic bypass flag?


diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d658c7c6a2ab..40e096d3dbc5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2242,12 +2242,14 @@ request_default_domain_for_dev(struct device 
*dev, unsigned long type)
  /* Request that a device is direct mapped by the IOMMU */
  int iommu_request_dm_for_dev(struct device *dev)
  {
+	set_dma_ops(dev, NULL);
  	return request_default_domain_for_dev(dev, IOMMU_DOMAIN_IDENTITY);
  }

  /* Request that a device can't be direct mapped by the IOMMU */
  int iommu_request_dma_domain_for_dev(struct device *dev)
  {
+	set_dma_ops(dev, &iommu_dma_ops);
  	return request_default_domain_for_dev(dev, IOMMU_DOMAIN_DMA);
  }


If intel-iommu gets fully converted such that everyone using default 
domains is also using iommu-dma, that should be it as far as the generic 
DMA ops are concerned (ultimately we might even be able to do it in 
__iommu_attach_device() based on the domain type). Like I said, the hard 
part is deciding when to make *these* calls, but apparently intel-iommu 
can already do that.

> I looked into that for powerpc a while ago and it wasn't pretty at all.
> Compared to that just checking another flag for the DMA direct calls
> is relatively clean and trivial as seens in the diffstat for this series
> alone.
> 
>> I don't see a great benefit to pulling legacy cruft out into common code
>> instead of just working to get rid of it in-place, when said cruft pulls in
>> the opposite direction to where we're taking the common code (i.e. it's
>> inherently based on the premise of global ops).
> 
> I'm not sure what legacy cruft it pull in.  I think it actually fits very
> much into a mental model of "direct mapping is the default, to be overriden
> if needed" which is pretty close to what we have at the moment.  Just
> with a slightly more complicated processing of the override.

Because the specific "slightly more complicated" currently used by the 
existing powerpc code will AFAICS continue to be needed only by the 
existing powerpc code, thus I don't see any benefit to cluttering up the 
common code with it today. You may as well just refactor powerpc to 
swizzle its own ops to obviate archdata.iommu_bypass, and delete a fair 
chunk of old code.

Robin.
