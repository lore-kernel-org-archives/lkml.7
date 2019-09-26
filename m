Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BC6C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4699222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="fXhsn+SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392483AbfIZFvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:51:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39185 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387630AbfIZFvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:51:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so1134370pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 22:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XvnXoC0bFMVKOVkPDLgp2HQxALd4QfSI/v6j3NIo3I=;
        b=fXhsn+SYMLqe+Q6n29vM4sjfalUL09JT/lKvwO8u0//o4Rs+MJ+ZjYN4oLe8zFzTNz
         Bb5wikxGZ1OiJn+60Ld1VtvVT7TjWyw1JRYVE3pxzSTMojeyNUMb7N4MuFic+9OH4pDk
         m2rR1xCNYzmKyUrfsIPSJuobRfA5w2L4FlfouuL8VBtg9T5aNPjQa7BKWKBZ9heYrBOA
         +xKJX5BMp8cpOtQqgzauugBrz0Jo+bBqaSqirhF27KrCcAEeByg4igD/ztsF+kgQhLj4
         hzPUvZTd0f3wxh5FXTBuxFb1Y6QdsDvxfD3tKR1p5l2DJkm8RlXST1WUQvaPZ6GxW2nd
         sskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XvnXoC0bFMVKOVkPDLgp2HQxALd4QfSI/v6j3NIo3I=;
        b=c6DOkXH4t3s409UvhXXpQMBnqMaYz8RW7LqXq05tBllL4LurCDQCB6KY7tw+pknpvS
         LPVnHHeQRVd/DU2qYB/IorYGW9s+s4EvXprEF4FUSlJQy+M91vzLCDZxLJD7JPkKrc5K
         QXfMe7UMO+1GsvDVVNhM3LbuzZ66++F0Ua/d0MP/w1BUXsPOtdQDkFShdB1Y3/yyFvNE
         dUnu5Cf9Uu1VjHs8AOffX/ExfQ/M1AX7qJIdrW0IVi+4xYyNIFFO8bRYufbOC1kdQ+CM
         TGX+ZMBvqXfca37abPI4dOqLjZCvxUi7dDDDoMLmP8i5A61uUYPgMYtPc3MZ/RXdtaIY
         WMnQ==
X-Gm-Message-State: APjAAAXzmG0qWLBQbQ8yWS5Le205aoYThPITRLsrMWXgNv9Ao+H9Nro2
        Fzmu5FUX9DLTyejmpthBT6oALQ==
X-Google-Smtp-Source: APXvYqznbdLeev/KFSMHvIpum7OyWavq/DHP7Vaw7H7bKT/vOrJQpm+JkUsC09F8wvWjvq8nEg1Tmw==
X-Received: by 2002:a63:4243:: with SMTP id p64mr1653318pga.343.1569477100925;
        Wed, 25 Sep 2019 22:51:40 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id f15sm854021pfd.141.2019.09.25.22.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 22:51:40 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: da9063: Simplify da9063_buck_set_mode for BUCK_MODE_MANUAL case
Date:   Thu, 26 Sep 2019 13:51:28 +0800
Message-Id: <20190926055128.23434-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926055128.23434-1-axel.lin@ingics.com>
References: <20190926055128.23434-1-axel.lin@ingics.com>
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
 drivers/regulator/da9063-regulator.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 28b1b20f45bd..2aceb3b7afc2 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -225,7 +225,7 @@ static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
 	struct regmap_field *field;
-	unsigned int val, mode = 0;
+	unsigned int val;
 	int ret;
 
 	ret = regmap_field_read(regl->mode, &val);
@@ -235,7 +235,6 @@ static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
 	switch (val) {
 	default:
 	case BUCK_MODE_MANUAL:
-		mode = REGULATOR_MODE_FAST | REGULATOR_MODE_STANDBY;
 		/* Sleep flag bit decides the mode */
 		break;
 	case BUCK_MODE_SLEEP:
@@ -262,11 +261,9 @@ static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
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

