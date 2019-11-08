Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6751AFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328E62245A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213282;
	bh=TGsOxMyPWE5J2waCsiFoRzIAdziPYQCI2nChIIFrhiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jNF7XCr1vC57E5MXheQ6Ypg8AQbvftJ9LU3cQCFaBlUUI59EGb4bArQgPRoNtCfzO
	 72qN42kCb7/e7fFepWvGpkGXalEXejG8TgrS4DQ+M4j435THO9ATNTTX/Znv59i3Dh
	 WhF/StEEhcyaOJe5C+4TasRLg/lMr0lEGsHb60J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbfKHLlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389227AbfKHLlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE7DC222CF;
        Fri,  8 Nov 2019 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213272;
        bh=TGsOxMyPWE5J2waCsiFoRzIAdziPYQCI2nChIIFrhiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrtBQM2c34qggKGChPE09KAPlyE69PwESatb6I/mxLQsKNEb0v2VgiftSC54qzkdY
         3LHP4bQ/px8IECgaHJkZRC2xQwZ5XSUUWWXpUZdNxj5gHZUkaDgETuOiwqH5Wfv3on
         FxkK8QoE92SIMGlg8sI+9YjqC7ttnsMA/7bdw1Yc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 134/205] f2fs: fix memory leak of write_io in fill_super()
Date:   Fri,  8 Nov 2019 06:36:41 -0500
Message-Id: <20191108113752.12502-134-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 0b2103e886e6de9802e1170e57c573443286a483 ]

It needs to release memory allocated for sbi->write_io in error path,
otherwise, it will cause memory leak.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6851afc3bf805..588c575bd72b0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2923,7 +2923,7 @@ try_onemore:
 				     GFP_KERNEL);
 		if (!sbi->write_io[i]) {
 			err = -ENOMEM;
-			goto free_options;
+			goto free_bio_info;
 		}
 
 		for (j = HOT; j < n; j++) {
-- 
2.20.1

