Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0204F2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Gpvdoyws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfCAGQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:16:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44443 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfCAGQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:16:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id c4so10947615pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 22:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=cQNG138ikpNGw3qpRZFj1ncB7YFrvlGB8Mo8CMazV98=;
        b=GpvdoywsNJu9eusCQfnoDp4ZpDchC3f3Kw1+kpt93NeRA4OQXL4ejxyvu72jPqBWEN
         1bV5gHWBODRmgIk+97/89MALqmXeORtJd9GKkxcX8mATPb/h3lKwlZwyM3/rgmRMGW6N
         RC6gyctnPrx7RlfR/ZfF/8L65cmo12H4/PrBDv4nC/t4ssJaFS9xRSsR9X/f22iRmT+b
         9o5cWYyIauVwcbVu54GppZ4O5AzdSYpVJaYZombS2Yx410ofCpm4B2JBqqLbDmHYEtae
         Xlw03doMYwNXWPdQib98ZbAGgeCxSmiht+L1+08zDPfUebOjo4QSLIwBmVb6W8sJtktq
         PHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cQNG138ikpNGw3qpRZFj1ncB7YFrvlGB8Mo8CMazV98=;
        b=Qg1H12+esRNXWBMEr0zB09J3sz1TjDqThJBWVXC71nMy0vHSK2xQJPMch4Sy4NfPyz
         +m7bHnDkSoOWNjCdTu1DOLCwrIb/EwWn582hx/i69Sjbo9Gcp5ukMMvKIcR1Hh25UNJR
         wgUfMi8AMwejdEN49ZDEvEAx9HZna3PseI7Sm/tYUKhO5rVBz0wbz3aLE2LNd0V/bBA5
         DafhXMeyhXFzF8n2NrJrCL4bSe+dbLgpIugb4WCwRxwquqOYBkua9j/nFcxWwQcE1it4
         FGoG6PMO56zUqyNKG7jYSeoZpyR/6E5ecPK1jcJn3AKQBxR0+QBVLE1BXytkML0Nd5cN
         bvaA==
X-Gm-Message-State: APjAAAWW+gi+HBJKGC2smfEYUrOOlr8PGpspBUzp8jEHxRMVXFvYJSoW
        vDPO1dqOY9Oxz7itoB5Ax1pK3Q==
X-Google-Smtp-Source: APXvYqxmbeKBPR+OlZwvNMQIqKTVuX/2Git/yD/vSdQFCnRI5CEGxhaaPOUPDfjul8yQiWgCR0jEMA==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr3819373plo.254.1551421015984;
        Thu, 28 Feb 2019 22:16:55 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e303-1426-0ded-295b-b15d-4a53.emome-ip6.hinet.net. [2001:b400:e303:1426:ded:295b:b15d:4a53])
        by smtp.gmail.com with ESMTPSA id j24sm31245078pgl.58.2019.02.28.22.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 22:16:55 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] regulator: lp87565: Fix missing register for LP87565_BUCK_0
Date:   Fri,  1 Mar 2019 14:16:40 +0800
Message-Id: <20190301061640.28921-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LP87565_BUCK_0 is missed, fix it.

Fixes: f0168a9bf ("regulator: lp87565: Add support for lp87565 PMIC regulators")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi J Keerthy,
While reading the code, it seems strange that LP87565_BUCK_0 is never used.
So current code only register 3 BUCKs for lp87565-regulator.
Can you confirm if this fix is correct or not?

Thanks,
Axel
 drivers/regulator/lp87565-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 4ed41731a5b1..0418e478c6dc 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -193,7 +193,7 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 	struct lp87565 *lp87565 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	int i, min_idx = LP87565_BUCK_1, max_idx = LP87565_BUCK_3;
+	int i, min_idx = LP87565_BUCK_0, max_idx = LP87565_BUCK_3;
 
 	platform_set_drvdata(pdev, lp87565);
 
-- 
2.17.1

