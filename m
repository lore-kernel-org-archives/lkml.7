Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38038C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F482071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452273;
	bh=FqKwnTSG7AcKY1Bv6PdyhFFgeWBJYYKoNEjWXCwJtiw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZnGm8yhDDP/90FDqr/0R9q2XHa+qNJmvHrK8okM9xgKKHhjlpOFA+4DENZDMx5q/6
	 XHZ9szfhbYnSipPYjy7Q7WTekQ4hYJAchS9+3P6by+eyIrBWRDa/HbZy5A0VenvfQl
	 rRwJIbgFkMxeXG5umiPkHwugmz0sXBA0X4y4Q/wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfKVTvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:51:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbfKVTuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:50:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7082073F;
        Fri, 22 Nov 2019 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452216;
        bh=FqKwnTSG7AcKY1Bv6PdyhFFgeWBJYYKoNEjWXCwJtiw=;
        h=From:To:Cc:Subject:Date:From;
        b=0bZ1/7stIWastlGVubiY5CyR4NQ8vK8oaJ3SwFj+y4YjSiVPPh3VcyjSGXEGdC8Ob
         UWF340Uu77abeb64/05rA5Uio2kpeEQ8hYptd4oRVUUdzRrS5XXhvVXRvfve80NEiv
         K8DGRXtgs7or7ndZSyI2NsU2FHOtwOgO5yAJ3Z+I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 1/9] autofs: fix a leak in autofs_expire_indirect()
Date:   Fri, 22 Nov 2019 14:50:06 -0500
Message-Id: <20191122195014.25065-1-sashal@kernel.org>
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
index 0d8b9c4f27f21..5124f06c32bcc 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -467,9 +467,10 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
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

