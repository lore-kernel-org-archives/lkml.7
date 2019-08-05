Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6519C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D672086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfHEGtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:49:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:39127 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfHEGto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:49:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x756nNRm017042;
        Mon, 5 Aug 2019 01:49:24 -0500
Message-ID: <6290507e1b2830b1729fc858cd5c20b85d092728.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Date:   Mon, 05 Aug 2019 16:49:23 +1000
In-Reply-To: <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
         <20190730153044.GA13948@localhost.localdomain>
         <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 13:28 -0700, Benjamin Herrenschmidt wrote:
> > One problem is that we've an nvme parameter, io_queue_depth, that a user
> > could set to something less than 32, and then you won't be able to do
> > any IO. I'd recommend enforce the admin queue to QD1 for this device so
> > that you have more potential IO tags.
> 
> So I had a look and it's not that trivial. I would have to change
> a few things that use constants for the admin queue depth, such as
> the AEN tag etc...
> 
> For such a special case, I am tempted instead to do the much simpler:
> 
>         if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS) {
>                 if (dev->q_depth < (NVME_AQ_DEPTH + 2))
>                         dev->q_depth = NVME_AQ_DEPTH + 2;
>         }
> 
> In nvme_pci_enable() next to the existing q_depth hackery for other
> controllers.
> 
> Thoughts ?

Ping ? I had another look today and I don't feel like mucking around
with all the AQ size logic, AEN magic tag etc... just for that sake of
that Apple gunk. I'm happy to have it give up IO tags, it doesn't seem
to make much of a difference in practice anyway.

But if you feel strongly about it, then I'll implement the "proper" way
sometimes this week, adding a way to shrink the AQ down to something
like 3 (one admin request, one async event (AEN), and the empty slot)
by making a bunch of the constants involved variables instead.

This leas to a question: Wouldn't be be nicer/cleaner to make AEN be
tag 0 of the AQ ? That way we just include it as reserved tag ? Not a
huge different from what we do now, just a thought.

Cheers,
Ben.


