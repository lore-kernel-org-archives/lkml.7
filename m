Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D360EC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914E120866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Y1ONhyuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfEABLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 21:11:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40557 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfEABLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:11:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so7653263pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 18:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLbFfePIXhHKlqLDWpLXnrFweDYBpHhu10xEmMt/WgI=;
        b=Y1ONhyuhP1pR7OIKl9yssecBqsAP3IDLG2BDOW0p3ekW4bmjco6hF0oh4qeo4OGLmO
         /Rda5XzA6cOveDKxoWw+CKnBj8RQ8DSnGYh98gg86coQHU+HglcN5MpQ6wzU/+Gv2+N6
         QrZ6wHBv8+GnnHbujl+B7iQoan2vFQKbafOUFtFP+F9T50p6iwEOTmQJm6ImaQYoFZxk
         yZNEherIvyqUNzbr8JHl79kyGQfo8s/RNAWpgthG/d6rgX8lGjvajCYwR0jRdxUDQ5k1
         EvPFAD0PqTWEYahqcUDLYvPEjXuojfI25x+KIgklkO7WBt+MH53fA+czcN9cZ5QYjliJ
         +a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLbFfePIXhHKlqLDWpLXnrFweDYBpHhu10xEmMt/WgI=;
        b=tGbFwHOyGJRMKZNJhrNcX6Y7GZfGKCVQUbwENFmKpIZchSdtlcxPizvOqvZ9QqZROU
         g0XVYHdeNiZnSdrWEkHsKeEuh9ZOnhBs4hn3UrZXuabzqgfn+uLSv92g+VeMagAHOR6U
         AoW1Sl19UYaOmZlN+5YMrzZ2nRlMk6WvYlCn+vSnIgQMGtpkhc39M1eUotkHe363DeFO
         zFHTDtCFbQxgnRuCJmpgAvUfsM2XFWJuTUZQP93PNQIFUiEFYE2DGvK/mDTcPm2XbmVq
         WGNIFlFRGypTkVif83vsXyZ0sQU+MJCXW7IilyO8/jCN5EqzbP6vROMnOAJIvhroGDAe
         8ajQ==
X-Gm-Message-State: APjAAAWs4LOK3wJJtM7I7FOtyjFyjLZyKl9i9HeGojOMMKnuGthivEpR
        rwPR5G2WQyJ2u86OhZIuqZYIZQ==
X-Google-Smtp-Source: APXvYqxbk62+b0D2+4MUmsK4Q+HXp47m8Z6MP2AWcwzvS1ti1bXxDroalbmsrbxny+Ss6ukUDHZzBA==
X-Received: by 2002:a63:d803:: with SMTP id b3mr42635926pgh.267.1556673103560;
        Tue, 30 Apr 2019 18:11:43 -0700 (PDT)
Received: from localhost.localdomain (36-239-226-61.dynamic-ip.hinet.net. [36.239.226.61])
        by smtp.gmail.com with ESMTPSA id w38sm31539531pgk.90.2019.04.30.18.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 18:11:42 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Guodong Xu <guodong.xu@linaro.org>,
        Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: hi6xxx: Switch to SPDX identifier
Date:   Wed,  1 May 2019 09:11:31 +0800
Message-Id: <20190501011131.16186-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert HiSilicon hi6xxx PMIC drivers to SPDX identifier.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi6421-regulator.c     | 24 +++++++++-------------
 drivers/regulator/hi6421v530-regulator.c | 26 ++++++++++--------------
 drivers/regulator/hi655x-regulator.c     | 22 ++++++++------------
 3 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/regulator/hi6421-regulator.c b/drivers/regulator/hi6421-regulator.c
index 6c7ea4eb4bb0..5ac3d7c29725 100644
--- a/drivers/regulator/hi6421-regulator.c
+++ b/drivers/regulator/hi6421-regulator.c
@@ -1,17 +1,13 @@
-/*
- * Device driver for regulators in Hi6421 IC
- *
- * Copyright (c) <2011-2014> HiSilicon Technologies Co., Ltd.
- *              http://www.hisilicon.com
- * Copyright (c) <2013-2014> Linaro Ltd.
- *              http://www.linaro.org
- *
- * Author: Guodong Xu <guodong.xu@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Device driver for regulators in Hi6421 IC
+//
+// Copyright (c) <2011-2014> HiSilicon Technologies Co., Ltd.
+//              http://www.hisilicon.com
+// Copyright (c) <2013-2014> Linaro Ltd.
+//              http://www.linaro.org
+//
+// Author: Guodong Xu <guodong.xu@linaro.org>
 
 #include <linux/slab.h>
 #include <linux/device.h>
diff --git a/drivers/regulator/hi6421v530-regulator.c b/drivers/regulator/hi6421v530-regulator.c
index c09bc71538a5..06ae65199afd 100644
--- a/drivers/regulator/hi6421v530-regulator.c
+++ b/drivers/regulator/hi6421v530-regulator.c
@@ -1,18 +1,14 @@
-/*
- * Device driver for regulators in Hi6421V530 IC
- *
- * Copyright (c) <2017> HiSilicon Technologies Co., Ltd.
- *              http://www.hisilicon.com
- * Copyright (c) <2017> Linaro Ltd.
- *              http://www.linaro.org
- *
- * Author: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
- *         Guodong Xu <guodong.xu@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Device driver for regulators in Hi6421V530 IC
+//
+// Copyright (c) <2017> HiSilicon Technologies Co., Ltd.
+//              http://www.hisilicon.com
+// Copyright (c) <2017> Linaro Ltd.
+//              http://www.linaro.org
+//
+// Author: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
+//         Guodong Xu <guodong.xu@linaro.org>
 
 #include <linux/mfd/hi6421-pmic.h>
 #include <linux/module.h>
diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index 6f6635daa026..ac2ee2030211 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -1,16 +1,12 @@
-/*
- * Device driver for regulators in Hi655x IC
- *
- * Copyright (c) 2016 Hisilicon.
- *
- * Authors:
- * Chen Feng <puck.chen@hisilicon.com>
- * Fei  Wang <w.f@huawei.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Device driver for regulators in Hi655x IC
+//
+// Copyright (c) 2016 Hisilicon.
+//
+// Authors:
+// Chen Feng <puck.chen@hisilicon.com>
+// Fei  Wang <w.f@huawei.com>
 
 #include <linux/bitops.h>
 #include <linux/device.h>
-- 
2.17.1

