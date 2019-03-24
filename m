Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EB3C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361772148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Wx+7HXq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfCXGAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 02:00:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41376 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfCXGAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 02:00:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so99401pgs.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 23:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RpsghNEoKDUGJY80S6ZRTuXGZP6cJNaic35UNAimvLw=;
        b=Wx+7HXq0S544Q4e3auf8P1z2UmSujQ6Lg85Z8/3UtMEtcVuMCtL3gSQxlLK0gi9cBU
         1LUDkTymbGA7MIlaJhrAbqTv6v1UTdMyOWvbfu3rshT6Cp3RDipF+dderq90wwDsVGUn
         iE5OYHeJ8uJUdR8Sv1HGgTp2QVjJSVBWFLIMzcM/HWXOkuKVgE9ztbCeB2g3kTxMmV9V
         m3nruDY9yAR7ZIscW+vVJEB4J+qqZ3p0JBzxade9PhfS55H42BTvOTD8DQf/KplJBCnw
         gvVOOwOKh05MibTTRTYtw1ovGxozVTtDAU1ZCkuFmSSy2Avz0gRF60dd5RfXsXIBFAuI
         T5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RpsghNEoKDUGJY80S6ZRTuXGZP6cJNaic35UNAimvLw=;
        b=qVfduSm610Hmk61KvqYDil9P4CH8i6IO/IWT8xi+u2tpJD7N1taePyiAJi+oelzJgT
         rbZhhXGX//dptJvrFl1eGfBjqGlwvFtGc2P5+a2/SpL3VagoNezTdawfOwfF5W4LCjhQ
         4KO1jyFliH3CkqmJ0uu7pIHEb8R+oIwmGtOnAfQCZacudl2ieyjkPmInQQypCegLSYEZ
         v90drn9u5jAICo94wxLHle1MzBoYkOPqZIqk1dd2pGsGoyj/CLUxW9jAEXSadhy+i1k9
         hz4qUMCGmC4PoKKSuvTbReonRQkOYyrA7U8+UTQDeDlcb71K6KdGbTM3Tsg7QpqBJ8gn
         J8sw==
X-Gm-Message-State: APjAAAVZMVQQvVnULZrPawxZ8MrIbvwzYDq+edA/ajrxnM5NWHu0BIvn
        U6TAkJQsxqK6Xot9J2Ig/AONJQ==
X-Google-Smtp-Source: APXvYqytjyzjLZMY/JpIHV9ZzGpQmzCYns9t5ZXynGP70UN0EmgKxhKWeywZTW+EYfLAGc1153Gbow==
X-Received: by 2002:a63:cd10:: with SMTP id i16mr16425541pgg.90.1553407220921;
        Sat, 23 Mar 2019 23:00:20 -0700 (PDT)
Received: from localhost.localdomain (118-171-129-125.dynamic-ip.hinet.net. [118.171.129.125])
        by smtp.gmail.com with ESMTPSA id f6sm17426197pfd.115.2019.03.23.23.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 23:00:20 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Russ Dill <Russ.Dill@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: tps65217: Constify regulator_ops
Date:   Sun, 24 Mar 2019 14:00:05 +0800
Message-Id: <20190324060005.22895-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190324060005.22895-1-axel.lin@ingics.com>
References: <20190324060005.22895-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps65217-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index ead31741dc13..67ba78da77ec 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -149,7 +149,7 @@ static int tps65217_pmic_set_suspend_disable(struct regulator_dev *dev)
 }
 
 /* Operations permitted on DCDCx, LDO2, LDO3 and LDO4 */
-static struct regulator_ops tps65217_pmic_ops = {
+static const struct regulator_ops tps65217_pmic_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65217_pmic_enable,
 	.disable		= tps65217_pmic_disable,
@@ -162,7 +162,7 @@ static struct regulator_ops tps65217_pmic_ops = {
 };
 
 /* Operations permitted on LDO1 */
-static struct regulator_ops tps65217_pmic_ldo1_ops = {
+static const struct regulator_ops tps65217_pmic_ldo1_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65217_pmic_enable,
 	.disable		= tps65217_pmic_disable,
-- 
2.17.1

