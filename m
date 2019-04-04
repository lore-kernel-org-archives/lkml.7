Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B47C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879252133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXhOlJqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfDDDgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38157 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDDDgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so625567pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dOOzJONg42NBLUevdjidfidJoqrClGTmFfG3kUUzoxQ=;
        b=qXhOlJqPUARfaFRhk52W+mdWfLOuctMZRZL+W/w7PkoTzwJehVfu/CSbnqE7KuHEbG
         wEqDswYmao+uuJ55P/SNTWJ2q+VHF7M3zbj5UnFBy2rn8iq/LS2lKxzff5g/qcxYZIw3
         qdgM5FuaS/DEGzMCy8RiTbrxYmNRZzKx5Jh/QwJ0GUQQoCRa4YBuph91rmXfm3W2FiZY
         tW09b3cejjCN2nmCbToB8Gfg0i28XiA6P+IbyAUWekRyrMpimXCB92W44kpgi6+kZFES
         umLywbqC2ssdNYBrLJseCl3SdmPWBGzZmWZnY1ptvETPAi2wGf1xB7Vwzs1EehjWIHi+
         en2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dOOzJONg42NBLUevdjidfidJoqrClGTmFfG3kUUzoxQ=;
        b=khigKKWzZQNOD6B2BAySzUrXcs4eXqupQzayQVwp3C63QxVKXNlct3kTXN+jGGp4Jy
         6TEnf8SNcg8PfkHkFPwwHmbQyxeO0WDvNGoEjHI1hs+Pw7lU9w/HXbGZV5Q4LxRVSVJa
         Y7BhjQ+0NiR3OHsOzmeOAe/Vqpid9QWE3hGZLek6a5DVSUdIfXhXX3dNep+nwZuxO12Z
         PsQqTa/tTt4ijYsxuG1dSV5CCjz2swFybINB/d9cpvbiMEsh/tTDHGQcYUa4HbhxGQBC
         DKTbqsMkDXaKUNbt7V6l886qI8js2TKmAWxk7mASmNSpgdhIa48iLs0DsEjAYe8U81VW
         KunQ==
X-Gm-Message-State: APjAAAUfH3fVCM8BQO51yzd38c3BXVs1l8jwvvlRZuuPE9feelTAmaVc
        ekwR3yp8UX5R+VsbYtU1/jrb8w==
X-Google-Smtp-Source: APXvYqzxpJ20zCtqQ3VxnIub/k1QTL0CDHWGDt+viLS9oCnQwvYmGaU5Drsu/DVa+tv4mjL3A3Q0bA==
X-Received: by 2002:a63:8143:: with SMTP id t64mr3341387pgd.301.1554348993093;
        Wed, 03 Apr 2019 20:36:33 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:32 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/20] coresight: tmc-etr: Refactor function tmc_etr_setup_perf_buf()
Date:   Wed,  3 Apr 2019 21:35:33 -0600
Message-Id: <20190404033541.14072-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactoring function tmc_etr_setup_perf_buf() so that it only deals
with the high level etr_perf_buffer, leaving the allocation of the
backend buffer (i.e etr_buf) to another function.

That way the backend buffer allocation function can decide if it wants
to reuse an existing buffer (CPU-wide trace scenarios) or simply create
a new one.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 00db6a6ce23f..e9c77009188a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1159,29 +1159,24 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 }
 
 /*
- * tmc_etr_setup_perf_buf: Allocate ETR buffer for use by perf.
+ * alloc_etr_buf: Allocate ETR buffer for use by perf.
  * The size of the hardware buffer is dependent on the size configured
  * via sysfs and the perf ring buffer size. We prefer to allocate the
  * largest possible size, scaling down the size by half until it
  * reaches a minimum limit (1M), beyond which we give up.
  */
-static struct etr_perf_buffer *
-tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
-		       int nr_pages, void **pages, bool snapshot)
+static struct etr_buf *
+alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
+	      int nr_pages, void **pages, bool snapshot)
 {
 	int node, cpu = event->cpu;
 	struct etr_buf *etr_buf;
-	struct etr_perf_buffer *etr_perf;
 	unsigned long size;
 
 	if (cpu == -1)
 		cpu = smp_processor_id();
 	node = cpu_to_node(cpu);
 
-	etr_perf = kzalloc_node(sizeof(*etr_perf), GFP_KERNEL, node);
-	if (!etr_perf)
-		return ERR_PTR(-ENOMEM);
-
 	/*
 	 * Try to match the perf ring buffer size if it is larger
 	 * than the size requested via sysfs.
@@ -1205,6 +1200,32 @@ tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 		size /= 2;
 	} while (size >= TMC_ETR_PERF_MIN_BUF_SIZE);
 
+	return ERR_PTR(-ENOMEM);
+
+done:
+	return etr_buf;
+}
+
+static struct etr_perf_buffer *
+tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
+		       int nr_pages, void **pages, bool snapshot)
+{
+	int node, cpu = event->cpu;
+	struct etr_buf *etr_buf;
+	struct etr_perf_buffer *etr_perf;
+
+	if (cpu == -1)
+		cpu = smp_processor_id();
+	node = cpu_to_node(cpu);
+
+	etr_perf = kzalloc_node(sizeof(*etr_perf), GFP_KERNEL, node);
+	if (!etr_perf)
+		return ERR_PTR(-ENOMEM);
+
+	etr_buf = alloc_etr_buf(drvdata, event, nr_pages, pages, snapshot);
+	if (!IS_ERR(etr_buf))
+		goto done;
+
 	kfree(etr_perf);
 	return ERR_PTR(-ENOMEM);
 
-- 
2.17.1

