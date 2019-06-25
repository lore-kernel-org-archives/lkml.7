Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8155C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FDC20644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfFYKHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:07:32 -0400
Received: from verein.lst.de ([213.95.11.211]:33395 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFYKHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:07:32 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5367068B05; Tue, 25 Jun 2019 12:07:01 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:07:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] xfs: initialize ioma->flags in xfs_bmbt_to_iomap
Message-ID: <20190625100701.GG1462@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-5-hch@lst.de> <20190624145707.GH5387@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624145707.GH5387@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:57:07AM -0700, Darrick J. Wong wrote:
> On Mon, Jun 24, 2019 at 07:52:45AM +0200, Christoph Hellwig wrote:
> > Currently we don't overwrite the flags field in the iomap in
> > xfs_bmbt_to_iomap.  This works fine with 0-initialized iomaps on stack,
> > but is harmful once we want to be able to reuse an iomap in the
> > writeback code.
> 
> Is that going to affect all the other iomap users, or is xfs the only
> one that assumes zero-initialized iomaps being passed into
> ->iomap_begin?

This doesn't affect any existing user as they all get a zeroed iomap
passed from the caller in iomap.c.  It affects the writeback code
once it uses struct iomap as it overwrites a previously used iomap.
