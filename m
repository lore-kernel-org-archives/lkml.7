Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80347C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECA820675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vPpCrKUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfD2QW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:22:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34974 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbfD2QW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:22:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so5318813plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4f6WrzyzuO2F1bDTPxHcLE3z/+pAjPfe9qLmvK4A6as=;
        b=vPpCrKUW2ez99jzndfqZtu6JNvWNanlUzH3AuveO0GSSRCCQl72+NIdUPDxp4e1j2D
         oR+KD27SMnporP7BtqsmFOHrHH48hM80JhZBbvQFxbgs9ZmuljJwGNsbO97maHqcUfjg
         8wSXcpfVKMB8tCe4gXP+HgKsW0HJtYjx0dBSpNwC87IzbXqY3gwaTJ7c+snUOwGxdTSd
         2zD9P9f8ZXZjyRLibwYBPF9JXLqNVcGKoIVvLYRLSDdEH/zokklEz+pbZ4uhjxbg/sSw
         527JDJwiLrfS+2iiWXbdKDp8JItn+dGur5RpDU6TA35z23hVVY64OqVnxcZtB9i0suTd
         njtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4f6WrzyzuO2F1bDTPxHcLE3z/+pAjPfe9qLmvK4A6as=;
        b=kEamK9pvTkG7qLNY0OsLKdqy1v92cYz65ZoEDDpXHCKI6iAM+iZoZLLloPH4Jl8kj8
         9q7JYc6YE1Q70n3FlioKoAw5LZnFtxC9eqonKuN4tgfhpvzhRLdAmjeKWh0FkA2BoiGj
         gvkyqS2Zf77lLxL0+o6ryQ5oy32z7VZxC7oeW7D9ZMflEsSKog5Cyuq6r3f8QqF8LCFS
         85AVc/JKKM1wBAvjwVCGWXOdrciDYVaPuRFMgj6SQTBfkTudBhkfoSZTDnWj13mm8RA9
         iKpANF5OcGb5vzbGE9jiGJTmXEx84pC7Wtv0kngg9otCQaLsV2Ek9xChQlyld7chMv2E
         2iCw==
X-Gm-Message-State: APjAAAXUpggiJuufcTi7F9S+EmnDxkEx3JRkJpEeSQ6nJ0G/RPLjoas1
        8kF6xykpXQaO+QjokzDQc5evGQ==
X-Google-Smtp-Source: APXvYqzYEA3pbS2iE2gKVdOlfQIPiAhmrRB708Vt+S0UrPEJo1az+L1keMZHjy1L2zZAifx1wHJpAQ==
X-Received: by 2002:a17:902:b605:: with SMTP id b5mr24397547pls.206.1556554975840;
        Mon, 29 Apr 2019 09:22:55 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id g10sm39691003pgq.54.2019.04.29.09.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 09:22:54 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     linux-spi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] spi: zynqmp: Fix build break
Date:   Mon, 29 Apr 2019 09:22:46 -0700
Message-Id: <20190429162246.6061-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <2bb66114-c976-9c44-6db3-33a5dd12edde@monstr.eu>
References: <2bb66114-c976-9c44-6db3-33a5dd12edde@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing include:
drivers/spi/spi-zynqmp-gqspi.c:1025:13: error: implicit declaration of
  function 'zynqmp_pm_get_eemi_ops'; did you mean
  'zynqmp_process_dma_irq'? [-Werror=implicit-function-declaration]

Fixes: 3d0313786470a ('drivers: Defer probe if firmware is not ready')
Cc: Rajan Vaja <rajan.vaja@xilinx.com>
Cc: Jolly Shah <jollys@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/spi/spi-zynqmp-gqspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index d07b6f940f9f..9850a0efe85a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/firmware/xlnx-zynqmp.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.11.0

