Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D17C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C6C2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612446;
	bh=2lyiCBU9FjYFYsa2mPpwZ6W58qOtlZI8IJkQGr0g5Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S04P0lDP//HvTLC7Vanr6iZ70litAzTNlJnm6anQwJjWWfEecuHQjkY71G621e1Mn
	 FOq+FDRcX4glcAXDdobJfsO/kJ4rJriX2XjIySiJSaPCKEDFk+vp4oncrqNAQCC9ff
	 /i7c/ZJqUUpTKeVbua0Kw34tzAVh28E4CxWIAvOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390049AbfDRR7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390014AbfDRR67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:58:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3AEA217FA;
        Thu, 18 Apr 2019 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610339;
        bh=2lyiCBU9FjYFYsa2mPpwZ6W58qOtlZI8IJkQGr0g5Gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2YUU0ntLuyuG4GCg7ZvaWtDUDUXDZhLve0X6d+U/ja0DOtKwp+W8Si6YNoTnGOcC
         HrmkTBijD4eyz12iVO6dhYft5ezhob0Yq+LCZ3xLejTUXv2HbUiU/FkpP3OGWz/8tE
         0ByWgI2UopduPAba6bA/kogrbg7SO82EAK5OVZr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 008/110] ext4: report real fs size after failed resize
Date:   Thu, 18 Apr 2019 19:55:57 +0200
Message-Id: <20190418160438.217446887@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6c7328400e0488f7d49e19e02290ba343b6811b2 ]

Currently when the file system resize using ext4_resize_fs() fails it
will report into log that "resized filesystem to <requested block
count>".  However this may not be true in the case of failure.  Use the
current block count as returned by ext4_blocks_count() to report the
block count.

Additionally, report a warning that "error occurred during file system
resize"

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/resize.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 90061c3d048b..e7ae26e36c9c 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -2080,6 +2080,10 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 		free_flex_gd(flex_gd);
 	if (resize_inode != NULL)
 		iput(resize_inode);
-	ext4_msg(sb, KERN_INFO, "resized filesystem to %llu", n_blocks_count);
+	if (err)
+		ext4_warning(sb, "error (%d) occurred during "
+			     "file system resize", err);
+	ext4_msg(sb, KERN_INFO, "resized filesystem to %llu",
+		 ext4_blocks_count(es));
 	return err;
 }
-- 
2.19.1



