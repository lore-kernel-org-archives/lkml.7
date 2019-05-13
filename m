Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A78C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D8C208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awxf1rKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfEMKah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:30:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35524 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbfEMKaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:30:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so9123031wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D2Cp7f/Qid/by7EIC98tg3BbhOaVwQta3p5eP2Mz3hQ=;
        b=awxf1rKt8shPIXHZraJS5fZLFnvTaFd4ypRimyn0+syJg+6YCdK0vkQQlGZQihWiQy
         dqfVHq4IkzUVyycEPEa4ZBl6vbWhscuLOoDnGbLvYXjeFB8Fd9sHi7YyKQvZyNfiQuCA
         nM7B6V7jiHiTwCNjbFrIOmt4Tp/yfW9HmHIftGpSL0dsqmOioOjr1fOdIde3cfNaUlU6
         C9DIsFk3CeRtIlH42aMxIyIf52SwHnR7GhNm8ewuStu+WPnDRleG+PDhyWER297fLOOQ
         Vn2X4zTxbPOi20sbh6657KOHQOoux9sogvJ86Bi+v3Vv6jY74nN9I9BIV7wEVi/eRlCk
         qU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D2Cp7f/Qid/by7EIC98tg3BbhOaVwQta3p5eP2Mz3hQ=;
        b=fZHcHOqdBL4DvmwACh80J6zfs1vVrYmJD2SgEPv9KCuy/R3VFy+GrG2AKB8y/c1LJl
         itLUDx5T6lL/7B0rjOvIGAYkJtoPfi5MJZi4PQELVuQT0XZQPQTs+F5wmi9Yo89SWHmd
         Lon8G75B1iFByMxACOZRF9UAwyOzqaTNsQAct48ei4CjdHsjNmJkaw+w2xDS8/tF1IcE
         yQQA2M/QhFkEQINCDWuefQdAs8uSFIcIc3ZMSPFALJWdRnkVSoAQZliHooI6L1BkYQLj
         LhjcUn/f4P5goMUPu2PcqJu55gpukbPh04XyrlADyeXi0qlpeQo5TQckxzS5M9Oo3q4R
         YULQ==
X-Gm-Message-State: APjAAAWfv2nfNdeBR0AciwD0CfWfQ166wDHlxsOdlfPJhyr2gKX2RKe6
        xr3roNI6iiVpcKcUrcuyxUDrRTbAe9Q=
X-Google-Smtp-Source: APXvYqwfssxxmDs0TSGhHRym5WZKIWpCLVJdZh6u62E/gkVfVqaX8kzokCJK9EJVceaF0dU9YS9Ckw==
X-Received: by 2002:a05:600c:230a:: with SMTP id 10mr2020296wmo.13.1557743409981;
        Mon, 13 May 2019 03:30:09 -0700 (PDT)
Received: from clegane.local (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.gmail.com with ESMTPSA id v192sm13645238wme.24.2019.05.13.03.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:30:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] genirq/timings: Encapsulate timings push
Date:   Mon, 13 May 2019 12:29:49 +0200
Message-Id: <20190513102953.16424-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102953.16424-1-daniel.lezcano@linaro.org>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the next patches providing the selftest, we do want to
artificially insert timings value in the circular buffer in order to
check the correctness of the code. Encapsulate the common code between
the future test code and the current with an always-inline tag.

No functional change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/internals.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 70c3053bc1f6..21f9927ff5ad 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -354,6 +354,16 @@ static inline int irq_timing_decode(u64 value, u64 *timestamp)
 	return value & U16_MAX;
 }
 
+static __always_inline void irq_timings_push(u64 ts, int irq)
+{
+	struct irq_timings *timings = this_cpu_ptr(&irq_timings);
+
+	timings->values[timings->count & IRQ_TIMINGS_MASK] =
+		irq_timing_encode(ts, irq);
+
+	timings->count++;
+}
+
 /*
  * The function record_irq_time is only called in one place in the
  * interrupts handler. We want this function always inline so the code
@@ -367,15 +377,8 @@ static __always_inline void record_irq_time(struct irq_desc *desc)
 	if (!static_branch_likely(&irq_timing_enabled))
 		return;
 
-	if (desc->istate & IRQS_TIMINGS) {
-		struct irq_timings *timings = this_cpu_ptr(&irq_timings);
-
-		timings->values[timings->count & IRQ_TIMINGS_MASK] =
-			irq_timing_encode(local_clock(),
-					  irq_desc_get_irq(desc));
-
-		timings->count++;
-	}
+	if (desc->istate & IRQS_TIMINGS)
+		irq_timings_push(local_clock(), irq_desc_get_irq(desc));
 }
 #else
 static inline void irq_remove_timings(struct irq_desc *desc) {}
-- 
2.17.1

