Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE0C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083A62147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdec1QIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfDDDgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39268 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfDDDgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id b65so438476plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rs0Mz9KrYOZgcBXADVGIV6b2w07we0qLU/jBgiUTV9k=;
        b=gdec1QIXZeSLFtCBGpLGPuiGmrxIPSimppb5U9XDlVghC5LgWVcBP9Mfa1xbFdUOOa
         l1phJ6Y5zBrTHa1fsbSTWLx0aEUcvu+5wuDUvJsKjAQpPDubxp7PS5AckgUnZoy8ZdFr
         b9akJJhz8tIkZZYpFAKr/D1chofAiyvy2oQrMZzAJ/LLLPYi/6Q229+vkpgY55rW/qbg
         hFRkQ38/Y9VIQHBOanauk/GszRrMZEkZqKroxY37IkekTpk/BuKy2/ypZ5RjlVgtT74e
         XW2uePefexh0xccalxM9sn8/l2Qyjwidmxlq1V6meE53dP6Y5ghM3LNtY/7HVREco18R
         g0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rs0Mz9KrYOZgcBXADVGIV6b2w07we0qLU/jBgiUTV9k=;
        b=LTggfbc/6a8si8Iml1JtRDdPp7uoZ/8v1kcp+NJbOtT9+bHLRCJGLGw7myaZtpaK4F
         szqemr1LkL535vlyTAD2RL1XQ0BnWryUKF1EU0bGr/RpONND4ISDPb9mNAD5vt40KvLx
         SS5LJQNtw8v+0LgFylN0z9uug/odK7rLcV0TaGdsJUIVJBHa2VNwzff5U75mNtwuLwEF
         GQ38kYIEaZPMjO0ZBATYSRvy2EzMpKZ0tCg6lNhFCcofdnS8JmKjPjXFPGzpUFtSKNqE
         jThc22MfF/K6+UUb5phC0qH6V/Ll8mPSsOFVNI1XUmc9DxjOF2E/qMxlPbRkFBXTQH0N
         nbVw==
X-Gm-Message-State: APjAAAWpByQ1eWG0yBgHQ2Z9zW4tHv6dsYpceazxlHTgVEjemZo0rt5e
        n4cJJCNhaEP9tqbE7q6Sp+q7aQ==
X-Google-Smtp-Source: APXvYqxO8ppGN6tZd2HsirjKkIj0LBnPgYXjxD+xI+d/d1vo7t+3KzwBxUeYsaMXrG6VS3UeDb09Qg==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr3828458ply.41.1554348981813;
        Wed, 03 Apr 2019 20:36:21 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:21 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/20] coresight: perf: Clean up function etm_setup_aux()
Date:   Wed,  3 Apr 2019 21:35:30 -0600
Message-Id: <20190404033541.14072-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in allocating sink memory for a trace session if
there is not a way to free it once it is no longer needed.  As such make
sure the sink API function to allocate and free memory have been
implemented before moving ahead with the establishment of a trace
session.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index bbfed70b3402..b8ca3800b56b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -134,8 +134,7 @@ static void free_event_data(struct work_struct *work)
 	if (event_data->snk_config && !WARN_ON(cpumask_empty(mask))) {
 		cpu = cpumask_first(mask);
 		sink = coresight_get_sink(etm_event_cpu_path(event_data, cpu));
-		if (sink_ops(sink)->free_buffer)
-			sink_ops(sink)->free_buffer(event_data->snk_config);
+		sink_ops(sink)->free_buffer(event_data->snk_config);
 	}
 
 	for_each_cpu(cpu, mask) {
@@ -215,7 +214,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		sink = coresight_get_enabled_sink(true);
 	}
 
-	if (!sink || !sink_ops(sink)->alloc_buffer)
+	if (!sink)
 		goto err;
 
 	mask = &event_data->mask;
@@ -261,6 +260,9 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	if (cpu >= nr_cpu_ids)
 		goto err;
 
+	if (!sink_ops(sink)->alloc_buffer || !sink_ops(sink)->free_buffer)
+		goto err;
+
 	/* Allocate the sink buffer for this session */
 	event_data->snk_config =
 			sink_ops(sink)->alloc_buffer(sink, cpu, pages,
-- 
2.17.1

