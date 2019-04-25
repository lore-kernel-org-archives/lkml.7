Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E1C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A63C205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILmbs2ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfDYTxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41550 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbfDYTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so359930pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=riIgjligLeRRiB4uxmqLKgEO+EfIEZ1Ob5vBkh/7tHQ=;
        b=ILmbs2aoPlmUNUbt7qtr4o33UB9S3lf5gy6X4vXdMwqpG4DuaSg6522exgvDndFveq
         ivH+/2unaZyWrhG5NCx4b4r3nsA+xgTdN499vrjI5MkzlVf+ON1D9ot8jNp0pgNgb3y3
         Myts0t0/sQsGF2F59st18MbHBwrJD+uvFrLnoU3CWQ91sD4XsYJQoa0++o494gZvdZq6
         nGdIY9M797aXTftC8qTCbKDBPEjE2brMYycL/r2Y7FyySUY4qWynf1Z7cSsJIjNf5sDc
         ueZjQKMXgGjh5vBsRfOyWI9FRLcQ4zsOXsb8Cah/DO2aHtG7MUtbt2QdIQpZ+Dvv5HzU
         icPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=riIgjligLeRRiB4uxmqLKgEO+EfIEZ1Ob5vBkh/7tHQ=;
        b=kuo3To+6tSJzGozVEns3ERK8CkwSQxFleF6E5004NjthcSavMQSDkAZ/Nm61xwAd4V
         tS6bxAZ/uqlf97IUs5WfNbBlzy2bKvUkuWhOdPw6+/lhMIBDRx1jBdZ2cyN6I834DML9
         l2VHL4AHb8Q8dQ5sviF/m/QJeuvqXM766IZE/FRSouM7T1V1z9rUQpf3ThW231AwREh6
         KpL/y0nQbRQf9VU9KuIINlPFUxYB2lSznwryBxJXUBEkxe2410lPDeeIgWL6rhVKEU6u
         6tFQW0TNl1yCRlDoG4I38J2lYODzcY9KwCG2wQ/MVX6XWK6baJsoZJKRraTfFC12ICqy
         ATJQ==
X-Gm-Message-State: APjAAAUjp/t1qkoLZ1iX2r3p6ori9ghrgg4AA3NVRxoAfQ7gbxuZt0KU
        VvOVaVwkwPM7/Il0NURpes+6pA==
X-Google-Smtp-Source: APXvYqzQKdpobs8eqUY4G/mE7P6yWwvbA+5zw8B0orGOLocb380FOI24GnzH5J28mYllJnmUx6VveA==
X-Received: by 2002:a63:2ace:: with SMTP id q197mr38563780pgq.371.1556222025852;
        Thu, 25 Apr 2019 12:53:45 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:45 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/32] coresight: tmc-etr: Introduce the notion of process ID to ETR devices
Date:   Thu, 25 Apr 2019 13:53:04 -0600
Message-Id: <20190425195310.31562-27-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support CPU-wide trace scenarios, introduce the notion
of process ID to ETR devices.  That way events monitoring the same process
can use the same etr_buf, allowing multiple CPUs to use the same sink.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index bca1b2d9ef2e..1acad42184e6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/slab.h>
+#include <linux/types.h>
 #include <linux/vmalloc.h>
 #include "coresight-catu.h"
 #include "coresight-etm-perf.h"
@@ -25,6 +26,7 @@ struct etr_flat_buf {
 /*
  * etr_perf_buffer - Perf buffer used for ETR
  * @etr_buf		- Actual buffer used by the ETR
+ * @pid			- The PID this etr_perf_buffer belongs to.
  * @snaphost		- Perf session mode
  * @head		- handle->head at the beginning of the session.
  * @nr_pages		- Number of pages in the ring buffer.
@@ -32,6 +34,7 @@ struct etr_flat_buf {
  */
 struct etr_perf_buffer {
 	struct etr_buf		*etr_buf;
+	pid_t			pid;
 	bool			snapshot;
 	unsigned long		head;
 	int			nr_pages;
@@ -1277,6 +1280,7 @@ static void *tmc_alloc_etr_buffer(struct coresight_device *csdev,
 		return NULL;
 	}
 
+	etr_perf->pid = task_pid_nr(event->owner);
 	etr_perf->snapshot = snapshot;
 	etr_perf->nr_pages = nr_pages;
 	etr_perf->pages = pages;
-- 
2.17.1

