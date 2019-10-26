Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E791CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5658C222C1
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096183;
	bh=wIrmKXoWyrtW1mzcTG0mwLXuPPnsBYNTQNvxyIgDcL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Buw8Bv6fw6qSK3IHF/Bw9Z9gRai6Phyn4Yb78WncjP5I6AzTkVBO3PGLdJ89REiHV
	 j1cpsCTI/4bnL060i9YvLgfW5tLKa0SIXPe/CD2lEZKFXmmW7cd4ydedS3vDHe+PPl
	 nHM3EuGsyJYO0tUXkEGnu7vlGthFSIg2A1z0TN+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfJZNXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729581AbfJZNW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:22:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 325CD21E6F;
        Sat, 26 Oct 2019 13:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096178;
        bh=wIrmKXoWyrtW1mzcTG0mwLXuPPnsBYNTQNvxyIgDcL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjuegvMtXvet//qsh1C11jrUcPUOXjEPhHDj13HvybuFenbqDDWD8YSXEilLdIebi
         /QK2YndhnzKCPZkLYz8R8o6xDepsZ+M8dE2XW0mlTKLt919YXIP2jDnkKV2DBlsJOS
         /bKsyR/k/o5dViVrkx2py2JAuNb3STpSpL+k+8bI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 20/21] ocfs2: fix error handling in ocfs2_setattr()
Date:   Sat, 26 Oct 2019 09:22:16 -0400
Message-Id: <20191026132217.4380-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026132217.4380-1-sashal@kernel.org>
References: <20191026132217.4380-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengguang Xu <cgxu519@mykernel.net>

[ Upstream commit ce750f43f5790de74c1644c39d78f684071658d1 ]

Should set transfer_to[USRQUOTA/GRPQUOTA] to NULL on error case before
jumping to do dqput().

Link: http://lkml.kernel.org/r/20191010082349.1134-1-cgxu519@mykernel.net
Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
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
 fs/ocfs2/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 05a0fb9854f9e..8526589a7cdc5 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1224,6 +1224,7 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
 			transfer_to[USRQUOTA] = dqget(sb, make_kqid_uid(attr->ia_uid));
 			if (IS_ERR(transfer_to[USRQUOTA])) {
 				status = PTR_ERR(transfer_to[USRQUOTA]);
+				transfer_to[USRQUOTA] = NULL;
 				goto bail_unlock;
 			}
 		}
@@ -1233,6 +1234,7 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
 			transfer_to[GRPQUOTA] = dqget(sb, make_kqid_gid(attr->ia_gid));
 			if (IS_ERR(transfer_to[GRPQUOTA])) {
 				status = PTR_ERR(transfer_to[GRPQUOTA]);
+				transfer_to[GRPQUOTA] = NULL;
 				goto bail_unlock;
 			}
 		}
-- 
2.20.1

