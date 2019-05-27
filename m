Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDB9C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283FD20815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MmnicGkR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VEWjIQOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfE0NLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:11:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0NLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:11:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D32D6019D; Mon, 27 May 2019 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558962671;
        bh=vgQHKjatuuR2l1jDszVWwCc/xyVrmWfL4GYi56xMaTY=;
        h=From:To:Cc:Subject:Date:From;
        b=MmnicGkRTYq9gwqqJLY1E7kWPavHb/K56l7da0LKv0ULSS2rKnxJW8l9EbvYtsmfn
         ui2SsoLOaOVyQaI0pDhU6XO6vE8hElxq8lGy9eWlg8q5Sdk0g0wMY/Ex0boV4rOnk7
         0kW7uvixMt4eHYuMzmL1PjmJIidau8jIB6ROp+tQ=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3FDB6019D;
        Mon, 27 May 2019 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558962670;
        bh=vgQHKjatuuR2l1jDszVWwCc/xyVrmWfL4GYi56xMaTY=;
        h=From:To:Cc:Subject:Date:From;
        b=VEWjIQOwqdA0P1ReYmBt320WWrqap1AU8BbKYGiflJ7uvOFqtZhtwQJF6xchI/528
         eu2lAv2LCAlp6sGlXmqigxP0eSJENQlhW/1OJtQscI87gBosjv9oVtZiAzE98Erevo
         0e49zF8c/L9J7rtMTRlkiZDz28+IXGjsedIs03NU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3FDB6019D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: ratelimit recovery messages
Date:   Mon, 27 May 2019 18:40:55 +0530
Message-Id: <1558962655-25994-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ratelimit the recovery logs, which are expected in case
of sudden power down and which could result into too
many prints.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
 - fix minor formatting and add new line for printk

 fs/f2fs/recovery.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index e04f82b..60d7652 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -188,8 +188,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 		name = "<encrypted>";
 	else
 		name = raw_inode->i_name;
-	f2fs_msg(inode->i_sb, KERN_NOTICE,
-			"%s: ino = %x, name = %s, dir = %lx, err = %d",
+	printk_ratelimited(KERN_NOTICE
+			"%s: ino = %x, name = %s, dir = %lx, err = %d\n",
 			__func__, ino_of_node(ipage), name,
 			IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
@@ -292,8 +292,8 @@ static int recover_inode(struct inode *inode, struct page *page)
 	else
 		name = F2FS_INODE(page)->i_name;
 
-	f2fs_msg(inode->i_sb, KERN_NOTICE,
-		"recover_inode: ino = %x, name = %s, inline = %x",
+	printk_ratelimited(KERN_NOTICE
+			"recover_inode: ino = %x, name = %s, inline = %x\n",
 			ino_of_node(page), name, raw->i_inline);
 	return 0;
 }
@@ -642,11 +642,11 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 err:
 	f2fs_put_dnode(&dn);
 out:
-	f2fs_msg(sbi->sb, KERN_NOTICE,
-		"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d",
-		inode->i_ino,
-		file_keep_isize(inode) ? "keep" : "recover",
-		recovered, err);
+	printk_ratelimited(KERN_NOTICE
+			"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d\n",
+			inode->i_ino,
+			file_keep_isize(inode) ? "keep" : "recover",
+			recovered, err);
 	return err;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

