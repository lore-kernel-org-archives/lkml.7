Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6804AC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B84205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z60rd2YZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbfDYTyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:54:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45663 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbfDYTxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id o5so299310pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BWqaSOkHsxJfaZN3QLvNFkWqa4XvxW+N+NDPocOCvzI=;
        b=z60rd2YZEpEDu+UvQPLQUb3IqoHa6vicmzKNWQqHP+vS81haR5WL9FQ/qcvyUcTy4+
         WRHpxR813bLFRAiR/eQSFJ/Tj6tWU/SRV2MGKo76PoVG0tGhQbn2WdYMXIkUXk8PSv3a
         mAmE4dUI0Rf9qu39EPmNfwh+sJ/lf8MLBjf2joEtmq8dyAzJBmMKj+6WcO7neOOxBra6
         f7uRdufrpTZWdUulzHOQ5YZrbA8uXHoWQpUVpvbJsU9u7Wm9dPfGzMETflNwILn2kC6f
         LL3Za3kIkDG6KYeK47RNVfs8iAs/xyedSlr3+ca3+9/w1wuwB5f04Gb0uGqmJ19EoBdc
         IrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BWqaSOkHsxJfaZN3QLvNFkWqa4XvxW+N+NDPocOCvzI=;
        b=DZ0hpl3mgRThBOTghtVvbOM6SJh9WP9+EFhlVfHq4gy6bkDpT9QkGHna2YMO8ZabEi
         9gKFULaIQPcPDbTxGpQuS6IO4le/zf+8kqq0Vts02UEA9T3FXe7ggLVi2Ly8SLEK3PKh
         XaSlnhB07D8As019nmsgpW5JoyGI2aOH3mBXt0LlTj6rukUEY7O4n/QpxEdNW7KCeu1C
         iMWVuQsJHXppCQmFayDgeuH9cbQTwcJUJrbT+NHc76L25pLnq5s/bEeGH588fWxwWeke
         /ChDNq8ql6weJ0mD3yZtaNhwcHJ6wrbv8QLvvWBKsMgW2XFN2RnfAoB45BVHh/Of6gqZ
         otug==
X-Gm-Message-State: APjAAAWTvDUUdnvjVuqCCNBeq3xZmwd2e80ZVVNW3yi+/vecJQDDwqxw
        ZHQt0Cq+EH2JkxjRgWfJBJcUGg==
X-Google-Smtp-Source: APXvYqxuNeONaUblvd45TdB6AOaPDCUSCN4gGb8boQOGhyz2d0MQrsM5rHQMSS0/9Zh/D4WM+YqicQ==
X-Received: by 2002:a17:902:5c5:: with SMTP id f63mr39998769plf.327.1556222021137;
        Thu, 25 Apr 2019 12:53:41 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:40 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/32] coresight: perf: Refactor function free_event_data()
Date:   Thu, 25 Apr 2019 13:53:00 -0600
Message-Id: <20190425195310.31562-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function free_event_data() is already busy and is bound to become
worse with the addition of CPU-wide trace scenarios.  As such spin
off a new function to strickly take care of the sink buffers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index b8ca3800b56b..806b3dd5872d 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -120,22 +120,34 @@ static int etm_event_init(struct perf_event *event)
 	return ret;
 }
 
+static void free_sink_buffer(struct etm_event_data *event_data)
+{
+	int cpu;
+	cpumask_t *mask = &event_data->mask;
+	struct coresight_device *sink;
+
+	if (WARN_ON(cpumask_empty(mask)))
+		return;
+
+	if (!event_data->snk_config)
+		return;
+
+	cpu = cpumask_first(mask);
+	sink = coresight_get_sink(etm_event_cpu_path(event_data, cpu));
+	sink_ops(sink)->free_buffer(event_data->snk_config);
+}
+
 static void free_event_data(struct work_struct *work)
 {
 	int cpu;
 	cpumask_t *mask;
 	struct etm_event_data *event_data;
-	struct coresight_device *sink;
 
 	event_data = container_of(work, struct etm_event_data, work);
 	mask = &event_data->mask;
 
 	/* Free the sink buffers, if there are any */
-	if (event_data->snk_config && !WARN_ON(cpumask_empty(mask))) {
-		cpu = cpumask_first(mask);
-		sink = coresight_get_sink(etm_event_cpu_path(event_data, cpu));
-		sink_ops(sink)->free_buffer(event_data->snk_config);
-	}
+	free_sink_buffer(event_data);
 
 	for_each_cpu(cpu, mask) {
 		struct list_head **ppath;
-- 
2.17.1

