Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1425C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE13A2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1iuQ8jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfEBQyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:54:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45256 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfEBQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:54:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so1311104pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vRavtCuEgDmIK+L0LjCzpchEvsYFUuSGMHsKbPl1OXo=;
        b=p1iuQ8jp93efREIh6tYMi7eudLPjh6BqGeUJEt+25legIa8wXytBuW36/RYS3b9GRD
         zhPlnLD9gMJp4+rT1NG5f9R7MUbqdBxDKnkIXc/nYmYox4ISoh9TrNuLHPtoH+9CwvYT
         ysz8ess489SK5iVoYQViyDaSkP5qFfOkTqolR+qOUit3Z2XakRcEFTJPGT6FPJFOC0Rc
         g2eDFre6sXVSAvBL7dFH1aesDippUpYcqi6PBM4umc8pEHTI82Zxm8O0TO9JCwPK3n4u
         wP8GJzCCarOZWhrzPbwBTNcgjqM8b+bQs8q8EHs9nvrQPOG2VmRiqru+PsGr7vYrNVeR
         Aw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vRavtCuEgDmIK+L0LjCzpchEvsYFUuSGMHsKbPl1OXo=;
        b=dvsbW3He6i8v4BxMqADzsBPy2J5OQ/0EKxclMfughEaB7cfe1O560vMvBubofDkHFg
         KNjpEmORor92nrKjkTsiUhTPspi4XWhgPDeXGU5B/qQdqIS7eTUcsw35vJ+p69LZ0qqo
         CDqIbL1SoCc/XoPEcJpIoszKlLa/LnbcOzLox+R5CSi2SvmuJ+eC4BYRAfnWHR0esBZ3
         cz0jaFwUEuzmHXnfVFSCGrl2VIBkMcKnbBB72ujO516s3CAmaYnF8FG6CVX5mS+jHsoY
         fYMOsxWgekX8ltUFtxPNMD+sXEPqfmDAcCvgMQGaLO8CGMmRcm6IBl10s0z0tM8SVAUk
         Vl/Q==
X-Gm-Message-State: APjAAAXZ96NcQrJd4GmbVcNWnQ6VMiKOxF/JrWU015Ao8QL0OCF5DVu4
        Z959dL7sOPec43Kw+DQBtrCfFg==
X-Google-Smtp-Source: APXvYqzuEa4AvvzUuF+vRnu4cN2uHh5br+nlbOPlgO29fCu9f+FQqF4a72vx9pr8GZSfiJCLoTg6ag==
X-Received: by 2002:a63:ef46:: with SMTP id c6mr5003771pgk.392.1556816049674;
        Thu, 02 May 2019 09:54:09 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j2sm69949pff.77.2019.05.02.09.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 09:54:08 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] coresight: replicator: Add new device id for static replicator
Date:   Thu,  2 May 2019 10:54:03 -0600
Message-Id: <20190502165405.31573-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190502165405.31573-1-mathieu.poirier@linaro.org>
References: <20190502165405.31573-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

This patch adds a device id for the new static replicator compatible
string; it changes the driver name from "coresight-replicator" to
"coresight-static-replicator" as well.

This patch also gives warning when use the replicator obsolete DT
binding.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 4e0da85efd2d..8c9ce74498e1 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -189,6 +189,9 @@ static int replicator_probe(struct device *dev, struct resource *res)
 		dev->platform_data = pdata;
 	}
 
+	if (of_device_is_compatible(np, "arm,coresight-replicator"))
+		pr_warn_once("Uses OBSOLETE CoreSight replicator binding\n");
+
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -285,13 +288,14 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 
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

