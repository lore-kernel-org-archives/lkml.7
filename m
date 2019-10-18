Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A7F21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436799;
	bh=LtgV19MgtfFX69rc+LOivsTvlCGFkpIRKuEDQjfkHRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OOyMtHhA+qmnbalbX7xyPA+SB6ekfke0+IK579gwbYatYSodODh5ZBt/1VYPJF4mU
	 1mYfwrsEvVVJhqqlXMQ0yP0RreRPDQUxdsY6ZlF5hV93LMoDwIiOl1ONK0afUgx26V
	 vZ/B9ktrabhvdMhpLkDQ9/Ut5e+Zba0Bz5ewsKxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391922AbfJRWNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389538AbfJRWJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:09:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C7C2247F;
        Fri, 18 Oct 2019 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436598;
        bh=LtgV19MgtfFX69rc+LOivsTvlCGFkpIRKuEDQjfkHRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9vrcw2iufThw41x0SXf6DLPt/YrH47MNF8lCCuLH2itRJQJw7196GrLxJ3EKPfBM
         jXJzIyyVyWe1XJ2XkU+KHn9vPkadMyp9nhY6UigK5qaZnrjEFiDI27BHa9ABYnfF3R
         l0c566RoSijYfVIyew2J5hZzZ3D0VoLyaGM+wa+M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 22/29] fs: ocfs2: fix a possible null-pointer dereference in ocfs2_info_scan_inode_alloc()
Date:   Fri, 18 Oct 2019 18:09:13 -0400
Message-Id: <20191018220920.10545-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220920.10545-1-sashal@kernel.org>
References: <20191018220920.10545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 2abb7d3b12d007c30193f48bebed781009bebdd2 ]

In ocfs2_info_scan_inode_alloc(), there is an if statement on line 283
to check whether inode_alloc is NULL:

    if (inode_alloc)

When inode_alloc is NULL, it is used on line 287:

    ocfs2_inode_lock(inode_alloc, &bh, 0);
        ocfs2_inode_lock_full_nested(inode, ...)
            struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);

Thus, a possible null-pointer dereference may occur.

To fix this bug, inode_alloc is checked on line 286.

This bug is found by a static analysis tool STCheck written by us.

Link: http://lkml.kernel.org/r/20190726033717.32359-1-baijiaju1990@gmail.com
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index 4506ec5ec2ea6..bfc44644301ca 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -289,7 +289,7 @@ static int ocfs2_info_scan_inode_alloc(struct ocfs2_super *osb,
 	if (inode_alloc)
 		inode_lock(inode_alloc);
 
-	if (o2info_coherent(&fi->ifi_req)) {
+	if (inode_alloc && o2info_coherent(&fi->ifi_req)) {
 		status = ocfs2_inode_lock(inode_alloc, &bh, 0);
 		if (status < 0) {
 			mlog_errno(status);
-- 
2.20.1

