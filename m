Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2098AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B9220644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437474AbfITGJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:09:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437367AbfITGJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EAE3FE3E38337AF6BEEA;
        Fri, 20 Sep 2019 14:09:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:09:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>
Subject: [PATCH 29/32] tools lib api: Renaming pr_warning to pr_warn
Date:   Fri, 20 Sep 2019 14:25:41 +0800
Message-ID: <20190920062544.180997-30-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kernel logging macro, pr_warning is completely removed and
replaced by pr_warn, using pr_warn in tools lib api for symmetry
to kernel logging macro, then we could drop pr_warning in the
whole linux code.

Changing __pr_warning to __pr_warn to be consistent.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 tools/lib/api/debug-internal.h | 4 ++--
 tools/lib/api/debug.c          | 4 ++--
 tools/lib/api/fs/fs.c          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/lib/api/debug-internal.h b/tools/lib/api/debug-internal.h
index 80c783497d25..5a5820c11db8 100644
--- a/tools/lib/api/debug-internal.h
+++ b/tools/lib/api/debug-internal.h
@@ -10,11 +10,11 @@ do {				\
 		(func)("libapi: " fmt, ##__VA_ARGS__); \
 } while (0)
 
-extern libapi_print_fn_t __pr_warning;
+extern libapi_print_fn_t __pr_warn;
 extern libapi_print_fn_t __pr_info;
 extern libapi_print_fn_t __pr_debug;
 
-#define pr_warning(fmt, ...)	__pr(__pr_warning, fmt, ##__VA_ARGS__)
+#define pr_warn(fmt, ...)	__pr(__pr_warn, fmt, ##__VA_ARGS__)
 #define pr_info(fmt, ...)	__pr(__pr_info, fmt, ##__VA_ARGS__)
 #define pr_debug(fmt, ...)	__pr(__pr_debug, fmt, ##__VA_ARGS__)
 
diff --git a/tools/lib/api/debug.c b/tools/lib/api/debug.c
index 69b1ba3d1ee3..7708f0558e8c 100644
--- a/tools/lib/api/debug.c
+++ b/tools/lib/api/debug.c
@@ -15,7 +15,7 @@ static int __base_pr(const char *format, ...)
 	return err;
 }
 
-libapi_print_fn_t __pr_warning = __base_pr;
+libapi_print_fn_t __pr_warn    = __base_pr;
 libapi_print_fn_t __pr_info    = __base_pr;
 libapi_print_fn_t __pr_debug;
 
@@ -23,7 +23,7 @@ void libapi_set_print(libapi_print_fn_t warn,
 		      libapi_print_fn_t info,
 		      libapi_print_fn_t debug)
 {
-	__pr_warning = warn;
+	__pr_warn    = warn;
 	__pr_info    = info;
 	__pr_debug   = debug;
 }
diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 7aba8243a0e7..11b3885e833e 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -381,8 +381,8 @@ int filename__read_str(const char *filename, char **buf, size_t *sizep)
 		n = read(fd, bf + size, alloc_size - size);
 		if (n < 0) {
 			if (size) {
-				pr_warning("read failed %d: %s\n", errno,
-					 strerror_r(errno, sbuf, sizeof(sbuf)));
+				pr_warn("read failed %d: %s\n", errno,
+					strerror_r(errno, sbuf, sizeof(sbuf)));
 				err = 0;
 			} else
 				err = -errno;
-- 
2.20.1

