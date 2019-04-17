Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE91C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E87A2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="y+p7oy6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbfDQH77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:59:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46780 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQH76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:59:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id q1so11609474pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=K3NXzTVp29K9R1SfEBsZC+ehQxZgYEfMymhcMkWw+KY=;
        b=y+p7oy6xAvUhHf25QiPjgdDf4dXgdRmOnuK1FBNJo6gbPRsDpAP2rmIqEXojSlV2qB
         p4QhLWaDC+H9XjfBDSFoC3hyatN/1i/fYur4w1WN6BMkWG6cexoGPHgDkmpGEjDQCOmE
         b8Od8p7J4cXlWbzVtWE/Nwjjr4nEC1Dlik2RPgOZ3PQV4S8kvApWAz5Azuc6iridJ0ak
         ++ZleG35su7G+EIP9QAY5rnqkmKW5cLY2Phx8J05o3pIhxSVv7hqLJO+mmh4UC38ebsU
         m9KRZw0JnhlmXBtw/e9Dzll7ZBX3Mb1OoSb/kGLdXOyq3n5qwOoRCK/7TrNaHFaF/KCE
         jO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K3NXzTVp29K9R1SfEBsZC+ehQxZgYEfMymhcMkWw+KY=;
        b=jewbwHFrLZ0neXQoJCNq9Be92nenhYJW49hS/o31B8TJY5wiCLIoBLm9kOAQseZHNF
         MrxkrxBGjyQD6Io6DAic7F8QYolAsrgxvpIcAhuwhTvOIm6yXddWjsAkgSTJrKvX/2bv
         vAfc9QSU47U+JZjnn1qPgL+lj1oMqAtgwBXZWQx9n8xy0nAq2e14RXs1S5p8MjLcmXfw
         IEgmfZ2xwOddNBX+fUzRiShNeSTJEo5+m4vGxGF/aaEXX9IMeCg+nUbU6gg/34H9bSW5
         9mh9rtf6c0s2C56X54XJJY6cl2ThRMu0phfHCpO54uEYXndxBuAjtMw7fbz8nYKQQD7Q
         aa4w==
X-Gm-Message-State: APjAAAXpAE0TM2Bn+mkD0wez5Sx/ck527S9PslESD5WrvuSJ/eKQFbhr
        NeG4sJe0tuRdMoSh+P6zc8yanA==
X-Google-Smtp-Source: APXvYqx+K2fr1BJjJrXpnAzpbeX2VgpZCS/E/HWN1xLfQlTYFKwFH8kBzW8Bru9X6b5LexXBl9g2zQ==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr88337648pfn.133.1555487997943;
        Wed, 17 Apr 2019 00:59:57 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id 17sm72499594pgz.52.2019.04.17.00.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 00:59:56 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pascal Paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: stm32-pwr: Staticize local symbols
Date:   Wed, 17 Apr 2019 15:59:42 +0800
Message-Id: <20190417075942.28321-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These symbols are only used by this driver, make them static.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/stm32-pwr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index e434b26d4c8b..222d593d76a2 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -32,7 +32,7 @@ enum {
 	STM32PWR_REG_NUM_REGS
 };
 
-u32 ready_mask_table[STM32PWR_REG_NUM_REGS] = {
+static u32 ready_mask_table[STM32PWR_REG_NUM_REGS] = {
 	[PWR_REG11] = REG_1_1_RDY,
 	[PWR_REG18] = REG_1_8_RDY,
 	[PWR_USB33] = USB_3_3_RDY,
@@ -44,7 +44,7 @@ struct stm32_pwr_reg {
 	u32 ready_mask;
 };
 
-int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
+static int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
 {
 	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
 	u32 val;
@@ -54,7 +54,7 @@ int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
 	return (val & priv->ready_mask);
 }
 
-int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
+static int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
 {
 	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
 	u32 val;
-- 
2.17.1

