Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91462C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616F5208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZDd2Grcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfH3GCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:02:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36633 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfH3GC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:02:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so3900956pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 23:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVR5WK7jw8bBtk+96qcPeVzLLFLq4erxKa+SEg0zTgE=;
        b=ZDd2GrcbYhVH1waqmTlIUW+64lcxxjrJYr5RLlBqyCDbUzFHLa3ziiTmSoyUr2P4Jp
         SUyAEu56MzN3geRGuEAbrAqJbbpFqLQgwOYvAvZX3Y1Oue0U+lBnApEXEoeMmRMPK39f
         L8hDKYfGEd6SPKa4Ulf7yX6koEXwtJktVedMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVR5WK7jw8bBtk+96qcPeVzLLFLq4erxKa+SEg0zTgE=;
        b=levivjDb+Iam61F2JMaf+lEgHLpKS26qUfjhxHEfaIUigK4ZBExyr/0u60XHIecrNJ
         mYMLL4TMrlYXpS6D8UPYHxcoGiP5uErTLT2Y2YT+aj0hyVtwob6jCDwiTHi78b4eI/op
         WexbOfFRyFBvOdv1estT/0JJlJ6fPJ7Zg7cXx1q89lHuXSb/Ielov+GtE/KhhBv2uluc
         TIK2fUxXDsgDRRLmkDQdKmpMTRMrd9I02cRpd37MQwRWCyNbNx970CNpvGFzBblBYVIg
         75hK8CIkVPmuJztC0rWx/cn0+htrkBzYqzrr2LLXrVJfuQE1YeeGLk7hesTsqk9tqO8L
         qRow==
X-Gm-Message-State: APjAAAVfhtH2+rajjGd+c1TZyVJZ3IZl+UEMYgVV7MgVyMz1n9jTTKfc
        iqwRtEEtSBkdVbkBS0eOvxYuog==
X-Google-Smtp-Source: APXvYqwJSUMil0yYhGisN0J5w16EOL8/CV6qq5568mVBJX4s6BMWhVxxdAzWH+XRG6JYrfPhcSV5oQ==
X-Received: by 2002:a63:1e06:: with SMTP id e6mr11408856pge.185.1567144948737;
        Thu, 29 Aug 2019 23:02:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x10sm3449865pjo.4.2019.08.29.23.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 23:02:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH] pinctrl: qcom: sdm845: Fix UFS_RESET pin
Date:   Thu, 29 Aug 2019 23:02:27 -0700
Message-Id: <20190830060227.12792-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS_RESET pin is the magical pin #150 now, not 153 per the
sdm845_groups array declared in this file. Fix the order of pins so that
UFS_RESET is 150 and the SDC pins follow after.

Fixes: 53a5372ce326 ("pinctrl: qcom: sdm845: Expose ufs_reset as gpio")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pinctrl/qcom/pinctrl-sdm845.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 39f498c09906..ce495970459d 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -262,10 +262,10 @@ static const struct pinctrl_pin_desc sdm845_pins[] = {
 	PINCTRL_PIN(147, "GPIO_147"),
 	PINCTRL_PIN(148, "GPIO_148"),
 	PINCTRL_PIN(149, "GPIO_149"),
-	PINCTRL_PIN(150, "SDC2_CLK"),
-	PINCTRL_PIN(151, "SDC2_CMD"),
-	PINCTRL_PIN(152, "SDC2_DATA"),
-	PINCTRL_PIN(153, "UFS_RESET"),
+	PINCTRL_PIN(150, "UFS_RESET"),
+	PINCTRL_PIN(151, "SDC2_CLK"),
+	PINCTRL_PIN(152, "SDC2_CMD"),
+	PINCTRL_PIN(153, "SDC2_DATA"),
 };
 
 #define DECLARE_MSM_GPIO_PINS(pin) \
-- 
Sent by a computer through tubes

