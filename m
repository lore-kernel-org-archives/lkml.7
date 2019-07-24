Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63029C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DF422ADF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997857;
	bh=GoxHsisoqa+AVmh9AiTDG6tRPFAbhEt9vwx0+qT3/UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rxAwAMcWOlol0jTQNlEWyEzrEeARWj9gmTTEpokXH7YrgA8WbHLbP+tNAiAKQ9S7t
	 6NP9pdLM33IwqCVOxFHvKyNFUFB/WY0PgwgeA2IGVLIpdJtmTx1YIFdxsUtTU8kqlh
	 A18az/wZRi6hNU/D1wT3wWmze+meTJjU3XsYGbMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391300AbfGXTu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403988AbfGXTuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:50:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A96205C9;
        Wed, 24 Jul 2019 19:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997851;
        bh=GoxHsisoqa+AVmh9AiTDG6tRPFAbhEt9vwx0+qT3/UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbvPSXDlaZG3EKowq+KO2xiaJ2Hqf7olYYj5TdIBNR4966afY7F/vn1Fl67JylcAs
         eoIhM6hShRP6c+UxFh+mO088hOZ3Foyyy08U0hFHbzGWBbvTVKM/S049TZm0VHN9Ef
         yhKEf7EdSimK3wAxlIcYFMFlq6+9Ghpd2bdVLggs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 123/371] lightnvm: pblk: fix freeing of merged pages
Date:   Wed, 24 Jul 2019 21:17:55 +0200
Message-Id: <20190724191734.129809693@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 510fd8ea98fcb586c01aef93d87c060a159ac30a ]

bio_add_pc_page() may merge pages when a bio is padded due to a flush.
Fix iteration over the bio to free the correct pages in case of a merge.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/pblk-core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6ca868868fee..7393d64757a1 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -323,14 +323,16 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
 			 int nr_pages)
 {
-	struct bio_vec bv;
-	int i;
-
-	WARN_ON(off + nr_pages != bio->bi_vcnt);
-
-	for (i = off; i < nr_pages + off; i++) {
-		bv = bio->bi_io_vec[i];
-		mempool_free(bv.bv_page, &pblk->page_bio_pool);
+	struct bio_vec *bv;
+	struct page *page;
+	int i, e, nbv = 0;
+
+	for (i = 0; i < bio->bi_vcnt; i++) {
+		bv = &bio->bi_io_vec[i];
+		page = bv->bv_page;
+		for (e = 0; e < bv->bv_len; e += PBLK_EXPOSED_PAGE_SIZE, nbv++)
+			if (nbv >= off)
+				mempool_free(page++, &pblk->page_bio_pool);
 	}
 }
 
-- 
2.20.1



