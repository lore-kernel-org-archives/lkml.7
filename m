Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CC5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420EC20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZfKtX4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfDDIHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:07:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35048 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfDDIHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:07:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so777884plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ibM3lHeqJzWAyx2I7VLyFgmTRoqBMjsuQ/db2mydldI=;
        b=eZfKtX4lsRpGT7pRHg5sNpC8SAp2bYdtvTa3cbXRkSl5Fc9RMIM/A2yon7YwcG9TuP
         TACqLqVii5l0KjdP0oTi9X/vm33eeKy805mOsXn9Rzmtd+RXB0zJNzOmIhAc0073F3CO
         ApknFQQbhyORoABtRDBZB1I/gG7j1DizZvuGHkxv9wZchNWH7C7GGlbYi+2ru0z97lb3
         loINPYJ6ZGH5dD5XM0XvifMF4Werfk2UBAYjnT1mAxsofW8gBM3rYzeiS6BKBHoUnSnU
         KEYEja3yVzWB0uRjcO4C3Q7OkvkIPn7Fa8lqYA2zeVDqD34jq8b1kyDS9gmFEEal9jXI
         H6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ibM3lHeqJzWAyx2I7VLyFgmTRoqBMjsuQ/db2mydldI=;
        b=bYEFmgiADx3JSRzFn8ycswI3fQnldLE0oPd+Hs/bZJQRXSq3GEVeF1Hnva9fB2bH/s
         52MS0JUdTxNecKi/rcDXhZUoDXSqB9edTl6mbGM3b0xyntSxtUYui+RbYpRJY/ugurSK
         zNz9UJvTly5kkFOpJITrY/lvkxYno4RR3y4teK4mIbOUD5js1QfFN2vnayrxVq54vtan
         OZSqteD566Yc4e7v8n6XZUsFQTuSVDozEpxrPJ6drEQ2pgupB2JYnQhBuTAmLknBcP3g
         L/rBNln2du2fEMAdmGJK0SRYloKfBSHwSfhIMpsSyWjNluA00QsLKofmtt7tnczRuLZ1
         kGhA==
X-Gm-Message-State: APjAAAW6Sl43YSe/nPs4qEtWCqvgvX36jniWwyy2A58HLjCHyjtpmJbe
        IDbwTa1MCh20UzTx6Lm/u34dEA==
X-Google-Smtp-Source: APXvYqyYFGqcw6rM8ckAtlp1uymKMPH2ic4KPwQ06ehaJuSoIm7zPzWo3JxMz6kFS/AY073MxEvrRQ==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr5043893pll.12.1554365233446;
        Thu, 04 Apr 2019 01:07:13 -0700 (PDT)
Received: from mai.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id x9sm32380940pfn.60.2019.04.04.01.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 01:07:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andrew.smirnov@gmail.com
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 2/2] thermal/drivers/qoriq: Use the get_temp_id()
Date:   Thu,  4 Apr 2019 10:06:47 +0200
Message-Id: <20190404080647.8173-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404080647.8173-1-daniel.lezcano@linaro.org>
References: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
 <20190404080647.8173-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the code is adding extra back pointer to find out the general
structure for the driver from the sensor data.

Use the get_temp_id() which pass the sensor id when registering the callback.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qoriq_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3b5f5b3fb1bc..405d1fbdd0cb 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -92,20 +92,20 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
 		return ioread32be(addr);
 }
 
-static int tmu_get_temp(void *p, int *temp)
+static int tmu_get_temp(int id, void *p, int *temp)
 {
 	struct qoriq_sensor *qsensor = p;
 	struct qoriq_tmu_data *qdata = qsensor->qdata;
 	u32 val;
 
-	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
+	val = tmu_read(qdata, &qdata->regs->site[id].tritsr);
 	*temp = (val & 0xff) * 1000;
 
 	return 0;
 }
 
 static const struct thermal_zone_of_device_ops tmu_tz_ops = {
-	.get_temp = tmu_get_temp,
+	.get_temp_id = tmu_get_temp,
 };
 
 static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
-- 
2.17.1

