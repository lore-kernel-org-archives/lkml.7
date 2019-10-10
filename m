Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAECFC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45A5206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfJJVwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJVwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:52:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40DE52067B;
        Thu, 10 Oct 2019 21:52:18 +0000 (UTC)
Date:   Thu, 10 Oct 2019 17:52:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC][PATCH] kprobes/x86: While list ftrace locations in kprobe
 blacklist areas
Message-ID: <20191010175216.4ceb3cf1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

I noticed some of my old tests failing on kprobes, and realized that
this was due to black listing irq_entry functions on x86 from being
used by kprobes. IIRC, this was due to the cr2 being corrupted and
such, and I believe other things were to cause. But black listing all
irq_entry code is a big hammer to this.

 (See commit 0eae81dc9f026 "x86/kprobes: Prohibit probing on IRQ
 handlers directly" for more details)

Anyway, if kprobes is using ftrace as a hook, there shouldn't be any
problems here. If we white list ftrace locations in the range of
kprobe_add_area_blacklist(), it should be safe.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d9770a5393c8..9d28a279282c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2124,6 +2124,11 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	int ret = 0;
 
 	for (entry = start; entry < end; entry += ret) {
+#ifdef CONFIG_KPROBES_ON_FTRACE
+		/* We are safe if using ftrace */
+		if (ftrace_location(entry))
+			continue;
+#endif
 		ret = kprobe_add_ksym_blacklist(entry);
 		if (ret < 0)
 			return ret;
