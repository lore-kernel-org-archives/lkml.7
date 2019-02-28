Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE48F218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551369802;
	bh=6HIg3cCfp80ZWIMRQ0sAPRGGN0ciKotjFxY4qEk/hP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qdm1+AucAJLBOr9eg7wPZ3w9MugOk6hFLLeY3Bnq/QshZE9czhfZ8gIqgiTgn3CCi
	 2tKtiLGsGwWi+Ox+NVZdoXgjxeu3GDOAR4wzF3h1NotePMorTaEQZh7iaGk6P6ds58
	 /3q71K+EHl5oWs9Zxh1dYFmQGrOoC/aweWPMoVN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbfB1QDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbfB1QDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:03:20 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77CAE2184A;
        Thu, 28 Feb 2019 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551369799;
        bh=6HIg3cCfp80ZWIMRQ0sAPRGGN0ciKotjFxY4qEk/hP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjd2xmyv89Nz7F27mQqwazjWf8ihvr4wMg73Ep19t0RUfTa76P+MClTcbZZDLC0zr
         FWTCnql5wp3PacdCCNWYJLc6C6oV0Qn8VQmUZzSrijPWuP6VPsrsWWH8PHNPxoAj06
         YBj8eAIKOs1N++Z7PvXqPpSVuEr5v7tH03RgzYUg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: [PATCH v5 1/6] uaccess: Add user_access_ok()
Date:   Fri,  1 Mar 2019 01:02:55 +0900
Message-Id: <155136977556.2968.5821499627398165570.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155136974478.2968.3105123100519786079.stgit@devbox>
References: <155136974478.2968.3105123100519786079.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Add user_access_ok() macro which ensures current context
is user context, or explicitly do set_fs(USER_DS).

This function is very much like access_ok(), except it (may)
have different context validation. In general we must be
very careful when using this.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/uaccess.h |    8 +++++++-
 include/linux/uaccess.h        |   18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 780f2b42c8ef..3125d129d3b6 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -92,12 +92,18 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
  * checks that the pointer is in the user space range - after calling
  * this function, memory access functions may still return -EFAULT.
  */
-#define access_ok(addr, size)					\
+#define access_ok(addr, size)						\
 ({									\
 	WARN_ON_IN_IRQ();						\
 	likely(!__range_not_ok(addr, size, user_addr_max()));		\
 })
 
+#define user_access_ok(addr, size)					\
+({									\
+	WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));			\
+	likely(!__range_not_ok(addr, size, user_addr_max()));		\
+})
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 37b226e8df13..bf762689658b 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -10,6 +10,24 @@
 
 #include <asm/uaccess.h>
 
+/**
+ * user_access_ok: Checks if a user space pointer is valid
+ * @addr: User space pointer to start of block to check
+ * @size: Size of block to check
+ *
+ * Context: User context or explicit set_fs(USER_DS).
+ *
+ * This function is very much like access_ok(), except it (may) have different
+ * context validation. In general we must be very careful when using this.
+ */
+#ifndef user_access_ok
+#define user_access_ok(addr, size)					\
+({									\
+	WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));			\
+	access_ok(addr, size);						\
+})
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and

