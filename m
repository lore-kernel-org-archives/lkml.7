Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1B2C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA7420663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfFXXAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:00:15 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:48325 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbfFXXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:00:15 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id F058B3DC80F;
        Tue, 25 Jun 2019 09:00:11 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hfXvU-0000ZQ-Kb; Tue, 25 Jun 2019 08:59:04 +1000
Date:   Tue, 25 Jun 2019 08:59:04 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] xfs: remove XFS_TRANS_NOFS
Message-ID: <20190624225904.GB7777@dread.disaster.area>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=cSrwqqIVXR2GPqyHJbwA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:47AM +0200, Christoph Hellwig wrote:
> Instead of a magic flag for xfs_trans_alloc, just ensure all callers
> that can't relclaim through the file system use memalloc_nofs_save to
> set the per-task nofs flag.

I'm thinking that it would be a good idea to add comments to explain
exactly what the memalloc_nofs_save/restore() are protecting where
they are used. Right now the XFS_TRANS_NOFS flag is largely
undocumented, so a reader is left guessing as to why the flag is
necessary and what contexts it may apply to. Hence I think we should
fix that while we are changing over to a different GFP_NOFS
allocation context mechanism....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
