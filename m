Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAF2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C4920825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfIEQLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:11:39 -0400
Received: from verein.lst.de ([213.95.11.211]:50003 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfIEQLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:11:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B01668B05; Thu,  5 Sep 2019 18:11:35 +0200 (CEST)
Date:   Thu, 5 Sep 2019 18:11:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme: Restore device naming sanity
Message-ID: <20190905161134.GA22363@lst.de>
References: <20190904173159.22921-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904173159.22921-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 11:31:59AM -0600, Keith Busch wrote:
> The namespace names must be unique for the lifetime of the subsystem.
> This was accomplished by using their parent subsystems' instances which
> was independent of the controllers connected to that subsystem.
> 
> The consequence of that naming scheme meant that name prefixes given to
> namespaces may match a controller from an unrelated subsystem. This has
> understandbly invited confusion when examining device nodes.
> 
> Ensure the namespace's subsystem instance never clashes with a
> controller instance of another subsystem by transferring the instance
> ownership to parent subsystem from the first controller discovered in
> that subsystem.

Sanitity sounds a little exaggerated.  The nvme naming isn't really
that different except that the block devices uses number where say
scsi uses letters.  So maybe tone down that claim a bit, but otherwise
the patch looks fine.
