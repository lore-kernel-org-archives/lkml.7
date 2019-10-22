Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED62CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076682184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afhY9KI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389431AbfJVUef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:34:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42761 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389407AbfJVUed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:34:33 -0400
Received: by mail-qk1-f194.google.com with SMTP id m4so689128qke.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+62b01duIzwhl+lWRPPBbONvvknzw7BTtBn7ok/CsvU=;
        b=afhY9KI98X7oFg8SEiw6QnjzPR5O+aClzT0lPCL6RRLwqRm4KHhE/dJea/JM6sIhDW
         87pXYEQdEdxSuoZ5XetxEQuUvpk53W2X31ARCH0Zhjai2qr7guaEL5Q3pxxn1Ac+ysks
         xc4GjWgjvF3FKJB+E2sRVXN3TY66jGGEOd9Erz2eAX/5uYgA4Ke04oc1ozzSSMdT624f
         Kx8oriWjnOkyc+fkgSW3J+C9W24kfVgKxiI6ff6CsLfiOCzRVXnSzixSrZcytlvzHvjx
         J5DYJ7R3NSUAm7hSwIBp6mMK+3p2omGMCwV1Vsa2ZGPMJqznnTznWwMRk+rC6I1gjloF
         kh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+62b01duIzwhl+lWRPPBbONvvknzw7BTtBn7ok/CsvU=;
        b=qKxMXsz7jQ6gbFtf1Ez9NlrDWQXlNZvIc9tkvUlel5ZhLjzQmDCsdtSgRJYFYQD7RN
         I3zW537CNLeXlmEP/cEfyXwsgYxihOJOM79gR8TkxW9+aq1nzsUPBALum+Qyh5qlNS07
         MKxZGUbJx1t5E9QvCug2PseT2ZWqQgfjM/K6pByh5XvcQbCfuuDFLP6+SNT8oQ+y37k2
         p8OAvmM2+tLZpV5AayW411XLtLBNIu41J12MzRBe5KgopJZDVXb1xrFrNlO7uxNDWJ99
         4nVqcjHLMeouZzfe/zCQjN9J5hRDZHFlcFORxl+hmPccSFjG9xJToulX1Arf3H0hnLHT
         KkHA==
X-Gm-Message-State: APjAAAXhXFlcIscZ34DwjtRn/uPSySVkMpIDy2e3QaZ5EvYUL0v4m7Zh
        Nnmlu2DIpxILST44lFQW6kZR+A==
X-Google-Smtp-Source: APXvYqxSM0uHdH3NJnUXH+1yNXm3ysSsygTvjP2yIjL6DzLdsPZKXwbv2QuhshpZgGBf50+OIQNZIw==
X-Received: by 2002:a37:6e85:: with SMTP id j127mr4993065qkc.392.1571776472427;
        Tue, 22 Oct 2019 13:34:32 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r126sm8895038qke.98.2019.10.22.13.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 13:34:31 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v4 3/6] sched/fair: Enable CFS periodic tick to update thermal pressure
Date:   Tue, 22 Oct 2019 16:34:22 -0400
Message-Id: <1571776465-29763-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support in CFS periodic tick to trigger the process of
computing average thermal pressure for a cpu.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 682a754..4f9c2cb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -21,6 +21,7 @@
  *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
  */
 #include "sched.h"
+#include "thermal.h"
 
 #include <trace/events/sched.h>
 
@@ -7574,6 +7575,8 @@ static void update_blocked_averages(int cpu)
 		done = false;
 
 	update_blocked_load_status(rq, !done);
+
+	trigger_thermal_pressure_average(rq);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -9933,6 +9936,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+
+	trigger_thermal_pressure_average(rq);
 }
 
 /*
-- 
2.1.4

