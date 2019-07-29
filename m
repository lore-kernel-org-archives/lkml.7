Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D931C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101FD2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h8jFmrSe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MoVOvdoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfG2FU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:20:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfG2FU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:20:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7550A6030E; Mon, 29 Jul 2019 05:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564377656;
        bh=nn4l3B+Tf7YJji7ydB+5u0cuzi2/Yx4Dzyvf35VIPO8=;
        h=From:To:Cc:Subject:Date:From;
        b=h8jFmrSePKbG9gt57DG3JtGI2HdMWMa7N6SaBfPf4YAdjuiKtgZGvFKWFo64VDlmw
         uDmnAdeidhgDmcWiKJ3wabDbMVmZxJeBIfQzk0YIIQluYT2JQV6WWia4TwnhNkNfEo
         n7BJr/KEagkqnrOtWG3kABeD6OyyZk3rrovyA3/k=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A327602B7;
        Mon, 29 Jul 2019 05:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564377655;
        bh=nn4l3B+Tf7YJji7ydB+5u0cuzi2/Yx4Dzyvf35VIPO8=;
        h=From:To:Cc:Subject:Date:From;
        b=MoVOvdoMsDTX6km6I4LYGbfkxBkA2gaHNqg7J9xiJDVjdSzrH7DaCWI6oiqFHSk/N
         ab+Nwsfa+68RPogtLX/4oHZnN7r27IU/Yf5NjYARul53+pIx3vh1OSaNxFWdwXTfNj
         d4gntsIaM7gI7GLAQG4Yuo+yKONkMAN67PoMRQOc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A327602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: Fix indefinite loop in f2fs_gc()
Date:   Mon, 29 Jul 2019 10:50:26 +0530
Message-Id: <1564377626-12898-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Policy - foreground GC, LFS mode and greedy GC mode.

Under this policy, f2fs_gc() loops forever to GC as it doesn't have
enough free segements to proceed and thus it keeps calling gc_more
for the same victim segment.  This can happen if the selected victim
segment could not be GC'd due to failed blkaddr validity check i.e.
is_alive() returns false for the blocks set in current validity map.

Fix this by not resetting the sbi->cur_victim_sec to NULL_SEGNO, when
the segment selected could not be GC'd. This helps to select another
segment for GC and thus helps to proceed forward with GC.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8974672..7bbcc4a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1303,7 +1303,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		round++;
 	}
 
-	if (gc_type == FG_GC)
+	if (gc_type == FG_GC && seg_freed)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
 	if (sync)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

