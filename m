Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2C1C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145A622CEB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149342;
	bh=EZUN6warFmuHuCAzru1zhkp3J+uC5cuJqeHTnXFdn80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kfd6maPwOaCerHfn6QkCyCUTQ1cHnaLdaOwUVUd1MjB0BW54IhZiWSJEjjv0wdZsm
	 2RC3secbFPh/R9g25D+n/6U/agKv07EXMLnXQrb1ifRRYw6wr2dhqj6ApHaPwgAYmv
	 sobOdIEUONrSBYmvf+bfINBCEoy3G7Tsy4s/pGnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbfGZNym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388026AbfGZNmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:42:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883C522CC2;
        Fri, 26 Jul 2019 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148564;
        bh=EZUN6warFmuHuCAzru1zhkp3J+uC5cuJqeHTnXFdn80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltk+6fJZ7DGM/RazKyiJ65ESuHFMW0m9Te63bwk3BNkmVYsHYMLernaQKnX166jHx
         Ed1Dl8esTRPi1wniCTdOl6afRJz1cRBtSpqQjr0qIH+5VYq6+M24Rt/yJQk28jsQhf
         1YCNFzS12yA5TMZF/VPxYm8Qx55SE63+YeDtXalo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 20/47] ceph: return -ERANGE if virtual xattr value didn't fit in buffer
Date:   Fri, 26 Jul 2019 09:41:43 -0400
Message-Id: <20190726134210.12156-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
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
index 996ee87b1eaf..7e6d3df99f2f 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -79,7 +79,7 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 	const char *ns_field = " pool_namespace=";
 	char buf[128];
 	size_t len, total_len = 0;
-	int ret;
+	ssize_t ret;
 
 	pool_ns = ceph_try_get_string(ci->i_layout.pool_ns);
 
@@ -103,11 +103,8 @@ static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
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
@@ -817,8 +814,11 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
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

