Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0BFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE83B218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257436;
	bh=5rX9H+cSzWOwcRTFFxy16tZFeVHX7qNMiL1u9G/kP3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U6tw8RVLNnW6ImmsJ/SL+mNjrJuT1rjoy8C8FyTEfOADk9EdYIezzSEvjSh1zyF55
	 oKv+ZPCj2i0FqgAt348C7HPLQ7bvZjKzoLa0EKJpc+/zsdv3p1sFKpb/6WVEX5zaMC
	 +Jh4pqCtNPStd9UgifsiH4opBSzoeqMNa2OfuhUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390972AbfCVMXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391172AbfCVMXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B8C82054F;
        Fri, 22 Mar 2019 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257429;
        bh=5rX9H+cSzWOwcRTFFxy16tZFeVHX7qNMiL1u9G/kP3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs7juu+eovKPvGaEjGmIwAdKrZyeXDOwdUFyfa95jwBojtr4P2keXM3Xsw2jHI/gC
         gbddK7qDV1IeEGIefhoPvCNWEUZ6cmq8U007LXiC1QsTNudBXZgSeiRBF+iqd8GunJ
         T8OUPniXiqqpQpZjxfpjG38vQGzbuZQy8Mv4EYkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nix <nix@esperi.org.uk>,
        Coly Li <colyli@suse.de>, Andre Noll <maan@tuebingen.mpg.de>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.0 196/238] bcache: use (REQ_META|REQ_PRIO) to indicate bio for metadata
Date:   Fri, 22 Mar 2019 12:16:55 +0100
Message-Id: <20190322111309.758372237@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Coly Li <colyli@suse.de>

commit dc7292a5bcb4c878b076fca2ac3fc22f81b8f8df upstream.

In 'commit 752f66a75aba ("bcache: use REQ_PRIO to indicate bio for
metadata")' REQ_META is replaced by REQ_PRIO to indicate metadata bio.
This assumption is not always correct, e.g. XFS uses REQ_META to mark
metadata bio other than REQ_PRIO. This is why Nix noticed that bcache
does not cache metadata for XFS after the above commit.

Thanks to Dave Chinner, he explains the difference between REQ_META and
REQ_PRIO from view of file system developer. Here I quote part of his
explanation from mailing list,
   REQ_META is used for metadata. REQ_PRIO is used to communicate to
   the lower layers that the submitter considers this IO to be more
   important that non REQ_PRIO IO and so dispatch should be expedited.

   IOWs, if the filesystem considers metadata IO to be more important
   that user data IO, then it will use REQ_PRIO | REQ_META rather than
   just REQ_META.

Then it seems bios with REQ_META or REQ_PRIO should both be cached for
performance optimation, because they are all probably low I/O latency
demand by upper layer (e.g. file system).

So in this patch, when we want to decide whether to bypass the cache,
REQ_META and REQ_PRIO are both checked. Then both metadata and
high priority I/O requests will be handled properly.

Reported-by: Nix <nix@esperi.org.uk>
Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Andre Noll <maan@tuebingen.mpg.de>
Tested-by: Nix <nix@esperi.org.uk>
Cc: stable@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/request.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -392,10 +392,11 @@ static bool check_should_bypass(struct c
 
 	/*
 	 * Flag for bypass if the IO is for read-ahead or background,
-	 * unless the read-ahead request is for metadata (eg, for gfs2).
+	 * unless the read-ahead request is for metadata
+	 * (eg, for gfs2 or xfs).
 	 */
 	if (bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND) &&
-	    !(bio->bi_opf & REQ_PRIO))
+	    !(bio->bi_opf & (REQ_META|REQ_PRIO)))
 		goto skip;
 
 	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
@@ -877,7 +878,7 @@ static int cached_dev_cache_miss(struct
 	}
 
 	if (!(bio->bi_opf & REQ_RAHEAD) &&
-	    !(bio->bi_opf & REQ_PRIO) &&
+	    !(bio->bi_opf & (REQ_META|REQ_PRIO)) &&
 	    s->iop.c->gc_stats.in_use < CUTOFF_CACHE_READA)
 		reada = min_t(sector_t, dc->readahead >> 9,
 			      get_capacity(bio->bi_disk) - bio_end_sector(bio));


