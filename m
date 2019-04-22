Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5AC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A5C204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963293;
	bh=NVgqi82qlt2eSBl1Cd9hanYvDzTeWpWbcBOze/nDCsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0E/cVshkVMSI4ydZLR8BjwnK5DgygmyzdGwNsMS4b/Puz7NZPT0mSbSO2hFD9bgWK
	 ai1p+Aw6tNS6ifEHDyKIeicK029tk/HHxxS7NMN0lueoZSnEnymkk5rD9jjN81oRTM
	 v4jOV/IRDjd3B1ofjg8dFJqZgKZ4ofncRi37+AV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfDVUBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730111AbfDVTqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 225BE21908;
        Mon, 22 Apr 2019 19:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962413;
        bh=NVgqi82qlt2eSBl1Cd9hanYvDzTeWpWbcBOze/nDCsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QtSwxGmwzZzL3orSADOQlsEH5T5Qw65hlY8V3t90j5Y2XIa0NSy2QgMGKQbq3uSR4
         TgFt4jHc17QekCyQm7yp7jOO3aGdl1MFP7Xrn5fFE/DR8fh7saqc8H6TOe0Ml70p77
         GWpsmnVo27n8YeVxu9Dd9Fn63WYxeHo3c4rbJXhs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>,
        ceph-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 48/68] libceph: fix breakage caused by multipage bvecs
Date:   Mon, 22 Apr 2019 15:44:56 -0400
Message-Id: <20190422194516.11634-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
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
index f7d7f32ac673..ef5216206bdf 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -870,6 +870,7 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
 					size_t bytes)
 {
 	struct ceph_bio_iter *it = &cursor->bio_iter;
+	struct page *page = bio_iter_page(it->bio, it->iter);
 
 	BUG_ON(bytes > cursor->resid);
 	BUG_ON(bytes > bio_iter_len(it->bio, it->iter));
@@ -881,7 +882,8 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
 		return false;   /* no more data */
 	}
 
-	if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done))
+	if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done &&
+		       page == bio_iter_page(it->bio, it->iter)))
 		return false;	/* more bytes to process in this segment */
 
 	if (!it->iter.bi_size) {
@@ -929,6 +931,7 @@ static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
 					size_t bytes)
 {
 	struct bio_vec *bvecs = cursor->data->bvec_pos.bvecs;
+	struct page *page = bvec_iter_page(bvecs, cursor->bvec_iter);
 
 	BUG_ON(bytes > cursor->resid);
 	BUG_ON(bytes > bvec_iter_len(bvecs, cursor->bvec_iter));
@@ -940,7 +943,8 @@ static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
 		return false;   /* no more data */
 	}
 
-	if (!bytes || cursor->bvec_iter.bi_bvec_done)
+	if (!bytes || (cursor->bvec_iter.bi_bvec_done &&
+		       page == bvec_iter_page(bvecs, cursor->bvec_iter)))
 		return false;	/* more bytes to process in this segment */
 
 	BUG_ON(cursor->last_piece);
-- 
2.19.1

