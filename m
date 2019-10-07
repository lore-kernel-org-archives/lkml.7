Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BBBC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5380206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="jJWWEw+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfJGLuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:50:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46175 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGLuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:50:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so8460784pfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSn44ELsACDrJV6YuzhazB9chVnS0zNhjUBqVEIYH+E=;
        b=jJWWEw+ywPRxiLCbL0yXNsBIVsxxQ75msibMDy3tdqTkEzU0jbKdYADa5mkrQdnz46
         E583AijCNh0bbNRMfMelHC10IpWHkiQvBNM5v1X+4/wMclEhMzz3SmRzrneM/Y85a34U
         l5UhGTXm5KNyzbLsUddwI3kshqQPTfBl2B7brz6NV59fQmzjuTzlelZ5J1Hs1dumqtaQ
         ddlF/N8ZVgs9XW9dpG3OQX+3L8LHtkkyJDrZ8yl+jhbRYL/fzGEiLIfhJ3oYLe1JbjL4
         DOsVByLPRblDz6dn0HbwsmPykYxqI0pHUWxF4PuEPXnnUPGbUqNrQlOJQI36/ybFa1nw
         kpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSn44ELsACDrJV6YuzhazB9chVnS0zNhjUBqVEIYH+E=;
        b=s0kjeRf3zaumwtOPvU6BK9fEXTC2ZVzrSCq/B55SL/pcgA7+4RKF/4YE6IRmMiaxv/
         IY9XwesBhl6nt6QK7TG9+ijHHXXDHHprymYAyFjDcFeCxhqY0Iud6k/k6wn8/t/NFOEm
         EEKZdbsUxwDiF/1PfuqmsMX9cD4mcfmV0FITMJCyH2oTcfHH5rbWj0/FVw+e+Sge8jZl
         RJUpYfIH22WW4VzY8vSLSLSv6b2rIC9ZxgL15j9ZebZsi53fsuTj91crKSB2u5SavGsi
         i/Y2EuYpow52fMikq4VwTroM3yjIHO7OvaUq4PwE5yAstT3aoo0aOvA+IKoiVnEDLk6l
         WZnQ==
X-Gm-Message-State: APjAAAVWnYXJoXyPbzxkmWmCaflhUlyiM/aGOijBNOtykqN5yBph2/Yz
        1JYhHJDJO19UM4NugLiJKW/TbQ==
X-Google-Smtp-Source: APXvYqwIGHG76ygYtiMBWUQj8YkERrvUlorn8r9fc+GbzwAP/EDh33DUl38qf5qqpLYdZcDd8DvQUg==
X-Received: by 2002:aa7:90c7:: with SMTP id k7mr32887105pfk.39.1570449018527;
        Mon, 07 Oct 2019 04:50:18 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id e21sm10986067pgk.57.2019.10.07.04.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 04:50:17 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [RESEND][PATCH 1/2] regulator: da9062: Simplify the code iterating all regulators
Date:   Mon,  7 Oct 2019 19:50:08 +0800
Message-Id: <20191007115009.25672-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more straightforward to use for statement here.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
This was sent on https://lkml.org/lkml/2019/7/11/208 with Adam's Ack.
 drivers/regulator/da9062-regulator.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 710e67081d53..9bb895006455 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -942,8 +942,7 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	regulators->n_regulators = max_regulators;
 	platform_set_drvdata(pdev, regulators);
 
-	n = 0;
-	while (n < regulators->n_regulators) {
+	for (n = 0; n < regulators->n_regulators; n++) {
 		/* Initialise regulator structure */
 		regl = &regulators->regulator[n];
 		regl->hw = chip;
@@ -1002,8 +1001,6 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 				regl->desc.name);
 			return PTR_ERR(regl->rdev);
 		}
-
-		n++;
 	}
 
 	/* LDOs overcurrent event support */
-- 
2.20.1

