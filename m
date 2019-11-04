Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55256CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2838821850
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904406;
	bh=g+wi91HW9+cZs9M5/NkuPzE5YUQtA1qquDKeM0/R1KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VNhcoSsScTCGhHRo7GNmiHJcdPtugnrCeKOQ1jFUfCHO+l79hTalR1+l4fZJsdTCB
	 CpoQuvwCNCtBVwwHnFCSAYfI4w97iAbLdq/yk2LKGZapP7yu2pGeVFt/luC6+lTqQ0
	 6Wse9wpXzOBo5oN/aGOQV4M0IAvCDz0qVC6GZhVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfKDVxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbfKDVxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:53:20 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E0A2053B;
        Mon,  4 Nov 2019 21:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904399;
        bh=g+wi91HW9+cZs9M5/NkuPzE5YUQtA1qquDKeM0/R1KA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyJCpkgtACcte+yUHHQSWJkI7giNr5GvNGiDU7ErAYzNUA9LQdNnLFqP4zWO8C4gP
         6q8YjpKkSLw3uHxbjOcfRX14ofx8bRd6xFF0YGR/W7N6jNDDzduhtDCcksL5TM1IBh
         01IZUox1GKuKZzvzA75LIN/ZR982mOsUXN6ojgw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 06/95] f2fs: flush quota blocks after turnning it off
Date:   Mon,  4 Nov 2019 22:44:04 +0100
Message-Id: <20191104212040.828524358@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index e70975ca723b7..0f3209b23c940 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1523,6 +1523,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
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
 
 int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
-- 
2.20.1



