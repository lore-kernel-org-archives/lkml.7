Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C61C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131562077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgYCokQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfDYTyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:54:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32893 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfDYTxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so327909plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R2jIvb1354+yjxn5P0goj61vP+hMBRVkIBdNyTFpnwU=;
        b=CgYCokQ/ybTjV5ssvcyExZJ6Nf7ERQzXe55wATDM682JZVcxakBYLZZCRPM6QMK8uL
         0cU8JWU7I/KshXczAzjDqCk+33PVv0D2Rm8ZhVkI7NYEt9QP4guwBEOT0PO1x0MSIdbB
         6Oo+3HcoJd/a7QrVuRkkFDyQIF3CCKbHudTv72dnuHjPZlqXusuD7PghV4AVHu7zF5tc
         xeUlkJJ2AFadETyzt8X0azxAuXQUyeFP3k+RmlyfoaY8nHduLb5AD8+2i1ioFqJoGsUO
         8v4D8WT8ApU0V+V9ROqKinivcDtVUetL5sI1S8VN144SIJBqK4yo/ZNPzdduz+OjweOj
         1i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R2jIvb1354+yjxn5P0goj61vP+hMBRVkIBdNyTFpnwU=;
        b=f0Jeg+QSW5FBioPlJehcvhfiwZ+ri9BafdNE8hcFukXvyHQWJgGnzScbZ/KUyp7HyG
         3FUx25nnSQhNA3S8p54fioK/vhulXt3L+ue3p6vMXeeZlkn1AsPKGboCQsYLYH5KwY9k
         MUOD+Kcyhp39tHfi5NIruCQmGjHND9pKIOac4SYdM370ifaf5+wC6UaFUyRwJEh2sd0q
         isZ2DgYo94gr69iAsorIe2JG+RhMkICeEH6+YBe14LE14iJ3on538C2XYBPDFODBLrVV
         ti6wmf4lXI0AfuuhNVyGf+Ieo9IvVb8T5qculEW0A6VWKiPbL7B6wYs5BxWfGdTeQHHO
         lmNw==
X-Gm-Message-State: APjAAAVxMEtlnyHczlCX+zOjDn6fNGPORWclOdN7uuXjfs9vTJS1BPqt
        ci3OwbMgx3Hiri5I5rwIGfm6FA==
X-Google-Smtp-Source: APXvYqz2sq5h+deYA6Do1TtpiuoHrah/j52F0ykFW39xhfteYraQ3NxRyFom1Wuup5R9TmFIpVxEhA==
X-Received: by 2002:a17:902:521:: with SMTP id 30mr40209169plf.248.1556222029848;
        Thu, 25 Apr 2019 12:53:49 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:49 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/32] coresight: tmc-etr: Allocate and free ETR memory buffers for CPU-wide scenarios
Date:   Thu, 25 Apr 2019 13:53:07 -0600
Message-Id: <20190425195310.31562-30-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the PID of the process being traced to allocate and free
ETR memory buffers for CPU-wide scenarios.  The implementation is tailored
to handle both N:1 and 1:1 source/sink HW topologies.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 107 +++++++++++++++++-
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index de33c0391186..8c75800003d2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -8,6 +8,8 @@
 #include <linux/coresight.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
+#include <linux/idr.h>
+#include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -26,6 +28,7 @@ struct etr_flat_buf {
 
 /*
  * etr_perf_buffer - Perf buffer used for ETR
+ * @drvdata		- The ETR drvdaga this buffer has been allocated for.
  * @etr_buf		- Actual buffer used by the ETR
  * @pid			- The PID this etr_perf_buffer belongs to.
  * @snaphost		- Perf session mode
@@ -34,6 +37,7 @@ struct etr_flat_buf {
  * @pages		- Array of Pages in the ring buffer.
  */
 struct etr_perf_buffer {
+	struct tmc_drvdata	*drvdata;
 	struct etr_buf		*etr_buf;
 	pid_t			pid;
 	bool			snapshot;
@@ -1211,6 +1215,72 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 	return etr_buf;
 }
 
