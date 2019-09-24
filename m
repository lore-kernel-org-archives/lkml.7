Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F2FC4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3532146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cmN5Vtc7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ozI6fWgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503705AbfIXBAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:00:00 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55368 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503497AbfIXA77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:59:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F43B8EE175;
        Mon, 23 Sep 2019 17:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569286799;
        bh=PMEg8ieV56yiI9Zsc7N2G24OJU6ZZnC2v4ENnREABOE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cmN5Vtc7t+RR2IluXJ036tHvzf+G5W2bBnDCVxOoZub7O1syGDdSMSgeSdkCG32w4
         p+4HIA7CY6w5MFkqWkBpXkKUxs2MUEAENMNZz/ZKPmgk3nT87aUFCUWWYJ5XKEIR0S
         zbDkMxW4QSLWCdrulTXFuLRitdX2N5zFd5RLZBYQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B0eV4ZDqEney; Mon, 23 Sep 2019 17:59:55 -0700 (PDT)
Received: from [172.19.130.119] (unknown [8.46.76.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 759C28EE02B;
        Mon, 23 Sep 2019 17:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569286794;
        bh=PMEg8ieV56yiI9Zsc7N2G24OJU6ZZnC2v4ENnREABOE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ozI6fWgxMgG6Z1epxX+PIvJT6RIFYI0DyVT24F6P579fPsAe5K2BL7XYZpeWKvHfT
         tGT6BURQ1PDv2CX3SA2A3SwSLu+3xxvMYlGfa77D35c2PCTkJkGVTpK1ab9nKJVfv2
         +c22yfTVmBxRQ6fpkYp5t6b/DQaTLyP1b++ajWFs=
Message-ID: <1569286782.3657.29.camel@HansenPartnership.com>
Subject: Re: allow larger than require DMA masks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sven Schnelle <svens@stackframe.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 Sep 2019 20:59:42 -0400
In-Reply-To: <20190923211415.GA1875@stackframe.org>
References: <20190215144559.8777-1-hch@lst.de>
         <20190923211415.GA1875@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-23 at 23:14 +0200, Sven Schnelle wrote:
> Hi,
> 
> On Fri, Feb 15, 2019 at 03:45:54PM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series finishes off converting our dma mask model to split
> > between device capabilities (dev->dma_mask and dev-
> > >coherent_dma_mask) and system limitations (dev->bus_dma_mask).  We 
> > already accept larger than required masks in most dma_map_ops
> > implementation, in case of x86 and implementations based on it
> > since the dawn of time.  Only one parisc and two sparc64 instances
> > failed larger than required DMA masks, and this series fixes that
> > up and updates the documentation that devices don't need to handle
> > DMA mask fallbacks.
> > 
> 
> I just tried latest linux-5.4 git on my hp c8000 (parisc), and got
> the following
> error:
> 
> [   27.246866] sata_sil24 0000:00:01.0: Applying completion IRQ loss
> on PCI-X errata fix
> [   27.336968] sata_sil24 0000:00:01.0: DMA enable failed
> [   27.476922] sata_sil24: probe of 0000:00:01.0 failed with error -5
> 
> This is caused by commit dcc02c19cc06bd7bc1b6db0aa0087a2b6eb05b94:
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Aug 26 12:57:24 2019 +0200
> 
>     sata_sil24: use dma_set_mask_and_coherent
> 
>     Use the dma_set_mask_and_coherent helper to set the DMA mask.
> Rely
>     on the relatively recent change that setting a larger than
> required
>     mask will never fail to avoid the need for the boilerplate 32-bit
>     fallback code.
> 
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> However, the real problem seems to be in sba_dma_supported():
> 
> »       /* Documentation/DMA-API-HOWTO.txt tells drivers to try 
> »        * first, then fall back to 32-bit if that fails.
> »        * We are just "encouraging" 32-bit DMA masks here since we
> can
> »        * never allow IOMMU bypass unless we add special support for
> ZX1.
> »        */
> 	if (mask > ~0U)
> »     »       return 0;
> 
> Removing the if() makes the DMA mapping work. It's almost midnight
> here, so i won't look into that any further today. Does anyone have
> an opinion on this behaviour? Otherwise i will look a bit more into
> this in the next days.

The reason for the if was to kick the device into 32 bit descriptors,
which are usually more efficient, especially with older dual descriptor
format cards like we have on parisc systems.

Nothing should go wrong if we don't fail the larger mask request except
that the card uses the inefficient descriptors whereas we'll only
supply it with 32 bit addresses.

James

