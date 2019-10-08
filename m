Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D02C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4209020867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="JNZPUt6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfJHBGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:06:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39321 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJHBGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:06:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so9270174pgj.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 18:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKgtCIbZPMsJhjG/EViFF25V+bEhzuRO63sJkz7mdtY=;
        b=JNZPUt6joXunnB+3n1aWRxxtV/fwxR0rciCRbApd9CHBW67bq0nRBC8Iv6W3FQBCiT
         0vTJuzVgjoaUR7x8b0CvG5tfr223cs0PTiP0jfH4X7BhUDY2baSK02LgKVU76O7S7AKh
         WEsLmdNM4dpu8qzpL7SVX0NHm3UJSx8NzZh+sL1wmC2ZJHoApoTskW9PIcqXC/A3yoln
         WckgcWnyHewuOMmVdAybP1N4jfZ7zOGUev4MXnA7eJyvH9KCuVDoSFtMUoHl7MAXnk2x
         4/SzWbkukKWuTU1BTxviaUgoWgg2p4nCU+BU4uAtVjlpP2hAt5reSFpwOMy9CC8fSJ4F
         T6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKgtCIbZPMsJhjG/EViFF25V+bEhzuRO63sJkz7mdtY=;
        b=GCLmhW8wmVTXKscW/ZHWFaVRHUEcCmp5jYlLZ6NvAfMTU6q9UH2FrACiF7ag2bVOND
         5RpYwcwS5Tv9EhiZS9t1JzVVgiHGZKPj+v9kXT2MqGJl0EqdCtMbDScVRDGCnPfECwTn
         z4Hvl9dRDDjO5Xkmy6JTL46f/okyvvCgrHVcNE3EzZPBdqDeglUvppMS1sHJ9uXAtTMf
         8jjWv52vkhB5JjKxWPL7389c1DXyY3O2ZQblQrsj9RxeTwPZ+R/btEuMcBsy+wHdY1vh
         AiVVvLgEaFqLx4pU884z+YXWhfqs/dpbH2a4rQpnxIfZ/bOojY6Kj5vlnkv7yPb2wu/a
         ZDEg==
X-Gm-Message-State: APjAAAW1NEgJ0UYeRYGNunvOuzwpm9CNabB2yagIDPVGWQiZ3WsZ2xnl
        2idwBXcqxVNTWSaZCPf+NC+Cdw==
X-Google-Smtp-Source: APXvYqxmONRNo62xhvLsSUS7WJI+/3seSmcNxvNtEi+vuTQ+v1fGpuzObfEjegzzVATTZV9XoKXCrg==
X-Received: by 2002:a63:e549:: with SMTP id z9mr32746365pgj.67.1570496797659;
        Mon, 07 Oct 2019 18:06:37 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 18sm15563898pfp.100.2019.10.07.18.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 18:06:36 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Tony Xie <tony.xie@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: rk808: Constify rk817 regulator_ops
Date:   Tue,  8 Oct 2019 09:06:26 +0800
Message-Id: <20191008010628.8513-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rk808-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 61bd5ef0806c..eda056fce65f 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -686,7 +686,7 @@ static const struct regulator_linear_range rk805_buck_1_2_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(2300000, 63, 63, 0),
 };
 
-static struct regulator_ops rk809_buck5_ops_range = {
+static const struct regulator_ops rk809_buck5_ops_range = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -700,7 +700,7 @@ static struct regulator_ops rk809_buck5_ops_range = {
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
 
-static struct regulator_ops rk817_reg_ops = {
+static const struct regulator_ops rk817_reg_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -713,7 +713,7 @@ static struct regulator_ops rk817_reg_ops = {
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
 
-static struct regulator_ops rk817_boost_ops = {
+static const struct regulator_ops rk817_boost_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -725,7 +725,7 @@ static struct regulator_ops rk817_boost_ops = {
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
 
-static struct regulator_ops rk817_buck_ops_range = {
+static const struct regulator_ops rk817_buck_ops_range = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -743,7 +743,7 @@ static struct regulator_ops rk817_buck_ops_range = {
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
 
-static struct regulator_ops rk817_switch_ops = {
+static const struct regulator_ops rk817_switch_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= rk8xx_is_enabled_wmsk_regmap,
-- 
2.20.1

