Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BAAC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADFC21721
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfGPJdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:33:04 -0400
Received: from verein.lst.de ([213.95.11.211]:40185 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfGPJdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:33:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3360468B05; Tue, 16 Jul 2019 11:33:02 +0200 (CEST)
Date:   Tue, 16 Jul 2019 11:33:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH 2/3] nvme: Retrieve the required IO queue entry size
 from the controller
Message-ID: <20190716093301.GA32562@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org> <20190716004649.17799-2-benh@kernel.crashing.org> <20190716060430.GB29414@lst.de> <ad18ff8d004225e102076f8e1fb617916617f337.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad18ff8d004225e102076f8e1fb617916617f337.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 04:21:14PM +1000, Benjamin Herrenschmidt wrote:
> > Actually, this doesn't work on a "real" nvme controller, to change CC
> > values the controller needs to be disabled.
> 
> Not really. The specs says that MPS, AMD and CSS need to be set before
> enabling, but IOCQES and IOSQES can be modified later as long as there
> is no IO queue created yet.

I guess that is true based on the spec.

> This is necessary otherwise there's a chicken and egg problem. You need
> the admin queue to do the controller id in order to get the sizes and
> for that you need the controller to be enabled.
> 
> Note: This is not a huge issue anyway since I only update the register
> if the required size isn't 6 which is probably never going to be the
> case on non-Apple HW.

Yes, but the whole point of making you go down the route is so that
we can share the code with eventual real nvme controllers that can
support a larger SQE size.

> >   So back to the version
> > you circulated to me in private mail that just sets q->sqes and has a
> > comment that this is magic for The Apple controller.  If/when we get
> > standardized large SQE support we'll need to discover that earlier or
> > do a disable/enable dance.  Sorry for misleading you down this road and
> > creating the extra work.  
> 
> I think it's still ok, let me know...

Ok, let's go with this series then unless the other maintainers have
objections.

I'm still not sure if we want to queue this up for 5.3 (new hardware
enablement) or wait a bit, though.
