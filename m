Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E2C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0527022BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148636;
	bh=uhH9P+Aaagp/XwlCOCFutSHhmpwD4V84LUUcvSV0RTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G9/6I3hLa/qjEkCFi7YxyvjGvIJ034eELMXh73J4xvR+s/T3VW+FCEfIWkb+8qgJG
	 IaP+m/6N/iiJwVDbIHjI9eQvwxt1asbw6CVSSVizS8OtmJvg+0WR4ztj9mF58UUrWq
	 9itSKSVt9AWYDY+VUcqTW/09vRKP6VYJTw9YSbCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbfGZNny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbfGZNnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:43:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81B622CD7;
        Fri, 26 Jul 2019 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148631;
        bh=uhH9P+Aaagp/XwlCOCFutSHhmpwD4V84LUUcvSV0RTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCupW3gxqcjvnv+4dhXETrsj6/PWgj21p52pzTkDcOCLVPy7Gee9Dk70MeaG3DYdb
         97fOF5R1DyuRlUyBzL/Fd/ukCzTT56JIu3+8OI7g9q/8T8alGGYAdTIqZr5DEXbhgu
         +f8KEFzWTzg/1oY8oi/+R+LgBd0bIfTxozHGbJa0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 14/37] ceph: return -ERANGE if virtual xattr value didn't fit in buffer
Date:   Fri, 26 Jul 2019 09:43:09 -0400
Message-Id: <20190726134332.12626-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134332.12626-1-sashal@kernel.org>
References: <20190726134332.12626-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 3b421018f48c482bdc9650f894aa1747cf90e51d ]

The getxattr manpage states that we should return ERANGE if the
destination buffer size is too small to hold the value.
ceph_vxattrcb_layout does this internally, but we should be doing
this for all vxattrs.

Fix the only caller of getxattr_cb to check the returned size
against the buffer length and return -ERANGE if it doesn't fit.
Drop the same check in ceph_vxattrcb_layout and just rely on the
caller to handle it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Acked-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/xattr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index e1c4e0b12b4c..0376db8a74f8 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -75,7 +75,7 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 	const char *ns_field = " pool_namespace=";
 	char buf[128];
 	size_t len, total_len = 0;
-	int ret;
+	ssize_t ret;
 
 	pool_ns = ceph_try_get_string(ci->i_layout.pool_ns);
 
@@ -99,11 +99,8 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 	if (pool_ns)
 		total_len += strlen(ns_field) + pool_ns->len;
 
-	if (!size) {
-		ret = total_len;
-	} else if (total_len > size) {
-		ret = -ERANGE;
-	} else {
+	ret = total_len;
+	if (size >= total_len) {
 		memcpy(val, buf, len);
 		ret = len;
 		if (pool_name) {
@@ -761,8 +758,11 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 		if (err)
 			return err;
 		err = -ENODATA;
-		if (!(vxattr->exists_cb && !vxattr->exists_cb(ci)))
+		if (!(vxattr->exists_cb && !vxattr->exists_cb(ci))) {
 			err = vxattr->getxattr_cb(ci, value, size);
+			if (size && size < err)
+				err = -ERANGE;
+		}
 		return err;
 	}
 
-- 
2.20.1

