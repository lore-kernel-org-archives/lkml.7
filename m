Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A4CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E5F2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTWy3uKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfDDDgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40741 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfDDDgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so619257pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kFYUPXqDT+4NKa1uTQaXULpv7Y+YefzCDvbN138zMnI=;
        b=LTWy3uKHie6dKXq48SuUSLDOFWqCbGplQB45KxnD/vCJcF5L/sa/6SJCsJfosIpCPl
         vKFmCf6HgO8KQKoD1jtzcVSjz7N+SN/Vumg/EhLmnN98dw6WYr3+RXOJrXl5KlF3LOO/
         ggUt2/E4oD0dsHEWIQ8WZTik71totE9jL6xSGHHwC+3bR7dOnPQTVaHHz7PcMHHdAzp8
         iHehk1++FQ943S5EtIOSoTJKk6P+ZEKkjpaSMak+FOY7m8refm9ZzDNl+7bnuAwwmmK1
         YBNM9mtRz+VTcMmRuCg7nFKbz6ofMXDes8uQJykGMOlO1RKxwfW1K62fR75y1GMZEIrv
         Oo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kFYUPXqDT+4NKa1uTQaXULpv7Y+YefzCDvbN138zMnI=;
        b=bBSbF7giFF8ZKMQHcoPiJcYXVPz24Oa9+AEIwfZ/1Yu7fYuIO95k53k0j+gdnAVtHR
         YpFvm/GAY0qmmnlOqQo2SJOGoVjmoRb8yWv5TCcsVUf/xSJscsb6oD6Gt5P8RKbx4hsi
         nqP5msSMMuwSoHobJRoFS4r8ahpcCrNIo6MjubwqSvoIRIjcNYNoglzRAT6wnFdeU0EY
         y8teCwRxZaNuexWqLEjxG3HkNNSqenzGiVaUhZRsOll17PpyBSoWW9PizmTIfEGikm3X
         7pmKJUnQd0/6/b3C1gdYVn7q00lrJCkpNLm5wEbrrRparEdv9D+1e++V4DlbwfBeCba3
         6nNw==
X-Gm-Message-State: APjAAAWanZwQ9lb/WLlmHdevsST8Xhi2dMF0yk+Izpao2f4bNKJ4tpT4
        NuncdTWROPnknL8IFZQgJ6W3bA==
X-Google-Smtp-Source: APXvYqxx/cle2EssAtFjyb90I0PMaH5UqnhmroQOmHt53z8YZ32ZmNf5mj3nCTrCe2iY/q7XgHIcjg==
X-Received: by 2002:a63:4e57:: with SMTP id o23mr3467140pgl.368.1554349011296;
        Wed, 03 Apr 2019 20:36:51 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:50 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/20] coresight: tmc-etr: Allocate and free ETR memory buffers for CPU-wide scenarios
Date:   Wed,  3 Apr 2019 21:35:38 -0600
Message-Id: <20190404033541.14072-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the PID of the process being traced to allocate and free
ETR memory buffers for CPU-wide scenarios.  The implementation is tailored
to handle both N:1 and 1:1 source/sink HW topologies.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 107 +++++++++++++++++-
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 1346474ac019..61110ef41d00 100644
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
@@ -1210,6 +1214,72 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
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
@@ -1238,7 +1308,8 @@ get_perf_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 		return get_perf_etr_buf_per_thread(drvdata, event, nr_pages,
 						   pages, snapshot);
 
-	return ERR_PTR(-ENOENT);
+	return get_perf_etr_buf_cpu_wide(drvdata, event, nr_pages,
+					 pages, snapshot);
 }
 
 static struct etr_perf_buffer *
@@ -1265,7 +1336,13 @@ tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
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
 
@@ -1295,9 +1372,33 @@ static void *tmc_alloc_etr_buffer(struct coresight_device *csdev,
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

