Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DEBC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA412205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CxeIMdWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfDYTy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:54:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40202 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbfDYTxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so307291plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lgLjzzRV23KmGDqFjyFr57/D8n2Xmn3ZciLBU3MPiP0=;
        b=CxeIMdWWSDc2PEXPC9j4agtPupzgxrkvoH4RiV1J4ErGc7+Ci7OhIDWMaeMHzxHPCI
         SKIY518ymqkRpzFTxEZjcUtakOrBiessQxPfUEON4dPQlnKzNBGSdJDQIsZFhgKbBqli
         zkMkb+JZN+IkPEd/GfcSxema9uKHKoY2bJaCuY3vBWZZfjLShNDmllMvgHB9Cii/neED
         OpL0nGciaiZt/TIuCGRIeh8eavKs/ChLLknWW7TNFeyk11UOlwJxzj6JG8kXfjPbSc45
         JybEpD+1hVsy9aUYNW47LGXbmv1wrdeKgyR9jDyo4nHQFsvMe4yrkBO5ZY70CBDtuo3g
         Vgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lgLjzzRV23KmGDqFjyFr57/D8n2Xmn3ZciLBU3MPiP0=;
        b=rvf3xmsAZtxj3PuyUFhi+GqDnCR7PhxuBHBxS4BGfjAU5qDvZ+eKW+pJ7WgIwHpHMN
         ttvtvoPYgHk1yPPfdCuKMBnfIm2fN877L0hga2imHxLdUFY8ZKCUF0p+kSW4NZlAN3OU
         jjdWHi8AMWBqnmdQmF/CeVyonciiS0vJ+dGtG1Ci83mT17IIDYJ2jV7thaG9EG/7MvGw
         fDeJWXefLFI77C1FJHVWptkSEM16vL7LWD/A2eKcHv+nVtSaJJFu2XnqIoyjfZDXVYxe
         CwsFMVDMLTj54ruh7I1PmHRVbxGbnPgfFfj2FHHChpJzZjx201XVwVJxQGwRk/xmH4S4
         pRwQ==
X-Gm-Message-State: APjAAAVnx51GIskSiUK683tgx6pECVczfRxwW3HSM88WLXMg0xPzGfi2
        P3Rx2NNORNDmzLgL8PCZaGF4jemgsOg=
X-Google-Smtp-Source: APXvYqyHJ58WQlVx7/4l663AKgVO87pSeBYlHJTiG61ufp+mwZM4R9dG1ZUoVqfEVzG03ZeL/7dOKg==
X-Received: by 2002:a17:902:9a4a:: with SMTP id x10mr200131plv.113.1556222022221;
        Thu, 25 Apr 2019 12:53:42 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:41 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/32] coresight: Communicate perf event to sink buffer allocation functions
Date:   Thu, 25 Apr 2019 13:53:01 -0600
Message-Id: <20190425195310.31562-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make struct perf_event available to sink buffer allocation functions in
order to use the pid they carry to allocate and free buffer memory along
with regimenting access to what source a sink can collect data for.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c  |  7 ++++---
 .../hwtracing/coresight/coresight-etm-perf.c   |  2 +-
 .../hwtracing/coresight/coresight-tmc-etf.c    |  7 ++++---
 .../hwtracing/coresight/coresight-tmc-etr.c    | 18 ++++++++++--------
 include/linux/coresight.h                      |  5 +++--
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 00d664c6a401..eeae375c7aed 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -343,10 +343,11 @@ static int etb_disable(struct coresight_device *csdev)
 	return 0;
 }
 
-static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
-			      void **pages, int nr_pages, bool overwrite)
+static void *etb_alloc_buffer(struct coresight_device *csdev,
+			      struct perf_event *event, void **pages,
+			      int nr_pages, bool overwrite)
 {
-	int node;
+	int node, cpu = event->cpu;
 	struct cs_buffers *buf;
 
 	if (cpu == -1)
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 806b3dd5872d..3c6294432748 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -277,7 +277,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 
 	/* Allocate the sink buffer for this session */
 	event_data->snk_config =
-			sink_ops(sink)->alloc_buffer(sink, cpu, pages,
+			sink_ops(sink)->alloc_buffer(sink, event, pages,
 						     nr_pages, overwrite);
 	if (!event_data->snk_config)
 		goto err;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index a38ad2b0d95a..1df1f8fade71 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -350,10 +350,11 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	dev_dbg(drvdata->dev, "TMC-ETF disabled\n");
 }
 
-static void *tmc_alloc_etf_buffer(struct coresight_device *csdev, int cpu,
-				  void **pages, int nr_pages, bool overwrite)
+static void *tmc_alloc_etf_buffer(struct coresight_device *csdev,
+				  struct perf_event *event, void **pages,
+				  int nr_pages, bool overwrite)
 {
-	int node;
+	int node, cpu = event->cpu;
 	struct cs_buffers *buf;
 
 	if (cpu == -1)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 9a0b346be58b..55ee0aca321c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1167,13 +1167,18 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
  * reaches a minimum limit (1M), beyond which we give up.
  */
 static struct etr_perf_buffer *
-tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, int node, int nr_pages,
-		       void **pages, bool snapshot)
+tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
+		       int nr_pages, void **pages, bool snapshot)
 {
+	int node, cpu = event->cpu;
 	struct etr_buf *etr_buf;
 	struct etr_perf_buffer *etr_perf;
 	unsigned long size;
 
+	if (cpu == -1)
+		cpu = smp_processor_id();
+	node = cpu_to_node(cpu);
+
 	etr_perf = kzalloc_node(sizeof(*etr_perf), GFP_KERNEL, node);
 	if (!etr_perf)
 		return ERR_PTR(-ENOMEM);
@@ -1211,16 +1216,13 @@ tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, int node, int nr_pages,
 
 
 static void *tmc_alloc_etr_buffer(struct coresight_device *csdev,
-				  int cpu, void **pages, int nr_pages,
-				  bool snapshot)
+				  struct perf_event *event, void **pages,
+				  int nr_pages, bool snapshot)
 {
 	struct etr_perf_buffer *etr_perf;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	if (cpu == -1)
-		cpu = smp_processor_id();
-
-	etr_perf = tmc_etr_setup_perf_buf(drvdata, cpu_to_node(cpu),
+	etr_perf = tmc_etr_setup_perf_buf(drvdata, event,
 					  nr_pages, pages, snapshot);
 	if (IS_ERR(etr_perf)) {
 		dev_dbg(drvdata->dev, "Unable to allocate ETR buffer\n");
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 189cc6ddc92b..62a520df8add 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -193,8 +193,9 @@ struct coresight_device {
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev, u32 mode, void *data);
 	int (*disable)(struct coresight_device *csdev);
-	void *(*alloc_buffer)(struct coresight_device *csdev, int cpu,
-			      void **pages, int nr_pages, bool overwrite);
+	void *(*alloc_buffer)(struct coresight_device *csdev,
+			      struct perf_event *event, void **pages,
+			      int nr_pages, bool overwrite);
 	void (*free_buffer)(void *config);
 	unsigned long (*update_buffer)(struct coresight_device *csdev,
 			      struct perf_output_handle *handle,
-- 
2.17.1

