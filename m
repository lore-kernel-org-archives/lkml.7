Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00369C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07EC208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfG3U3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:29:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:45202 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbfG3U3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:29:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6UKSwii027076;
        Tue, 30 Jul 2019 15:28:58 -0500
Message-ID: <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Date:   Tue, 30 Jul 2019 13:28:57 -0700
In-Reply-To: <20190730153044.GA13948@localhost.localdomain>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
         <20190730153044.GA13948@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 09:30 -0600, Keith Busch wrote:
> On Fri, Jul 19, 2019 at 03:31:02PM +1000, Benjamin Herrenschmidt wrote:
> > From 8dcba2ef5b1466b023b88b4eca463b30de78d9eb Mon Sep 17 00:00:00 2001
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Date: Fri, 19 Jul 2019 15:03:06 +1000
> > Subject: 
> > 
> > Another issue with the Apple T2 based 2018 controllers seem to be
> > that they blow up (and shut the machine down) if there's a tag
> > collision between the IO queue and the Admin queue.
> > 
> > My suspicion is that they use our tags for their internal tracking
> > and don't mix them with the queue id. They also seem to not like
> > when tags go beyond the IO queue depth, ie 128 tags.
> > 
> > This adds a quirk that marks tags 0..31 of the IO queue reserved
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> 
> One problem is that we've an nvme parameter, io_queue_depth, that a user
> could set to something less than 32, and then you won't be able to do
> any IO. I'd recommend enforce the admin queue to QD1 for this device so
> that you have more potential IO tags.

So I had a look and it's not that trivial. I would have to change
a few things that use constants for the admin queue depth, such as
the AEN tag etc...

For such a special case, I am tempted instead to do the much simpler:

	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS) {
		if (dev->q_depth < (NVME_AQ_DEPTH + 2))
			dev->q_depth = NVME_AQ_DEPTH + 2;
	}

In nvme_pci_enable() next to the existing q_depth hackery for other
controllers.

Thoughts ?

Cheers,
Ben.


