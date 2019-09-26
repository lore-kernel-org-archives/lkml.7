Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA7C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213FB222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="qT+Xf+me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392445AbfIZFvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:51:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45048 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387630AbfIZFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:51:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id q15so563963pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 22:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yR1g/TNs/jOubvrkovMok5XTGrxoLV7pJnCO9STU1U=;
        b=qT+Xf+mebPQvBlGlfjVhqkR4sKw9MjU+5kgNWOf9kqHgwnXXbBBXXnbvagFwRGWbDp
         FYN0J4pg5DHYIRcCwMJ+C1PF67oOCikv0LdNPbiegX+1/Bhg3Zd8D4QDIDGq1VQNiiEs
         ZFrFAcBYw3cHuhAxbz9ds3NkCk0frjLdyWmNkwJA6KtD3K7xl9PMlLcpUZb2tRXIkGrB
         7ifn2gbZLvruYZIEThfZaMuU/4IfSBuDE7w4EBPB7UiJFkoQ2M063esL1ZBsnxuo/8Yn
         Hvw6jZDoGPCjssuDxnp7MMSOtbWO+8UDbuJkIX/V1zzput27+OSSN4kVKX2OmYcIOVmb
         7NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yR1g/TNs/jOubvrkovMok5XTGrxoLV7pJnCO9STU1U=;
        b=nP7kDI88b+81kEX/LVrfyfI6SsZ0ZorFGfXhQYe4L2Ix/kdm3qgrFWQ26Vyi1ePofG
         f+Fzt8m2k9xKTGzr6lf9/US7snDZvtZIu58ffJmmOm67rHilBDRgYirolJjMncOcdGFO
         Qeq0fawQpohQPut8ulBBzvRYKV8UsaCb8V5pXCdvw3Er90526T/FM2YIplttkmrAerwg
         k1WG3P8n83guK3KfB7BX8RR2ORPE7bk/HkzBhXaWBslimuomeFnXiy2KcX0cnsm8hSDQ
         IlbQwkwv+RNDwY40qu5yNe7tyNMB26fktHZAWvOFPPIZnoyf+J7bOIWSVJErvziGLFIF
         YSWA==
X-Gm-Message-State: APjAAAVWXmHQC8yC/egTeKilw6dXpUHYBRPJm6kXL1VnvtjNT+F6x1Rv
        2Y8spFZ3EZq6/gGzyYNqdtLLzg==
X-Google-Smtp-Source: APXvYqxeStTr1xHQGT6dHGgCRAizc9AjFzFBKKOIVjgAQinhPXdx/MRVHhszd/boN9NCXhv6mDTdrg==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10mr2034538plo.233.1569477098773;
        Wed, 25 Sep 2019 22:51:38 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id f15sm854021pfd.141.2019.09.25.22.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 22:51:37 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: da9062: Simplify da9062_buck_set_mode for BUCK_MODE_MANUAL case
Date:   Thu, 26 Sep 2019 13:51:27 +0800
Message-Id: <20190926055128.23434-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sleep flag bit decides the mode for BUCK_MODE_MANUAL case, simplify
the logic as the result is the same.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9062-regulator.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 710e67081d53..739a40f256f6 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -136,7 +136,7 @@ static int da9062_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	unsigned int val, mode = 0;
+	unsigned int val;
 	int ret;
 
 	ret = regmap_field_read(regl->mode, &val);
@@ -146,7 +146,6 @@ static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 	switch (val) {
 	default:
 	case BUCK_MODE_MANUAL:
-		mode = REGULATOR_MODE_FAST | REGULATOR_MODE_STANDBY;
 		/* Sleep flag bit decides the mode */
 		break;
 	case BUCK_MODE_SLEEP:
@@ -162,11 +161,9 @@ static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 		return 0;
 
 	if (val)
-		mode &= REGULATOR_MODE_STANDBY;
+		return REGULATOR_MODE_STANDBY;
 	else
-		mode &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_FAST;
-
-	return mode;
+		return REGULATOR_MODE_FAST;
 }
 
 /*
-- 
2.20.1

