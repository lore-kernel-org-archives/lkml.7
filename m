Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2755C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF80621908
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909344;
	bh=0I/1J8aJfN5I88jHgPiNoG0KtScanBcpje0vOD93KKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W2gzb8oOnaFWvw4hd6MQbP9S7mxvj3KAtH4UBB/nSAEK1Oum5wxVrAgecAOYeksMG
	 //DWPOQJjjQjZLD2vPjSLLY/xUu5uq/CfBuxr/dquxX07wlTJPWJLP6Amh39mdo/tz
	 U3wcSPmcLmTHeMpuJm1unDDDIihjw2N/XNV7Yej8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfC3B3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730696AbfC3B3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:29:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 047772184C;
        Sat, 30 Mar 2019 01:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909340;
        bh=0I/1J8aJfN5I88jHgPiNoG0KtScanBcpje0vOD93KKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgtsXfNB5n3gQF0R8+rJ2hAMg5cXMWjoll2fs0UyucK7CJrvfnFBalz0BsJ9Q3XXe
         Iw4JAXN9j4tK6+A0fnPxO2U92gHqoMKisw3j76mhKsu6YoSN0BvJx4y4VWp4Sfc2CZ
         cyFpmzswYqi7qT2YztnbraHZA5Vx2hhN9zhEEvec=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gertjan Halkes <gertjan@google.com>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/57] 9p: do not trust pdu content for stat item size
Date:   Fri, 29 Mar 2019 21:27:58 -0400
Message-Id: <20190330012854.32212-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gertjan Halkes <gertjan@google.com>

[ Upstream commit 2803cf4379ed252894f046cb8812a48db35294e3 ]

v9fs_dir_readdir() could deadloop if a struct was sent with a size set
to -2

Link: http://lkml.kernel.org/r/1536134432-11997-1-git-send-email-asmadeus@codewreck.org
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=88021
Signed-off-by: Gertjan Halkes <gertjan@google.com>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_dir.c   | 8 +++-----
 net/9p/protocol.c | 3 ++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 48db9a9f13f9..cb6c4031af55 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -105,7 +105,6 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 	int err = 0;
 	struct p9_fid *fid;
 	int buflen;
-	int reclen = 0;
 	struct p9_rdir *rdir;
 	struct kvec kvec;
 
@@ -138,11 +137,10 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 		while (rdir->head < rdir->tail) {
 			err = p9stat_read(fid->clnt, rdir->buf + rdir->head,
 					  rdir->tail - rdir->head, &st);
-			if (err) {
+			if (err <= 0) {
 				p9_debug(P9_DEBUG_VFS, "returned %d\n", err);
 				return -EIO;
 			}
-			reclen = st.size+2;
 
 			over = !dir_emit(ctx, st.name, strlen(st.name),
 					 v9fs_qid2ino(&st.qid), dt_type(&st));
@@ -150,8 +148,8 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 			if (over)
 				return 0;
 
-			rdir->head += reclen;
-			ctx->pos += reclen;
+			rdir->head += err;
+			ctx->pos += err;
 		}
 	}
 }
diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index ee32bbf12675..b4d80c533f89 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -571,9 +571,10 @@ int p9stat_read(struct p9_client *clnt, char *buf, int len, struct p9_wstat *st)
 	if (ret) {
 		p9_debug(P9_DEBUG_9P, "<<< p9stat_read failed: %d\n", ret);
 		trace_9p_protocol_dump(clnt, &fake_pdu);
+		return ret;
 	}
 
-	return ret;
+	return fake_pdu.offset;
 }
 EXPORT_SYMBOL(p9stat_read);
 
-- 
2.19.1

