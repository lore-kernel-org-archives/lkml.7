Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CF2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A11D20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfDJKp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:45:57 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:41240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730729AbfDJKp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:45:57 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id C9645159ABD44B127B7B;
        Wed, 10 Apr 2019 18:45:55 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 10 Apr 2019 18:45:54 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 10 Apr 2019 18:45:54 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid deadloop in foreground GC
Date:   Wed, 10 Apr 2019 18:45:50 +0800
Message-ID: <20190410104550.82389-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203211

- Overview
When mounting the attached crafted image and making a new file, I got this error and the error messages keep repeating.

The image is intentionally fuzzed from a normal f2fs image for testing and I run with option CONFIG_F2FS_CHECK_FS on.

- Reproduces
mkdir test
mount -t f2fs tmp.img test
cd test
touch t

- Messages
[   58.820451] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.821485] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.822530] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.823571] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.824616] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.825640] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.826663] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.827698] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.828719] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.829759] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.830783] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.831828] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.832869] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.833888] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.834945] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.835996] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.837028] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.838051] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.839072] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.840100] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.841147] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.842186] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.843214] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.844267] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.845282] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.846305] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
[   58.847341] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and SIT
... (repeating)

During GC, if segment type stored in SSA and SIT is inconsistent, we just
skip migrating current segment directly, since we need to know the exact
type to decide the migration function we use.

So in foreground GC, we will easily run into a infinite loop as we may
select the same victim segment which has inconsistent type due to greedy
policy. In order to end up this, we choose to shutdown filesystem. For
backgrond GC, we need to do that as well, so that we can avoid latter
potential infinite looped foreground GC.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ab764bd106de..a66a8752e5f6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1175,6 +1175,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				"type [%d, %d] in SSA and SIT",
 				segno, type, GET_SUM_TYPE((&sum->footer)));
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_stop_checkpoint(sbi, false);
 			goto skip;
 		}
 
-- 
2.18.0.rc1

