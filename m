Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B199CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADE720856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495405;
	bh=yASL+NwRc0UbVUW2k+W/cvGUBI3Zqy6zFvj7PbXBho8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ssN8qzyL/4GNkt0Tkn5zjR+BD48D8BCoDnm92jirV60juSAnwgNgSQpdxwnU6B4V0
	 WnGmxdr5ibg4yOR6y1pS5nP6o/c3NY+kkWdvTnsEsG18BIxJs22Oj8gku5h6cjvAjJ
	 38+ZzzKZkma4K51nkEn+quN3GhzAg62yL663siUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392530AbfHVRgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391575AbfHVRYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:49 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C82223400;
        Thu, 22 Aug 2019 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494688;
        bh=yASL+NwRc0UbVUW2k+W/cvGUBI3Zqy6zFvj7PbXBho8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/YhtRfS41rxqa2ZHGSp1zi9D8dERNMvAULLMuO1RijgrCKmX287rACinbyQXFQnK
         LdSdS6rhZKdcUiO0pc+93eYVWUtVNfMgGClfkL8A7myWPhnuJr9uRhSIDQ0Mh+lTLj
         pJqqun0fJtD3LifTKaXJ9lEs+kNvvXDtxeD9+JU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 35/71] arm64: unwind: Prohibit probing on return_address()
Date:   Thu, 22 Aug 2019 10:19:10 -0700
Message-Id: <20190822171729.441973221@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
References: <20190822171726.131957995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ee07b93e7721ccd5d5b9fa6f0c10cb3fe2f1f4f9 ]

Prohibit probing on return_address() and subroutines which
is called from return_address(), since the it is invoked from
trace_hardirqs_off() which is also kprobe blacklisted.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/return_address.c | 3 +++
 arch/arm64/kernel/stacktrace.c     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index 933adbc0f654d..0311fe52c8ffb 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
@@ -32,6 +33,7 @@ static int save_return_addr(struct stackframe *frame, void *d)
 		return 0;
 	}
 }
+NOKPROBE_SYMBOL(save_return_addr);
 
 void *return_address(unsigned int level)
 {
@@ -55,3 +57,4 @@ void *return_address(unsigned int level)
 		return NULL;
 }
 EXPORT_SYMBOL_GPL(return_address);
+NOKPROBE_SYMBOL(return_address);
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d5718a060672e..2ae7630d685b5 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
@@ -85,6 +86,7 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 
 	return 0;
 }
+NOKPROBE_SYMBOL(unwind_frame);
 
 void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 		     int (*fn)(struct stackframe *, void *), void *data)
@@ -99,6 +101,7 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 			break;
 	}
 }
+NOKPROBE_SYMBOL(walk_stackframe);
 
 #ifdef CONFIG_STACKTRACE
 struct stack_trace_data {
-- 
2.20.1



