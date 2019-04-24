Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521F6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1816120652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129447;
	bh=WzUJxl3OXlum2ItBe6yeyYBH6BpTHsiJ6CXaMpqw7G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IXLvd6YQNJ+u9/TngdrjwRF6KIm0iuPI3nxUEtR3sOwM+PtlM0Y7QuSkof3Tw0IzJ
	 UEqUFWNwY/nspFcmD9WCL2RNal6ubLcgoZSUIBkNHPyTgdWZjiswCSvhuVG6/8NAr7
	 3oKThJ0ExEhQz0qfJwc+3Sp+eSLmX5IU5xNc3dOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbfDXSKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387641AbfDXROT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:19 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8D0A206BA;
        Wed, 24 Apr 2019 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126058;
        bh=WzUJxl3OXlum2ItBe6yeyYBH6BpTHsiJ6CXaMpqw7G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+H8QHJ6lOl4JpeTSatKO7mQ2kowYuGgNhMfnkCdnb4jd/hdSoDZd0IJ+7Cew/Bwq
         ofT4b5zk5KlxwEd6hbfGGFHwgm7+ElAUkljapio/RQ0p6GRirO5d4cqAAS0RY6wwXd
         HzCLn5U2vyS6wB9zGQ0Sg9SOkc2ZH74UUFZAxCQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gertjan Halkes <gertjan@google.com>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 077/104] 9p: do not trust pdu content for stat item size
Date:   Wed, 24 Apr 2019 19:09:34 +0200
Message-Id: <20190424170906.721884399@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index cfe4cf6486af..fa7d1c3536e6 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -104,7 +104,6 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 	int err = 0;
 	struct p9_fid *fid;
 	int buflen;
-	int reclen = 0;
 	struct p9_rdir *rdir;
 
 	p9_debug(P9_DEBUG_VFS, "name %pD\n", file);
@@ -129,11 +128,10 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
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
@@ -141,8 +139,8 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
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
index bceb6999614f..66613837b287 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -578,9 +578,10 @@ int p9stat_read(struct p9_client *clnt, char *buf, int len, struct p9_wstat *st)
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



