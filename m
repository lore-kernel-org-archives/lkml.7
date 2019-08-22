Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E981C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4753F21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfHVA3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:29:24 -0400
Received: from verein.lst.de ([213.95.11.211]:42095 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfHVA3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:29:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3BFCF68BFE; Thu, 22 Aug 2019 02:29:21 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:29:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH v4 4/4] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
Message-ID: <20190822002921.GC10391@lst.de>
References: <20190807075122.6247-1-benh@kernel.crashing.org> <20190807075122.6247-5-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807075122.6247-5-benh@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:51:22PM +1000, Benjamin Herrenschmidt wrote:
> Another issue with the Apple T2 based 2018 controllers seem to be
> that they blow up (and shut the machine down) if there's a tag
> collision between the IO queue and the Admin queue.
> 
> My suspicion is that they use our tags for their internal tracking
> and don't mix them with the queue id. They also seem to not like
> when tags go beyond the IO queue depth, ie 128 tags.
> 
> This adds a quirk that marks tags 0..31 of the IO queue reserved

What a mess.  But given how widely available the macbooks are supporting
them makes sense:

Reviewed-by: Christoph Hellwig <hch@lst.de>
