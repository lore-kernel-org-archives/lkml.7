Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C459F20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDHVbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:31:12 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37753 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfDHVbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:31:11 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MYedH-1hQ0Az0Akd-00Vkv1; Mon, 08 Apr 2019 23:28:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] s390: avoid __builtin_return_address(n) on clang
Date:   Mon,  8 Apr 2019 23:26:23 +0200
Message-Id: <20190408212648.2407234-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZmbNTcWWXcZFOu9pYUwZHanm3aNR7zdy1Jq0xKUgcSGMxA6iUIX
 1/vrvowcwhMsTyRXO7j2R0HqNlxsmoIxRA+FAZUo6QTUjBssk1B6rEfW+vHO6v7o8Jjv92L
 QqN4uN6itj0eTzPCYXYHSLO1obgdKAP3UDr5gdFf5cB2PttphKSu37C0S1GSzpBSltpft+P
 utRZj3Rh3rjWFryYPy1yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v7Q/Qbjvw/4=:WfsFPCgAfcRRRvrnNcKaVa
 SUjtnyoMRr7ZToW07cc8wIV1zciKiTjsIDUxXJivxdwvdMBULUjlM2MyxF9Sb3BEKZBD1RIVU
 d9F4o+C9671lbPTYHPDlZci5cMA8S/uoY5UaLgVLH1NSjUo8KGBNqxwkJH1RoN9ybG/5ByDGj
 z+3MgcBsOIorRL1988x7xt41pgCUZ+vhRR3tdQYeA0PKpfAvhuWmrPYzUVf8eKQC4hJ8pXRWk
 3HfVs/vzuRQZJwus3PXDbmchKOTs1KlFNMIbU5Vq01Ae2K7MNHuYE0lnn2hTItAeMOwUIMFmu
 qF11mRdXuNbuhRMmAGiG/5eioNd2xozeg9twpPQAGNXCxP/8i0cxEZcwMVldqeufvLgBdWfIt
 GHTH7nvGC/ngBJQhCue+WxpEGUcswtq0FVfWfuYfxqpeI6XD+aqkYeZyUUvV9Tlw7QxTLqtEE
 2ZAzcwWSgOifBJYyfu2gPIBeLybzAOW/MednihhhhmW4kmheyAKZdTzZ5ipJ1eTv4JeCS311B
 7gYcS66NWcMpH9imybbGUyeFHBCTphBn7BFJSld6VkSZKNNWRoxGJ9wifxZV+xyuC+0FVclpX
 p42bMYsY2OqgYBHkDrLLOjhyg/njjTMlRS421AAEJn1rEL5wt7hv4MPN2/HSmDZzfTXU/0k69
 ymNc9uYeqLMqFD2lqliRYeYSab7/3eMr2aLxMXSFu9yjAeZFUMOQSQWzCZZJvpiqWG7XwSEgi
 so01zVQbQFCtrvG5dZwMrHzgEECBLZePwqEMvw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

llvm on s390 has problems with __builtin_return_address(n), with n>0,
this results in a somewhat cryptic error message:

fatal error: error in backend: Unsupported stack frame traversal count

To work around it, use the direct return address directly. This
is probably not ideal here, but gets things to compile and should
only lead to inferior reporting, not to misbehavior of the generated
code.

Link: https://bugs.llvm.org/show_bug.cgi?id=41424
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/ftrace.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 5a3c95b11952..7923c63946fb 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -13,7 +13,12 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_CC_IS_CLANG
+/* https://bugs.llvm.org/show_bug.cgi?id=41424 */
+#define ftrace_return_address(n) __builtin_return_address(0)
+#else
 #define ftrace_return_address(n) __builtin_return_address(n)
+#endif
 
 void _mcount(void);
 void ftrace_caller(void);
-- 
2.20.0

