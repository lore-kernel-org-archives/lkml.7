Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CE6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC28204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000282;
	bh=LIJGF+UuwXoc24xOqPrYVuQP8Bd1KAdghCvRIVquvws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WI/WBY87LVKGBlYGNBuWVUooni9GgXFGTlq47/uA/+xCQu5rhZiG+mk1GpCy5olRo
	 6a0ImP9P39OjiksyZXoDYFUgLYYlKfz5shelvVlPewNvDs64lfpPr2QYV30tmu1iI6
	 qfK7t5UlE4kDS5MtpWyJDAV2vE9ItCa9gtG/WcLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfGXUbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388383AbfGXTam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:30:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D98621951;
        Wed, 24 Jul 2019 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996641;
        bh=LIJGF+UuwXoc24xOqPrYVuQP8Bd1KAdghCvRIVquvws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXnGF6b7kAGfycFJ+kUcxcWP5+OoGxIJuw6RIKSsq1mTnT3sJsFHE9MI/MtG9FDzX
         iyHALcyU5aYYuTVKFs5onJJ2QPwxmtpI7Oj6OKwTObTzsBMxxXjqJUQOori9Ku3r/W
         uSaBoNcmtIwoBCC3VOuDQZ/SIb6x49zzJ72RXwes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 126/413] blk-iolatency: only account submitted bios
Date:   Wed, 24 Jul 2019 21:16:57 +0200
Message-Id: <20190724191744.147311482@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a3fb01ba5af066521f3f3421839e501bb2c71805 ]

As is, iolatency recognizes done_bio and cleanup as ending paths. If a
request is marked REQ_NOWAIT and fails to get a request, the bio is
cleaned up via rq_qos_cleanup() and ended in bio_wouldblock_error().
This results in underflowing the inflight counter. Fix this by only
accounting bios that were actually submitted.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iolatency.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index d22e61bced86..c91b84bb9d0a 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -600,6 +600,10 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
 		return;
 
+	/* We didn't actually submit this bio, don't account it. */
+	if (bio->bi_status == BLK_STS_AGAIN)
+		return;
+
 	iolat = blkg_to_lat(bio->bi_blkg);
 	if (!iolat)
 		return;
-- 
2.20.1



