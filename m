Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB05C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18F320644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfFYKNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:13:23 -0400
Received: from verein.lst.de ([213.95.11.211]:33445 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfFYKNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:13:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 04CA768B05; Tue, 25 Jun 2019 12:12:51 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:12:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs: remove XFS_TRANS_NOFS
Message-ID: <20190625101250.GJ1462@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-7-hch@lst.de> <20190624225904.GB7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624225904.GB7777@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 08:59:04AM +1000, Dave Chinner wrote:
> On Mon, Jun 24, 2019 at 07:52:47AM +0200, Christoph Hellwig wrote:
> > Instead of a magic flag for xfs_trans_alloc, just ensure all callers
> > that can't relclaim through the file system use memalloc_nofs_save to
> > set the per-task nofs flag.
> 
> I'm thinking that it would be a good idea to add comments to explain
> exactly what the memalloc_nofs_save/restore() are protecting where
> they are used. Right now the XFS_TRANS_NOFS flag is largely
> undocumented, so a reader is left guessing as to why the flag is
> necessary and what contexts it may apply to. Hence I think we should
> fix that while we are changing over to a different GFP_NOFS
> allocation context mechanism....

Sure.
