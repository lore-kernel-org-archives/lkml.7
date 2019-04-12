Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B3EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3222206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HEHJboxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfDLJYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:24:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40776 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfDLJXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:23:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so10192479wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrVpee+f1QzUj1w55U43u2u06qeWlLDZnjDCHCt7aSQ=;
        b=HEHJboxbmey2sK5gsDZ6Bv1s8NO6jixV7xN7iG0VB/XiUbfIsSZ58svig80dxvcOis
         ay5iJHGFSetEs7SBOkVGPW2Ntzx+KVU4Wdg4t35TeYTixLWBQvGfy+oIEaEiWF5edL1U
         gx8ACBpZ7eNR5bXkzqnCZA1gI/E/TQqyPKx/uiw5XqpRvmyo+NdSnROPH1LXlwCvh6Th
         9Fiq0vsVjVXjh7L9NG+kQH/PsWkOXsPIE12R+GdW9vFXHJmxd7w3Z2BR0m/PYDxcj8zi
         GqG9O1IxbggoALYd7RQyaBuJLr5w6TSvlJYta1OTQjzlURJrgIxIR4vanLUfo7CbeoUo
         z0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrVpee+f1QzUj1w55U43u2u06qeWlLDZnjDCHCt7aSQ=;
        b=K7KRpigd5Gzlri4OM3f4vXOkoTs+3t9KpMiwpzHTaui8LvVQkps0cVsFiOmovuTcdP
         fx8ryy6/MdK5rc2vN/sswNFNnNqalo+7pwSDpZcCkq/9oMXw1nyH7AiQ9tvkNmJshr6X
         js3R03jURYirDKygVr5OBo/73g+/0K9iw1V2U+VkwDGmlZXEJi30JQxutk2jDc/tWnSo
         R9jIMiR4NGYA+A47JqyNRmOPFKu0fYWc4J+ptHzDRiyz6JAMTlF4qJzBtJIgiZNIhbUa
         USYmE81i4yaP7lgs+coRlFvnjg5IL3tItLLLqJaMmJzi+cDzAJ+VKP3s9yQtmAnr1SVb
         Vreg==
X-Gm-Message-State: APjAAAUfUZUeX8EnsIIJQcwhQMsF2jozb6dgwX6k+VF3RqXwYXNOWETE
        lMihNZFwFFs2+XdYUkpAWaiKYA==
X-Google-Smtp-Source: APXvYqzT+1A4+cJ5R6rz0CC94Ba+2nsxQWdqlVcqQeiJQiGhA9HZc4R+uEyff8wJ2WNp95n5AAqVxw==
X-Received: by 2002:a1c:e1c5:: with SMTP id y188mr10395823wmg.39.1555061021412;
        Fri, 12 Apr 2019 02:23:41 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s21sm6630224wmh.22.2019.04.12.02.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 02:23:40 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pwm: meson: Add clock source configuration for Meson G12A
Date:   Fri, 12 Apr 2019 11:23:36 +0200
Message-Id: <20190412092337.6941-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412092337.6941-1-narmstrong@baylibre.com>
References: <20190412092337.6941-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PWM controller in the Meson G12A SoC, the EE domain and AO domain
have different clock sources. This patch tries to describe them in the
DT compatible data.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2b03938039b6..46287cc8a0eb 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -434,6 +434,15 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
 };
 
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
@@ -455,6 +464,14 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-axg-ao-pwm",
 		.data = &pwm_axg_ao_data
 	},
+	{
+		.compatible = "amlogic,meson-g12a-ee-pwm",
+		.data = &pwm_g12a_ee_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm",
+		.data = &pwm_axg_ao_data
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
-- 
2.21.0

