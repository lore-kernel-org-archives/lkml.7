Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769E1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F69520674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420630;
	bh=j7hhSDZ7CtrD2nv5ImgbrakypO9BBw85VDk4h55n7J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cg/1qGgmacwWoGTrZlsUYZYglBppYEBieiljunmEOK8cOsSo5dmmDvf+EZqkCBdme
	 pjgv6eaKcQ5a2wnT1QCwQ7iVgt8i8jGEQwlybV7/lDSSKuOwWseSaXGmKqHul8OFpl
	 a1UmG2DcqYdNndsM3+2Li5vRJz2+e/x8g//kTDZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfKVLDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbfKVLDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:03:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41BF1207DD;
        Fri, 22 Nov 2019 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420622;
        bh=j7hhSDZ7CtrD2nv5ImgbrakypO9BBw85VDk4h55n7J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmjNdGjx+Rfig4gyUyR8cYbRQNe7Qg86LAyVs3y7CUVs20gsqA0oldegddl0ydW55
         zL87zozX3J8vxl7YjK+bYsExqVM5xQN3/pX9Oceaoz404X9rqDvqPe0UAn7h3/Gqne
         O1q/zYHMTt3i4qJFfrGG26CL949O6ezstKwUAxJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 126/220] gfs2: slow the deluge of io error messages
Date:   Fri, 22 Nov 2019 11:28:11 +0100
Message-Id: <20191122100921.851990005@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit b524abcc01483b2ac093cc6a8a2a7375558d2b64 ]

When an io error is hit, it calls gfs2_io_error_bh_i for every
journal buffer it can't write. Since we changed gfs2_io_error_bh_i
recently to withdraw later in the cycle, it sends a flood of
errors to the console. This patch checks for the file system already
being withdrawn, and if so, doesn't send more messages. It doesn't
stop the flood of messages, but it slows it down and keeps it more
reasonable.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/incore.h |  1 +
 fs/gfs2/log.c    |  7 +++++--
 fs/gfs2/util.c   | 13 +++++++------
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index b96d39c28e17c..5d72e8b66a269 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -623,6 +623,7 @@ enum {
 	SDF_RORECOVERY		= 7, /* read only recovery */
 	SDF_SKIP_DLM_UNLOCK	= 8,
 	SDF_FORCE_AIL_FLUSH     = 9,
+	SDF_AIL1_IO_ERROR	= 10,
 };
 
 enum gfs2_freeze_state {
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index cd85092723dea..90b5c8d0c56ac 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -108,7 +108,9 @@ __acquires(&sdp->sd_ail_lock)
 		gfs2_assert(sdp, bd->bd_tr == tr);
 
 		if (!buffer_busy(bh)) {
-			if (!buffer_uptodate(bh)) {
+			if (!buffer_uptodate(bh) &&
+			    !test_and_set_bit(SDF_AIL1_IO_ERROR,
+					      &sdp->sd_flags)) {
 				gfs2_io_error_bh(sdp, bh);
 				*withdraw = true;
 			}
@@ -206,7 +208,8 @@ static void gfs2_ail1_empty_one(struct gfs2_sbd *sdp, struct gfs2_trans *tr,
 		gfs2_assert(sdp, bd->bd_tr == tr);
 		if (buffer_busy(bh))
 			continue;
-		if (!buffer_uptodate(bh)) {
+		if (!buffer_uptodate(bh) &&
+		    !test_and_set_bit(SDF_AIL1_IO_ERROR, &sdp->sd_flags)) {
 			gfs2_io_error_bh(sdp, bh);
 			*withdraw = true;
 		}
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 59c811de0dc7a..6a02cc890daf9 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -256,12 +256,13 @@ void gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
 			const char *function, char *file, unsigned int line,
 			bool withdraw)
 {
-	fs_err(sdp,
-	       "fatal: I/O error\n"
-	       "  block = %llu\n"
-	       "  function = %s, file = %s, line = %u\n",
-	       (unsigned long long)bh->b_blocknr,
-	       function, file, line);
+	if (!test_bit(SDF_SHUTDOWN, &sdp->sd_flags))
+		fs_err(sdp,
+		       "fatal: I/O error\n"
+		       "  block = %llu\n"
+		       "  function = %s, file = %s, line = %u\n",
+		       (unsigned long long)bh->b_blocknr,
+		       function, file, line);
 	if (withdraw)
 		gfs2_lm_withdraw(sdp, NULL);
 }
-- 
2.20.1



