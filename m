Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E5FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009402173E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405961AbfHIIpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:45:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfHIIpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:45:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 99DA8DB8D5F1A4BCE188;
        Fri,  9 Aug 2019 16:45:50 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 16:45:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dhowells@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-afs@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] afs: use correct afs_call_type in yfs_fs_store_opaque_acl2
Date:   Fri, 9 Aug 2019 16:43:23 +0800
Message-ID: <20190809084323.46204-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that 'yfs_RXYFSStoreOpaqueACL2' should be use in
yfs_fs_store_opaque_acl2().

Fixes: f5e4546347bc ("afs: Implement YFS ACL setting")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/afs/yfsclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 2575503..ca24528 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -2171,7 +2171,7 @@ int yfs_fs_store_opaque_acl2(struct afs_fs_cursor *fc, const struct afs_acl *acl
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
 	size = round_up(acl->size, 4);
-	call = afs_alloc_flat_call(net, &yfs_RXYFSStoreStatus,
+	call = afs_alloc_flat_call(net, &yfs_RXYFSStoreOpaqueACL2,
 				   sizeof(__be32) * 2 +
 				   sizeof(struct yfs_xdr_YFSFid) +
 				   sizeof(__be32) + size,
-- 
2.7.4


