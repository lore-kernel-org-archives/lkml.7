Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF0C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F136A2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfHENwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:52:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:18172 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbfHENwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:52:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 06:51:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="178854881"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2019 06:51:38 -0700
Date:   Mon, 5 Aug 2019 07:49:07 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
Message-ID: <20190805134907.GC18647@localhost.localdomain>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
 <20190730153044.GA13948@localhost.localdomain>
 <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
 <6290507e1b2830b1729fc858cd5c20b85d092728.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6290507e1b2830b1729fc858cd5c20b85d092728.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 04:49:23PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2019-07-30 at 13:28 -0700, Benjamin Herrenschmidt wrote:
> > > One problem is that we've an nvme parameter, io_queue_depth, that a user
> > > could set to something less than 32, and then you won't be able to do
> > > any IO. I'd recommend enforce the admin queue to QD1 for this device so
> > > that you have more potential IO tags.
> > 
> > So I had a look and it's not that trivial. I would have to change
> > a few things that use constants for the admin queue depth, such as
> > the AEN tag etc...
> > 
> > For such a special case, I am tempted instead to do the much simpler:
> > 
> >         if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS) {
> >                 if (dev->q_depth < (NVME_AQ_DEPTH + 2))
> >                         dev->q_depth = NVME_AQ_DEPTH + 2;
> >         }
> > 
> > In nvme_pci_enable() next to the existing q_depth hackery for other
> > controllers.
> > 
> > Thoughts ?
> 
> Ping ? I had another look today and I don't feel like mucking around
> with all the AQ size logic, AEN magic tag etc... just for that sake of
> that Apple gunk. I'm happy to have it give up IO tags, it doesn't seem
> to make much of a difference in practice anyway.
> 
> But if you feel strongly about it, then I'll implement the "proper" way
> sometimes this week, adding a way to shrink the AQ down to something
> like 3 (one admin request, one async event (AEN), and the empty slot)
> by making a bunch of the constants involved variables instead.

I don't feel too strongly about it. I think your patch is fine, so

Acked-by: Keith Busch <keith.busch@intel.com>
