Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D60C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20AC20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004811;
	bh=YQaGtvdPkCyGlkVgJ0R45zBbXZGNYd7ph6U3pDQ7TXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIUQGzV9b2vBBksxTjVvirf84xkNJVg/hEkoUnk4HTXPM1wKK2oniQ2fZ6yFiMrws
	 NUNmtBqbVhfw3k6IDNxH7+8Oylu9Dq6Ap4sGzPHN5uG/zOFSnBQvZuNVi3uRjGIMxP
	 t2XWikND3wZUwYwP2yIAuj1ojYpnmAm3zjn9x2/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgABWkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:53080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731328AbgABWik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:38:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2378D21835;
        Thu,  2 Jan 2020 22:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004719;
        bh=YQaGtvdPkCyGlkVgJ0R45zBbXZGNYd7ph6U3pDQ7TXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoV43hYjcoLNN9X9k+ojHTeHYD6ZHZrXiu61YhdMPVtD1lJYpjhQkKFpa50xIaMWl
         jx7qZspOEnP6ztRKcGMnnoQnwSsUtectqxOEq9Nk9yRnHnVuAyymToMyGNhl5AwSvs
         8YEBglH/jm0NzSN58y2pfcduW0lrE+aosnzFUz1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 125/137] ocfs2: fix passing zero to PTR_ERR warning
Date:   Thu,  2 Jan 2020 23:08:18 +0100
Message-Id: <20200102220604.007998694@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 1e0d8da0d3cd..80b92120c812 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -338,8 +338,8 @@ int ocfs2_acl_chmod(struct inode *inode, struct buffer_head *bh)
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



