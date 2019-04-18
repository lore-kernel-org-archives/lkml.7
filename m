Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73DDC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB06321872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610765;
	bh=QSjGhzEDo2t+nBLrj3RrgO/HvU80Wxo5JNT359+d3hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p3M8Nmkms7ZirMCIpn2SGYfODAc0rjY4xIfhfVVKJXeHinf25zvzr2l0c+kxhtFaS
	 5hLhiyprLsqm4YhMpMz0tcBI3aoLbHGuNi7WgJXuPouCrNifZog5NwQryFPhcCcaxx
	 1hFt8htqqFZLZP6P2zJrquCCJ2Hb7jZum29lJyeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390396AbfDRSGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391407AbfDRSF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:05:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86C11206B6;
        Thu, 18 Apr 2019 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610759;
        bh=QSjGhzEDo2t+nBLrj3RrgO/HvU80Wxo5JNT359+d3hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jat5V5HWc/jdLcppu04g83TF5AlPE1KJLJJb0d6CbID9b03ud3A4XtrhGoaHV/A+s
         Cl4HOQ9fkN9/OnpJJ50VsYgFcM2PjMVZSeCt5BCDvyB/Bp0yjUFnoDgMMeYDxA2lA4
         aisovfpNJ10J/+3+RxPOZZtUoxJfb8BZ2Rit1VdM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gertjan Halkes <gertjan@google.com>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 40/92] 9p: do not trust pdu content for stat item size
Date:   Thu, 18 Apr 2019 19:56:58 +0200
Message-Id: <20190418160433.778900572@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
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
index 9743837aebc6..766d1ef4640a 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -570,9 +570,10 @@ int p9stat_read(struct p9_client *clnt, char *buf, int len, struct p9_wstat *st)
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



