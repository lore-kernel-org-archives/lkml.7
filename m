Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C4AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 01:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E3B216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 01:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567992338;
	bh=E2cqUMgnAApDs9Dsnc3TkUoWZaykQ41wUr7ucx5cits=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=To13duCRuoiU0rCVrR+qthEq9iWN2qdu0zXxQRI1psITbxBtpGR7zQmLlX/M4Ktxw
	 SeSdubsdZuPHo9Ken6c5WYQ/PilvzRwthHd1f6xuNmfB3IpNRAdMmLsO1EwlMowWmW
	 jSlPQpV8+iXMVWioocwi5n15/7VO/LSptH9OCmW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbfIIBZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 21:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731552AbfIIBZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 21:25:36 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F562086D;
        Mon,  9 Sep 2019 01:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567992336;
        bh=E2cqUMgnAApDs9Dsnc3TkUoWZaykQ41wUr7ucx5cits=;
        h=From:To:Cc:Subject:Date:From;
        b=U+XjKg5BZeMQiD3PXoW/UEPCmrQK8Q0NPiqdpxHOERHwJI9vfsVDlXvDI/pCc3ckO
         PQques6ArVn5mc8J/Jf6suYB6L4roUtEABY/k+NfQlNwZUIgvav6B5FPdgAvQzN+Fl
         QTFKL6XoELbN8HFR3CSohe0uvu5YCDxnR0a443LM=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: do not select same victim right again
Date:   Mon,  9 Sep 2019 02:25:31 +0100
Message-Id: <20190909012532.20454-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GC must avoid select the same victim again.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e88f98ddf396..15ca8bbb0b22 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -274,6 +274,9 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct victim_sel_policy *p)
 {
+	if (sbi->cur_victim_sec == GET_SEC_FROM_SEG(sbi, segno))
+		return UINT_MAX;
+
 	if (p->alloc_mode == SSR)
 		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
 
@@ -1326,9 +1329,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		round++;
 	}
 
-	if (gc_type == FG_GC)
-		sbi->cur_victim_sec = NULL_SEGNO;
-
 	if (sync)
 		goto stop;
 
-- 
2.19.0.605.g01d371f741-goog

