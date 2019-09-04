Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4B3C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060BA23400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfIDGGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:06:07 -0400
Received: from verein.lst.de ([213.95.11.211]:36258 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfIDGGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:06:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D026227A8D; Wed,  4 Sep 2019 08:05:59 +0200 (CEST)
Date:   Wed, 4 Sep 2019 08:05:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904060558.GA10849@lst.de>
References: <20190831000139.7662-1-logang@deltatee.com> <20190831152910.GA29439@localhost.localdomain> <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com> <20190903164620.GA20847@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903164620.GA20847@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:46:20AM -0600, Keith Busch wrote:
> Could we possibly make /dev/nvmeX be a subsystem handle without causing
> trouble for anyone? This would essentially be the same thing as today
> for non-CMIC controllers with a device-per-controller and only affects
> the CMIC ones.

A per-subsyste character device doesn't make sense, as a lot of admin
command require a specific controller.

If this really is an isue for people we'll just need to refcount the
handle allocation.  That is:

 - nvme_init_ctrl allocates a new nvme_instance or so object, which
   does the ida_simple_get.
 - we allocate a new subsystem that reuses the handle and grabs
   a reference in nvme_init_subsystem, then if we find an existing
   subsystem we drop that reference again.
 - last free of a ctrl or subsystem also drops a reference, with
   the final free releasing the ida
