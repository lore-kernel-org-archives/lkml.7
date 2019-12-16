Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68304C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DD42082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522078;
	bh=fILLnvAxvEczC53mWgcn9FqojH3F0b9g/obpbhr42SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g3M711upUI3dosbFNT4uK3kfNTYxQegP46j3sBUBqWzp6XbFMKtdGvxBYi9mSVbwJ
	 DRHI8BilbzL4SsemtCSlNUWRdyF8KqKFrrNVh8B6Vz/F82rIKB9me/s0A30NBtSKbw
	 4/TR64d6ca37fcnRJqY031YTuKagkM/rztKqJJvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfLPRyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:54:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfLPRyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:54:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F4120663;
        Mon, 16 Dec 2019 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518876;
        bh=fILLnvAxvEczC53mWgcn9FqojH3F0b9g/obpbhr42SQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/gBQ4MOIlmSUjbFsyWtcrhmeMZcEGMPCDNKpj+9SehLSGJq7pFS6LsGWEPeTiCHM
         cqA+IXeOX59yVi6sVHZVvPiRPrnlbWmovnzScC/5q5tTYhMelktY3svlA0P8LXcQ1h
         3A9pHR3ojjUbSg5+TcI7XMhuFhvuZJOJP9dzJUc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlong Song <yunlong.song@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 066/267] f2fs: change segment to section in f2fs_ioc_gc_range
Date:   Mon, 16 Dec 2019 18:46:32 +0100
Message-Id: <20191216174856.049950091@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunlong Song <yunlong.song@huawei.com>

[ Upstream commit 67b0e42b768c9ddc3fd5ca1aee3db815cfaa635c ]

f2fs_ioc_gc_range skips blocks_per_seg each time, however, f2fs_gc moves
blocks of section each time, so fix it from segment to section.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d68b0132718a6..a90173b856f6d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2029,7 +2029,7 @@ do_more:
 	}
 
 	ret = f2fs_gc(sbi, range.sync, true, GET_SEGNO(sbi, range.start));
-	range.start += sbi->blocks_per_seg;
+	range.start += BLKS_PER_SEC(sbi);
 	if (range.start <= end)
 		goto do_more;
 out:
-- 
2.20.1



