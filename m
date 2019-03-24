Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4351C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8382171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 02:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="wP3DngJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfCXCF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 22:05:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41059 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfCXCF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 22:05:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id k11so4029883pgb.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 19:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=H/m3krOTNzgOBj3cvcWuQ8ZBPL8FrfzxO1olgG82hzg=;
        b=wP3DngJPfNuW+DxIJQub59Dv/RfdPXgml1pm+gZyq9zZNFgopPcltP9OYA2w8kUO1m
         dWDQlwyuOlXYiJ+CdkQsC+mCElswSYNlP927w80MiNwiLjf4a3AInWc1BaJwC0jgMSdS
         bilB4umWUxWR2Ev0ybkOb+3ChDC6Npg8jZrnEmdBwdH0DwSpQDK225L5Lj57AX5d+WXt
         pRXHXYIMgc2ywTQ0ZH0B6kizQ2TZYOT5Bi4Ti+DKiVD790IPdJHcDEucbIfB69omkNH7
         A+LDnup8g9+i+7y3jbHdK7Z40hjkgHlZSB9sVW0ujRqV3Z/anE+UCZ7uSzJjKmQlztAV
         TohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H/m3krOTNzgOBj3cvcWuQ8ZBPL8FrfzxO1olgG82hzg=;
        b=bIQ5Cngnc8Ci7YLLozLxHl0Ool+EPDNjunbcL/hTmCjatGmWmCP8z+VStygwrvzfp8
         Ak5zX9wmFtLS+4DktFQSsB9ZGMfNzJeXLL6HwGeA42FHlmD3gNGAWPNW6e+plhY8uIGY
         uonZbVoIOkR9qC67qG0msU2n/AgMkTgKRqKMPtdOSJY7moCAmb7r09Y2h7ieWOUl/CfV
         k+33eX9qkofyx+sHI49qIba1XEf+xwVbb9SYGAxz1+ev94v2lvwXUPkFCYIzMSwky9Ql
         uK4tEp+FKTY4mO2t8k3f8wlqC5wGdZ5RdV2isDUlJY0bmd74AN8u+67bVoRPTxk7ojR/
         HmHA==
X-Gm-Message-State: APjAAAWSKenWsaGl0Rq2Nk5ybc70bazqELA6cUM53w/aynjYQRejRhTr
        /tIINsp7mEHMQfyl3CR9xVxQ+0Oi2PI=
X-Google-Smtp-Source: APXvYqytoAlLmp77b689caossjiWNq5/pmmDnH1uKL5srDwIkD1ScxwADN3fe2jxU+NlqYyeY/qTeQ==
X-Received: by 2002:a17:902:aa87:: with SMTP id d7mr17284124plr.146.1553393157202;
        Sat, 23 Mar 2019 19:05:57 -0700 (PDT)
Received: from localhost.localdomain (118-171-129-125.dynamic-ip.hinet.net. [118.171.129.125])
        by smtp.gmail.com with ESMTPSA id n15sm23006508pgc.92.2019.03.23.19.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 19:05:55 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>,
        Keerthy <j-keerthy@ti.com>, Felipe Balbi <balbi@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: tps65218: Constify regulator_ops
Date:   Sun, 24 Mar 2019 10:05:42 +0800
Message-Id: <20190324020542.24788-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps65218-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 95708d34876b..7aed3fbffecc 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -162,7 +162,7 @@ static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
 }
 
 /* Operations permitted on DCDC1, DCDC2 */
-static struct regulator_ops tps65218_dcdc12_ops = {
+static const struct regulator_ops tps65218_dcdc12_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -176,7 +176,7 @@ static struct regulator_ops tps65218_dcdc12_ops = {
 };
 
 /* Operations permitted on DCDC3, DCDC4 and LDO1 */
-static struct regulator_ops tps65218_ldo1_dcdc34_ops = {
+static const struct regulator_ops tps65218_ldo1_dcdc34_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -245,7 +245,7 @@ static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
 	return ls3_currents[index];
 }
 
-static struct regulator_ops tps65218_ls23_ops = {
+static const struct regulator_ops tps65218_ls23_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -255,7 +255,7 @@ static struct regulator_ops tps65218_ls23_ops = {
 };
 
 /* Operations permitted on DCDC5, DCDC6 */
-static struct regulator_ops tps65218_dcdc56_pmic_ops = {
+static const struct regulator_ops tps65218_dcdc56_pmic_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
-- 
2.17.1

