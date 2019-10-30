Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD60CA9ECB
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADD320856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfJ3WiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:38:21 -0400
Received: from verein.lst.de ([213.95.11.211]:48074 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfJ3WiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:38:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B09CA68B05; Wed, 30 Oct 2019 23:38:18 +0100 (CET)
Date:   Wed, 30 Oct 2019 23:38:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] net: sgi: ioc3-eth: don't abuse dma_direct_* calls
Message-ID: <20191030223818.GA23807@lst.de>
References: <20191030211233.30157-1-hch@lst.de> <20191030211233.30157-2-hch@lst.de> <20191030230549.ef9b99b5d36b0a818d904eee@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030230549.ef9b99b5d36b0a818d904eee@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:05:49PM +0100, Thomas Bogendoerfer wrote:
> On Wed, 30 Oct 2019 14:12:30 -0700
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > dma_direct_ is a low-level API that must never be used by drivers
> > directly.  Switch to use the proper DMA API instead.
> 
> is the 4kb/16kb alignment still guaranteed ? If not how is the way
> to get such an alignment ?

The DMA API gives you page aligned memory. dma_direct doesn't give you
any gurantees as it is an internal API explicitly documented as not
for driver usage that can change at any time.
