Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55646C28CC1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2D4243B7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tq0C+xLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfE3Axa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 20:53:30 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36101 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfE3Ax0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:53:26 -0400
Received: by mail-qk1-f201.google.com with SMTP id a12so3504786qkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pFDT61UYE6+362eUPJJuMi+49iBrHpoUZVksNkDJA2o=;
        b=tq0C+xLpxnScJrE7KGvLRNW1EvyW7w8fxZLYhMG38iqb6B65iu+pJNUwkSmSw9Wsl3
         /9PNywbClVW9JA9DR/Dh1tSwsF6mMdgLrRvRMdWic+A+8I5sxRkeLEB1Ob2MAWWJm9jL
         6ev53ORFgvokwK4cHk17Y7Ckh2RQmG74ba2tYgemlhSg7VkheKlADWDbsqwFIwOUSizD
         ZYBWe2VO+7gH+pPgHLcdOlhkOX4cS9lzTtfup83L3evOB0ATtVcM/T1mPq4hDcSUF5Uc
         u/Y86bsvfsu8KvdNmkA/2KSKxTBI0UsTGqIlC4MAGZr2YM/9PfAUtAnGcsXxF7iTVQkS
         YuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pFDT61UYE6+362eUPJJuMi+49iBrHpoUZVksNkDJA2o=;
        b=CicrLPPkhtqWT71Tm2ePAYq3Gmu5inF1gFKYJYK9J9dJ3pg4aSBpvE+LK0n59XBWri
         JXPCAHxyiFXlwxV2cpTs/8OqXsCj6iINes+P9Ija2980mYSEX9xhXAMU3ytNxh09wSlg
         hKlwYOtb9DZ5RiqyN4eHC6tiJcRox+lgGl16FqoIQJc6xqye3N62W5uQIR29lDlABt2m
         B/IX20Vqcv0YbdR3LtyfSsskkzeZAc0TlobZN48Plo+EdM49ZyDlt5w3KQ81b8IL5rtp
         xNZJ/wdU52hi08GAe76dsykCdDYiC9AMuFEJxMfx8CoXxn4DtR7Uqz9uLHAkLWvp+OMw
         LOgg==
X-Gm-Message-State: APjAAAUQRBHZdsBVxkfoGsjcUIcnbiOg/l3FlkKcPvbP+H+C8mnd6UQj
        dd/RlCTrdzhrTK/WXbvR45gxEAHQMDg=
X-Google-Smtp-Source: APXvYqzdUz6c4pIj7GBI7bppXtBGbR717H7HlhysYDM55NbncVD1VFEeIv2JijSIJKEof8AzW57Fcs/wZys=
X-Received: by 2002:a37:660b:: with SMTP id a11mr723548qkc.342.1559177606029;
 Wed, 29 May 2019 17:53:26 -0700 (PDT)
Date:   Wed, 29 May 2019 17:49:05 -0700
In-Reply-To: <20190530004906.261170-1-drosen@google.com>
Message-Id: <20190530004906.261170-4-drosen@google.com>
Mime-Version: 1.0
References: <20190530004906.261170-1-drosen@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 3/4] f2fs: Fix accounting for unusable blocks
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes possible underflows when dealing with unusable blocks.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/f2fs.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b3d9977cd1ef..a39cc4ffeb4b1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1769,8 +1769,12 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	if (!__allow_reserved_blocks(sbi, inode, true))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
-	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
-		avail_user_block_count -= sbi->unusable_block_count;
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		if (avail_user_block_count > sbi->unusable_block_count)
+			avail_user_block_count = 0;
+		else
+			avail_user_block_count -= sbi->unusable_block_count;
+	}
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
 		if (diff > *count)
@@ -1970,7 +1974,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
 	block_t	valid_block_count;
-	unsigned int valid_node_count;
+	unsigned int valid_node_count, user_block_count;
 	int err;
 
 	if (is_inode) {
@@ -1997,10 +2001,11 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 
 	if (!__allow_reserved_blocks(sbi, inode, false))
 		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
+	user_block_count = sbi->user_block_count;
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
-		valid_block_count += sbi->unusable_block_count;
+		user_block_count -= sbi->unusable_block_count;
 
-	if (unlikely(valid_block_count > sbi->user_block_count)) {
+	if (unlikely(valid_block_count > user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
 	}
-- 
2.22.0.rc1.257.g3120a18244-goog

