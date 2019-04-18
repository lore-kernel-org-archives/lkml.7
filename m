Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1307720675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611520;
	bh=2lyiCBU9FjYFYsa2mPpwZ6W58qOtlZI8IJkQGr0g5Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+k6OK3/UIxBtl0LiYayQC5cOWRn8zHPnqDqcnHMd3FA+kWRGD9g2CzdrnhGkfOFP
	 b+ODbzFqs9o+Zrl+gGg7PlthpJKdGkwnNQ4OpdgCtO6+42y+U3QL92brxG07dl4iXI
	 bRBJcJ32eGBM8n0FPXhAjLtS+tPnFwiARhPa7TqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391760AbfDRSSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391689AbfDRSKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0493D206B6;
        Thu, 18 Apr 2019 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611031;
        bh=2lyiCBU9FjYFYsa2mPpwZ6W58qOtlZI8IJkQGr0g5Gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2VMOceRiKi7+tZd+zBZ7ocjYwhQdM8JCsSbMB8u6jFOD7uP/Nm0M6iiTzKwD3dlVY
         vwkmCCDH5U4BtErhnok/F6Nc/Ct11bs6aB8gXTBkNd7jrvRdExItPrO/vyiFSBWORO
         E2hX2xfGUONNMjh9UywOSatXb87p4+z+qvj0GecI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 09/93] ext4: report real fs size after failed resize
Date:   Thu, 18 Apr 2019 19:56:47 +0200
Message-Id: <20190418160437.920334439@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
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



