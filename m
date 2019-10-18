Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA37205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437387;
	bh=AJVWB7TLbX40U29Q4POdrtB+H1Pg+a1SVyDpypxpocM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q/Ky9szurpahFO+Bls3/MMyHxk60a7ImCo++s0NriQGndZagxHsX83VVcF7Q86brb
	 gFbC2FLuLiGrXreexM/+OMKLG4Y4UJVHabzDU/0JH0TG+pONilZ8+ZeQOPZzjeMi/w
	 R1X0nfmtwVEDZG1eqQWcVRIN4IR8Lau2GJbu5OFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfJRWXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfJRWF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:05:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75099222D1;
        Fri, 18 Oct 2019 22:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436328;
        bh=AJVWB7TLbX40U29Q4POdrtB+H1Pg+a1SVyDpypxpocM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhLagNsWHIMX1ilIwr/bQyX0uur6IuYHg8oLiqE9qXS4cPmbPfKaLKphKYooKCR+E
         dIQgQbn9GDgqPh97cYlcQUYUxU3fRankx02iza1Dv5ZWpv25LjzKwqjQTjYaAuE3N4
         278RhS3/1waJcqV7wibhiOKA/2MOTSR/XZQQkaaU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 002/100] f2fs: flush quota blocks after turnning it off
Date:   Fri, 18 Oct 2019 18:03:47 -0400
Message-Id: <20191018220525.9042-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 0e0667b625cf64243df83171bff61f9d350b9ca5 ]

After quota_off, we'll get some dirty blocks. If put_super don't have a chance
to flush them by checkpoint, it causes NULL pointer exception in end_io after
iput(node_inode). (e.g., by checkpoint=disable)

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fdafcfd8b20e2..4ec57d538c15c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1886,6 +1886,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
 			set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
 		}
 	}
+	/*
+	 * In case of checkpoint=disable, we must flush quota blocks.
+	 * This can cause NULL exception for node_inode in end_io, since
+	 * put_super already dropped it.
+	 */
+	sync_filesystem(sb);
 }
 
 static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
-- 
2.20.1

