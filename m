Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AF0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71742064A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392818AbfHBM4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:56:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392685AbfHBMyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:54:35 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9C60B6925965E2539DDC;
        Fri,  2 Aug 2019 20:54:32 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 2 Aug 2019
 20:54:23 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, "Pavel Machek" <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v6 12/24] erofs: introduce tagged pointer
Date:   Fri, 2 Aug 2019 20:53:35 +0800
Message-ID: <20190802125347.166018-13-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802125347.166018-1-gaoxiang25@huawei.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kernel has scattered tagged pointer usages
hacked by hand in plain code, without a unique and
portable functionset to highlight the tagged pointer
itself and wrap these hacked code in order to clean up
all over meaningless magic masks.

This patch introduces simple generic methods to fold
tags into a pointer integer. Currently it supports
the last n bits of the pointer for tags, which can be
selected by users.

In addition, it will also be used for the upcoming EROFS
filesystem, which heavily uses tagged pointer pproach
 to reduce extra memory allocation.

Link: https://en.wikipedia.org/wiki/Tagged_pointer

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/tagptr.h | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 fs/erofs/tagptr.h

diff --git a/fs/erofs/tagptr.h b/fs/erofs/tagptr.h
new file mode 100644
index 000000000000..a72897c86744
--- /dev/null
+++ b/fs/erofs/tagptr.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * A tagged pointer implementation
+ *
+ * Copyright (C) 2018 Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_FS_TAGPTR_H
+#define __EROFS_FS_TAGPTR_H
+
+#include <linux/types.h>
+#include <linux/build_bug.h>
+
+/*
+ * the name of tagged pointer types are tagptr{1, 2, 3...}_t
+ * avoid directly using the internal structs __tagptr{1, 2, 3...}
+ */
+#define __MAKE_TAGPTR(n) \
+typedef struct __tagptr##n {	\
+	uintptr_t v;	\
+} tagptr##n##_t;
+
+__MAKE_TAGPTR(1)
+__MAKE_TAGPTR(2)
+__MAKE_TAGPTR(3)
+__MAKE_TAGPTR(4)
+
+#undef __MAKE_TAGPTR
+
+extern void __compiletime_error("bad tagptr tags")
+	__bad_tagptr_tags(void);
+
+extern void __compiletime_error("bad tagptr type")
+	__bad_tagptr_type(void);
+
+/* fix the broken usage of "#define tagptr2_t tagptr3_t" by users */
+#define __tagptr_mask_1(ptr, n)	\
+	__builtin_types_compatible_p(typeof(ptr), struct __tagptr##n) ? \
+		(1UL << (n)) - 1 :
+
+#define __tagptr_mask(ptr)	(\
+	__tagptr_mask_1(ptr, 1) ( \
+	__tagptr_mask_1(ptr, 2) ( \
+	__tagptr_mask_1(ptr, 3) ( \
+	__tagptr_mask_1(ptr, 4) ( \
+	__bad_tagptr_type(), 0)))))
+
+/* generate a tagged pointer from a raw value */
+#define tagptr_init(type, val) \
+	((typeof(type)){ .v = (uintptr_t)(val) })
+
+/*
+ * directly cast a tagged pointer to the native pointer type, which
+ * could be used for backward compatibility of existing code.
+ */
+#define tagptr_cast_ptr(tptr) ((void *)(tptr).v)
+
+/* encode tagged pointers */
+#define tagptr_fold(type, ptr, _tags) ({ \
+	const typeof(_tags) tags = (_tags); \
+	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(type))) \
+		__bad_tagptr_tags(); \
+tagptr_init(type, (uintptr_t)(ptr) | tags); })
+
+/* decode tagged pointers */
+#define tagptr_unfold_ptr(tptr) \
+	((void *)((tptr).v & ~__tagptr_mask(tptr)))
+
+#define tagptr_unfold_tags(tptr) \
+	((tptr).v & __tagptr_mask(tptr))
+
+/* operations for the tagger pointer */
+#define tagptr_eq(_tptr1, _tptr2) ({ \
+	typeof(_tptr1) tptr1 = (_tptr1); \
+	typeof(_tptr2) tptr2 = (_tptr2); \
+	(void)(&tptr1 == &tptr2); \
+(tptr1).v == (tptr2).v; })
+
+/* lock-free CAS operation */
+#define tagptr_cmpxchg(_ptptr, _o, _n) ({ \
+	typeof(_ptptr) ptptr = (_ptptr); \
+	typeof(_o) o = (_o); \
+	typeof(_n) n = (_n); \
+	(void)(&o == &n); \
+	(void)(&o == ptptr); \
+tagptr_init(o, cmpxchg(&ptptr->v, o.v, n.v)); })
+
+/* wrap WRITE_ONCE if atomic update is needed */
+#define tagptr_replace_tags(_ptptr, tags) ({ \
+	typeof(_ptptr) ptptr = (_ptptr); \
+	*ptptr = tagptr_fold(*ptptr, tagptr_unfold_ptr(*ptptr), tags); \
+*ptptr; })
+
+#define tagptr_set_tags(_ptptr, _tags) ({ \
+	typeof(_ptptr) ptptr = (_ptptr); \
+	const typeof(_tags) tags = (_tags); \
+	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(*ptptr))) \
+		__bad_tagptr_tags(); \
+	ptptr->v |= tags; \
+*ptptr; })
+
+#define tagptr_clear_tags(_ptptr, _tags) ({ \
+	typeof(_ptptr) ptptr = (_ptptr); \
+	const typeof(_tags) tags = (_tags); \
+	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(*ptptr))) \
+		__bad_tagptr_tags(); \
+	ptptr->v &= ~tags; \
+*ptptr; })
+
+#endif	/* __EROFS_FS_TAGPTR_H */
+
-- 
2.17.1

