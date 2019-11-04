Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D619CA9ED4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BD421E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904633;
	bh=iSuchusAehub8/OSSTazSzsq4ZRiyFsHmrWUsdoSclw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lg+N0NsxC0NSouc1wto6U+fOSVqAO9oBQ9iCsRtqbMSNu/FJrgNFk6PPf8frLHy5B
	 NNEZdYBtGIkM/lE8Cd8+8z2PslTIbF1oB4yECos3zbwwXJuIMLf4T6BrIv01/yRpR3
	 jJi7z70nc5DunR2rPRjNyG5BV2mB11efMP4apcnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbfKDV5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:57:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388530AbfKDV5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:57:07 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85739217F4;
        Mon,  4 Nov 2019 21:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904627;
        bh=iSuchusAehub8/OSSTazSzsq4ZRiyFsHmrWUsdoSclw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xV/GsrQcLXPNOmZUOtLOj4io+851Q6b1wQjSOSjvQ2FKKJ6yugUm5Z1CfgLZubB4u
         LpSEXA+zUHCbPk/YWyUvxAQlW20ipXagnpIf5NyZeDgHfJfYOSneoiXtD3pdqETEmz
         arPtUuQ9FAZkPzj/pHCbvEPo9AN/R89ieAqt87zY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/149] f2fs: fix to recover inode->i_flags of inode block during POR
Date:   Mon,  4 Nov 2019 22:43:27 +0100
Message-Id: <20191104212133.874700194@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 0c093b590efb5c1ccdc835868dc2ae94bd2e14dc ]

Testcase to reproduce this bug:
1. mkfs.f2fs /dev/sdd
2. mount -t f2fs /dev/sdd /mnt/f2fs
3. touch /mnt/f2fs/file
4. sync
5. chattr +a /mnt/f2fs/file
6. xfs_io -a /mnt/f2fs/file -c "fsync"
7. godown /mnt/f2fs
8. umount /mnt/f2fs
9. mount -t f2fs /dev/sdd /mnt/f2fs
10. xfs_io /mnt/f2fs/file

There is no error when opening this file w/o O_APPEND, but actually,
we expect the correct result should be:

/mnt/f2fs/file: Operation not permitted

The root cause is, in recover_inode(), we recover inode->i_flags more
than F2FS_I(inode)->i_flags, so fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 281ba46b5b359..2c3be4c3c626f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -226,6 +226,7 @@ static void recover_inode(struct inode *inode, struct page *page)
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
 	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
+	f2fs_set_inode_flags(inode);
 	F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] =
 				le16_to_cpu(raw->i_gc_failures);
 
-- 
2.20.1



