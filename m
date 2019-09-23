Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31EFC432C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91FA2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="qHvBeoux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502961AbfIWVOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:14:19 -0400
Received: from smtp.duncanthrax.net ([89.31.1.170]:53045 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbfIWVOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
        bh=AJ5ol9v2EUTwQAPB9vizOTA+wIdU/2p6jWo8NCnDe1M=; b=qHvBeouxVOpX8crobvcGXT+VAi
        vLG2HGdFnhu0yt0r6HeHkyPRogj8Iw6I3Wevgv8s0fv3ZPQ8mp7RAB5Igd8D7tE1fNqO4cklacvLC
        uufSNccTJg3xSBL3gunMb8DAKIligAvWQ6NSaWFzi9+lu+jeQZxdYeS8iTNz9rWAnbA8=;
Received: from [2001:470:70c5:1111:5054:ff:febf:83e1] (helo=stackframe.org)
        by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <svens@stackframe.org>)
        id 1iCVey-0000HQ-Sr; Mon, 23 Sep 2019 23:14:16 +0200
Date:   Mon, 23 Sep 2019 23:14:15 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: allow larger than require DMA masks
Message-ID: <20190923211415.GA1875@stackframe.org>
References: <20190215144559.8777-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190215144559.8777-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 15, 2019 at 03:45:54PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series finishes off converting our dma mask model to split between
> device capabilities (dev->dma_mask and dev->coherent_dma_mask) and system
> limitations (dev->bus_dma_mask).  We already accept larger than required
> masks in most dma_map_ops implementation, in case of x86 and
> implementations based on it since the dawn of time.  Only one parisc
> and two sparc64 instances failed larger than required DMA masks, and
> this series fixes that up and updates the documentation that devices
> don't need to handle DMA mask fallbacks.
>

I just tried latest linux-5.4 git on my hp c8000 (parisc), and got the following
error:

[   27.246866] sata_sil24 0000:00:01.0: Applying completion IRQ loss on PCI-X errata fix
[   27.336968] sata_sil24 0000:00:01.0: DMA enable failed
[   27.476922] sata_sil24: probe of 0000:00:01.0 failed with error -5

This is caused by commit dcc02c19cc06bd7bc1b6db0aa0087a2b6eb05b94:
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Aug 26 12:57:24 2019 +0200

    sata_sil24: use dma_set_mask_and_coherent

    Use the dma_set_mask_and_coherent helper to set the DMA mask. Rely
    on the relatively recent change that setting a larger than required
    mask will never fail to avoid the need for the boilerplate 32-bit
    fallback code.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

However, the real problem seems to be in sba_dma_supported():

»       /* Documentation/DMA-API-HOWTO.txt tells drivers to try 64-bit
»        * first, then fall back to 32-bit if that fails.
»        * We are just "encouraging" 32-bit DMA masks here since we can
»        * never allow IOMMU bypass unless we add special support for ZX1.
»        */
	if (mask > ~0U)
»     »       return 0;

Removing the if() makes the DMA mapping work. It's almost midnight here,
so i won't look into that any further today. Does anyone have an opinion
on this behaviour? Otherwise i will look a bit more into this in the
next days.

Regards
Sven
