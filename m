Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B02C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D28C2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711082;
	bh=G29KAmivEVauUP9kmJQ62V5Z8ACbEWa485xV7vn5CXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qkOpr6cgK+7kDsVi9uU3Mp6II54bDs+kJWF57Dz/zaCVp+UirkTxWlbLaVUf57o2p
	 a2oUGEPxUyPOXy2v9crtSUctsBfdEWTgJhtMtG4NH9K71KV2ciGAfwlsZEvkQo5u61
	 w2nv/mOzjXf3zqmaQ8QzKmkz43ZepVjU7VRBBECE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404033AbfC0SYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390452AbfC0SYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:24:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11F1A2087C;
        Wed, 27 Mar 2019 18:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711074;
        bh=G29KAmivEVauUP9kmJQ62V5Z8ACbEWa485xV7vn5CXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUqHV8eq49GX/PNDlZfwSFxorQt/mMqr0GhNlnxxLSYzBnm02jl+6OFgbae7X9yHG
         okvEyJPi0VKTRqQekXaJD/EXvxCKxr5nBHss5ien+/nHVFWorckUFFx5fduCGBTnRM
         RcgfGRflWYUG+xtfa2HS1lU/t0R4lbiLDstp1HVU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 39/63] bcache: fix input overflow to cache set sysfs file io_error_halflife
Date:   Wed, 27 Mar 2019 14:22:59 -0400
Message-Id: <20190327182323.18577-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182323.18577-1-sashal@kernel.org>
References: <20190327182323.18577-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit a91fbda49f746119828f7e8ad0f0aa2ab0578f65 ]

Cache set sysfs entry io_error_halflife is used to set c->error_decay.
c->error_decay is in type unsigned int, and it is converted by
strtoul_or_return(), therefore overflow to c->error_decay is possible
for a large input value.

This patch fixes the overflow by using strtoul_safe_clamp() to convert
input string to an unsigned long value in range [0, UINT_MAX], then
divides by 88 and set it to c->error_decay.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 5a5c1f1bd8a5..87daccbbc61b 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -645,8 +645,17 @@ STORE(__bch_cache_set)
 		c->error_limit = strtoul_or_return(buf) << IO_ERROR_SHIFT;
 
 	/* See count_io_errors() for why 88 */
-	if (attr == &sysfs_io_error_halflife)
-		c->error_decay = strtoul_or_return(buf) / 88;
+	if (attr == &sysfs_io_error_halflife) {
+		unsigned long v = 0;
+		ssize_t ret;
+
+		ret = strtoul_safe_clamp(buf, v, 0, UINT_MAX);
+		if (!ret) {
+			c->error_decay = v / 88;
+			return size;
+		}
+		return ret;
+	}
 
 	sysfs_strtoul(journal_delay_ms,		c->journal_delay_ms);
 	sysfs_strtoul(verify,			c->verify);
-- 
2.19.1

