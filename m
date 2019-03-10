Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B8CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 15:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72791207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 15:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="ZrfFfp+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCJPGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 11:06:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38322 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfCJPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 11:06:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id m2so2027242pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=e7FiArjntyyDk7k5HjJB+X733nBPsbMzlYk28oFJBNs=;
        b=ZrfFfp+csisrdZXvJM9pJH9IOCgM+SVkSnd7Q11qJaqwKsprqrILXhNFxR/8GWidjd
         D/+5aNf7c4pTQiIdeEUiXtllDHCAeUSgiWBa9lCvAPINLqemsGbdfQK+Z67rtq6bFUwM
         x+ao9JkMRhN0q1iERaFe6IpmyBSdi1RIj1eB+0AB9kArsnOgfEqFccLU/2JT6/6++5Mh
         HSxk2iNgMIW9waeKaFTaRNpeWz0SfAf11UKVs8UWBwG1NPlpap2jHKb2zhbc+LuqAWrs
         5dFs3/Bf/DDLlExQXE2Gqc0Y9+qY1NYT4cL6u6FJJ3V0aD51yh3gJP8okN6g0prxv4CR
         A95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e7FiArjntyyDk7k5HjJB+X733nBPsbMzlYk28oFJBNs=;
        b=cAjJamT6BRC8cUKYxUxzAiWdbpbztG/S5BauTCe9BocOKlDFB+Qu7AjJq+szhqdKx6
         ZR67alrFWvV9kneEJJOvTubuI1qF40y6DhlX4T8u/THmo/8SHryx4a0mElzU1X56QnEg
         IoEUR6jJAihdafUVmrpGiGGS+pS2usmRPvo/fbI6hnXA5HLmA97Nf9ZbXrBvEp3VWzpO
         0ll1akrr73Gzaz/gEYKCCyLdMICC86jAI76tLkwmUpLlhmsso/ByGY5H5LnHa4gMeERN
         vxyMSRi/b1/dnZGu+GxII46L6r3d1X7ergdVBHHKKn+mm77O7Yu+R579W+l/9hsRIgqv
         FP1Q==
X-Gm-Message-State: APjAAAXjM/svYGGnx+SymwPwbIc7QHK8uoA0xctC4k7KZfRyJUc+Z6hc
        3ZCpEiqA9CAuneB1ABxp/7Xg1A==
X-Google-Smtp-Source: APXvYqznhhzSbgiBCcIkGUt0s0Ys1laYcD53gvS2BPgl5po87wBEublsakUmA++aAMnm2guHYQ37TQ==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr26103486pgk.287.1552230398306;
        Sun, 10 Mar 2019 08:06:38 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id q62sm5608229pfi.183.2019.03.10.08.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 08:06:37 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: palmas: Remove *rdev[PALMAS_NUM_REGS] from struct palmas_pmic
Date:   Sun, 10 Mar 2019 23:06:09 +0800
Message-Id: <20190310150609.5178-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is using devm_regulator_register() so it is not necessary
to save *rdev for clean up. Actually the pmic->rdev[id] is not used now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/palmas-regulator.c | 12 ------------
 include/linux/mfd/palmas.h           |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 7fb9e8dd834e..f13c7c8b1061 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -991,9 +991,6 @@ static int palmas_ldo_registration(struct palmas_pmic *pmic,
 			return PTR_ERR(rdev);
 		}
 
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
-
 		/* Initialise sleep/init values from platform data */
 		if (pdata) {
 			reg_init = pdata->reg_init[id];
@@ -1101,9 +1098,6 @@ static int tps65917_ldo_registration(struct palmas_pmic *pmic,
 			return PTR_ERR(rdev);
 		}
 
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
-
 		/* Initialise sleep/init values from platform data */
 		if (pdata) {
 			reg_init = pdata->reg_init[id];
@@ -1288,9 +1282,6 @@ static int palmas_smps_registration(struct palmas_pmic *pmic,
 				pdev_name);
 			return PTR_ERR(rdev);
 		}
-
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
 	}
 
 	return 0;
@@ -1395,9 +1386,6 @@ static int tps65917_smps_registration(struct palmas_pmic *pmic,
 				pdev_name);
 			return PTR_ERR(rdev);
 		}
-
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
 	}
 
 	return 0;
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 75e5c8ff85fc..c34d5f0d34d7 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -553,7 +553,6 @@ struct palmas_pmic {
 	struct palmas *palmas;
 	struct device *dev;
 	struct regulator_desc desc[PALMAS_NUM_REGS];
-	struct regulator_dev *rdev[PALMAS_NUM_REGS];
 	struct mutex mutex;
 
 	int smps123;
-- 
2.17.1

