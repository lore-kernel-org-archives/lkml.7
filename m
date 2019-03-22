Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E02C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64EC2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="eykvmGlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfCVGio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:38:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40663 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfCVGin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:38:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so805946pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 23:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TZfZE7f6urMk4KGdthPM1mif2F60iLLFa3fdDmUAiOY=;
        b=eykvmGlcMc4QbI/dlyMIzYkVByij6ngIpVNawzklq4KbwpdTkJ/7Xp55NF+H8wGeJY
         j5LdLVx3M1+0SOSu0TiKAfH3htHFG5vCqvbJbjW6LO40SfXhReemSGcVJGTTuON7D/FA
         ZidW/Qjx4DO+mRCOakD0KwLAbugV5ToQyuAW7nPG4gfzvtaENV/Zct40FsLOFtTL5oPf
         STGoZOalY/zEMydYFSJUEzS8L3Azg7+VEEsyUSbNXUfqo5UrkUN2kpHLpWEUuyrlvQDp
         gq+OXdk/NqMoDpp8CyNKTzNC7Y1AwJsdfbIRuq7PQDyZRyvtM77R1THKNt7Dha6QZAKA
         2S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TZfZE7f6urMk4KGdthPM1mif2F60iLLFa3fdDmUAiOY=;
        b=S9UPmiaDIHlkNOvf+kEohmSEuM5jbWfp1OkOPxejNDM4b8jTeBN+98264LS7gXNbmC
         qk+Rg0jsuy037VtgezikDBk9OpmQ5RCcEQrJ4leOC4XSdbdPM43EoMejOQVpkD060whg
         +QtsFeM6e7s/T/VjRLGyyjnRHC0hvbUSzAppS337+ooWVbab6ikNtMoiFxNheUiP2oF8
         BHgS7muV61jZsidQkLcEHuLe7z6qaE179PuuaGCSXuoR3q5MvAxdn2c6VVBbkF8GK0MG
         eOWktnw+GI/IOE9Bd7dkVEgNnEVWGpr4Z0dOHbwrCGcfTRAEDmhsQbrdPm6asIpL/Wa0
         QtRg==
X-Gm-Message-State: APjAAAXA3akaPChBuMYl/SF05jceRzE5T65KiWCAidO99HPy19oit9t2
        jy0TJ46fAcrvU/GiqhZnC5pAlQ==
X-Google-Smtp-Source: APXvYqyw3O9VRCK1b/QWQOkNUx9hMGDrw5hhFYbL9T9km6Y+HNdlE8kpbNDwEhQ2vdAVhFftQob/4w==
X-Received: by 2002:a17:902:2702:: with SMTP id c2mr7758610plb.239.1553236722320;
        Thu, 21 Mar 2019 23:38:42 -0700 (PDT)
Received: from localhost.localdomain (118-171-129-125.dynamic-ip.hinet.net. [118.171.129.125])
        by smtp.gmail.com with ESMTPSA id v4sm7953766pgh.53.2019.03.21.23.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 23:38:41 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: act8865: Constify regulator_ops
Date:   Fri, 22 Mar 2019 14:38:20 +0800
Message-Id: <20190322063820.31205-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322063820.31205-1-axel.lin@ingics.com>
References: <20190322063820.31205-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The act8865_ops and act8865_ldo_ops never need to be modified,
make them const so compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/act8865-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index af8f201e67d7..19d9ee2dac1f 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -226,7 +226,7 @@ static const struct regulator_linear_range act8600_sudcdc_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(41400000, 248, 255, 0),
 };
 
-static struct regulator_ops act8865_ops = {
+static const struct regulator_ops act8865_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -236,7 +236,7 @@ static struct regulator_ops act8865_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops act8865_ldo_ops = {
+static const struct regulator_ops act8865_ldo_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
-- 
2.17.1

