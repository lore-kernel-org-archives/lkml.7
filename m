Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ACBC43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E2214DE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141848;
	bh=WlfZxGvFtSLI+pDvBdYGRlWued5mo0mUhIgQQNCXeqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=taCKCtcJ64m+gvpml6XGW5m2PDFm0OyAX5UQglVQdNc2icD96i2PB0ROeobfJ6UYc
	 w70JWXr92Ggw09+il/o17M16JquU/lIspxP1MDe7UI6rzOTxFmXPKPJkrFjL3pUNIa
	 ci5OGIds6gENJo2by98iJNtNseRKE4n2rYtffOPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfKSFh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:37:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfKSFhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:37:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A521621939;
        Tue, 19 Nov 2019 05:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141845;
        bh=WlfZxGvFtSLI+pDvBdYGRlWued5mo0mUhIgQQNCXeqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hPvu/+5EpgmPn0MWZxuF0bbCp3eam5ENBZdHSDfYaxyvZc5I2lVPWhWAGD7V+T1R
         QsZf6JqWOo6uDAkdrSaiBdEm4bcQDWdkUYjdNPVuDoGo8dmWhp8DFVuRzwltQmboQg
         W78Kplh1eLYmqGJOzaXR+x+AFoDM/FdeO7m8oBy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 299/422] f2fs: fix to recover inodes uid/gid during POR
Date:   Tue, 19 Nov 2019 06:18:16 +0100
Message-Id: <20191119051418.378313400@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit dc4cd1257c86451cec3e8e352cc376348e4f4af4 ]

Step to reproduce this bug:
1. logon as root
2. mount -t f2fs /dev/sdd /mnt;
3. touch /mnt/file;
4. chown system /mnt/file; chgrp system /mnt/file;
5. xfs_io -f /mnt/file -c "fsync";
6. godown /mnt;
7. umount /mnt;
8. mount -t f2fs /dev/sdd /mnt;

After step 8) we will expect file's uid/gid are all system, but during
recovery, these two fields were not been recovered, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 2c3be4c3c626f..2c5d2c25d37e3 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -216,6 +216,8 @@ static void recover_inode(struct inode *inode, struct page *page)
 	char *name;
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
+	i_uid_write(inode, le32_to_cpu(raw->i_uid));
+	i_gid_write(inode, le32_to_cpu(raw->i_gid));
 	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
 	inode->i_atime.tv_sec = le64_to_cpu(raw->i_atime);
 	inode->i_ctime.tv_sec = le64_to_cpu(raw->i_ctime);
-- 
2.20.1



