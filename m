Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A175C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA0A2087F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coGSFv8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDFLW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 07:22:29 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46371 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDFLW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 07:22:28 -0400
Received: by mail-yb1-f195.google.com with SMTP id u15so3374444ybj.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gLR19HUc+gmFjS967MFA8MMpurGf3MGUCdDqqoTyKSg=;
        b=coGSFv8K1L/KQk7yOFkkw+BoZ0QXgZirUaQOqnqT4WFiK6AKev8A8EPZC/iZyVSxJY
         6H8ZBBzuJa75AwcskBk+kv0slv1O4R9yOcfbmxgafT+xtHf+PKXMTufk5TX5CtGkJsmJ
         bpb9NasXW1OJ2FFAJNDU17PI6T9vkGLO9++s72KTiZcl/sbpLBQ1z0uUH96tkpfJTOPD
         BpQzHOtGErPnSYLVzvFtNFK4jzrib5YVi/JXvATqj8/4lTn3JHLSRRx8qrNhaYDh6zFG
         /sU/42o41b64q3vSuXyS62FC/8K2X99daZLHdPmJegW8qQ4U0Iw7fjRZD6UGZbgQtMfr
         MDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gLR19HUc+gmFjS967MFA8MMpurGf3MGUCdDqqoTyKSg=;
        b=tlLBJMYdd0FJ2kfrAfewDcxjxrVEc7d3V0L0WKmbRNs/vIJUOiS5krnA0jXlrR1nQf
         qKuxGc8dbXVTcYm0jKwpZh8/u5oGwy73FaizpFr/sUVF3Ojl1nYNNJhILRM2NLPqlB0i
         yPRqSmXGeAuEC5JU38ef/YdnR0nlATuYb55e8lqTkNJDh9d/rFcr0rI6n0Q8euMMY6MZ
         qnVMEf4Vx0O9sk7YWdAru1oL1biZTM13TCELzK8ocOS6Yqg441oE3bEraZt7hMzZarIE
         CIInYk6OovHU5u8KKw/mpo9cCLOew6mrfQDxZwmsSt/UmWVBjCnEMX5fG3xhHfZWl9pU
         Lz1A==
X-Gm-Message-State: APjAAAU1tJ0CEz0WkmBIJTciR2qJWw8TmZBNckxRB6d4t6hqzC+lKdlA
        8wNrcCOHBSwDC47lKbg19VSybA==
X-Google-Smtp-Source: APXvYqwmNU3mGjBEISnJD2cFa6v/OnnTtU19DfRUI5IV7Rwsb8LE1oGJ7ixqz7IP0SpUkcbjDn2ORQ==
X-Received: by 2002:a25:cc86:: with SMTP id l128mr4507046ybf.266.1554549747464;
        Sat, 06 Apr 2019 04:22:27 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id w22sm12729360yww.58.2019.04.06.04.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:22:26 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wanglai Shi <shiwanglai@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 2/4] coresight: replicator: Add new device id for static replicator
Date:   Sat,  6 Apr 2019 19:21:43 +0800
Message-Id: <20190406112145.15184-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190406112145.15184-1-leo.yan@linaro.org>
References: <20190406112145.15184-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device id for the new static replicator compatible
string; it changes the driver name from "coresight-replicator" to
"coresight-static-replicator" as well.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 4e0da85efd2d..e6a03642bbdb 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -285,13 +285,14 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 
 static const struct of_device_id static_replicator_match[] = {
 	{.compatible = "arm,coresight-replicator"},
+	{.compatible = "arm,coresight-static-replicator"},
 	{}
 };
 
 static struct platform_driver static_replicator_driver = {
 	.probe          = static_replicator_probe,
 	.driver         = {
-		.name   = "coresight-replicator",
+		.name   = "coresight-static-replicator",
 		.of_match_table = static_replicator_match,
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
-- 
2.17.1

