Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 02:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0FA206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 02:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="lwJSpZq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgAACYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 21:24:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36007 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgAACYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 21:24:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so20166201pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 18:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SckOlVLAXPRQjXd3namPH2PjXgWirqUNFX3r/4kBd48=;
        b=lwJSpZq1wjX2c4dBxGnzPXr4C09fZOZIjFbvmLvdFX/WWYNDkUA/9pXypgmrbyqgH2
         LVeMN73R7nw16zwCsWkEgsfeqZWJxcuVpxo0c1xv8MprSZyyrxI8Tofx1kBMKeIuuZhe
         G0KMYMe9j8uAevG4QH+fGC+d5Kv7lggaSxPgQLMEuX3gd1o/jz0V6Q+f0itaOXw3ku2V
         HrsP/959Z/wGd3zk6g7ttzWJhpW0U/+PbzFrUFEwMhX9SkYPhrs4WsPZtn+QFyOrR5fA
         f2pp/zH5md8V6sTEO3CgpLypgo0cr1BPMgEvQ8ZRCJs2p+Q/38MrvOXxooN4IvKgafe7
         ijgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SckOlVLAXPRQjXd3namPH2PjXgWirqUNFX3r/4kBd48=;
        b=MoQguQWlG6EewuAVkJWnPpVY3N/01/mVCHlgua9GkcrHomPzJCzXsLyFBN4U5bpi/a
         LmR3RotxKtwiWSEeAjg/Jd9Hg9dF5q8LBa0yUx1nk/ulmtiTruq0poEwbDWlQN1LslEs
         vm4ucOOJlqElws9KrkqEXj4vd2y6KOtwZwcwOfFl0Dhz6XMcDOwTHmKgKK68Tc8Agv1o
         E1vYqGAIefAuDMhU0b954MV04t2Kc6FV4CTptNzRomxMbjz+91HdJnqqWLBAsZ++vdeg
         JmHafYDjgtVboS7GnTyx4Nl8IrNvFiMvd771HNuyh3Nmn42sJoT1E0WlbYGob8UGfmiW
         Usyg==
X-Gm-Message-State: APjAAAX93JEOCtM0M5E0XWIUbp/kUTJI2ZrOsypQVV+gj2XVlrgMvHsV
        wtJ2kKs1Ln4ZqcjhuE4spKZqIg==
X-Google-Smtp-Source: APXvYqzOtBnQfZXz6EJYVRa7abSg/UQNqMgiYsVFPa5VX1YCt5TEqRhwSGohdnh3d+bZ1yAf9+q3gA==
X-Received: by 2002:a63:642:: with SMTP id 63mr79537185pgg.73.1577845460151;
        Tue, 31 Dec 2019 18:24:20 -0800 (PST)
Received: from localhost.localdomain (36-239-219-170.dynamic-ip.hinet.net. [36.239.219.170])
        by smtp.gmail.com with ESMTPSA id x132sm56481373pfc.148.2019.12.31.18.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 18:24:19 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bd70528: Remove .set_ramp_delay for bd70528_ldo_ops
Date:   Wed,  1 Jan 2020 10:24:06 +0800
Message-Id: <20200101022406.15176-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .set_ramp_delay should be for bd70528_buck_ops only.
Setting .set_ramp_delay for for bd70528_ldo_ops causes problem because
BD70528_MASK_BUCK_RAMP (0x10) overlaps with BD70528_MASK_LDO_VOLT (0x1f).
So setting ramp_delay for LDOs may change the voltage output, fix it.

Fixes: 99ea37bd1e7d ("regulator: bd70528: Support ROHM BD70528 regulator block")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd70528-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index ec764022621f..5bf8a2dc5fe7 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -101,7 +101,6 @@ static const struct regulator_ops bd70528_ldo_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-	.set_ramp_delay = bd70528_set_ramp_delay,
 };
 
 static const struct regulator_ops bd70528_led_ops = {
-- 
2.20.1

