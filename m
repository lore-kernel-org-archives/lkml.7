Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D391C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7532084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="FZ1PSMDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfDMHaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:30:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44107 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfDMHaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:30:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so6187359pfm.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=giBB1Ax8yawUBM/21xntSxct8s/aOn+EPzldC0qFaIE=;
        b=FZ1PSMDXmkH6XgSVw+DmJDvchdSaKCgeohhjgH+D6K02mvDkvCGcBHzeXY6Yw6DrdV
         CqAdu+3tzFja2PYgd2XzhBwS64c/D13LnI+MOixWRrbvnhhxQPKiFFO3N2bg+zr0RgrC
         OHG5CbpVYBauAFFOJWiiTlsF5QsaNblIXORzZRWQI3Y87ApXwy5dzy7l60n/n+jO8ka/
         GmoWOx8n67HwtzENxl3xjL7L0znMqUzipY/TQG23DHhUGiyMeNCXrEJIYdKjU9naaX0N
         NAiZ3iUJTFaW8YzvOK3mXhSinYlEGyWyaYHq+skg0YxkSAvEG6AmCZ8loqffOfpKDic+
         Q0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=giBB1Ax8yawUBM/21xntSxct8s/aOn+EPzldC0qFaIE=;
        b=jmmd8/iP8xe7wiTRfb3cM9cZY5Joncaj2rcFIawgKM9sCqelOICKic09PftltZuaDj
         jj3FvKLFZQ7YSlAMUuxnfXHdyr9Wqhk3JPATd+CLLBIE5WeZNNYGYTKjkjr9JvO100ut
         5Sq4f3o3Iw20wGCTHk/GoteM2m6raWAe/suXTLup4JxAHlxlyopy2SRcdAighQ13CUMF
         h1IlJ8uFFdKqjZ3kJO3xIlM97RYL/L4CrCMTNr7YmPpbRBCxmHMcJ3tQI1SHePW5gKAL
         tQgXBMfPdkTh4WhQdu1RW8oqF5te7QBUmkTchYgRAsfiQuZuPc/mmvVESyeilf8PMYV9
         CxSQ==
X-Gm-Message-State: APjAAAXESBhCX8VbQr9dSK0Xx7tLfNHy1+QOKnewGLPJ8Vx0yX9pC1eA
        8EPLGcl6s3JUlpSl4FLnAmZARg==
X-Google-Smtp-Source: APXvYqzV7f/zD+ZCAxkuTJiuMR9Ldc+sXWnsgZvJc0LSWlP5qaWuyoNsC7ZOrQn4GjjdJGjgoNrjXg==
X-Received: by 2002:a65:638f:: with SMTP id h15mr52821289pgv.147.1555140616357;
        Sat, 13 Apr 2019 00:30:16 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-188.dynamic-ip.hinet.net. [36.239.234.188])
        by smtp.gmail.com with ESMTPSA id q80sm84418286pfa.66.2019.04.13.00.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 00:30:15 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cyril Chemparathy <cyril@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: tps6524x: Remove *rdev[N_REGULATORS] from struct tps6524x
Date:   Sat, 13 Apr 2019 15:30:02 +0800
Message-Id: <20190413073002.764-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413073002.764-1-axel.lin@ingics.com>
References: <20190413073002.764-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code is using devm_regulator_register() so we don't need to store
*rdev for clean up, use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps6524x-regulator.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index c09223c34dbf..740aeccdfb1f 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -137,7 +137,6 @@ struct tps6524x {
 	struct spi_device	*spi;
 	struct mutex		lock;
 	struct regulator_desc	desc[N_REGULATORS];
-	struct regulator_dev	*rdev[N_REGULATORS];
 };
 
 static int __read_reg(struct tps6524x *hw, int reg)
@@ -584,6 +583,7 @@ static int pmic_probe(struct spi_device *spi)
 	const struct supply_info *info = supply_info;
 	struct regulator_init_data *init_data;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	int i;
 
 	init_data = dev_get_platdata(dev);
@@ -616,10 +616,9 @@ static int pmic_probe(struct spi_device *spi)
 		config.init_data = init_data;
 		config.driver_data = hw;
 
-		hw->rdev[i] = devm_regulator_register(dev, &hw->desc[i],
-						      &config);
-		if (IS_ERR(hw->rdev[i]))
-			return PTR_ERR(hw->rdev[i]);
+		rdev = devm_regulator_register(dev, &hw->desc[i], &config);
+		if (IS_ERR(rdev))
+			return PTR_ERR(rdev);
 	}
 
 	return 0;
-- 
2.17.1

