Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E23C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01769218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="s3hqE5oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCPDxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:53:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44801 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCPDxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:53:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id a3so7628784pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 20:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=H34PW3zJRWJmTKKZOqzZyYoTnWD3Ab1uIePCowMzXK8=;
        b=s3hqE5oiSF1+VuJPmb1pkORIemvbCLPmgn+DzePbdro6f2VXfmQz7+6Q7XMolMpjc3
         SG7IrE0Flk1u8hiNXBsMpEEx0n8P14riODGZWGS2A6VCwqQgEtQcUquDAz9bGDAMhg2v
         oj0vapZn5YY3GMzZQS4yk1M2O17MsxnW4nQzkd169HoXk8UcTH82w2dUXb9cv9GgyGBw
         nEj7hNxoS5F5AE6itWO4bUBIZpj+aRtQzlTUx9XcWadcwNuVYc8TmTkAPXIV4LswdJX1
         XAnRDYcNQgqfKf2smNqaNwkHX9zZWty5HbIygH1xaKQD+Qv1Y6S367iMLdoq/SJFQDrS
         R/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H34PW3zJRWJmTKKZOqzZyYoTnWD3Ab1uIePCowMzXK8=;
        b=PQ6ec+2QAJ32lWSlGnv7gyXb9sush28SpWwNk/nm0DJCWvh5vN6zXG9cBP33CjSSyf
         DVjUkQsx4L5+rn/8gUuSvjq4ZGXZngDtk0iyvqQIjP0BZRTTet4TI7ZN0/3476MZ+T9F
         U0BYnI6Gb5Tu+j2MMwLy3Oqcx9NehxAoWoOPLZKXh5Zl0Zs7D9JnfZN5/8qGftETe3kc
         oCQZoVgYcwJA9FmlkY0vE9O6266YTyG0wivrTVsRgWoMxVxmOU0fnHCvTtxzSGbtsVXr
         P7l76AkwOO/edDbdeG4qdRereUARJpCaBgv8AULH/o8/gF0OgrAphMkcYCYRrdKg0ui4
         vYGg==
X-Gm-Message-State: APjAAAWuoEIpMve3o1TVyBJi/HcZyBrTAcGx6djczxjnTux48dEHvFj1
        sJKsWCpU8JoMXkFuq5lmP2fPvQ==
X-Google-Smtp-Source: APXvYqxe+TpJkphkdgXrfTyM6DdfQCiaDTD5Hv/fbiQStlFlLoCHTvXjzT2pJqXLsibRuJHI6m9XPg==
X-Received: by 2002:a62:1c87:: with SMTP id c129mr7540665pfc.94.1552708389324;
        Fri, 15 Mar 2019 20:53:09 -0700 (PDT)
Received: from localhost.localdomain (36-239-209-125.dynamic-ip.hinet.net. [36.239.209.125])
        by smtp.gmail.com with ESMTPSA id k29sm5056718pfj.92.2019.03.15.20.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 20:53:07 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vince Hsu <vinceh@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: as3722: Remove *rdevs[] from struct as3722_regulators
Date:   Sat, 16 Mar 2019 11:52:57 +0800
Message-Id: <20190316035257.19441-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code is using devm_regulator_register() so it is not necessary
to save as3722_regs->rdevs[id] for clean up.
The *rdevs[] is not used now, remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/as3722-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index 66337e12719b..26f2951c1dac 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -81,7 +81,6 @@ struct as3722_regulator_config_data {
 struct as3722_regulators {
 	struct device *dev;
 	struct as3722 *as3722;
-	struct regulator_dev *rdevs[AS3722_REGULATOR_ID_MAX];
 	struct regulator_desc desc[AS3722_REGULATOR_ID_MAX];
 	struct as3722_regulator_config_data
 			reg_config_data[AS3722_REGULATOR_ID_MAX];
@@ -929,7 +928,6 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		as3722_regs->rdevs[id] = rdev;
 		if (reg_config->ext_control) {
 			ret = regulator_enable_regmap(rdev);
 			if (ret < 0) {
-- 
2.17.1

