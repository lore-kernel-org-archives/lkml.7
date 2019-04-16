Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C803C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A05620652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="yrBQcedA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfDPKRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:17:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42365 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDPKRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:17:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so10120080plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b9sQ2yqIbNA41Ye8NU58Qav1m5dawFkcSpL9ONWZnsM=;
        b=yrBQcedAyZeYLykXpT+24N2LC1E0y4ac6amOHbsNv9pfJIlFKyYrA9QXYlCTiQfoIN
         HcMpxRjDlPKuvQXFRkJ31AfIINycjkQ0OG/oyjnRyOH6+8ANFJFg9skbaKkVmjyOjDvX
         yzmzdTqglaEtcjfym2mGA6YLCQqYp8WxBN5YUYiJmHkhpCq3qpY44GL3EoSSF2SrNg/0
         4o4RZbNPEmBpbJZn/39Wy8n/XNB3pNHMgHeGy3s8dnvyKVVHJq7QBryu4ps3iW9meZ/g
         iU5ck1F5EU2/GCgHc+/SMKC0fpAZmqizTCYiUA0l880wnTpPPdoGUr7+X4Ty5Pdjx+8P
         CGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b9sQ2yqIbNA41Ye8NU58Qav1m5dawFkcSpL9ONWZnsM=;
        b=ey9OE9y5XrDqaK/D3mGsbHzmfKnHRveWpXxeJf6gAqY0xeTLR6P0391lXuDR7raGXg
         cbl5C6SQ3xMTqDyzglcWXk6y68jUG9kuazv/6tvbVvuG/G/Qtnm3V+Juth5qQ5ZTVbFq
         00EdaovbuGIjrCzRZxg8TFZXvj5Wv6Fb/LH8pJ/QGG1CuRiaGfJ67pYuUVdsGbSgDXXx
         c1E7FBA2IBSi3gPT3ruYwTJUTGa2F58hoUl+qxXFJj2ByyaelQjtrZ4xv3+rUDq8lxZo
         4/0y23kOsMDS8kkDafWptfiznyfuQ5Lszd8HQbV6e/vGuR1cY9Oyf6T/VMf6BcOPmMDr
         1vAQ==
X-Gm-Message-State: APjAAAUJqSGoQHDU6yQccY7aF4ntgbOe2yckgZ2G4mxpxvToZ2AJH+o7
        Hrf24EaIIDZa2kZO3iV4R8n0uQ==
X-Google-Smtp-Source: APXvYqwxBBsi6zGmBbZeNTQReoLTuyyHTpTWVVlpiOGHWR3CBmjVxLriApd3Jc1Pw7ca5tXZ+Rnjzw==
X-Received: by 2002:a17:902:e101:: with SMTP id cc1mr81997702plb.129.1555409864242;
        Tue, 16 Apr 2019 03:17:44 -0700 (PDT)
Received: from localhost.localdomain (118-171-129-145.dynamic-ip.hinet.net. [118.171.129.145])
        by smtp.gmail.com with ESMTPSA id h187sm105434588pfc.52.2019.04.16.03.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 03:17:43 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: tps80031: Switch to SPDX identifier
Date:   Tue, 16 Apr 2019 18:17:29 +0800
Message-Id: <20190416101729.26330-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416101729.26330-1-axel.lin@ingics.com>
References: <20190416101729.26330-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps80031-regulator.c | 34 ++++++++------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index 8e65a13e2ef5..85a6a8ca8c1b 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -1,27 +1,13 @@
-/*
- * tps80031-regulator.c -- TI TPS80031 regulator driver.
- *
- * Regulator driver for TI TPS80031/TPS80032 Fully Integrated Power
- * Management with Power Path and Battery Charger.
- *
- * Copyright (c) 2012, NVIDIA Corporation.
- *
- * Author: Laxman Dewangan <ldewangan@nvidia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
- * whether express or implied; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
- * 02111-1307, USA
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// tps80031-regulator.c -- TI TPS80031 regulator driver.
+//
+// Regulator driver for TI TPS80031/TPS80032 Fully Integrated Power
+// Management with Power Path and Battery Charger.
+//
+// Copyright (c) 2012, NVIDIA Corporation.
+//
+// Author: Laxman Dewangan <ldewangan@nvidia.com>
 
 #include <linux/delay.h>
 #include <linux/err.h>
-- 
2.17.1

