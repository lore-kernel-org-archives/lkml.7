Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BE3C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9643206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Aezef3sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfDQIn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:43:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44134 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfDQIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:43:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so11677315pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TRumfEhcKZivyvP950gUeZEwSNv7CtTexn5omDDhDQI=;
        b=Aezef3sgfaqvUY0lMfS5iRe0Bqnc/9c8xtQ+1Of2z5JLwJVHV+xR+Uoa+CUC1CI9fu
         2fee6Ex7ZLgge7LinJYChDWe/vGe5iA+bnLWcFQW8t/RjmLeCsWhZdfiIAkkBtcSRMTm
         d/aJTj7RWfZH/9JJnJ+5dA4GNBm20vnxxcgr8knfAMCHV+uDazgargcjWjc1AHT+rS/l
         EwlIVeEiNUCIBpqg1tcIu0700XjdhtBi/yHIoo/q8RM8qoS9jSr3kx5bOSzMHki96jRr
         br21hFwnTCIjMnfar3nSDc5aBi+iBBXtR4Sx+PyAHo+GmhGNZ4p/rM0gRtKl23FCB9Bs
         x1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TRumfEhcKZivyvP950gUeZEwSNv7CtTexn5omDDhDQI=;
        b=S8YuRMt+rMmHED7iC5c2/ZUVBUyAbLko4bVNOOisacHHOBYiQyBleOgYi6r2jtFImg
         QAxiG5p73i+FCrPWD/8XGRA8NY9VyB6FBjsMnz+ynELbvvS2qQX8CGwt/jIJDmUPx/VE
         PxiiJlJ3rBpZq8Vvzs4jode6gi1mW/dvaIUva5A5Au/RnoJFUL0n5hSSPPXDLz9ojyWC
         tJFbrQksgsO4s6lWM58gmhC5uEn6XfqLCLCXt8uDaD1Vy77kInQ8ooo2VUrw5FcxChZc
         JszxQfjvOeWxrZQlrUcSZVaLmbydpj94nvZGvvtOt5szmnjU8M/RxZQKZV6cQvhk6oWs
         LQNQ==
X-Gm-Message-State: APjAAAXT7TUTJ0teKtdO5UQNa5MlZg8rTpQi9CZEwHOrqCd79vaNUlwN
        xTZHqPvbW3cdL1aQXJKme98DCQ==
X-Google-Smtp-Source: APXvYqxQFcwJoH/v5ouQdujfBpDpjHdECF9dFNMMv9NwtsHVcWPWXKsivnRoNLjZEA8gZsNFXPzADg==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3mr88772087plp.241.1555490638163;
        Wed, 17 Apr 2019 01:43:58 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id g4sm76546971pfo.38.2019.04.17.01.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 01:43:56 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pascal Paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: stm32-pwr: Fix error checking for of_iomap
Date:   Wed, 17 Apr 2019 16:43:35 +0800
Message-Id: <20190417084335.15483-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_iomap returns NULL on error.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/stm32-pwr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 222d593d76a2..dd5c2b383e5b 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -140,9 +140,9 @@ static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 	int i, ret = 0;
 
 	base = of_iomap(np, 0);
-	if (IS_ERR(base)) {
+	if (!base) {
 		dev_err(&pdev->dev, "Unable to map IO memory\n");
-		return PTR_ERR(base);
+		return -ENODEV;
 	}
 
 	config.dev = &pdev->dev;
-- 
2.17.1

