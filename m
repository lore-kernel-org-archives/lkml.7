Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4158C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E11E206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDBUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:04:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDBUEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:04:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 665A33082A51;
        Tue,  2 Apr 2019 20:04:21 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AE0A6014A;
        Tue,  2 Apr 2019 20:04:18 +0000 (UTC)
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
Subject: [RFC PATCH 3/7] trace: Optimize trace_get_context_bit()
Date:   Tue,  2 Apr 2019 22:03:55 +0200
Message-Id: <d4efd910035c5b5eaa9f54eea64f8fef2c33339d.1554234787.git.bristot@redhat.com>
In-Reply-To: <cover.1554234787.git.bristot@redhat.com>
References: <cover.1554234787.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 02 Apr 2019 20:04:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_get_context_bit() and trace_recursive_lock() uses the same logic,
but the second reads the per_cpu variable only once.

Uses the trace_recursive_lock()'s logic in trace_get_context_bit().

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
 kernel/trace/trace.h | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index dad2f0cd7208..09318748fab8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -635,20 +635,13 @@ enum {
 
 static __always_inline int trace_get_context_bit(void)
 {
-	int bit;
-
-	if (in_interrupt()) {
-		if (in_nmi())
-			bit = TRACE_CTX_NMI;
+	unsigned long pc = preempt_count();
 
-		else if (in_irq())
-			bit = TRACE_CTX_IRQ;
-		else
-			bit = TRACE_CTX_SOFTIRQ;
-	} else
-		bit = TRACE_CTX_NORMAL;
-
-	return bit;
+	if (pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET))
+		return pc & NMI_MASK ? TRACE_CTX_NMI :
+			pc & HARDIRQ_MASK ? TRACE_CTX_IRQ : TRACE_CTX_SOFTIRQ;
+	else
+		return TRACE_CTX_NORMAL;
 }
 
 static __always_inline int trace_test_and_set_recursion(int start, int max)
-- 
2.20.1

