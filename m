Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89E020684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="vRrV0Vpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCFNuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:50:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36947 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfCFNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:50:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so8479650pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 05:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SZfhpALKUvjXqolUDGnnDLLSa1wSeT7YJc6melV9Zxg=;
        b=vRrV0Vpl2RwhenLKKyGJ4AMctTBgRYh7vncRdEsZsEMIDIr6MZPMBiqdzN6yUVq+jZ
         4UbYHCgqb6uKvL/OGOkxZZ2ZrSX5q05xcGQYJFjuH+cC8tI2AQG/s41LPG+phawegzAO
         wTQElNX60dpkyXAxV/l92/+3lZPfqS2/zsnQYthDxXBeagNff5HHSiExwp/WVIyW3iO5
         kdnljICZI2BXqiIPvV4SYpNs/xwP8RDoJrCMtFg9ud2Q9pSXvEGsOp89gX9yy6ZOlW5/
         J3GIZ0ZoTtGEsWY80WwZ92Ep+690B/lTYcPIqs1YEIoimNyEhUazGq17ddJX4voiiIVe
         rf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SZfhpALKUvjXqolUDGnnDLLSa1wSeT7YJc6melV9Zxg=;
        b=bR0KeQqLAloVnSuxTLVR3xUPQBvYMnuNIo1WUTDJHjqyRsNv+2IFmnbuUFWPe5aike
         vvfKrSiVuwyaagrNksz3kMb0EJcJ4usPPAOzhF6mDvlZsNa3Mg4ePdYExq7P+ukzJcCn
         gj6XCxckqYXAmldOrC+MYn4QGoJ/44uXawa2kfmG24hpxtzUds5+GHflK1I221WGhZFj
         KdiRemZqevhgbWYDmEhw2KaGvr/gFUhX4sam9t1dLuu/ru5a0FqqaG74A5VQ8GOGdpWF
         +30rruKOB4omSd1wC7+ICBVncMLXl1acE4bntjgRXPLiXMT3QX9feN2/H0Dm/pYyPHnk
         P/Xg==
X-Gm-Message-State: APjAAAVNpsqJr3taq3p1XJ+ZgByUsxzZQBZOVqpuG8Z1KJYcimsGKKNB
        DeQ/4oTOJJxPipGOyvhAHb4gKg==
X-Google-Smtp-Source: APXvYqy+9MtnVhm+orR1fWE03oClEKz94ap97KpI3e7Vm6V66fUle9UZt1ry9s7SBOSuXitW+jd6yA==
X-Received: by 2002:a63:591f:: with SMTP id n31mr6291183pgb.304.1551880201304;
        Wed, 06 Mar 2019 05:50:01 -0800 (PST)
Received: from localhost.localdomain (218-164-96-47.dynamic-ip.hinet.net. [218.164.96.47])
        by smtp.gmail.com with ESMTPSA id f125sm3966301pfc.91.2019.03.06.05.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 05:50:00 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chen Feng <puck.chen@hisilicon.com>, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mfd: hi655x-pmic: Fix missing return value check for devm_regmap_init_mmio_clk
Date:   Wed,  6 Mar 2019 21:49:49 +0800
Message-Id: <20190306134949.31883-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since devm_regmap_init_mmio_clk can fail, add return value checking.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mfd/hi655x-pmic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index 96c07fa1802a..6693f74aa6ab 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -112,6 +112,8 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
 
 	pmic->regmap = devm_regmap_init_mmio_clk(dev, NULL, base,
 						 &hi655x_regmap_config);
+	if (IS_ERR(pmic->regmap))
+		return PTR_ERR(pmic->regmap);
 
 	regmap_read(pmic->regmap, HI655X_BUS_ADDR(HI655X_VER_REG), &pmic->ver);
 	if ((pmic->ver < PMU_VER_START) || (pmic->ver > PMU_VER_END)) {
-- 
2.17.1

