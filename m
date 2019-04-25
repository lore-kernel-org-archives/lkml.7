Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E1C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76572205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldl8eDGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbfDYTzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:55:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45826 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387681AbfDYTx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so420154pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gDKvnZtlQcJ/F2zJQhfvE482g7t3vSsFp5ROjl2xttU=;
        b=ldl8eDGERjZIk7NuTVJ9jRJEehmNTz/FLrTt7FDfDdcvu0VbNp2uZ2U/kagpl4Plr+
         cF9vn3eNR0PTyXL+gF1gGO6IEp6LmgLx0D5TvTwTRreXzTgPWHvclElWrZ63tmKWoPVA
         1AJ6WICl1ajyhmMGE3RsL+lCaSKUAFfuE7HLAdbKhWdoWiT7HVnE77NbQJ4rPLn8mREY
         VHyort6GiUukCu+DRuMQwV3FqKlSwQvWGiYJDnq9ARbdik7Kdy4B3x5cdyu+sqmtelWC
         UfqVBUPSQt/FlmemvuRCwp4UEUp+jO6sNsBiOVVCtdzEdnYYQYTWM5kCd2XnjPuw2Qhc
         gyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gDKvnZtlQcJ/F2zJQhfvE482g7t3vSsFp5ROjl2xttU=;
        b=V27JaB69s4OdWEiyV8IZcZAK6b6l4SEjqlRvYnus/j+kj0ygBuDXylITPgW49BGF5Z
         7GHGrLqkCKKuRX1BnpocRr1ZaGyqlPWzsb9fmwFhGHH13hw49bM/DXn11Dz7thmiLl/K
         /QDQqnBxcDkMlfQrGvLEIgSlGpA0swxQXTyWYPQoaWlRC+E1DdigIDSj2RaiFw8cHAnc
         cF1lEP8JzLK0d1otmZxuU9domxKAkLzmQdGKTYpciVMTlRvffbuCU2h5aeTeS4OWvtJf
         ixeQN5n9EQka/2DyJp/JDQXcVE6PjVaMv8GtcplIrlxU6VYywUaGllFDjfl+sY31zn82
         5/Fw==
X-Gm-Message-State: APjAAAVyLGk3PjsZpfiiqLsV+AIqd1hIIulPwk222q1Ur0OxGvRPCSl9
        rqk7IS4e9crefxRISftwxuMAmw==
X-Google-Smtp-Source: APXvYqwOCW3Lo4PoYIZYaODdboVcE1gv/249sAwxQF2kSLHVTO/g2Igs4iPfaAlYRuOtiCNmo4GhHQ==
X-Received: by 2002:a63:fb58:: with SMTP id w24mr3428924pgj.444.1556222005459;
        Thu, 25 Apr 2019 12:53:25 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:24 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/32] coresight: tpiu: Cleanup power management
Date:   Thu, 25 Apr 2019 13:52:48 -0600
Message-Id: <20190425195310.31562-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Drop the power only when we have successfully probed. Otherwise
leave it to the amba probe to do the rest.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[Removed extra newline left after original modification]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b2f72a1fa402..93e2ef34e734 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -153,8 +153,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	/* Disable tpiu to support older devices */
 	tpiu_disable_hw(drvdata);
 
-	pm_runtime_put(&adev->dev);
-
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
 	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PORT;
 	desc.ops = &tpiu_cs_ops;
@@ -162,7 +160,12 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.dev = dev;
 	drvdata->csdev = coresight_register(&desc);
 
-	return PTR_ERR_OR_ZERO(drvdata->csdev);
+	if (!IS_ERR(drvdata->csdev)) {
+		pm_runtime_put(&adev->dev);
+		return 0;
+	}
+
+	return PTR_ERR(drvdata->csdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.17.1

