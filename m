Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0D5C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 04:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC3520881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 04:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PpC3lN8B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HpUEeHGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfEWET5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 00:19:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40050 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfEWET4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 00:19:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 115D66030E; Thu, 23 May 2019 04:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558585196;
        bh=fcgjdJ/PJA3qLLQdtDzwInWMZt4bLcUj3OyOsUB08Sc=;
        h=From:To:Cc:Subject:Date:From;
        b=PpC3lN8BDTY+iUn2gZfoMDqpZAXxrahmq7Q7FmmeQnn3wCocxqiiA0zAz5s3L5ncD
         NlXBJuDbMgWQRsyPXVQF1uFVmhJr0TfFiqsfrcyWaO3TaTqMC0VX21gTkTomXGwdYi
         54zt2GqjVZ8f/BgUXlg8xSoZoA21vK7Z/7OzjWqQ=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DF656030E;
        Thu, 23 May 2019 04:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558585195;
        bh=fcgjdJ/PJA3qLLQdtDzwInWMZt4bLcUj3OyOsUB08Sc=;
        h=From:To:Cc:Subject:Date:From;
        b=HpUEeHGTGyVc3ys5xm/2+psHewPGfZYJp3grZUcmAKFX3YEx4k1DLFHGtQ10m+MsP
         yc1iierAqa+6FvyeIJ9Rw8dakWGTS5heqtRLDYwPA0GlbW1eLbc/oUMRzm7fSazAEO
         YPAMNYQr8ai0O7fWkDxXl5HxqofkEyRBMBbYqj3g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DF656030E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: add error prints for debugging mount failure
Date:   Thu, 23 May 2019 09:49:17 +0530
Message-Id: <1558585157-9349-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error prints to get more details on the mount failure.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 6 +++++-
 fs/f2fs/super.c   | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4896443..bdc6956 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3567,8 +3567,12 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 
 	/* sanity check for summary blocks */
 	if (nats_in_cursum(nat_j) > NAT_JOURNAL_ENTRIES ||
-			sits_in_cursum(sit_j) > SIT_JOURNAL_ENTRIES)
+			sits_in_cursum(sit_j) > SIT_JOURNAL_ENTRIES) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"invalid journal entries nats %u sits %u\n",
+			nats_in_cursum(nat_j), sits_in_cursum(sit_j));
 		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 52f1497..2c9d4f7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3413,13 +3413,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	err = f2fs_build_segment_manager(sbi);
 	if (err) {
 		f2fs_msg(sb, KERN_ERR,
-			"Failed to initialize F2FS segment manager");
+			"Failed to initialize F2FS segment manager (%d)", err);
 		goto free_sm;
 	}
 	err = f2fs_build_node_manager(sbi);
 	if (err) {
 		f2fs_msg(sb, KERN_ERR,
-			"Failed to initialize F2FS node manager");
+			"Failed to initialize F2FS node manager (%d)", err);
 		goto free_nm;
 	}
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

