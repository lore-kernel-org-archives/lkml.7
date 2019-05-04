Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A36C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1259A20675
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfEDKP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:15:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfEDKP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:15:28 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5BDD631B4B829C42EB22;
        Sat,  4 May 2019 18:15:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Sat, 4 May 2019 18:15:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Anton Altaparmakov <anton@tuxera.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-ntfs-dev@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ntfs: remove set but not used variable 'attr_len'
Date:   Sat, 4 May 2019 10:25:06 +0000
Message-ID: <20190504102506.99020-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/ntfs/inode.c: In function 'ntfs_truncate':
fs/ntfs/inode.c:2357:6: warning:
 variable 'attr_len' set but not used [-Wunused-but-set-variable]

It is never use since introduction in
commit dd072330d1a6 ("NTFS: Implement fs/ntfs/inode.[hc]::ntfs_truncate().
It only supports       uncompressed and unencrypted files.")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ntfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index fb1a2b49a5da..1c8b669e7a52 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2354,7 +2354,6 @@ int ntfs_truncate(struct inode *vi)
 	ATTR_RECORD *a;
 	const char *te = "  Leaving file length out of sync with i_size.";
 	int err, mp_size, size_change, alloc_change;
-	u32 attr_len;
 
 	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
 	BUG_ON(NInoAttr(ni));
@@ -2728,7 +2727,6 @@ int ntfs_truncate(struct inode *vi)
 	 * this cannot fail since we are making the attribute smaller thus by
 	 * definition there is enough space to do so.
 	 */
-	attr_len = le32_to_cpu(a->length);
 	err = ntfs_attr_record_resize(m, a, mp_size +
 			le16_to_cpu(a->data.non_resident.mapping_pairs_offset));
 	BUG_ON(err);



