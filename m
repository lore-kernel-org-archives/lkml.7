Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97920C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70305206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDBUE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:04:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDBUEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:04:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAD3B59447;
        Tue,  2 Apr 2019 20:04:24 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2A786014A;
        Tue,  2 Apr 2019 20:04:21 +0000 (UTC)
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
Subject: [RFC PATCH 4/7] trace/ring_buffer: Use trace_get_context_bit()
Date:   Tue,  2 Apr 2019 22:03:56 +0200
Message-Id: <e96506d9a078637007b643c8b45f39ea7e48eaca.1554234787.git.bristot@redhat.com>
In-Reply-To: <cover.1554234787.git.bristot@redhat.com>
References: <cover.1554234787.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 02 Apr 2019 20:04:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify the context identification in the function trace_get_context_bit().

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
 kernel/trace/ring_buffer.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fa8cbad2ca88..5bff5bcb1bf8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2685,14 +2685,7 @@ static __always_inline int
 trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	unsigned int val = cpu_buffer->current_context;
-	unsigned long pc = preempt_count();
-	int bit;
-
-	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
-		bit = TRACE_CTX_NORMAL;
-	else
-		bit = pc & NMI_MASK ? TRACE_CTX_NMI :
-			pc & HARDIRQ_MASK ? TRACE_CTX_IRQ : TRACE_CTX_SOFTIRQ;
+	int bit = trace_get_context_bit();
 
 	if (unlikely(val & (1 << (bit + cpu_buffer->nest))))
 		return 1;
-- 
2.20.1

