Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45488C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C8E21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557322331;
	bh=rU/iHRxN7bFo6mkmI5rjfeZUhjBfRfMxbQW/mz8LX9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SkkZI/TOeZQBbfZuHOSixJ5gIowu//yMVjom4ANHTVngFe0MJ2PbKGg6iW8n7fH64
	 j4j5QuXxDbhIt6sxjDQEfWPCj8fg5n5s+uSJVRMehVGzEzzbxkyyaNDuFm4z1mXIwQ
	 lc5SdDMECkc24LpjZBTiEKfSBR+6YdKkX0XHxMn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfEHNcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHNcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:32:09 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB22320644;
        Wed,  8 May 2019 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557322328;
        bh=rU/iHRxN7bFo6mkmI5rjfeZUhjBfRfMxbQW/mz8LX9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEjge+nDQ/Zd2QV2h43aZstY+qUkKs2ZUhIRCvBiTyW/2mt2grWKGmPWfMisLsc59
         fkyNGVja7ZmrodKg2gGnfL8UvJynWefpTBSGN3psBz3ZHShHHgxxo6rhGgjHZ4OcU/
         4Ig68Nyix6FiCc3u5xEPvIO8trDe4jNL/lpgWmIU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
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
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: [PATCH v7 1/6] x86/uaccess: Allow access_ok() in irq context if pagefault_disabled
Date:   Wed,  8 May 2019 22:32:02 +0900
Message-Id: <155732232257.12756.4973477342508107797.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155732230159.12756.15040196512285621636.stgit@devnote2>
References: <155732230159.12756.15040196512285621636.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON_IN_IRQ() assumes that the access_ok() and following
user memory access can sleep. But this assumption is not
always correct; when the pagefault is disabled, following
memory access will just returns -EFAULT and never sleep.

Add pagefault_disabled() check in WARN_ON_ONCE() so that
it can ignore the case we call it with disabling pagefault.
For this purpose, this modified pagefault_disabled() as
an inline function.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/uaccess.h |    4 +++-
 include/linux/uaccess.h        |    5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1954dd5552a2..11581dc098d5 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -66,7 +66,9 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 })
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-# define WARN_ON_IN_IRQ()	WARN_ON_ONCE(!in_task())
+static inline bool pagefault_disabled(void);
+# define WARN_ON_IN_IRQ()	\
+	WARN_ON_ONCE(!in_task() && !pagefault_disabled())
 #else
 # define WARN_ON_IN_IRQ()
 #endif
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 37b226e8df13..ef3032db1aef 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -203,7 +203,10 @@ static inline void pagefault_enable(void)
 /*
  * Is the pagefault handler disabled? If so, user access methods will not sleep.
  */
-#define pagefault_disabled() (current->pagefault_disabled != 0)
+static inline bool pagefault_disabled(void)
+{
+	return current->pagefault_disabled != 0;
+}
 
 /*
  * The pagefault handler is in general disabled by pagefault_disable() or

