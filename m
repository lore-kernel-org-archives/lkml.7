Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F1DC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE3B21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfGSLgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:36:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49867 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfGSLgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:36:52 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N8oOk-1iTbMT0DmY-015ovh; Fri, 19 Jul 2019 13:36:43 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] waitqueue: shut up clang -Wuninitialized warnings
Date:   Fri, 19 Jul 2019 13:36:00 +0200
Message-Id: <20190719113638.4189771-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x4+Cu1ASADiy/TbeMxC/JpZ4Hr+PHiYnuXbOqr4YY9JuJSpeng2
 3f9Gv8/AO2G4WxmO68xqn9d3RwvDe9mxBGI5CUxFNJPDCg0QiArroD7xGIRZwk+hXUBIXlA
 0x3gN1Voe7tuES9yOqd27PpTJZs0P6DO03C0/UY7ekCZfmL1fIHWnwSkqEAygUyvmQnxqoV
 c5Jecl7JhGU8xwpKrJUbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7KfZFP7XH+Q=:Sn529HJGwLvCwrDi6Sgmzi
 +fliR/ktHw/W5AYSQhDmM/bxLESMIymifufmMeaWI/i5RMLb2RxzaXQcBH6q5nHnYmRcwTsdX
 Kll+kpldL7cqtevGoLOH33Yqt+6oUCO2uvbleralr8HS1J0WdjAoXA3OhpaQQq8pHUgLERDVf
 XxtFeemwa27Oe/cDd1i/hMZzlSaui1TvJZLopkdyU0LlMjAv88c/f7JzOs+EcWgrQFDkhImIg
 HJSXtFBK8Ikd+3v0mFYssMKumwhjMLenmbGH5GNgxjbzim5EBbaibDgoxoqN8Jn5EY+H2Kq6K
 X0MExrlW22nEiW46wLpYqmpkN7Wygsav9IsAyZVUNKlpAdDG+GkCcZ5Lpborb09YROrXdW7hK
 bbrIB88olZcwFvfwZZPDrT88aSTicaSSRM9MnZ6jVJsj/6dTH3SrK4bkf87gmyyJEp9y9HYWM
 pmbv7MI5/m8NAdDweu99zx3PptL2AUlaycJ61aTEYECauAhLjwUfTSvTFGYmgK74zDvusaZcB
 caF1VFYZsRVX+ey+hNDRs+aL1a2g0jBWdg6nFHOJLmnDv9T+xnTXdQKJ9txjXhkoyoLz08/CD
 I/4V/uBReZfUHLxqX3x2Cc4c5UXOveCZoY/SeO5q1HWoXBORJVd1DHP0OwpH9pFVtHcgDdfun
 xhacoCdNcU9kOi/dCWl77O389gffoYnPtnGwo+TFkAI2LM0HZOwSYATF5ljnOmpWEQ1jPT7b/
 iVslKq2SbVc0nSP2oQ1UaArDfdXf3cSLtU7M/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_LOCKDEP is set, every use of DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
produces an bogus warning from clang, which is particularly annoying
for allmodconfig builds:

fs/namei.c:1646:34: error: variable 'wq' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
        DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
                                        ^~
include/linux/wait.h:74:63: note: expanded from macro 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
        struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
                               ~~~~                                  ^~~~
include/linux/wait.h:72:33: note: expanded from macro '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
        ({ init_waitqueue_head(&name); name; })
                                       ^~~~

A patch for clang has already been proposed and should soon be
merged for clang-9, but for now all clang versions produce the
warning in an otherwise (almost) clean allmodconfig build.

Link: https://bugs.llvm.org/show_bug.cgi?id=31829
Link: https://bugs.llvm.org/show_bug.cgi?id=42604
Link: https://lore.kernel.org/lkml/20190703081119.209976-1-arnd@arndb.de/
Link: https://reviews.llvm.org/D64678
Link: https://storage.kernelci.org/next/master/next-20190717/arm64/allmodconfig/clang-8/build-warnings.log
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: given that kernelci is getting close to reporting a clean build for
    clang, I'm trying again with a less invasive approach after my
    first version was not too popular.
---
 include/linux/wait.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index ddb959641709..276499ae1a3e 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -70,8 +70,17 @@ extern void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *n
 #ifdef CONFIG_LOCKDEP
 # define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
 	({ init_waitqueue_head(&name); name; })
-# define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
+# if defined(__clang__) && __clang_major__ <= 9
+/* work around https://bugs.llvm.org/show_bug.cgi?id=42604 */
+#  define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name)					\
+	_Pragma("clang diagnostic push")					\
+	_Pragma("clang diagnostic ignored \"-Wuninitialized\"")			\
+	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)	\
+	_Pragma("clang diagnostic pop")
+# else
+#  define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
 	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
+# endif
 #else
 # define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) DECLARE_WAIT_QUEUE_HEAD(name)
 #endif
-- 
2.20.0

