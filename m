Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76666C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DF4206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1V4l2rJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfDZPhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:37:48 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45652 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfDZPhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UvVB9YW+Vf/5xEb1JhQ4wi6DLqMa8+rWR925tLl65eQ=; b=1V4l2rJNC2XkmV+VPpYk6e05n1
        yhh4hA0pIi1FbejNCY/aQODoLBKLKb/ghS6x1aPtipzeL3xTxF4PBWq0RSCGhoTl178rMUBG/3tCO
        nqv8I5Rr18wzSZ9q08e0MM3B0aoKA5nY5sFt/QWC5HX6uTxmIuF3BaBLaTxQkMYagiN8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK2uv-000221-1a; Fri, 26 Apr 2019 17:37:37 +0200
Date:   Fri, 26 Apr 2019 17:37:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Esben Haabendal <esben@geanix.com>, netdev@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Yang Wei <yang.wei9@zte.com.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/12] net: ll_temac: Fix iommu/swiotlb leak
Message-ID: <20190426153737.GC4041@lunn.ch>
References: <20190426073231.4008-1-esben@geanix.com>
 <20190426073231.4008-9-esben@geanix.com>
 <20190426142103.GI14432@lunn.ch>
 <0aab6152-82c6-b53f-6b9b-0905995de43a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aab6152-82c6-b53f-6b9b-0905995de43a@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 03:43:20PM +0100, Robin Murphy wrote:
> On 26/04/2019 15:21, Andrew Lunn wrote:
> >On Fri, Apr 26, 2019 at 09:32:27AM +0200, Esben Haabendal wrote:
> >>Unmap the actual buffer length, not the amount of data received.
> >
> >Hi Esben
> >
> >The patch Subject does not seem to match the content?
> >
> >Also, there can be performance advantages of just unmapping the
> >received length. The unmap operation does a cache invalidate, which
> >can be expensive. Consider the effort of unmapping a 64 byte ACK vs 9K
> >jumbo frame?
> 
> If the size passed to dma_unmap_*() is not the same as was passed to the
> corresponding dma_map_*(), that is fundamentally incorrect use of the API
> and may lead to warnings, resource exhaustion, or possibly even corruption
> and crashes for some DMA API implementations.
> 
> If there's a case where you just need to look at a small part of the buffer
> right now, but can unmap the whole thing properly later. then
> dma_sync_single_*() does allow operating on partial buffers. Even better, if
> you're able to recycle buffers in your Rx pool you could potentially replace
> the unmap/map dance altogether with some careful use of sync_single.

Hi Robin

Thanks for the info.

I went back to the driver i was thinking of, and it is using
dma_sync_single_range_for_cpu() for just the received packet length.

Sorry for the mixup.

      Andrew
