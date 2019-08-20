Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AEDC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB88720C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566299184;
	bh=zBcLo7GWdvo53ZL+qOqtR0PxkMh9A+yzuLf6IeQfgWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f7Y6DV5fqUzJXtPD3sCYQ6j0TlN+u8q5yAeVz8nmteNSQ0+2zxHnkYwViFnHyG4P6
	 mKm8QCRrMlqzwsWMqcwc4KJgERh/pr8/u8KOFAev+hGuQDbrKV7yVqdanHzCn9r9JG
	 lTmIOh+7WAYdIQ+bn98suO/Zqi1msFTUuPWP5CVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfHTLGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfHTLGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:06:23 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D8720C01;
        Tue, 20 Aug 2019 11:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566299182;
        bh=zBcLo7GWdvo53ZL+qOqtR0PxkMh9A+yzuLf6IeQfgWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vn4zeb13X6Id2TNzE5NpHZ9mBPZidwghpE4QL05SPMEilxDSOTDFS11uc6/MPCPVE
         yD/7atDqfthj1WUL8LciYesQcWmMUa2v2FOFCuUQlx8cDx/e9juk7JtVeHJnG2HNex
         +MdSEX1SM6t2ZYi/dECR2k9r0tU4E5OzprD5tqFE=
Date:   Tue, 20 Aug 2019 16:35:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Sameer Pujar <spujar@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dan.j.williams@intel.com, tiwai@suse.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, rlokhande@nvidia.com, dramesh@nvidia.com,
        mkumard@nvidia.com
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
Message-ID: <20190820110510.GQ12733@vkoul-mobl.Dlink>
References: <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
 <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
 <20190719050459.GM12733@vkoul-mobl.Dlink>
 <3e7f795d-56fb-6a71-b844-2fc2b85e099e@nvidia.com>
 <20190729061010.GC12733@vkoul-mobl.Dlink>
 <98954eb3-21f1-6008-f8e1-f9f9b82f87fb@nvidia.com>
 <20190731151610.GT12733@vkoul-mobl.Dlink>
 <c0f4de86-423a-35df-3744-40db89f2fdfe@nvidia.com>
 <20190808123833.GX12733@vkoul-mobl.Dlink>
 <a93a472d-b8f7-973f-6068-607492421472@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a93a472d-b8f7-973f-6068-607492421472@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-19, 16:56, Jon Hunter wrote:
> >>>>>>> On this, I am inclined to think that dma driver should not be involved.
> >>>>>>> The ADMAIF needs this configuration and we should take the path of
> >>>>>>> dma_router for this piece and add features like this to it
> >>>>>>
> >>>>>> Hi Vinod,
> >>>>>>
> >>>>>> The configuration is needed by both ADMA and ADMAIF. The size is
> >>>>>> configurable
> >>>>>> on ADMAIF side. ADMA needs to know this info and program accordingly.
> >>>>>
> >>>>> Well I would say client decides the settings for both DMA, DMAIF and
> >>>>> sets the peripheral accordingly as well, so client communicates the two
> >>>>> sets of info to two set of drivers
> >>>>
> >>>> That maybe, but I still don't see how the information is passed from the
> >>>> client in the first place. The current problem is that there is no means
> >>>> to pass both a max-burst size and fifo-size to the DMA driver from the
> >>>> client.
> >>>
> >>> So one thing not clear to me is why ADMA needs fifo-size, I thought it
> >>> was to program ADMAIF and if we have client programme the max-burst
> >>> size to ADMA and fifo-size to ADMAIF we wont need that. Can you please
> >>> confirm if my assumption is valid?
> >>
> >> Let me see if I can clarify ...
> >>
> >> 1. The FIFO we are discussing here resides in the ADMAIF module which is
> >>    a separate hardware block the ADMA (although the naming make this
> >>    unclear).
> >>
> >> 2. The size of FIFO in the ADMAIF is configurable and it this is
> >>    configured via the ADMAIF registers. This allows different channels
> >>    to use different FIFO sizes. Think of this as a shared memory that is
> >>    divided into n FIFOs shared between all channels.
> >>
> >> 3. The ADMA, not the ADMAIF, manages the flow to the FIFO and this is
> >>    because the ADMAIF only tells the ADMA when a word has been
> >>    read/written (depending on direction), the ADMAIF does not indicate
> >>    if the FIFO is full, empty, etc. Hence, the ADMA needs to know the
> >>    total FIFO size.
> >>
> >> So the ADMA needs to know the FIFO size so that it does not overrun the
> >> FIFO and we can also set a burst size (less than the total FIFO size)
> >> indicating how many words to transfer at a time. Hence, the two parameters.
> > 
> > Thanks, I confirm this is my understanding as well.
> > 
> > To compare to regular case for example SPI on DMA, SPI driver will
> > calculate fifo size & burst to be used and program dma (burst size) and
> > its own fifos accordingly
> > 
> > So, in your case why should the peripheral driver not calculate the fifo
> > size for both ADMA and ADMAIF and (if required it's own FIFO) and
> > program the two (ADMA and ADMAIF).
> > 
> > What is the limiting factor in this flow is not clear to me.
> 
> The FIFO size that is configured by the ADMAIF driver needs to be given
> to the ADMA driver so that it can program its registers accordingly. The
> difference here is that both the ADMA and ADMAIF need the FIFO size.

Can you please help describing what it is programming using the FIFO
size of ADMAIF?

Thanks
-- 
~Vinod
