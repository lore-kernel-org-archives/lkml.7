Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8412C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8722D217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558461988;
	bh=KeXQdf7LxJFZjE2BBsFH6zgWI0BnO6HokdbTkxtyYPA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=J82n4EkodkUpj85d481PZSZu+lOSPoFqgN0PM116uNhZIbEU0mOytONlIEAGQipIn
	 NZe9CKpaC5sMHOOUQySsB5AfuQdpu5x8dsD2RT1xsR0egsEJ9kTQKsdVutmLY6HnvH
	 j0tIRRDAZTyaMoDNtVph8g5Dw61OOSfp0E5TZexE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfEUSG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfEUSG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:06:27 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A0C20851;
        Tue, 21 May 2019 18:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558461987;
        bh=KeXQdf7LxJFZjE2BBsFH6zgWI0BnO6HokdbTkxtyYPA=;
        h=From:To:Cc:Subject:Date:From;
        b=ddvXiv8EIA6w84VHw+0NPtO+HSyrP77FHhH8dJLALrMH5S4IoYkz+FhBmgya4giph
         h4yPCfXwy1ZU4mc3+B32EkwUz4CnRiMSzCxG9SJCXnIW31X39wIyF4Q5VbbbVHl550
         4P1Upotux1pnA15YGFSTnT8OXjV5pC8qm5X6QQ8A=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] Revert "f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG"
Date:   Tue, 21 May 2019 11:06:24 -0700
Message-Id: <20190521180625.10562-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fb40d618b03978b7cc5820697894461f4a2af98b.

The original patch introduced # of fsck triggers.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d0539ddad6e2..89825261d474 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1317,10 +1317,8 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
-	/*
-	 * TODO: we count on fsck.f2fs to clear this flag until we figure out
-	 * missing cases which clear it incorrectly.
-	 */
+	else
+		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
 
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
-- 
2.19.0.605.g01d371f741-goog

