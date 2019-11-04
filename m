Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E79CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F09D2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTRqo8+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfKDSNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46334 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbfKDSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:13:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so11542993pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1T5qb1N1RGdNwfpZMS1nmW4JbJwNZQr2qiFyXV+vsXI=;
        b=rTRqo8+L54opQw9nOOIGSx7QK90W2+ZzHTPDMmxn1hbCSkcZuUL/6fkN+CfvtBKTdZ
         FQyvs5/addpNUheJk5F/Z7kqcvFW/X/4tEeWTflKsewuuK807msXk2yu5EH/mvLFcn8C
         LwwuwkuAW+DuwfVXerxkf7yv5czpA/VeEQv32eOSsUWvEShW1Ybkhi2zgRLzDd8zw7tP
         pSqjxj5VrqKF6AG548xdbuEneE6ki/9iCegyLDgHa/LySbv9FCZWD8BK28HoIAoEiAwY
         d/q6VWHJNPoL3Sj57PjR8LP8rVb4u90xDO2AC9rM93tw7BEO1mg8GLDusfk05LghjoZF
         cx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1T5qb1N1RGdNwfpZMS1nmW4JbJwNZQr2qiFyXV+vsXI=;
        b=EEGMkYB3XoEPsWVvjO/snoKoQeiuDAZZLQPlg+wdWw/VQGmXTps1uJdqlhyu5vTgZ7
         p36WhxTkUIlV5ptwMIrggpzlicwTePHb6EmcvyM6bYkOHkGs/0zhQIEkIcr1jScLQ0VG
         tjyjH6qxGYmpyQt/lTgz+wd2a8l2ewu7uo+eutFar6Ke5XfOL8B087rIj1Eo4EsnOy9w
         sHMwDK4+rdyopUvH0t5q16M4EAVCSyvzcztCbWka89hcttgbggPqhj6y8C+7i5sQmNgD
         PGXeM5cVc589NJyR3ngZgGcqSlPkJPPKPg5q6eg11QMpt0XVPxC0kJE0PRXZniqjMhHj
         ONqA==
X-Gm-Message-State: APjAAAV6CSqdWqSqTE+ISEfOUhnUUZ2XbTdxVjqFuEDRW7bQG0ucDV2e
        IsGCe5Aa5rCXbQkSXPpjb6mP6A==
X-Google-Smtp-Source: APXvYqzbD97XULlwKZFLLde0xd3Mo2cIZLDXgoGyIESD931rEzz+EAcepQaHiaccJptP0Iht3Ow9aQ==
X-Received: by 2002:a17:90a:86c1:: with SMTP id y1mr565934pjv.71.1572891187654;
        Mon, 04 Nov 2019 10:13:07 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:13:07 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] coresight: etm4x: Fix BMVAL misuse
Date:   Mon,  4 Nov 2019 11:12:51 -0700
Message-Id: <20191104181251.26732-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rikard Falkeborn <rikard.falkeborn@gmail.com>

The second argument should be the lsb and the third argument should be
the msb.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 3fc12ac44270..ce41482431f9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1246,7 +1246,7 @@ static ssize_t addr_exlevel_s_ns_show(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
-	val = BMVAL(config->addr_acc[idx], 14, 8);
+	val = BMVAL(config->addr_acc[idx], 8, 14);
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
-- 
2.17.1

