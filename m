Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F82AC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D06121734
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfGWPeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:34:24 -0400
Received: from verein.lst.de ([213.95.11.211]:42726 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfGWPeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:34:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B1D768B02; Tue, 23 Jul 2019 17:34:22 +0200 (CEST)
Date:   Tue, 23 Jul 2019 17:34:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Linux 5.3-rc1
Message-ID: <20190723153421.GA720@lst.de>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com> <20190722222126.GA27291@roeck-us.net> <20190723054841.GA17148@lst.de> <20190723145805.GA5809@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723145805.GA5809@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does this fix the problem for you?

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9381171c2fc0..4715671a1537 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1793,7 +1793,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 	dma_set_seg_boundary(dev, shost->dma_boundary);
 
 	blk_queue_max_segment_size(q, shost->max_segment_size);
-	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
+	if (shost->virt_boundary_mask)
+		blk_queue_virt_boundary(q, shost->virt_boundary_mask);
 	dma_set_max_seg_size(dev, queue_max_segment_size(q));
 
 	/*
