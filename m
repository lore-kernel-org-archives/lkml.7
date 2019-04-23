Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D562FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A711A21773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u3zZtz5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfDWNg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:36:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36940 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfDWNg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:36:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so105597wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyIwurtaQrYXM2ZMvHhJOtIlHoFi3EeiRaMRxuyOY5A=;
        b=u3zZtz5sFySkpfmLlMM2+qPIPYjsS1x2MbKbjd/6XHeBt7UGtzwLcVeGRCcuXWUpNg
         Z6qEWd1UOYpVkB+jVJp2lALjEEDH2Aivt2mQmQpP1USZoqi2TEeVTmMZqD22B3f1DbHR
         YlwkIoPBDC8w/8dvfCyC8jc8BN0CUkJhPjf310EBWvsG9yJgGRj2XmSf5cIl5XZGI00e
         kLUoajMrbt4mZmUFJxYeYmYNkrq3qyPsOg/3UaxDIMePVClxkeLN+ZMoJ826Wpiy6EZb
         c1hdRbpII1lS9wu9vYnWx7r7RCa2s74WEGScGrf7TS4eocFg5VdrXN/QZTmRvt3lfJCc
         mjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyIwurtaQrYXM2ZMvHhJOtIlHoFi3EeiRaMRxuyOY5A=;
        b=pDDYtKGMMz7eWoSqnTesczTeBslUSIlgGp88SmzS7Pj/R2v2i48KPiKTthAAJYwFFL
         AAwe0TF8CenYEFQEciclr87e9JoLiC4csSk2Zbysb6q6SEmqSiiObVL0rsiZLmzyZZoN
         5p47xxkSSVasLABPhwWzN2zCLy+0kZ1gOS2dmSavZuFQ2zvREVpK36C7e8h6OSmYJG9v
         nBApeM0zEIhHjhll/+URq/xEe37BO946WF3aVG1We+GtjlmI2em8NmbTpkoD2Dmh1/Zn
         0K8MvXY9VNv54GBx58vCx2I6sb72CmBWD8HcbXwbtnInWCQKT2aQc2Xj31JpALljbFyw
         SDwQ==
X-Gm-Message-State: APjAAAV9PpzeGM++oSYy/p3d9OT/naw85jDO85BkIcRHAt6oE8UaoQvK
        ucvKv54+Y5hi2SZ58TN0PTu0pQ==
X-Google-Smtp-Source: APXvYqzxnHz5TKORqYjOKr1Gnz2ldQm6TU7EG8p0lZZBtL8k0/i+klnj7GmE/20OoQmset/OJJy/dA==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr2337950wmi.2.1556026614420;
        Tue, 23 Apr 2019 06:36:54 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z20sm13509543wmf.34.2019.04.23.06.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:36:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] pwm: meson: Add clock source configuration for Meson G12A
Date:   Tue, 23 Apr 2019 15:36:45 +0200
Message-Id: <20190423133646.5705-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423133646.5705-1-narmstrong@baylibre.com>
References: <20190423133646.5705-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the PWM controller in the Meson G12A SoC, the EE domain and AO domain
have different clock sources. This patch tries to describe them in the
DT compatible data. The two AO PWM controller has different clock source,
but the first AO controller (A & B) can reuse the AXG parents name.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2b03938039b6..bdf1b367e391 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -434,6 +434,24 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
 };
 
+static const char * const pwm_g12a_ao_cd_parent_names[] = {
+	"aoclk81", "xtal",
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
+	.parent_names = pwm_g12a_ao_cd_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_g12a_ao_cd_parent_names),
+};
+
+static const char * const pwm_g12a_ee_parent_names[] = {
+	"xtal", "hdmi_pll", "fclk_div4", "fclk_div3"
+};
+
+static const struct meson_pwm_data pwm_g12a_ee_data = {
+	.parent_names = pwm_g12a_ee_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
+};
+
 static const struct of_device_id meson_pwm_matches[] = {
 	{
 		.compatible = "amlogic,meson8b-pwm",
@@ -455,6 +473,18 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-axg-ao-pwm",
 		.data = &pwm_axg_ao_data
 	},
+	{
+		.compatible = "amlogic,meson-g12a-ee-pwm",
+		.data = &pwm_g12a_ee_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
+		.data = &pwm_axg_ao_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
+		.data = &pwm_g12a_ao_cd_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
-- 
2.21.0

