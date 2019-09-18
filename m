Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DCDC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54B021907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfIRN0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:26:15 -0400
Received: from verein.lst.de ([213.95.11.211]:33305 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfIRN0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:26:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4020868B05; Wed, 18 Sep 2019 15:26:11 +0200 (CEST)
Date:   Wed, 18 Sep 2019 15:26:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Baldyga, Robert" <robert.baldyga@intel.com>,
        Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rakowski, Michal" <michal.rakowski@intel.com>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
Message-ID: <20190918132611.GA16232@lst.de>
References: <20190913111610.9958-1-robert.baldyga@intel.com> <20190913143709.GA8525@lst.de> <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com> <20190916073455.GA25515@lst.de> <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com> <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 10:39:09AM -0600, Keith Busch wrote:
> On Mon, Sep 16, 2019 at 12:13:24PM +0000, Baldyga, Robert wrote:
> > Ok, fair enough. We want to keep things hidden behind certain layers,
> > and that's definitely a good thing. But there is a problem with these
> > layers - they do not expose all the features. For example AFAIK there
> > is no clear way to use 512+8 format via block layer (nor even a way 
> > to get know that bdev is formatted to particular lbaf). It's impossible
> > to use it without layering violations, which nobody sees as a perfect
> > solution, but it is the only one that works.
> 
> I think your quickest path to supporting such a format is to consider
> each part separately, then bounce and interleave/unmix the data +
> metadata at another layer that understands how the data needs to be laid
> out in host memory. Something like this RFC here:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2018-February/015844.html
> 
> It appears connecting to infradead lists is a bit flaky at the moment,
> so not sure if you'll be able to read the above link right now.
> 
> Anyway, the RFC would have needed a bit of work to be considered, like
> using a mempool for the purpose, but it does generically make such
> formats usable through the block stack so maybe try flushing out that
> idea.

Even if we had a use case for that the bounce buffer is just too ugly
to live.  And I'm really sick and tired of Intel wasting our time for
their out of tree monster given that they haven't even tried helping
to improve the in-kernel write caching layers.
