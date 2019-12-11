Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63607C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB2C21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078753;
	bh=apbpHZOPY+eoKmJGXAD11PZAtKiJhYDrucqq6ys+9tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+tQpWZRB0uAefEWykP5T75SVEEvfqcTkgbi+8/DlPF4odDMy9XzkruS5voNCGtKp
	 LsYdhX1EDgBpvPpTzvnP1YHoes4UdRAxDkNm530qfc/ue/7+OeU2eACaakePSvy6yd
	 UEy1VKiIxIJhpyYuM2mKuPTqO2cPxh/mh4InKVQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbfLKPjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730621AbfLKPix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:38:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 835C2222C4;
        Wed, 11 Dec 2019 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078732;
        bh=apbpHZOPY+eoKmJGXAD11PZAtKiJhYDrucqq6ys+9tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tb0KgBRDDbvFJKZJUtAD204a6PX/1QZcDbtDXNzWh4ERUmsFOols0rNJZa/Cfvoee
         tCZ2Jq4rn+LkfP/kcA/TUNm85cPs2Mqtw5yLCeQubpnLyk4wwl40pMjp/tmnwRAqK6
         701EdFK0jfZe6lxvI5g631Txgt+VdSdyRkZvhP74=
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
Subject: [PATCH AUTOSEL 4.4 36/37] ocfs2: fix passing zero to 'PTR_ERR' warning
Date:   Wed, 11 Dec 2019 10:38:12 -0500
Message-Id: <20191211153813.24126-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211153813.24126-1-sashal@kernel.org>
References: <20191211153813.24126-1-sashal@kernel.org>
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
index 1e0d8da0d3cd6..80b92120c8120 100644
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

