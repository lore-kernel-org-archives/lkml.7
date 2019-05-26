Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B7DC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5582421721
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfEZTTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfEZTSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C122821721;
        Sun, 26 May 2019 19:18:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfO-0004Yc-Te; Sun, 26 May 2019 15:18:46 -0400
Message-Id: <20190526191846.811372856@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 03/16] x86/uaccess: Allow access_ok() in irq context if pagefault_disabled
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

WARN_ON_IN_IRQ() assumes that the access_ok() and following
user memory access can sleep. But this assumption is not
always correct; when the pagefault is disabled, following
memory access will just returns -EFAULT and never sleep.

Add pagefault_disabled() check in WARN_ON_ONCE() so that
it can ignore the case we call it with disabling pagefault.
For this purpose, this modified pagefault_disabled() as
an inline function.

Link: http://lkml.kernel.org/r/155789868664.26965.7932665824135793317.stgit@devnote2

Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/uaccess.h | 4 +++-
 include/linux/uaccess.h        | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c82abd6e4ca3..9c4435307ff8 100644
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
index 2b70130af585..5a43ef7db492 100644
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
-- 
2.20.1


