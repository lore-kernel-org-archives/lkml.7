Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8475EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA282245C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610200;
	bh=pLLO6uKtr+5rSm4ZgjYB/EnjSBT/h0uJQvYaoDcbTdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b1ohTTjXBY0Q+alfqGKLhpJFyKWVTvy2KMNnVYUrWNriiISxhSLmwaUQ7f6uuXgVW
	 BGV76YTa4LqoWs5mGe4WkxO5LzDlOpSdadEN2mvYBwFHWr+w7CCiPBFRxQUGGRGJ+B
	 o4V06zok+d4u395DM8G2howhnFrpWm0Qsz190/yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfKMB4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:56:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbfKMB4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:56:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 757E42245D;
        Wed, 13 Nov 2019 01:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610192;
        bh=pLLO6uKtr+5rSm4ZgjYB/EnjSBT/h0uJQvYaoDcbTdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTIHY0CKPOyaxJ9wC/dnMFcuzUg20OAuynEBQYpHnFnaMwqUyzpivcfb6zaU/lsDY
         M6+qmlH7U39a7h+SSbJ92LctTbKmBSWFXBi2aM59qnfV4ZbXSkJlvPtPrhNxnvsvEo
         ch4DKhhOhMUQ+TkZnFIphvUKX81JH/uKWHr99Kbg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.14 006/115] f2fs: return correct errno in f2fs_gc
Date:   Tue, 12 Nov 2019 20:54:33 -0500
Message-Id: <20191113015622.11592-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 61f7725aa148ee870436a29d3a24d5c00ab7e9af ]

This fixes overriding error number in f2fs_gc.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ceb6023786bdf..67120181dc2af 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1091,7 +1091,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 
 	put_gc_inode(&gc_list);
 
-	if (sync)
+	if (sync && !ret)
 		ret = sec_freed ? 0 : -EAGAIN;
 	return ret;
 }
-- 
2.20.1

