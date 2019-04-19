Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3565FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0277521736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfDSDno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:43:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbfDSDno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:43:44 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id C9D275459B0641D7A75C;
        Fri, 19 Apr 2019 11:43:39 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 19 Apr 2019 11:43:39 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 19 Apr 2019 11:43:39 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: relocate chksum_offset for large_nat_bitmap feature
Date:   Fri, 19 Apr 2019 11:43:33 +0800
Message-ID: <20190419034333.80383-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For large_nat_bitmap feature, there is a design flaw:

Previous:

struct f2fs_checkpoint layout:
+--------------------------+  0x0000
| checkpoint_ver           |
| ......                   |
| checksum_offset          |------+
| ......                   |      |
| sit_nat_version_bitmap[] |<-----|-------+
| ......                   |      |       |
| checksum_value           |<-----+       |
+--------------------------+  0x1000      |
|                          |      nat_bitmap + sit_bitmap
| payload blocks           |              |
|                          |              |
+--------------------------|<-------------+

Obviously, if nat_bitmap size + sit_bitmap size is larger than
MAX_BITMAP_SIZE_IN_CKPT, nat_bitmap or sit_bitmap may overlap
checkpoint checksum's position, once checkpoint() is triggered
from kernel, nat or sit bitmap will be damaged by checksum field.

In order to fix this, let's relocate checksum_value's position
to the head of sit_nat_version_bitmap as below, then nat/sit
bitmap and chksum value update will become safe.

After:

struct f2fs_checkpoint layout:
+--------------------------+  0x0000
| checkpoint_ver           |
| ......                   |
| checksum_offset          |------+
| ......                   |      |
| sit_nat_version_bitmap[] |<-----+
| ......                   |<-------------+
|                          |              |
+--------------------------+  0x1000      |
|                          |      nat_bitmap + sit_bitmap
| payload blocks           |              |
|                          |              |
+--------------------------|<-------------+

Related report and discussion:

https://sourceforge.net/p/linux-f2fs/mailman/message/36642346/

Reported-by: Park Ju Hyung <qkrwngud825@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 31531711e148..f5ffc09705eb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1911,7 +1911,11 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 	if (is_set_ckpt_flags(sbi, CP_LARGE_NAT_BITMAP_FLAG)) {
 		offset = (flag == SIT_BITMAP) ?
 			le32_to_cpu(ckpt->nat_ver_bitmap_bytesize) : 0;
-		return &ckpt->sit_nat_version_bitmap + offset;
+		/*
+		 * if large_nat_bitmap feature is enabled, leave checksum
+		 * protection for all nat/sit bitmaps.
+		 */
+		return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
 	}
 
 	if (__cp_payload(sbi) > 0) {
-- 
2.18.0.rc1

