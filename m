Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207D8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2911214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552891418;
	bh=rU/iHRxN7bFo6mkmI5rjfeZUhjBfRfMxbQW/mz8LX9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tMrL8lLQeoH8PLCT5Bu9ECpN9zPnrJmtmfEZVDgXBZccpt/rlZDDzEGHxX/mFqkdb
	 xDHzZQi2EbmJmm9hBUp7pUI13G8mkoTsfiIWqmsoG+18uFqo7z3TfFT/jejl3Bbxw/
	 io29dSFM+AVvuyWXmM7I+u37XhTUJv4iqqOheCMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfCRGnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfCRGnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 02:43:23 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8520A20857;
        Mon, 18 Mar 2019 06:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552891402;
        bh=rU/iHRxN7bFo6mkmI5rjfeZUhjBfRfMxbQW/mz8LX9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYZPfSOOKlG0eAb8jLI94SmC2GJXRba46b6hDejyTcALHBgHc66IH3KgePevjMz8t
         MUVjY0BrNx0KIvPyFI+cM1JGRvvNXPY+p1vEV8oNCUSxNdZ+NuG2W45iDdT5H65+tZ
         Z5Ur+DfIclexvCGlXqRCvKVhyrWNx8sCq7OzaMSk=
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
Subject: [RFC PATCH v6 1/6] x86/uaccess: Allow access_ok() in irq context if pagefault_disabled
Date:   Mon, 18 Mar 2019 15:43:17 +0900
Message-Id: <155289139725.7218.17265500814527931961.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155289137555.7218.9282784065958321058.stgit@devnote2>
References: <155289137555.7218.9282784065958321058.stgit@devnote2>
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

