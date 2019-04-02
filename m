Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD546C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966EF20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="1E/EdgkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfDBMN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:13:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43811 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDBMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:13:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id m10so6183137plt.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=OCs6Cin3XeNspbuCmedDJ5fZOEMABgOn//D7d7696l0=;
        b=1E/EdgkQhZTSAGcLaBNBrEQQW9HZhFtRyf1DjMA6XtgUavxXftpyJ6ILzLfQIzviIe
         17kCCSlzYzwku2Qgz5Xv/Ru2s3FMR3wamfxYPzw9X/dCDq9zZpczdoTXnV4GQsRLHQQL
         6FiZ/tA1OQuoX/kVo5shcsLXlXpxV2k+BF+t9hdkTFMJqL18jUC/ihvejRLiI29qbJBp
         k7KPoy1GZPviwFdYZjJGIGFYU0tbIKyFxW4AO85yKzxtyape+ugK3ivbwjaHHdS7pA3W
         sqTuEdlEy/WRfF/HfqXJWWyk7rtzCNJ8BXb/89CVz0i41n4bxrYoc0S8tXGy8/nlIo72
         BAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OCs6Cin3XeNspbuCmedDJ5fZOEMABgOn//D7d7696l0=;
        b=NiTyGlsw6EvFFrNj7jOLda90W9XseQx0U58fB4K0vDCudHksD8Z2MoH1ysVpp64Qzt
         7QqNcAII8FPQt0oBzBiryhzkM3uP4jf2Ih3eGLnKTF6KCNUbMH0yIJAsI7zUnKN/ZJY9
         lqgTae8vbEkbby127gg5+RO9wEOFTiw4zzNAt++PiTt4m+uS6uisapX0I9ALoxsnq5wK
         vcBmAbzGVW6G8UkYFQa/AvXEBCdmGGyv8p8MAYy75GuRnY3wIADSXjXcDYu9knxn3//H
         YwMdwC4n6Lb2E3ieM3ixyitO+nK6Ac0h1fgJoBfhKtG8JYrWfVR07NTTGLu0d/vGQFgD
         GDqQ==
X-Gm-Message-State: APjAAAW/Q2ud73ZJvkwjzC/LpWrcvO2Rknj9kHj5z/iFu8IouQ+LCPXQ
        AE/Kp/RX8VvaQSvgEyiXWyQY5g==
X-Google-Smtp-Source: APXvYqxrRNmFz6JWTgIqZzM7lkHBwH9NHT8fWIDF5KuOGUct0gksztfez32HTxD9RCKSBsVF4iBw9w==
X-Received: by 2002:a17:902:4827:: with SMTP id s36mr36522545pld.296.1554207238407;
        Tue, 02 Apr 2019 05:13:58 -0700 (PDT)
Received: from localhost.localdomain (36-239-229-248.dynamic-ip.hinet.net. [36.239.229.248])
        by smtp.gmail.com with ESMTPSA id a80sm36928415pfj.61.2019.04.02.05.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 05:13:57 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: lm363x: Use proper data type for regmap_read arguments
Date:   Tue,  2 Apr 2019 20:13:47 +0800
Message-Id: <20190402121348.23477-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_read() takes unsigned int reg and unsigned int *val arguments,
use proper data type for these arguments.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lm363x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index c876e161052a..ebec91b55ceb 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -48,7 +48,7 @@ static const int ldo_cont_enable_time[] = {
 static int lm363x_regulator_enable_time(struct regulator_dev *rdev)
 {
 	enum lm363x_regulator_id id = rdev_get_id(rdev);
-	u8 val, addr, mask;
+	unsigned int val, addr, mask;
 
 	switch (id) {
 	case LM3631_LDO_CONT:
@@ -71,7 +71,7 @@ static int lm363x_regulator_enable_time(struct regulator_dev *rdev)
 		return 0;
 	}
 
-	if (regmap_read(rdev->regmap, addr, (unsigned int *)&val))
+	if (regmap_read(rdev->regmap, addr, &val))
 		return -EINVAL;
 
 	val = (val & mask) >> LM3631_ENTIME_SHIFT;
-- 
2.17.1

