Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D46DC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55375205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c+R6u6VD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfDYTyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:54:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38723 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbfDYTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so312023plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uoxZQ+Jw0MNrOb10y+jglav9yUL3Ht92euc8TGFiAfY=;
        b=c+R6u6VDZOax4bq1uwh/NLDMM6m8tM8xqP8r64W8X1lp3bNVvCoo3j784NsFMYuRK8
         wQiISQfhGH+zQAYIu5bx5DDmkzIfCHMgvSt1hjXZKikIOUQ27Oylh9CiA3lqGBL05Eun
         nymJF+ihWa3/lUaXGLQoe/jkC26Jc8wBc9Hbsf39ztAu54e51BXz37ZfmbIw3ra25kTn
         r2I6GM9zkM9shPk7xQB/+AjTSzr+KMSOc6vq6YwnBry5JL9l4L7z9chblP0o79x1zznN
         0Ir3X9fQuT3JLCP4w6EVkjv8wznm1URh+6wAZknmv0agRc4MwnXUHYfDKCUbfWKrPph6
         xpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uoxZQ+Jw0MNrOb10y+jglav9yUL3Ht92euc8TGFiAfY=;
        b=RARNtULNeNIGpsKhAVQGrFmx0waxEabszC6tSgN0e0xCMngUljxoUQtRD6HA8b3xKp
         VN1MTAdFbSWSlOZJ05TrLwBv3OFb2y7UiUKZKTooBoTN9yVTvgp4rf894frhmKDn5O3h
         JnN5cDgyaxkfj583+fSTQuOYA6xtKBwpx3LH/kcOF8z1DvaTttmvbIyiPzVE++oKlWCo
         QdSaESZW00lPZskJF02GK4AVfzYUyKn0qxoZk7VQ6de+t+qvSX1cjRjuRNgErAbHM0Ie
         GlUXW465uQi8ZkDhcsA0tcARzTKPK2St964Se+w4FeqW/Zcr1AlLEN0/xRtW2C7UKOdX
         UJQQ==
X-Gm-Message-State: APjAAAWRcTXP60ykk4HJ/Rh4yDtGL1bkltQLX4MMTQRz2KNTIKvwyW88
        wY7fdGbGrM8nmwGAlBUBE877yg==
X-Google-Smtp-Source: APXvYqy9Sy0hbOt71peqowfIU7lIuhJaUBUiaGPiHwEcOWAXfChxSEAX80Y7xdzutxdf2bIXonjl1A==
X-Received: by 2002:a17:902:56e:: with SMTP id 101mr40689884plf.142.1556222019835;
        Thu, 25 Apr 2019 12:53:39 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:39 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/32] coresight: perf: Clean up function etm_setup_aux()
Date:   Thu, 25 Apr 2019 13:52:59 -0600
Message-Id: <20190425195310.31562-22-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
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
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
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

