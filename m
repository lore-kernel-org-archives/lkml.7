Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D6FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778E62147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyJzb0Uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfDDDgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33519 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDDDga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so519277pgh.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ednxYZuT+oA8hxh6HD6VGiDDQ3dBG66DPU7JCj5TchU=;
        b=CyJzb0UjFCPMfiNKnar/GdUSuGYeNSF22bfv4yi9xlJKYV8z5MahFDaHXDlOExNlcQ
         EHps+jWEkCsiIAHi0j9u7oKr7KoOqK5YTAqGcmYsxPLU5wk0xzjfhbPlEqpA3avNcdk4
         aI4hKBiD0YTTB3hYeKD/KdFV61/HHq7VyRikeOjxfbocQh3jw4bFWCFJWK6FXb9rOO5k
         9O/NZYxgEhOCIfYtecRElXvFs2GoFMzq2yGZKoOH2tdi87lJk8FjDf8pEEe2ja8MAGlr
         RkYJOee6rvZrrkmg3ZIGeVIAgB0ZLGCTmuGGwTQIUkpqw+EkqalUfRptOoohaUS19epF
         xX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ednxYZuT+oA8hxh6HD6VGiDDQ3dBG66DPU7JCj5TchU=;
        b=pvBQzlUjrHVd81ncNapTRV4WIfrh0B05vWFhN45nbnTfEZqApcoCf9F50X5sJPyVxl
         Q6y4nYv8tRUqqOT6fJVmzHmb7vpdRZbyZ/CL+vi/4aoZMbkSHD3OBR9tuC5X00rQdVi0
         lxBynNifl8jq0pHvBGtYrGHQGvo0Pr67uUqW7vYQzoMgFx32jl9NYT93JKgMjocPRYES
         iWo47UpPpcggzhye34ZTOpDHDn3JDACRNh35qZEJgdN+Cad3P0yW7y0NVdNqT3N6AfJ8
         a2GdYYKtFHq6bK548EZ+S2RbFF/pk2I64gHCWzZ9HrwkV+UFGSaq2b6HLJVBaaSIEQXe
         wr0w==
X-Gm-Message-State: APjAAAXRZ2ssOUkQTzq8doI9mj/JmYJ4qnnSDKsnYpV1JnMRSfwGb0Fz
        r/wA26ipwJIk12Ni6rC3hhPOUg==
X-Google-Smtp-Source: APXvYqyoyTKLxTOxDTtd37DkxWhasV7mEwSIhAhj7OAPpPdRdAYyAll5Gc50PUcZaLo3kZ8kzRKGBA==
X-Received: by 2002:a63:5150:: with SMTP id r16mr3247658pgl.307.1554348989515;
        Wed, 03 Apr 2019 20:36:29 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:28 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/20] coresight: Communicate perf event to sink buffer allocation functions
Date:   Wed,  3 Apr 2019 21:35:32 -0600
Message-Id: <20190404033541.14072-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make struct perf_event available to sink buffer allocation functions in
order to use the pid they carry to allocate and free buffer memory along
with regimenting access to what source a sink can collect data for.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c  |  7 ++++---
 .../hwtracing/coresight/coresight-etm-perf.c   |  2 +-
 .../hwtracing/coresight/coresight-tmc-etf.c    |  7 ++++---
 .../hwtracing/coresight/coresight-tmc-etr.c    | 18 ++++++++++--------
 include/linux/coresight.h                      |  5 +++--
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 6b50e781dc57..7d64c41cd8ac 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -351,10 +351,11 @@ static int etb_disable(struct coresight_device *csdev)
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
index 86e748d09dc3..00db6a6ce23f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1166,13 +1166,18 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
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
@@ -1210,16 +1215,13 @@ tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, int node, int nr_pages,
 
 
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

