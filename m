Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C443CC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8245E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963674;
	bh=HflbZPMLIcsquxM6ihd/etysUwhNi6g6wn+UFL0EiwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hKWQPaL7kR6SxwwRxGpFX58IXzy471GyAh7HlDz7aY4DPp9KYPgwd39UXwIVjRyb0
	 hJ5tNcsL6fQdlO1DGDIR4SH1I6heQOqLNU31y/TFaqRbULDHalgcDju0WgGUBiZ7th
	 fE05lpXl7aA9rRQ1AtambSmTTMtHEi1AwMMDZvzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfDVUHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbfDVToG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C15A6218FF;
        Mon, 22 Apr 2019 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962245;
        bh=HflbZPMLIcsquxM6ihd/etysUwhNi6g6wn+UFL0EiwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/o18F/Vm3FWprbXmFFrgodwMPB1Pyl3nO44x+t299v9VsaE2aOp9NXrdfa2HNtEo
         ISkEzR8XbTc/UnttRHG0sruanXuNaldqf78kEjozvNJWrUlqGhICfelrxiV3Ejo37u
         zl/OrEiDW2Ol+j1DhtOhdD0F0CLXRnW8XMVrxJyM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>,
        ceph-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 61/98] libceph: fix breakage caused by multipage bvecs
Date:   Mon, 22 Apr 2019 15:41:28 -0400
Message-Id: <20190422194205.10404-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit 187df76325af5d9e12ae9daec1510307797e54f0 ]

A bvec can now consist of multiple physically contiguous pages.
This means that bvec_iter_advance() can move to a different page while
staying in the same bvec (i.e. ->bi_bvec_done != 0).

The messenger works in terms of segments which can now be defined as
the smaller of a bvec and a page.  The "more bytes to process in this
segment" condition holds only if bvec_iter_advance() leaves us in the
same bvec _and_ in the same page.  On next bvec (possibly in the same
page) and on next page (possibly in the same bvec) we may need to set
->last_piece.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 net/ceph/messenger.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 7e71b0df1fbc..3083988ce729 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -840,6 +840,7 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
 					size_t bytes)
 {
 	struct ceph_bio_iter *it = &cursor->bio_iter;
+	struct page *page = bio_iter_page(it->bio, it->iter);
 
 	BUG_ON(bytes > cursor->resid);
 	BUG_ON(bytes > bio_iter_len(it->bio, it->iter));
@@ -851,7 +852,8 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
 		return false;   /* no more data */
 	}
 
-	if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done))
+	if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done &&
+		       page == bio_iter_page(it->bio, it->iter)))
 		return false;	/* more bytes to process in this segment */
 
 	if (!it->iter.bi_size) {
@@ -899,6 +901,7 @@ static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
 					size_t bytes)
 {
 	struct bio_vec *bvecs = cursor->data->bvec_pos.bvecs;
+	struct page *page = bvec_iter_page(bvecs, cursor->bvec_iter);
 
 	BUG_ON(bytes > cursor->resid);
 	BUG_ON(bytes > bvec_iter_len(bvecs, cursor->bvec_iter));
@@ -910,7 +913,8 @@ static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
 		return false;   /* no more data */
 	}
 
-	if (!bytes || cursor->bvec_iter.bi_bvec_done)
+	if (!bytes || (cursor->bvec_iter.bi_bvec_done &&
+		       page == bvec_iter_page(bvecs, cursor->bvec_iter)))
 		return false;	/* more bytes to process in this segment */
 
 	BUG_ON(cursor->last_piece);
-- 
2.19.1

