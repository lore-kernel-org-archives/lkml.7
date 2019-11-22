Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2543C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFBB20658
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452323;
	bh=vB7fiRaxZIeNzfklFngFBYkZnjceJ4G8m0vP6KQ8yF8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bn1sv9/4trYQExeC0/krzZIP4B2qOcu0PwB43N+yNvQqZVDWA+HVghB0s40g4YXid
	 WYhZu0g3ffEV7MOA3AomdQ8/pLw+ZSlq/54SEg1Tf+soF66/XwAlwds40ngZVlrZ67
	 eL7B38QooauB/W9yRS16kGMG+o5qeTKaGXVxN3JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfKVTwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbfKVTuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:50:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D6CE20658;
        Fri, 22 Nov 2019 19:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452200;
        bh=vB7fiRaxZIeNzfklFngFBYkZnjceJ4G8m0vP6KQ8yF8=;
        h=From:To:Cc:Subject:Date:From;
        b=rd8UeYccNje9em+B+vt+QN7fub+dvnnD68S6oY0Jqq9L+eyRC/MDp+fvrO6TkELHl
         4v5UAsYLaGfc/5KNUPY9ZeCb27iwXv72XA/t/GWQCma1E5gD5xDJsEhMquJgJ589Fo
         ji8UtRmf8sjggT6QtlsbVDdjX7A1a261VNoT6CWQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 01/13] autofs: fix a leak in autofs_expire_indirect()
Date:   Fri, 22 Nov 2019 14:49:46 -0500
Message-Id: <20191122194958.24926-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 03ad0d703df75c43f78bd72e16124b5b94a95188 ]

if the second call of should_expire() in there ends up
grabbing and returning a new reference to dentry, we need
to drop it before continuing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs4/expire.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 2e1f50e467f15..02f0d373adbf7 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -469,9 +469,10 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 		 */
 		flags &= ~AUTOFS_EXP_LEAVES;
 		found = should_expire(expired, mnt, timeout, how);
-		if (!found || found != expired)
-			/* Something has changed, continue */
+		if (found != expired) { // something has changed, continue
+			dput(found);
 			goto next;
+		}
 
 		if (expired != dentry)
 			dput(dentry);
-- 
2.20.1

