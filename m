Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B5920700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="jEdL94M7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfC1MCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:02:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33418 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfC1MCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:02:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id bg8so4849226plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E3e8EwAHebovQAzLmVLiibjy21ENgi9Ssdc0t7yHiCU=;
        b=jEdL94M7usmQBb/Y8NFgwxTejO8IpW7R3VVpHvPSbOmj4OtOf9vJkPCV+y384k5Y/N
         s2ADq91Yd4mba4xe5+qeHX7dWG8swvxx3j/aHdnostRImSNkLpjk7wfqYaFPyP2dHrD9
         yD6xW2iKEqJKa1LvXUAU/PRY/3QTcyiBLSW6jMplCF88DwIvCGxsr4wyoE4hmum9eB86
         Bm1Wh/idlzcyGLlaFg4F8DIYHJxvPsPlZihCdmyZ7Gx5IH3xRI6k9Q2D2w5SYmQR8p9y
         AFlKGknkyFkahwI/AiJje3PZ9gF+c2/PpnxarwFZ9ZT3fVLl1pQ6p/8OyNa5TXAheQu8
         ggSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E3e8EwAHebovQAzLmVLiibjy21ENgi9Ssdc0t7yHiCU=;
        b=SpcKbG3vDkTIWvN59pntTdJbMXxtCnM2ocq3F6IToqS3M3DB8Hb7InY4xUQVcG/i5w
         yn1UAAI83mhrCJQTnlo+GWK0XAgM4ZdpxoATBP3a7GFsMRjXnr4F0Qh4KkawUqj9KWKu
         swjlnv90p5cD2CYZZTHDsJ+FqMlhLpYwmNclu9k8uF/hV6nI8/g7d3Jj7sU5Ciu52M8M
         gmhAxRhg3HfaH47VNLZT4JEg1fNlmaaQ+bPLCHgSRJFJYs0NyEk7ebPOlsWNI2VxWIi9
         pWe4OLpPewK66Tug4Tl2cfuVI7EixNFucNpK6+ILeSXYz4M4pFk5DQNI0sr9Zv7wbFgD
         FfkQ==
X-Gm-Message-State: APjAAAW2nTIdO4KuncfkIf5Vs4jCg+Zwe+CE5WB3tyEBdAqPENimVoLs
        vf4Ob6ezss4AtSvIUUHnN0UkgA==
X-Google-Smtp-Source: APXvYqyt6XYAjL3XC2s2ppteTobXk8fVeK93iozpt4RngY5WgH9PWvPlFfKDr59jhyt72NbgWlDl0Q==
X-Received: by 2002:a17:902:e305:: with SMTP id cg5mr12622201plb.340.1553774558698;
        Thu, 28 Mar 2019 05:02:38 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id l63sm36859856pfc.89.2019.03.28.05.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 05:02:38 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Anuj Aggarwal <anuj.aggarwal@ti.com>,
        Todd Fischer <todd.fischer@ridgerun.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: tps6507x: Remove unused *rdev[] from struct tps6507x_pmic
Date:   Thu, 28 Mar 2019 20:02:24 +0800
Message-Id: <20190328120225.32556-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190328120225.32556-1-axel.lin@ingics.com>
References: <20190328120225.32556-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is using devm_regulator_register so no need to save *rdev for
clean up.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps6507x-regulator.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index 2b3064faaaf3..4dbb22685539 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -115,7 +115,6 @@ static struct tps_info tps6507x_pmic_regs[] = {
 struct tps6507x_pmic {
 	struct regulator_desc desc[TPS6507X_NUM_REGULATOR];
 	struct tps6507x_dev *mfd;
-	struct regulator_dev *rdev[TPS6507X_NUM_REGULATOR];
 	struct tps_info *info[TPS6507X_NUM_REGULATOR];
 	struct mutex io_lock;
 };
@@ -505,9 +504,6 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 				pdev->name);
 			return PTR_ERR(rdev);
 		}
-
-		/* Save regulator for cleanup */
-		tps->rdev[i] = rdev;
 	}
 
 	tps6507x_dev->pmic = tps;
-- 
2.17.1

