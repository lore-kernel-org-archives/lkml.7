Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7EAC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79932133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JDbo4KS1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HB/Yz2cN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfE0KiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:38:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfE0KiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:38:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7AEB560303; Mon, 27 May 2019 10:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558953486;
        bh=/Ncx2dTU4iPDuDOHevb/0Hm7K1eR/1l1da6675acaXo=;
        h=From:To:Cc:Subject:Date:From;
        b=JDbo4KS1r8G/D9AeKWP8FfHlfUDrrNKz3xHRtoc8QIVJDVMZNuDX5TVwboIH7yUyL
         ze6dnH31GSd29UhMpWHzyL2O8T0Mj3Jpoaxm5WedXpA/QHI4Z0c2Sdt5tNaaQxLYWH
         nYtLp4NbdK3AlTg7v6x6o6LlANIcthLg6ZThrjgI=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D88E60252;
        Mon, 27 May 2019 10:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558953485;
        bh=/Ncx2dTU4iPDuDOHevb/0Hm7K1eR/1l1da6675acaXo=;
        h=From:To:Cc:Subject:Date:From;
        b=HB/Yz2cN+KAbZF5y4AQf72vH5b4R5zj+IUKAvJzgHL2zVBuu5r1ADagr4wyXFnX65
         lD5R+YwaWsR1HobeDAcR6jGh5Ce45HRpWYFwEdT4IF6McdXo6Nkok4YBUhjWy0PJ/Y
         5g76QMN3d0gX2u3MyQQm1S35nUAbdpvvaYTLs/F0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D88E60252
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: ratelimit recovery messages
Date:   Mon, 27 May 2019 16:07:55 +0530
Message-Id: <1558953475-5258-1-git-send-email-stummala@codeaurora.org>
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
 fs/f2fs/recovery.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index e04f82b..38b3b24a 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -188,8 +188,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 		name = "<encrypted>";
 	else
 		name = raw_inode->i_name;
-	f2fs_msg(inode->i_sb, KERN_NOTICE,
-			"%s: ino = %x, name = %s, dir = %lx, err = %d",
+	printk_ratelimited(KERN_NOTICE "%s: ino = %x, name = %s, dir = %lx, err = %d",
 			__func__, ino_of_node(ipage), name,
 			IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
@@ -292,8 +291,7 @@ static int recover_inode(struct inode *inode, struct page *page)
 	else
 		name = F2FS_INODE(page)->i_name;
 
-	f2fs_msg(inode->i_sb, KERN_NOTICE,
-		"recover_inode: ino = %x, name = %s, inline = %x",
+	printk_ratelimited(KERN_NOTICE "recover_inode: ino = %x, name = %s, inline = %x",
 			ino_of_node(page), name, raw->i_inline);
 	return 0;
 }
@@ -642,10 +640,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 err:
 	f2fs_put_dnode(&dn);
 out:
-	f2fs_msg(sbi->sb, KERN_NOTICE,
-		"recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d",
-		inode->i_ino,
-		file_keep_isize(inode) ? "keep" : "recover",
+	printk_ratelimited(KERN_NOTICE "recover_data: ino = %lx (i_size: %s) recovered = %d, err = %d",
+		inode->i_ino, file_keep_isize(inode) ? "keep" : "recover",
 		recovered, err);
 	return err;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

