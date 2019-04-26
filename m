Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E7C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365132084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDZJ6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:58:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:32914 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbfDZJ6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:58:07 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 318BED9BDCD132DB3861;
        Fri, 26 Apr 2019 17:58:03 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 26 Apr 2019 17:58:02 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 26 Apr 2019 17:58:01 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        <drosen@google.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to handle error in f2fs_disable_checkpoint()
Date:   Fri, 26 Apr 2019 17:57:54 +0800
Message-ID: <20190426095754.85784-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190426095754.85784-1-yuchao0@huawei.com>
References: <20190426095754.85784-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_disable_checkpoint(), it needs to detect and propagate error
number returned from f2fs_write_checkpoint().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fcc9793dbc2c..ad0faa19cb69 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1507,9 +1507,12 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	mutex_lock(&sbi->gc_mutex);
 	cpc.reason = CP_PAUSE;
 	set_sbi_flag(sbi, SBI_CP_DISABLED);
-	f2fs_write_checkpoint(sbi, &cpc);
+	err = f2fs_write_checkpoint(sbi, &cpc);
+	if (err)
+		goto out_unlock;
 
 	sbi->unusable_block_count = 0;
+out_unlock:
 	mutex_unlock(&sbi->gc_mutex);
 restore_flag:
 	sbi->sb->s_flags = s_flags;	/* Restore MS_RDONLY status */
-- 
2.18.0.rc1

