Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B29FC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7834C2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfHZN14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:27:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727253AbfHZN14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:27:56 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D51777CE6EC814E9F398;
        Mon, 26 Aug 2019 21:27:52 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug
 2019 21:27:42 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH RESEND] erofs: fix compile warnings when moving out include/trace/events/erofs.h
Date:   Mon, 26 Aug 2019 21:26:53 +0800
Message-ID: <20190826132653.100731-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826132234.96939-1-gaoxiang25@huawei.com>
References: <20190826132234.96939-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Stephon reported [1], many compile warnings are raised when
moving out include/trace/events/erofs.h:

In file included from include/trace/events/erofs.h:8,
                 from <command-line>:
include/trace/events/erofs.h:28:37: warning: 'struct dentry' declared inside parameter list will not be visible outside of this definition or declaration
  TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
                                     ^~~~~~
include/linux/tracepoint.h:233:34: note: in definition of macro '__DECLARE_TRACE'
  static inline void trace_##name(proto)    \
                                  ^~~~~
include/linux/tracepoint.h:396:24: note: in expansion of macro 'PARAMS'
  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
                        ^~~~~~
include/linux/tracepoint.h:532:2: note: in expansion of macro 'DECLARE_TRACE'
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  ^~~~~~~~~~~~~
include/linux/tracepoint.h:532:22: note: in expansion of macro 'PARAMS'
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
                      ^~~~~~
include/trace/events/erofs.h:26:1: note: in expansion of macro 'TRACE_EVENT'
 TRACE_EVENT(erofs_lookup,
 ^~~~~~~~~~~
include/trace/events/erofs.h:28:2: note: in expansion of macro 'TP_PROTO'
  TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
  ^~~~~~~~

That makes me very confused since most original EROFS tracepoint code
was taken from f2fs, and finally I found

commit 43c78d88036e ("kbuild: compile-test kernel headers to ensure they are self-contained")

It seems these warnings are generated from KERNEL_HEADER_TEST feature and
ext4/f2fs tracepoint files were in blacklist.

Anyway, let's fix these issues for KERNEL_HEADER_TEST feature instead
of adding to blacklist...

[1] https://lore.kernel.org/lkml/20190826162432.11100665@canb.auug.org.au/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

[RESEND] Cc Stephen as well. no change at all...

Hi Chao and Greg,
 It seems the root cause reported by Stephen is the following (sorry for
 taking some time...) could you kindly review and merge this patch?

Thanks,
Gao Xiang

 include/trace/events/erofs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index bfb2da9c4eee..d239f39cbc8c 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -6,6 +6,9 @@
 #define _TRACE_EROFS_H
 
 #include <linux/tracepoint.h>
+#include <linux/fs.h>
+
+struct erofs_map_blocks;
 
 #define show_dev(dev)		MAJOR(dev), MINOR(dev)
 #define show_dev_nid(entry)	show_dev(entry->dev), entry->nid
-- 
2.17.1

