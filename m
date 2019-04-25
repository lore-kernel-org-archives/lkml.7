Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D574C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF22077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGnsIWFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfDYTxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35720 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfDYTxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so446429pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XBoKGJ3NBpX+0QpEcxQgM6T5eOFdLhBw4o64el6pVv8=;
        b=HGnsIWFn4b5O6kKBRdpR1PsesB627x+xvgTbDN+UtpU7rrh3GW2cjFQI/vHtW2uGWT
         +jt6r1eWuPCkTidtEZGjEz9BBzdHrtM3Fgv09k7FI6wtzPujrJf3ZPATscyJA5JGvOVB
         xwWLqw4HlgobFMVm+FVM8OMCu/8TNFh/B42xbj7vvIiH9ksgw3yIz6AWPR1q34HVFmqy
         zWjv2+GHOzRvkx5WEthV2ri76hDx6XjxJmw5Qv8qP9seJ/zey1vly3OF1A/TpcgFiyua
         DZ+Vy0qHBydbjqfiZyXDMI/TczJSvY6juQjET94us2xD30USL3iRjlB/bKsDGj+XiOw7
         8Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XBoKGJ3NBpX+0QpEcxQgM6T5eOFdLhBw4o64el6pVv8=;
        b=gowWgP9pbdLTRYsUr4Aqdx42aYJLU8FFSPQiYybt6fOBcQNasjglC9zjmPFuoBFMgC
         ox9zvl6rOQx8WOHauhalyJ6abPgM0trgl3bOL8VzbONcS2KXLzZ99hXebVgVlpRESIlL
         07z36/gVmbnc/Ezltza0L53OlY61QJqHKJ94NY9LRlKN1qBzexFRUyBn1H5E4KZZOWvs
         X4bbbz1dqmNwEMtFdCcMjEMUJ2UO2bhJiWfcaW8ifHMLD0bgDsPxAWmUT8j7cSP7A3Sb
         PZkz5D9zhEw7u0DVeb9kBnAbvxazPznGEEd399vgKFB6KMjEV3m2ElUBAQYWOTHViO8b
         uvwQ==
X-Gm-Message-State: APjAAAVDh5cWTcTlyBjsj65tdR1tT0OlkDmT126zBGNuuc5hXjwvTrGd
        wGD9UhNiMBWRraj6rQfDitPJip4a2Rw=
X-Google-Smtp-Source: APXvYqzv2ol2m5g3g+OnhJHHwB3tmBjauo2syw7LTmUJNkQi6ghI8b3meIg4iusSsKBtUghUy2aXvA==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr39270549pgi.123.1556222023475;
        Thu, 25 Apr 2019 12:53:43 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:42 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/32] coresight: tmc-etr: Refactor function tmc_etr_setup_perf_buf()
Date:   Thu, 25 Apr 2019 13:53:02 -0600
Message-Id: <20190425195310.31562-25-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
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
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 39 ++++++++++++++-----
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 55ee0aca321c..e1d2128ee757 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1160,29 +1160,24 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
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
@@ -1206,6 +1201,32 @@ tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
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

