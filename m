Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1B8C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7DB205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDMARAVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfDYTxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35286 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387734AbfDYTx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so321087plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gMY7lcZqy+WfNIqTjUNw1h7xvc16TKZ0ZukCEucshSQ=;
        b=TDMARAVvSXq2vvLhC/THO4dL+ARBU1PWV2PQuhxYpRUu+xrpjY1NIuuMhfCHOi+rxW
         O5RGCNpNulQyMWEdjl8Z4VXyBAKLYY8xkP47BZ4IsJch5Oce/t+4Pt32uX+3ROTCmWpq
         x2ZX4pS4UcetTt6+ymYcrZnBeV6Z4lNDTxTKm4CjqW2iDY6mRD6+y8rvuZc8UTN9kiCM
         SoB3pbI8kMZy9zjXwoOnwx7fgzxl+1JcdiFxLk3818inT04ScE910yDfFPg+Mm1co9Zb
         LstLjeIq1QL+09wQVd/pGIukrs68jkeXncuZUYLHHCfh4HVKlrBLXk50gOUpMjzomBg0
         JvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gMY7lcZqy+WfNIqTjUNw1h7xvc16TKZ0ZukCEucshSQ=;
        b=kjiIHiFagup3n89tbg83niuVmwkOgxtZE8JiOXi7yBJqQM4PdIrsxS00o+OnTOFRcp
         YAvmmGhyJCgbyiyXeGcpWqww9lp3sPOrM6xMXmcW0N3X7RfBwjG3JE7OJ62Gk+Piz5iW
         7wqSF9RDlGv0CbVYTOPIqJTVOo8yxXNBI0yUm7U9az3m/i7CJrQwOlxRDlGSURnvuVYD
         JyM0XfLOhatXjK0je0JkUDx/hdYd9fes+ZDzE+kbUIzIimYERIsuyyJf+QRyZlxHY9bx
         ciJ0XJG0KgEDytJijkGoAl9OphbysVcsvti39tfY8kmTv8yiEygIN4ArVzYOIsOyoBAK
         uAWA==
X-Gm-Message-State: APjAAAXqGIbi0kLFlmasIgC/gpBD8w0ROMYdd1u7zMg7HQUbKahOVbh3
        sGK+6JlHumqMPT/XsBwP4vkdzA==
X-Google-Smtp-Source: APXvYqzJcrMY5FGy9EfQhfOFA532LeRN1pKmX7y0OutIIjqKUOipOeSGHuyQdD5N2d2yRrZQATWnBg==
X-Received: by 2002:a17:902:42:: with SMTP id 60mr41442575pla.79.1556222009241;
        Thu, 25 Apr 2019 12:53:29 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:28 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/32] coresight: pmu: Adding ITRACE property to cs_etm PMU
Date:   Thu, 25 Apr 2019 13:52:51 -0600
Message-Id: <20190425195310.31562-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add to the capabilities the ITRACE property so that ITRACE START events
are generated when the PMU is switched on by the core.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 4d5a2b9f9d6a..25ae56e924bb 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -566,7 +566,8 @@ static int __init etm_perf_init(void)
 {
 	int ret;
 
-	etm_pmu.capabilities		= PERF_PMU_CAP_EXCLUSIVE;
+	etm_pmu.capabilities		= (PERF_PMU_CAP_EXCLUSIVE |
+					   PERF_PMU_CAP_ITRACE);
 
 	etm_pmu.attr_groups		= etm_pmu_attr_groups;
 	etm_pmu.task_ctx_nr		= perf_sw_context;
-- 
2.17.1

