Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2CBC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D41121848
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfIPHe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 03:34:59 -0400
Received: from verein.lst.de ([213.95.11.211]:42833 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfIPHe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:34:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BCB0C68B05; Mon, 16 Sep 2019 09:34:55 +0200 (CEST)
Date:   Mon, 16 Sep 2019 09:34:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Baldyga, Robert" <robert.baldyga@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rakowski, Michal" <michal.rakowski@intel.com>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
Message-ID: <20190916073455.GA25515@lst.de>
References: <20190913111610.9958-1-robert.baldyga@intel.com> <20190913143709.GA8525@lst.de> <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 07:16:52AM +0000, Baldyga, Robert wrote:
> On Fri, Sep 13, 2019 at 04:37:09PM +0200, Christoph Hellwig wrote:
> > On Fri, Sep 13, 2019 at 01:16:08PM +0200, Robert Baldyga wrote:
> > > Hello,
> > > 
> > > This patchset adds two functions providing kernel to kernel API 
> > > for submiting NVMe admin commands. This is for use of NVMe-aware
> > > block device drivers stacking on top of NVMe drives. An example of
> > > such driver is Open CAS Linux [1] which uses NVMe extended LBA 
> > > formats and thus needs to issue commands like nvme_admin_identify.
> > 
> > We never add functionality for out of tree crap.  And this shit really
> > is a bunch of crap, so it is unlikely to ever be merged. 
> 
> So that modules which are by design out of tree have to hack around
> lack of API allowing to use functionality implemented by driver.
> Don't you think that this is what actually produces crap?

Because you added another badly designed caching layer instead of fixing
up one of the 2 to 3 (depending on how you count) in the kernel tree.
And yours is amazingly bad even compared to the not very nice one in the
tree.  It basically spends more efforts on abstracting away abstraction
that you wouldn't need without another layer of abstractions.  And it
does all that pointlessly tied to NVMe through a bunch of layering
violations.

> 
> > Why can't intel sometimes actually do something useful for a change
> > instead of piling junk over junk?
> 
> Proposed API is equally useful for both in tree and out of tree modules,
> so I find your comment unrelated.

It is not.  We will not let random kernel modules directly issue nvme
admin command as there is no reason for it.  And even if for some weird
reason we did we'd certainly not do it for out of tree modules.

> If you don't like the way it's done, we can look for alternatives.
> The point is to allow other drivers use NVMe admin commands, which is
> currently not possible as neither the block layer nor the nvme driver
> provides sufficient API.

And the answer is that we are not going to allow that.  And we'd not
allow other things even if they were not a bad design for out of tree
modules.
