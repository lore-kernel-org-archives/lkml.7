Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39161C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086132084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyXftwAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDIJeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:34:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39673 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDIJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:34:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so8977710pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2N+5jiEm0s/U2LTS+8nQ21jut0Nu3Hq3t6TQBxBjLPk=;
        b=oyXftwAEU3sjeUXHhhr9SX8UD1Bd0orzHbkk7RSE0KuX+sEe+PVHpzUTHJVaRbxSwe
         3tinPmMWZbyIKXF0O8rbRK7ar5H0W0aI4adDC77hQliius64qASwX7Yp50OSrLnSMUrH
         umfL1/9h4ecEi33OB9oc40+cXLLOMQpHFXWKcclqrVbj/1iRHw9Ib2EEEAQm/1wQQpVL
         R3XKG3ICRhu9DkZ704JJ0uCA85VX3x8jYzSPm6m5Z0gwQ/bKNpMZnXKc2RQgL2fJQQ+c
         GLOdg+IA9y3XKuGt4jnsX0ii/RM9hY4SXXlFnThrPN1uTtl63fI7OL//zrRhw5clhdpA
         T0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2N+5jiEm0s/U2LTS+8nQ21jut0Nu3Hq3t6TQBxBjLPk=;
        b=FR82Y8bR28cEYSMXL5vN7dZRRgJj3BwzjVPfkkeE2qz2UVHlUz5HuuK2LteiYLjYNg
         f2tE9w9QTg2yEaTWYMcV8IKVNkie7nGv3IcrD2ARgkJ2UiLEdvYV2k/DLidzoT+x1bOv
         6111mC8ZrW5Qr/IOw1y1ECSItHB4Eyps0wb/p7FuS4XPxyasArWRF4kDNUJf8OBOetGF
         tehqsxFDQipT4nZg83XVDLJkA5Pqtt5Zwf1mgEvm+jyUJGUQmQnP/CQvoM92rhNbG6WX
         VOhCqw8Hotou+uyu9XjSzhpeUf2cSMb1KvN52E+Tm5br5Y2KEqBqm4WD1BmQ6JkLxikz
         vo4g==
X-Gm-Message-State: APjAAAV08j5yf9np3SKVatqCxVpreE8l4F3cVKP7jY4nr37OJU7i/uDa
        u0HKsXcbRP25VGVvxUI0CZM=
X-Google-Smtp-Source: APXvYqzhO65Xzo4IO+b31eRGM8g8TnjxyHsIgkEh1iyBS+1c9jr2oKhgJ5uVWfRyXg+oVeHqN5YwYg==
X-Received: by 2002:a65:64cf:: with SMTP id t15mr32643244pgv.322.1554802456213;
        Tue, 09 Apr 2019 02:34:16 -0700 (PDT)
Received: from bobo.local0.net ([58.84.79.14])
        by smtp.gmail.com with ESMTPSA id b63sm88892686pfj.54.2019.04.09.02.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:34:15 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] irq_work: Do not raise an IPI when queueing work on the local CPU
Date:   Tue,  9 Apr 2019 19:34:03 +1000
Message-Id: <20190409093403.20994-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QEMU powerpc/pseries machine model was not expecting a self-IPI,
and it may be a bit surprising thing to do, so have irq_work_queue_on
do local queueing when target is the current CPU.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/irq_work.c | 78 ++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 6b7cdf17ccf8..d2cdf2367c16 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -56,61 +56,69 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
 
-/*
- * Enqueue the irq_work @work on @cpu unless it's already pending
- * somewhere.
- *
- * Can be re-enqueued while the callback is still in progress.
- */
-bool irq_work_queue_on(struct irq_work *work, int cpu)
+/* Enqueue on current CPU, work must already be claimed and preempt disabled */
+static void __irq_work_queue_local(struct irq_work *work)
 {
-	/* All work should have been flushed before going offline */
-	WARN_ON_ONCE(cpu_is_offline(cpu));
-
-#ifdef CONFIG_SMP
-
-	/* Arch remote IPI send/receive backend aren't NMI safe */
-	WARN_ON_ONCE(in_nmi());
+	/* If the work is "lazy", handle it from next tick if any */
+	if (work->flags & IRQ_WORK_LAZY) {
+		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
+		    tick_nohz_tick_stopped())
+			arch_irq_work_raise();
+	} else {
+		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+			arch_irq_work_raise();
+	}
+}
 
+/* Enqueue the irq work @work on the current CPU */
+bool irq_work_queue(struct irq_work *work)
+{
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
 		return false;
 
-	if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
-		arch_send_call_function_single_ipi(cpu);
-
-#else /* #ifdef CONFIG_SMP */
-	irq_work_queue(work);
-#endif /* #else #ifdef CONFIG_SMP */
+	/* Queue the entry and raise the IPI if needed. */
+	preempt_disable();
+	__irq_work_queue_local(work);
+	preempt_enable();
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(irq_work_queue);
 
-/* Enqueue the irq work @work on the current CPU */
-bool irq_work_queue(struct irq_work *work)
+/*
+ * Enqueue the irq_work @work on @cpu unless it's already pending
+ * somewhere.
+ *
+ * Can be re-enqueued while the callback is still in progress.
+ */
+bool irq_work_queue_on(struct irq_work *work, int cpu)
 {
+#ifndef CONFIG_SMP
+	return irq_work_queue(work);
+
+#else /* #ifndef CONFIG_SMP */
+	/* All work should have been flushed before going offline */
+	WARN_ON_ONCE(cpu_is_offline(cpu));
+
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
 		return false;
 
-	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
-
-	/* If the work is "lazy", handle it from next tick if any */
-	if (work->flags & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
-			arch_irq_work_raise();
-	}
-
+	if (cpu != smp_processor_id()) {
+		/* Arch remote IPI send/receive backend aren't NMI safe */
+		WARN_ON_ONCE(in_nmi());
+		if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
+			arch_send_call_function_single_ipi(cpu);
+	} else
+		__irq_work_queue_local(work);
 	preempt_enable();
 
 	return true;
+#endif /* #else #ifndef CONFIG_SMP */
 }
-EXPORT_SYMBOL_GPL(irq_work_queue);
+
 
 bool irq_work_needs_cpu(void)
 {
-- 
2.20.1

