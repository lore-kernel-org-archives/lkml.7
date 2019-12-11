Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA956C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C772073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079940;
	bh=G/WSFKooNhL1hNUubKFq8v8Gq21Z1DJ47TPnJvIWq2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ExloqS89wLOvDgwfG1s/1X8EUZPmPsLntxSzWfgKfEvPDKFlX52tmnqTUZKvgLhGx
	 hUg3+5qnS0v52lhdLbwQm9uRR92UwaqOxjKNcmtzXCo90o3yezrQgVQhvhhDQ8QeN6
	 Ikz61ERRfKu61W3duh1+4ickNGmCGFvqchzLMUFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbfLKP67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731595AbfLKPOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2BD2467E;
        Wed, 11 Dec 2019 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077251;
        bh=G/WSFKooNhL1hNUubKFq8v8Gq21Z1DJ47TPnJvIWq2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1b5nt8mMDBqU8PvS34An6EeXngidx5BVDnzrKc9kCm+4/RY8AFkeMxwPZ6Kk14BH
         c0mgVt8QDakyv6cYlqNMk+1GPWNwpO1XObKDb+em1M9ky84pYPkUCbSGEQsrTR+n3o
         ay8UGs08Wg2eFANMI02WeZpQnZeHDjYcPSvS0ptQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, ocfs2-devel@oss.oracle.com
Subject: [PATCH AUTOSEL 5.4 128/134] ocfs2: fix passing zero to 'PTR_ERR' warning
Date:   Wed, 11 Dec 2019 10:11:44 -0500
Message-Id: <20191211151150.19073-128-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

[ Upstream commit 188c523e1c271d537f3c9f55b6b65bf4476de32f ]

Fix a static code checker warning:
fs/ocfs2/acl.c:331
	ocfs2_acl_chmod() warn: passing zero to 'PTR_ERR'

Link: http://lkml.kernel.org/r/1dee278b-6c96-eec2-ce76-fe6e07c6e20f@linux.alibaba.com
Fixes: 5ee0fbd50fd ("ocfs2: revert using ocfs2_acl_chmod to avoid inode cluster lock hang")
Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
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
 fs/ocfs2/acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 3e7da392aa6f8..bb981ec76456b 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -327,8 +327,8 @@ int ocfs2_acl_chmod(struct inode *inode, struct buffer_head *bh)
 	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	acl = ocfs2_get_acl_nolock(inode, ACL_TYPE_ACCESS, bh);
 	up_read(&OCFS2_I(inode)->ip_xattr_sem);
-	if (IS_ERR(acl) || !acl)
-		return PTR_ERR(acl);
+	if (IS_ERR_OR_NULL(acl))
+		return PTR_ERR_OR_ZERO(acl);
 	ret = __posix_acl_chmod(&acl, GFP_KERNEL, inode->i_mode);
 	if (ret)
 		return ret;
-- 
2.20.1

