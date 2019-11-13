Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3EAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1862067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573612110;
	bh=AZovaWb7kUE5S+uJuZWRgFGbFjGvS0V6bJLQ2mcQLZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yy4ZmfnG+oGO2SyfJrNTmJfu0fRizgYR+5HDtiFf+oL58GhNeiBczpBsWab3vgkTN
	 uK2FcwcdAS20Er6drsDTffQs5PRFJco6t/gsTyAQkTiAXN2EnFFVxY2VW/POW1J6Zw
	 onrDya7r0NSRS8fXY0jC2MziDe656JyZjKsY9vXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfKMC23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:28:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbfKMBue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:50:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 881FB22467;
        Wed, 13 Nov 2019 01:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609834;
        bh=AZovaWb7kUE5S+uJuZWRgFGbFjGvS0V6bJLQ2mcQLZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vw5fMwkWlz/5xf+e5QmWpePE/fJ9XcaE+M0rMeWqExexnLrR+rAwz87eXMTEm1aV1
         7AX3czyPi2vUa41Wv7o/mPeU012Ayf8UZ2fqFxayrYnPtlc4t3POuFRVFr6lAa/fw0
         83PUU3Tcer7XTWYYtt4uRe6kmGZUMb/fkR2vcAAY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 007/209] f2fs: return correct errno in f2fs_gc
Date:   Tue, 12 Nov 2019 20:47:03 -0500
Message-Id: <20191113015025.9685-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
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
index dd29a49143f54..8c4cb1eee10a6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1244,7 +1244,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 
 	put_gc_inode(&gc_list);
 
-	if (sync)
+	if (sync && !ret)
 		ret = sec_freed ? 0 : -EAGAIN;
 	return ret;
 }
-- 
2.20.1

