Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FABDC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A13920830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XbMWC8fm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bwgGMciK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDIKg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:36:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfDIKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:36:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D97D060E5F; Tue,  9 Apr 2019 10:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554806217;
        bh=YeN2BfC2ifSd/Xa4rkvu4C7vtEg1L40IynurX5RxQXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbMWC8fmR4h9QGqJHAIWf0Pfhc3yDJ2EBKTNbNcXM8Qko+kgzbPnzD6EcXL7KIfK7
         jFshU0kSttgcgTEKitS5rV2D2TA3iT/Ncw6pFuxDIsNa+95kOX+vHOVllOquGNzSjq
         o8Xj4ZF7147R0hnTOYYmWeNGrUy9AAYuLy8PQ9hc=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C48960E5A;
        Tue,  9 Apr 2019 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554806215;
        bh=YeN2BfC2ifSd/Xa4rkvu4C7vtEg1L40IynurX5RxQXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwgGMciKUWLuLLp5NnrdKg8PGoHeej96/7IHD1h41SNZHA8bEe+6ekw049LFdqURG
         KiHIIUfY32SLpxS/XE/nE1Yw5zmUYQQ6rRS919B1sQwMEkiLpgPuKWn9LWDUsaXNaf
         8N1lSf2QU0jjp/XV0cfstewyX6g0sXhEqHcTTBQg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C48960E5A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] f2fs: fix potential race between online resize path and gc path
Date:   Tue,  9 Apr 2019 16:06:18 +0530
Message-Id: <1554806178-32728-4-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
References: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NEW_MAIN_SECS() can be updated by f2fs_resize_from_end() path,
while get_victim_by_default() is running. Hence, protect all
references to NEW_MAIN_SECS() with seglist_lock mutex.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2077be9..d636721 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -311,10 +311,11 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	struct sit_info *sm = SIT_I(sbi);
 	struct victim_sel_policy p;
 	unsigned int secno, last_victim;
-	unsigned int last_segment = NEW_MAIN_SECS(sbi) * sbi->segs_per_sec;
+	unsigned int last_segment;
 	unsigned int nsearched = 0;
 
 	mutex_lock(&dirty_i->seglist_lock);
+	last_segment = NEW_MAIN_SECS(sbi) * sbi->segs_per_sec;
 
 	p.alloc_mode = alloc_mode;
 	select_policy(sbi, gc_type, type, &p);
@@ -1400,6 +1401,7 @@ int f2fs_resize_from_end(struct f2fs_sb_info *sbi, size_t resize_len)
 
 	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
 	NEW_MAIN_SECS(sbi) = MAIN_SECS(sbi) - secs;
+
 	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
 		if (SIT_I(sbi)->last_victim[gc_mode] >=
 					NEW_MAIN_SECS(sbi) * sbi->segs_per_sec)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

