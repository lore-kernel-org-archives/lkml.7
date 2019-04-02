Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0733EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55FD2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDBUEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:04:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDBUE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79B9E308338F;
        Tue,  2 Apr 2019 20:04:28 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 400C56014D;
        Tue,  2 Apr 2019 20:04:25 +0000 (UTC)
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
Subject: [RFC PATCH 5/7] trace: Use early task context tracking if available
Date:   Tue,  2 Apr 2019 22:03:57 +0200
Message-Id: <15e6b5ccf2e395bd8f5885c5d1c23f85937a2f18.1554234787.git.bristot@redhat.com>
In-Reply-To: <cover.1554234787.git.bristot@redhat.com>
References: <cover.1554234787.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 02 Apr 2019 20:04:28 +0000 (UTC)
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
 kernel/trace/trace.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 09318748fab8..62ba4bd0e436 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -632,7 +632,18 @@ enum {
 	TRACE_CTX_NORMAL,
 	TRACE_CTX_MAX
 };
+#ifdef ARCH_HAS_TASK_CONTEXT
+static __always_inline int trace_get_context_bit(void)
+{
+	unsigned long tc = this_cpu_read(task_context);
 
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
@@ -643,6 +654,7 @@ static __always_inline int trace_get_context_bit(void)
 	else
 		return TRACE_CTX_NORMAL;
 }
+#endif /* ARCH_HAS_TASK_CONTEXT */
 
 static __always_inline int trace_test_and_set_recursion(int start, int max)
 {
-- 
2.20.1

