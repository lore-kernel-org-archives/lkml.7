Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C4AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B50720882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDBUEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:04:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDBUEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:04:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0409E308FBA0;
        Tue,  2 Apr 2019 20:04:38 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FA6B6014A;
        Tue,  2 Apr 2019 20:04:32 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [RFC PATCH 7/7] events: Use early task context tracking if available
Date:   Tue,  2 Apr 2019 22:03:59 +0200
Message-Id: <bacc8756ef9cf6bfb407afe1ee0f184cfb8f54c1.1554234787.git.bristot@redhat.com>
In-Reply-To: <cover.1554234787.git.bristot@redhat.com>
References: <cover.1554234787.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 02 Apr 2019 20:04:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the early task context tracking to detect the current context,
if the arch supports it.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Cc: Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 kernel/events/internal.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 241a2318bfdc..8e4215f8cb93 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -219,6 +219,18 @@ enum {
 	TRACE_CTX_MAX
 };
 
+#ifdef ARCH_HAS_TASK_CONTEXT
+static __always_inline int trace_get_context_bit(void)
+{
+	unsigned long tc = this_cpu_read(task_context);
+
+	if (tc)
+		return tc & TASK_CTX_NMI ? TRACE_CTX_NMI :
+			tc & TASK_CTX_IRQ ? TRACE_CTX_IRQ : TRACE_CTX_SOFTIRQ;
+	else
+		return TRACE_CTX_NORMAL;
+}
+#else /* ARCH_HAS_TASK_CONTEXT */
 static __always_inline int trace_get_context_bit(void)
 {
 	unsigned long pc = preempt_count();
@@ -229,6 +241,7 @@ static __always_inline int trace_get_context_bit(void)
 	else
 		return TRACE_CTX_NORMAL;
 }
+#endif /* ARCH_HAS_TASK_CONTEXT */
 
 static inline int get_recursion_context(int *recursion)
 {
-- 
2.20.1

