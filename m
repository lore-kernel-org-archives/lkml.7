Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45358C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108F021019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552518984;
	bh=pY43j7G6xl0NBncrHcJsAIOfj4V0queHPm7U342mFg0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=01+tc5BAx0NRdV3yyEucTD70PRMveWhxsVctgH4dhS+lK9JO6T3mh5OL824XjvfiA
	 y6BlAoUKu3exVdlO4XLZ3MBGs6kgyTCdgst/egsT/qvHWFYxSmExXiEzk2JiQXisL5
	 kDyGKPF09TNdhlB88P1vDDpvAt0kZ+zpdMAMv85A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCMXQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfCMXQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:16:22 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FAE20854;
        Wed, 13 Mar 2019 23:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552518981;
        bh=pY43j7G6xl0NBncrHcJsAIOfj4V0queHPm7U342mFg0=;
        h=From:To:Cc:Subject:Date:From;
        b=tFeEPlNwki6FGi+PzFN73IlP85lqxLoGkcqQC8dWWxjXLJGPtVO1jffZTEz8rCD7o
         N3cJmF/+zfUgXM23HWlET8mN4oTibSOAiJEWHMuoh8Jpk0jsSmgC5OvDth2EGhkzTR
         XzubGqDAek4JEqkDhdDkpPvSW6SlseeKc/OA0CNk=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: set pin_file under CAP_SYS_ADMIN
Date:   Wed, 13 Mar 2019 16:16:19 -0700
Message-Id: <20190313231619.31453-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Android uses pin_file for uncrypt during OTA, and that should be managed by
CAP_SYS_ADMIN only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 807a97ad2430..012815d816e6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2873,8 +2873,8 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	__u32 pin;
 	int ret = 0;
 
-	if (!inode_owner_or_capable(inode))
-		return -EACCES;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
 
 	if (get_user(pin, (__u32 __user *)arg))
 		return -EFAULT;
-- 
2.19.0.605.g01d371f741-goog

