Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540E8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213D62133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="icli6rr+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ODIJ4PA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfDIKgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:36:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfDIKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:36:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4BACE6110F; Tue,  9 Apr 2019 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554806212;
        bh=dxzTPPPoyNwyoS5eFhOa7hTyrVyMHAbV16DEwfPsRdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icli6rr+fhPubyckZf7rQDsZB2wp/65eNpNbippPqyDzuQuUgYfZY+7+th0eFT3vN
         YedTM4FE6b0qNUBddhxMghSHHHW4KBwMzeWy7ehI9Zzh9kZgKnAF+Oy+812x7InSgO
         AaSYt5Q7KlTXSqt0y4Hoete7eCX+4JYh1KmKqor8=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FC356115A;
        Tue,  9 Apr 2019 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554806211;
        bh=dxzTPPPoyNwyoS5eFhOa7hTyrVyMHAbV16DEwfPsRdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODIJ4PA83GoLy/lM1hvqfa83oV4ERmV6GntkhmmFywiblP0S1XF9WKs4llbKkPrkm
         KHxrQPXLddgAte9W8w2AkMcQ/xXNbXT5dqNLbkuWZaNgtx9/dBiefEzlead8T58gHZ
         XK0bOp0IPP4u0i9Mo46tngbSY/tpprD5eSCerClw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FC356115A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] f2fs: fix race between online resize path and allocate new data block path
Date:   Tue,  9 Apr 2019 16:06:17 +0530
Message-Id: <1554806178-32728-3-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
References: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be a potential race between allocate_segment_for_resize() and
allocate_data_block(), resulting into two issues -

1. The allocate_data_block() can get a data block from a segment which
is currently being resized. This results in data being updated in an
outdated or already resized segment.

2. It also results into these warnings from get_new_segment():
f2fs_bug_on(sbi, secno >= NEW_MAIN_SECS(sbi));

Fix these by using curseg_mutex lock in the resize context to prevent
race with allocate_data_block() path.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1c3cc30..e7c411f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2643,12 +2643,14 @@ void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type)
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int old_segno = curseg->segno;
 
+	mutex_lock(&curseg->curseg_mutex);
 	if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type))
 		change_curseg(sbi, type);
 	else
 		new_curseg(sbi, type, true);
 
 	stat_inc_seg_type(sbi, curseg);
+	mutex_unlock(&curseg->curseg_mutex);
 
 	if (get_valid_blocks(sbi, old_segno, false) == 0)
 		__set_test_and_free(sbi, old_segno);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

