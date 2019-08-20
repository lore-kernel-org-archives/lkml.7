Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C85C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28883206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PF6ZLmQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfHTKjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:39:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34645 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfHTKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:39:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so3742996lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2TYwEMfGrR2V/Y74h1Dxih/lisI9ybOCrTEQdoojQTY=;
        b=PF6ZLmQ42qSI/yO6hIZui2lSliGTIAyLL5eruRkwMquuzi3Io4T0E0GqGZogEBseI1
         JMtFU3WtxDDrwKd/sK+2XTLVcml5BWc8fTLfLSck5KjVJdYZU4XPOl142HNcL8oSyLq5
         qz6nMaTKoydCQp5eY4BGudW1bintDhgkSpFkPL1NEGTFbDZXzdV+9yrW3jR08/epSqzp
         LsMBLiuM3omGaI8dVh+8wFFspZdt/eJnmM0b9WqgpcuBGN+26RF42bvw6FCJBMuR5ki1
         +Tl7qmp+qZY8pSjGy4lPSa8C4Hyqs3I2A3ozeUmDmBmde+GQpgf7ctM9qZWfV73EV36S
         w8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2TYwEMfGrR2V/Y74h1Dxih/lisI9ybOCrTEQdoojQTY=;
        b=p/kHE1tWbExRxRCGdbuKXZ5oy5Pfz92FbsswZ3hELj61G3Bv+UoPlvB1vOD+I1X/4K
         9d1PQ4gnWM+lmulegnND9Y7tIihfaf6Aenwdty+ZT80TbabgbSI/LdlvxpRVLHViVuHj
         Z6Zt6Y4b97QnqewlvGy7BBSUGiJG1O9mcCSbzzybvjSlZkCulqooEgN+fgj9T6vTrMhk
         UmutLbZb2En0+czwhjmhFEAidug2iL5QU3As1N4QGz16YX7jxo8FtNedN4GKxdHT+CTn
         QCLbrbP7O8CrFkJ6Gbvi1xXFjLPyutHbYqtkH+RQKq/LjJYNwktNWt/XKXpqey99CEH2
         2Gtw==
X-Gm-Message-State: APjAAAXHISTbP/i3Aec/6nqpLfjZB6kE3agFUSF/g6lRaQE8EgO9iGvD
        m96GtcLrRvLVmYQem+XtSiuP+w==
X-Google-Smtp-Source: APXvYqyktGaP184vU/JYJ0roadpC75V2yW2980xk8Wx+w4tOOBWsTpZ1UR7eNqhMCTroAqYDdMYwSg==
X-Received: by 2002:ac2:44cb:: with SMTP id d11mr14034950lfm.59.1566297560369;
        Tue, 20 Aug 2019 03:39:20 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id c23sm2743367ljj.69.2019.08.20.03.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 03:39:19 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mfd: sm501: Include the GPIO driver header
Date:   Tue, 20 Aug 2019 12:37:15 +0200
Message-Id: <20190820103715.7489-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver creates a gpio chip so it needs to include the
appropriate header <linux/gpio/driver.h> explicitly rather
than implicitly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/sm501.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 9b9b06d36cb1..dc46d62085cc 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/platform_data/i2c-gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/slab.h>
 
-- 
2.21.0

