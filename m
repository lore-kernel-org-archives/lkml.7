Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB3FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BDA2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nd7rhGJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfDDDg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34288 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfDDDg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so515448pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dv9y6a52f07gLfeGg5bt9mu9Q1KVd8oRTBa2/L6JdcE=;
        b=nd7rhGJLp6uakVyfCcVqzS4ysrJlCjbe5qVHJ8WFBTutz45kQj0T1EKbTNqXsJ4Xo1
         MXdii2+cyi0GnFyuX1/98yRAyZ81XFHh9Cn5e9yNLFJ+FZnJUsIFz1r5MvKX4LDeJLpl
         NQGj7G0eT5J/HCL/rF3/hj/YNYFac8nBgUNFebnX5wdf86aZjZ6yqabOO1Xeh8CHikcl
         1TH+dgxG4SOYPB5wxYiwoJC26THS5CCeXcyqpeM+Vxk1gwZVsmTJlNOENdWtUyHT7w1O
         4JL1IUaXgTJgBCvBxLnEAQRBDyVxzYBvlCx0el9OyYb8y7U4Ft5agX32zwYeEgjMSkiY
         chjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dv9y6a52f07gLfeGg5bt9mu9Q1KVd8oRTBa2/L6JdcE=;
        b=OXsosUB9LB3skzHVTgjQ0Z+8nZsNX/IpSgUstuY0tBA+my6fyXwLEtJUhH9S4Y5A3N
         P2jAhwlSE3jbmpz44X+TmXCsE0H0fehaW2I95HZB4kHBX9DjfGyxBdd2mZo+KGk1K8kE
         Yp/OQ/FDSlzVpMztbhi/2cYsH1niVS/QKDorCeMeKl5mm8TynSDRIFn0zv3gL8dJcwuE
         9Zp2Zwxqjj8cPbcyeeIVn1P2DYCDa/LSxBJ1bsqU3AIEsiubVsYILH9QJAYBPGxzVeXx
         SkM6yKzp8SowIk/7O9o5J0vAdQG6dH3/KIKaM3EzKdDjSVP2MENXWsZ05RaEPE++fpWg
         okCw==
X-Gm-Message-State: APjAAAWrvbIdy2NrCebSukoqoutz5HO0sSbKzXhW+HlOA3AJs7+9uGNv
        PWMtAlB2cTDbPUWByFUad4Mggg==
X-Google-Smtp-Source: APXvYqzpliniiY03EdRi60SI8VpjM7a1uF2J+7xGVpAyWtDwpNjy1DYHC27iE6NYShR6MMn73heX1Q==
X-Received: by 2002:a62:e50a:: with SMTP id n10mr3324246pff.55.1554348985691;
        Wed, 03 Apr 2019 20:36:25 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:24 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/20] coresight: perf: Refactor function free_event_data()
Date:   Wed,  3 Apr 2019 21:35:31 -0600
Message-Id: <20190404033541.14072-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function free_event_data() is already busy and is bound to become
worse with the addition of CPU-wide trace scenarios.  As such spin
off a new function to strickly take care of the sink buffers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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