+static struct etr_buf *
+get_perf_etr_buf_cpu_wide(struct tmc_drvdata *drvdata,
+			  struct perf_event *event, int nr_pages,
+			  void **pages, bool snapshot)
+{
+	int ret;
+	pid_t pid = task_pid_nr(event->owner);
+	struct etr_buf *etr_buf;
+
+retry:
+	/*
+	 * An etr_perf_buffer is associated with an event and holds a reference
+	 * to the AUX ring buffer that was created for that event.  In CPU-wide
+	 * N:1 mode multiple events (one per CPU), each with its own AUX ring
+	 * buffer, share a sink.  As such an etr_perf_buffer is created for each
+	 * event but a single etr_buf associated with the ETR is shared between
+	 * them.  The last event in a trace session will copy the content of the
+	 * etr_buf to its AUX ring buffer.  Ring buffer associated to other
+	 * events are simply not used an freed as events are destoyed.  We still
+	 * need to allocate a ring buffer for each event since we don't know
+	 * which event will be last.
+	 */
+
+	/*
+	 * The first thing to do here is check if an etr_buf has already been
+	 * allocated for this session.  If so it is shared with this event,
+	 * otherwise it is created.
+	 */
+	mutex_lock(&drvdata->idr_mutex);
+	etr_buf = idr_find(&drvdata->idr, pid);
+	if (etr_buf) {
+		refcount_inc(&etr_buf->refcount);
+		mutex_unlock(&drvdata->idr_mutex);
+		return etr_buf;
+	}
+
+	/* If we made it here no buffer has been allocated, do so now. */
+	mutex_unlock(&drvdata->idr_mutex);
+
+	etr_buf = alloc_etr_buf(drvdata, event, nr_pages, pages, snapshot);
+	if (IS_ERR(etr_buf))
+		return etr_buf;
+
+	refcount_set(&etr_buf->refcount, 1);
+
+	/* Now that we have a buffer, add it to the IDR. */
+	mutex_lock(&drvdata->idr_mutex);
+	ret = idr_alloc(&drvdata->idr, etr_buf, pid, pid + 1, GFP_KERNEL);
+	mutex_unlock(&drvdata->idr_mutex);
+
+	/* Another event with this session ID has allocated this buffer. */
+	if (ret == -ENOSPC) {
+		tmc_free_etr_buf(etr_buf);
+		goto retry;
+	}
+
+	/* The IDR can't allocate room for a new session, abandon ship. */
+	if (ret == -ENOMEM) {
+		tmc_free_etr_buf(etr_buf);
+		return ERR_PTR(ret);
+	}
+
+
+	return etr_buf;
+}
+
 static struct etr_buf *
 get_perf_etr_buf_per_thread(struct tmc_drvdata *drvdata,
 			    struct perf_event *event, int nr_pages,
@@ -1239,7 +1309,8 @@ get_perf_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 		return get_perf_etr_buf_per_thread(drvdata, event, nr_pages,
 						   pages, snapshot);
 
-	return ERR_PTR(-ENOENT);
+	return get_perf_etr_buf_cpu_wide(drvdata, event, nr_pages,
+					 pages, snapshot);
 }
 
 static struct etr_perf_buffer *
@@ -1266,7 +1337,13 @@ tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 	return ERR_PTR(-ENOMEM);
 
 done:
+	/*
+	 * Keep a reference to the ETR this buffer has been allocated for
+	 * in order to have access to the IDR in tmc_free_etr_buffer().
+	 */
+	etr_perf->drvdata = drvdata;
 	etr_perf->etr_buf = etr_buf;
+
 	return etr_perf;
 }
 
@@ -1296,9 +1373,33 @@ static void *tmc_alloc_etr_buffer(struct coresight_device *csdev,
 static void tmc_free_etr_buffer(void *config)
 {
 	struct etr_perf_buffer *etr_perf = config;
+	struct tmc_drvdata *drvdata = etr_perf->drvdata;
+	struct etr_buf *buf, *etr_buf = etr_perf->etr_buf;
+
+	if (!etr_buf)
+		goto free_etr_perf_buffer;
+
+	mutex_lock(&drvdata->idr_mutex);
+	/* If we are not the last one to use the buffer, don't touch it. */
+	if (!refcount_dec_and_test(&etr_buf->refcount)) {
+		mutex_unlock(&drvdata->idr_mutex);
+		goto free_etr_perf_buffer;
+	}
+
+	/* We are the last one, remove from the IDR and free the buffer. */
+	buf = idr_remove(&drvdata->idr, etr_perf->pid);
+	mutex_unlock(&drvdata->idr_mutex);
+
+	/*
+	 * Something went very wrong if the buffer associated with this ID
+	 * is not the same in the IDR.  Leak to avoid use after free.
+	 */
+	if (buf && WARN_ON(buf != etr_buf))
+		goto free_etr_perf_buffer;
+
+	tmc_free_etr_buf(etr_perf->etr_buf);
 
-	if (etr_perf->etr_buf)
-		tmc_free_etr_buf(etr_perf->etr_buf);
+free_etr_perf_buffer:
 	kfree(etr_perf);
 }
 
-- 
2.17.1

