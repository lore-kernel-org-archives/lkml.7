Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD6DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA3220652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="z2yj3CMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfDPKRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:17:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41198 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDPKRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:17:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so10099224plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l6xJgGOtvOKL39M/RqXdnNdXuuTHbONPpw2QRUpPRj8=;
        b=z2yj3CMwDeEgsRNRSLlu+ZRGVjVIekzoDywO7hByNZTx31k5AYnf1qobh/bKOlvdqN
         9Xi5sAt9oBZ5cSHzoFpcOB7irRFG+p0MVGLPUnpsFnQcp1ZvvAJ2ZixrH8CY2RgpNfOF
         fCaXVh7cbb8qxPXtG/vGDF0wXEOrKVVTN1PrM0XzOIFUv82mcUc+PH96arMdmlkYDiM+
         i/y08756Ic79XENz5s/VLtI1cqR3lJ/3qwt+s93dD3SVPVIfS8DS5XAM4YuMqlOmPR/p
         Q/mlfU17T5nuu0FWl6VaI86rbfYXyTX9QrLndOrNx4tqZDUBs2VmJX9+P6XOVWkz0wez
         x5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l6xJgGOtvOKL39M/RqXdnNdXuuTHbONPpw2QRUpPRj8=;
        b=prJiuxwoVVfZpTal2QZqQZmQzptUsbtkUlxMpKblztdu7Fd1PfrWez7WXZfUfOv25C
         HrBm0elevNZMWF7PlVHcoNo04hnSRPCoAhv9/N+QWFZ/zsSZd7weN2dw/V+Bwzefsipk
         NlIRop8G+XdtHPzo85Vv9LBh3AjpE43quNBFvlUAfir5F88JifpQ0dv8/x4jExofR+L2
         zAGY6Cm7MQiOw4dDuGx3Ld0gDA5IzA+Z7I4+Nus7agJFpehcG4UbxjExynA2NRQLtiM4
         WbKmZdoqxcZSIvuAm/+dDtgp85LSpS8tijYsOsQRa/152marPqLHXifl9/KyTvi729U4
         yjMg==
X-Gm-Message-State: APjAAAVeghoCKmPdqODRi5EePgVpoerb5lJPOwpdwBeDUX5TpdYWgXcQ
        3s9+V5fg18ck3qyNEHsz17J0zn596S4=
X-Google-Smtp-Source: APXvYqzVfnadb8TzljE6+ACmBKVuPR8Knt0BKtR90PgkMQ9xYw3vRF85heDEcS35m9TY3HonlP/gRg==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr64171923plb.237.1555409861137;
        Tue, 16 Apr 2019 03:17:41 -0700 (PDT)
Received: from localhost.localdomain (118-171-129-145.dynamic-ip.hinet.net. [118.171.129.145])
        by smtp.gmail.com with ESMTPSA id h187sm105434588pfc.52.2019.04.16.03.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 03:17:40 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: tps80031: Constify regulator_ops and tps80031_dcdc_voltages array
Date:   Tue, 16 Apr 2019 18:17:28 +0800
Message-Id: <20190416101729.26330-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416101729.26330-1-axel.lin@ingics.com>
References: <20190416101729.26330-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables and tps80031_dcdc_voltages array never need
to be modified, make them const so compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps80031-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index d97cd55b6850..8e65a13e2ef5 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -154,7 +154,7 @@ static int tps80031_reg_disable(struct regulator_dev *rdev)
 }
 
 /* DCDC voltages for the selector of 58 to 63 */
-static int tps80031_dcdc_voltages[4][5] = {
+static const int tps80031_dcdc_voltages[4][5] = {
 	{ 1350, 1500, 1800, 1900, 2100},
 	{ 1350, 1500, 1800, 1900, 2100},
 	{ 2084, 2315, 2778, 2932, 3241},
@@ -377,7 +377,7 @@ static int tps80031_vbus_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static struct regulator_ops tps80031_dcdc_ops = {
+static const struct regulator_ops tps80031_dcdc_ops = {
 	.list_voltage		= tps80031_dcdc_list_voltage,
 	.set_voltage_sel	= tps80031_dcdc_set_voltage_sel,
 	.get_voltage_sel	= tps80031_dcdc_get_voltage_sel,
@@ -386,7 +386,7 @@ static struct regulator_ops tps80031_dcdc_ops = {
 	.is_enabled	= tps80031_reg_is_enabled,
 };
 
-static struct regulator_ops tps80031_ldo_ops = {
+static const struct regulator_ops tps80031_ldo_ops = {
 	.list_voltage		= tps80031_ldo_list_voltage,
 	.map_voltage		= tps80031_ldo_map_voltage,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
@@ -396,18 +396,18 @@ static struct regulator_ops tps80031_ldo_ops = {
 	.is_enabled		= tps80031_reg_is_enabled,
 };
 
-static struct regulator_ops tps80031_vbus_sw_ops = {
+static const struct regulator_ops tps80031_vbus_sw_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= tps80031_vbus_enable,
 	.disable	= tps80031_vbus_disable,
 	.is_enabled	= tps80031_vbus_is_enabled,
 };
 
-static struct regulator_ops tps80031_vbus_hw_ops = {
+static const struct regulator_ops tps80031_vbus_hw_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 };
 
-static struct regulator_ops tps80031_ext_reg_ops = {
+static const struct regulator_ops tps80031_ext_reg_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= tps80031_reg_enable,
 	.disable	= tps80031_reg_disable,
-- 
2.17.1

