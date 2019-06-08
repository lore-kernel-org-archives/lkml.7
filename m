Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2257C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB529216F4
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994634;
	bh=YntNBn8zkYQ2utLEVUx+pG7XxnLayxLCz5AZlQ+gEo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0kOM5VqDEeqgTl7efHPXM6t/XKy+RbpFM02hRsDPtfS0tnlApob0X1czot/t0i1DM
	 ZwM2QAgk4lqaSptiRWRHlmgW/TagMIOpblfVffkX9E0M62gEDcZu5FJ318RQ4Hp+Eb
	 FiGYlqARrT/y1SQk2/gV164U3q7+xyHkfknO2ZP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfFHLs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfFHLsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:48:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0D1216FD;
        Sat,  8 Jun 2019 11:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994505;
        bh=YntNBn8zkYQ2utLEVUx+pG7XxnLayxLCz5AZlQ+gEo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9yEWxTANQ5dfO35IWHX2WiHLl/V/evxIBlDCpKEH2QCCqYDb2vdSKF+yJPZNbumk
         fQHtnUHBIlxVPZ5DVaJ3WBFxsivuQme/mOuMRwFV9REPW+coWfFK6D7i2jjEf6Tswr
         i9peTA/GaY+V9VTU16czge6onRS5G3HODnhEFId8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 10/20] configfs: Fix use-after-free when accessing sd->s_dentry
Date:   Sat,  8 Jun 2019 07:47:46 -0400
Message-Id: <20190608114756.9742-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114756.9742-1-sashal@kernel.org>
References: <20190608114756.9742-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

[ Upstream commit f6122ed2a4f9c9c1c073ddf6308d1b2ac10e0781 ]

In the vfs_statx() context, during path lookup, the dentry gets
added to sd->s_dentry via configfs_attach_attr(). In the end,
vfs_statx() kills the dentry by calling path_put(), which invokes
configfs_d_iput(). Ideally, this dentry must be removed from
sd->s_dentry but it doesn't if the sd->s_count >= 3. As a result,
sd->s_dentry is holding reference to a stale dentry pointer whose
memory is already freed up. This results in use-after-free issue,
when this stale sd->s_dentry is accessed later in
configfs_readdir() path.

This issue can be easily reproduced, by running the LTP test case -
sh fs_racer_file_list.sh /config
(https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/racer/fs_racer_file_list.sh)

Fixes: 76ae281f6307 ('configfs: fix race between dentry put and lookup')
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/configfs/dir.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index d2a1a79fa324..4930a3a211f3 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -58,15 +58,13 @@ static void configfs_d_iput(struct dentry * dentry,
 	if (sd) {
 		/* Coordinate with configfs_readdir */
 		spin_lock(&configfs_dirent_lock);
-		/* Coordinate with configfs_attach_attr where will increase
-		 * sd->s_count and update sd->s_dentry to new allocated one.
-		 * Only set sd->dentry to null when this dentry is the only
-		 * sd owner.
-		 * If not do so, configfs_d_iput may run just after
-		 * configfs_attach_attr and set sd->s_dentry to null
-		 * even it's still in use.
+		/*
+		 * Set sd->s_dentry to null only when this dentry is the one
+		 * that is going to be killed.  Otherwise configfs_d_iput may
+		 * run just after configfs_attach_attr and set sd->s_dentry to
+		 * NULL even it's still in use.
 		 */
-		if (atomic_read(&sd->s_count) <= 2)
+		if (sd->s_dentry == dentry)
 			sd->s_dentry = NULL;
 
 		spin_unlock(&configfs_dirent_lock);
-- 
2.20.1

