Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6900C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B0B2133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h368Vx+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfFGI3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:29:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41373 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfFGI3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:29:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so1221974wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=slZHnEyI/3MoxuWJDHsmJjpXD82N/IlcEekyL2S9VGE=;
        b=h368Vx+bZLWr0EL6gvHppBTRSD6ciSTtbA08qgE1t4taX1ccezuX+R++aXgYdUyb8y
         xqoTAMMnzsmDvOSRVcoiqE2DFyL7TAalaemw43t6ANajvZ6wL8XrTBPrSPCTaI37JOuC
         C+5L9vX/X5BqHwAWrn/zEo5FE4WFb8KPgNsOOUzOOniHj63Dv+LyXOscl8dFK8OY1u1o
         E/HW76TPKlwVq8tS/VJKvSGDMVvLLxyzlkHBehpsvVoeNsfJs8g8ByEL/eJhJVNJIndQ
         NPfMFhvNB2TjUGWQBnh8Zme9lqz8vUpZd67SuV+J3hkfi1YClwo9647sqAdkVGU2KAHa
         w/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=slZHnEyI/3MoxuWJDHsmJjpXD82N/IlcEekyL2S9VGE=;
        b=pgbrL2h4GXGJjoYPtYaa3r59i8AaxKDT+J9YFTUDrJBSp1bLCdkInRqzwnGH4JT1ru
         5Liu2cbYYjEa7MoRM5WQ+85q0AYA6qYtcvbqeBLD0kHWCYjUT29mPKVaTiKWkXTzi4ri
         TXpnvWk8nNdDwOgS0nFWnecJkHs9DZkqNj4X+0RbMFrRKvsEVQCN4jPXlayFrEFcL2EX
         m1+yKnlGXNQrS1G4KOUAVEH/j/jwyL1FRDXp2owVA1KW75WjsmUBsKC284pYNgKIBV7w
         8PanYvA/B847rSQii7J5w86sMaZXAUOYv05074wk+sZmyQ1NzD+RIQiceUzESB8GR+wH
         tyxw==
X-Gm-Message-State: APjAAAWgZlXiir97MikuJeWtHr6ja9ULhyMocy1bAnIroYyBea0s44Tt
        Kh+ZRw4W9vd8RyVGaSYHoWphpA==
X-Google-Smtp-Source: APXvYqxA6VZBIpKaCLm8h8+cRTckg6NGyIemaL7IeDtLMQhELQn4vSQSFHuHPVMnZWXnr8oeR8248g==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr370680wrv.89.1559896145359;
        Fri, 07 Jun 2019 01:29:05 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id a3sm1092946wmb.35.2019.06.07.01.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 01:29:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 3/8] pinctrl: msm: Add ability for drivers to supply a reserved GPIO list
Date:   Fri,  7 Jun 2019 09:28:56 +0100
Message-Id: <20190607082901.6491-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607082901.6491-1-lee.jones@linaro.org>
References: <20190607082901.6491-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting MSM based platforms with Device Tree or some ACPI
implementations, it is possible to provide a list of reserved pins
via the 'gpio-reserved-ranges' and 'gpios' properties respectively.
However some ACPI tables are not populated with this information,
thus it has to come from a knowledgable device driver instead.

Here we provide the MSM common driver with additional support to
parse this informtion and correctly populate the widely used
'valid_mask'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 18 ++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index ee8119879c4c..3ac740b36508 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -607,8 +607,23 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *chip)
 	int ret;
 	unsigned int len, i;
 	unsigned int max_gpios = pctrl->soc->ngpios;
+	const int *reserved = pctrl->soc->reserved_gpios;
 	u16 *tmp;
 
+	/* Driver provided reserved list overrides DT and ACPI */
+	if (reserved) {
+		bitmap_fill(chip->valid_mask, max_gpios);
+		for (i = 0; reserved[i] >= 0; i++) {
+			if (i >= max_gpios || reserved[i] >= max_gpios) {
+				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
+				return -EINVAL;
+			}
+			clear_bit(reserved[i], chip->valid_mask);
+		}
+
+		return 0;
+	}
+
 	/* The number of GPIOs in the ACPI tables */
 	len = ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL,
 						   0);
@@ -964,6 +979,9 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
 
 static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
 {
+	if (pctrl->soc->reserved_gpios)
+		return true;
+
 	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
 }
 
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index c12048e54a6f..23b93ae92269 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -121,6 +121,7 @@ struct msm_pinctrl_soc_data {
 	bool pull_no_keeper;
 	const char *const *tiles;
 	unsigned int ntiles;
+	const int *reserved_gpios;
 };
 
 extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
-- 
2.17.1

