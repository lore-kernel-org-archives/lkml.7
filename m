Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9D5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6735020818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bjyn2jUC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fPQp1xo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfDIKgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:36:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36938 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfDIKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:36:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 600F861196; Tue,  9 Apr 2019 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554806209;
        bh=o9CnlLwBhIOwI3R+fnRkUEEfNfLOW+j1FOo4ovAFYFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bjyn2jUCJ4pTO1P3s480yVu8tPZNnaQbd2YNQc7VYjxABAPTZpltXmIXNDAvW5Kk+
         5DGiDSkvsxKuiOWQInsKOkKMtNaMPiulgCmUVa6BiiWSONsdvdbQRYkQLZ35R7c40U
         ZmcSQChacVNp8BF595NlPGWAWadjV46O97z+gCVI=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 327056115A;
        Tue,  9 Apr 2019 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554806207;
        bh=o9CnlLwBhIOwI3R+fnRkUEEfNfLOW+j1FOo4ovAFYFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPQp1xo6n6uXbx81bUc9F6xig+t8mgwWYrOUGSxTrIDq9Sv+6se/fo2StJPduAGAf
         2ltOfxEGNAwSPe7SFrcP03QmtMQt8L6hcXp+NtdEZ1pbRNaJFKpVB1K9ME4Wwu9KbC
         HvmRF8WaT3ARZRRv/56jBoH2FZi0RilpQylEE46g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 327056115A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] f2fs: fix debugfs status to reflect the online resize changes
Date:   Tue,  9 Apr 2019 16:06:16 +0530
Message-Id: <1554806178-32728-2-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
References: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main area segs/secs/zones will be updated/changed after an
online resize. Hence, update the struct f2fs_stat_info as well
accordingly to show correct status in debugfs.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/debug.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 99e9a5c..7706049 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -27,8 +27,15 @@
 static void update_general_status(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
+	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	int i;
 
+	/* these will be changed if online resize is done */
+	si->main_area_segs = le32_to_cpu(raw_super->segment_count_main);
+	si->main_area_sections = le32_to_cpu(raw_super->section_count);
+	si->main_area_zones = si->main_area_sections /
+				le32_to_cpu(raw_super->secs_per_zone);
+
 	/* validation check of the segment numbers */
 	si->hit_largest = atomic64_read(&sbi->read_hit_largest);
 	si->hit_cached = atomic64_read(&sbi->read_hit_cached);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

