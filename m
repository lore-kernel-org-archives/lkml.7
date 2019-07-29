Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A79C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331402075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfG2Gwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:52:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfG2Gw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 21B1FA02D945F686E4E7;
        Mon, 29 Jul 2019 14:52:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:15 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 02/22] staging: erofs: rename source files for better understanding
Date:   Mon, 29 Jul 2019 14:51:39 +0800
Message-ID: <20190729065159.62378-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep in line with erofs-outofstaging patchset as well, see
https://lore.kernel.org/linux-fsdevel/20190725095658.155779-1-gaoxiang25@huawei.com/

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/Makefile                     | 2 +-
 drivers/staging/erofs/{include/linux => }/tagptr.h | 6 +++---
 drivers/staging/erofs/{unzip_vle.c => zdata.c}     | 4 ++--
 drivers/staging/erofs/{unzip_vle.h => zdata.h}     | 8 ++++----
 drivers/staging/erofs/{unzip_pagevec.h => zpvec.h} | 8 ++++----
 5 files changed, 14 insertions(+), 14 deletions(-)
 rename drivers/staging/erofs/{include/linux => }/tagptr.h (97%)
 rename drivers/staging/erofs/{unzip_vle.c => zdata.c} (99%)
 rename drivers/staging/erofs/{unzip_vle.h => zdata.h} (97%)
 rename drivers/staging/erofs/{unzip_pagevec.h => zpvec.h} (96%)

diff --git a/drivers/staging/erofs/Makefile b/drivers/staging/erofs/Makefile
index 3ade87e78d06..5cdae21cb5af 100644
--- a/drivers/staging/erofs/Makefile
+++ b/drivers/staging/erofs/Makefile
@@ -9,5 +9,5 @@ obj-$(CONFIG_EROFS_FS) += erofs.o
 ccflags-y += -I $(srctree)/$(src)/include
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o zmap.o decompressor.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
 
diff --git a/drivers/staging/erofs/include/linux/tagptr.h b/drivers/staging/erofs/tagptr.h
similarity index 97%
rename from drivers/staging/erofs/include/linux/tagptr.h
rename to drivers/staging/erofs/tagptr.h
index b3f13773fb99..a72897c86744 100644
--- a/drivers/staging/erofs/include/linux/tagptr.h
+++ b/drivers/staging/erofs/tagptr.h
@@ -4,8 +4,8 @@
  *
  * Copyright (C) 2018 Gao Xiang <gaoxiang25@huawei.com>
  */
-#ifndef _LINUX_TAGPTR_H
-#define _LINUX_TAGPTR_H
+#ifndef __EROFS_FS_TAGPTR_H
+#define __EROFS_FS_TAGPTR_H
 
 #include <linux/types.h>
 #include <linux/build_bug.h>
@@ -106,5 +106,5 @@ tagptr_init(o, cmpxchg(&ptptr->v, o.v, n.v)); })
 	ptptr->v &= ~tags; \
 *ptptr; })
 
-#endif
+#endif	/* __EROFS_FS_TAGPTR_H */
 
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/zdata.c
similarity index 99%
rename from drivers/staging/erofs/unzip_vle.c
rename to drivers/staging/erofs/zdata.c
index 28a98e79c1e9..f7667628bbf1 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/zdata.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/unzip_vle.c
+ * linux/drivers/staging/erofs/zdata.c
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
-#include "unzip_vle.h"
+#include "zdata.h"
 #include "compress.h"
 #include <linux/prefetch.h>
 
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/zdata.h
similarity index 97%
rename from drivers/staging/erofs/unzip_vle.h
rename to drivers/staging/erofs/zdata.h
index d92515cd1c06..8d0119d697da 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/zdata.h
@@ -1,16 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/unzip_vle.h
+ * linux/drivers/staging/erofs/zdata.h
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
-#ifndef __EROFS_FS_UNZIP_VLE_H
-#define __EROFS_FS_UNZIP_VLE_H
+#ifndef __EROFS_FS_ZDATA_H
+#define __EROFS_FS_ZDATA_H
 
 #include "internal.h"
-#include "unzip_pagevec.h"
+#include "zpvec.h"
 
 #define Z_EROFS_NR_INLINE_PAGEVECS      3
 
diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/zpvec.h
similarity index 96%
rename from drivers/staging/erofs/unzip_pagevec.h
rename to drivers/staging/erofs/zpvec.h
index f07302c3c3f5..77bf6877bad8 100644
--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/zpvec.h
@@ -1,15 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/unzip_pagevec.h
+ * linux/drivers/staging/erofs/zpvec.h
  *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
-#ifndef __EROFS_UNZIP_PAGEVEC_H
-#define __EROFS_UNZIP_PAGEVEC_H
+#ifndef __EROFS_FS_ZPVEC_H
+#define __EROFS_FS_ZPVEC_H
 
-#include <linux/tagptr.h>
+#include "tagptr.h"
 
 /* page type in pagevec for unzip subsystem */
 enum z_erofs_page_type {
-- 
2.17.1

