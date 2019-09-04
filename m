Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516CAC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C1722CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfIDPmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:42:20 -0400
Received: from verein.lst.de ([213.95.11.211]:40375 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfIDPmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:42:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 08E65227A8A; Wed,  4 Sep 2019 17:42:16 +0200 (CEST)
Date:   Wed, 4 Sep 2019 17:42:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904154215.GA20422@lst.de>
References: <20190831000139.7662-1-logang@deltatee.com> <20190831152910.GA29439@localhost.localdomain> <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com> <20190903164620.GA20847@localhost.localdomain> <20190904060558.GA10849@lst.de> <20190904144426.GB21302@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904144426.GB21302@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:44:27AM -0600, Keith Busch wrote:
> Let me step through an example:
> 
>   Ctrl A gets instance 0.
> 
>   Its subsystem gets the same instance, and takes ref count on it:
>   all namespaces in this subsystem will use '0'.
> 
>   Ctrl B gets instance 1, and it's in the same subsystem as Ctrl A so
>   no new subsytem is allocated.
> 
>   Ctrl A is disconnected, dropping its ref on instance 0, but the
>   subsystem still has its refcount, making it unavailable.
> 
>   Ctrl A is reconnected, and allocates instance 2 because 0 is still in
>   use.
> 
> Now all the namespaces in this subsystem are prefixed with nvme0, but no
> controller exists with the same prefix. We still have inevitable naming
> mismatch, right?

I think th major confusion was that we can use the same handle for
and unrelated subsystem vs controller, and that would avoid it.

I don't see how we can avoid the controller is entirely different
from namespace problem ever.
