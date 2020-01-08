Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D21C33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DC820656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjVwI/C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgAHATT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:19:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38495 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgAHATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:19:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so681459pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K7uPVFSGv/kS0jSGzc7cCqTW6KlASlBhguyS+lV6p3I=;
        b=VjVwI/C7i0lYIemV60zKTBBpdsmH13l13AJZnitD2mB/ej5G4YA8COL9kAUvNaMwW6
         he1bYldjPnY9hONiXEosNDo7JG1rE7/ZWE4u05WXOrsNl8ZksQXTFdIHW2UZo8e4VGLO
         gONcUezupq+MIqBVPlLWi4eJ/y9s/eB/Rx5ssfK7BpBXd5u84ZyLJn+JpPNQFuOOaCgV
         KG18qvIFl9xlkreah3lnXeAeHjN7lXhioIyq9W3ipRkW4WSAhvEjIC8HuUMgKEtQivA5
         ZJT/adl+gGYo815nJ/JX5sHALYw9/REqnYcMpdLqaNfBufm+XyauiAFgzOtXtpMpyVva
         KZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K7uPVFSGv/kS0jSGzc7cCqTW6KlASlBhguyS+lV6p3I=;
        b=MLL3b832ZxBuJm4aBIRo514iMra13prBbXZzYeRlyJu1NCsYiS0xkSfygCvBQswgrv
         jvG1+hqn3nZI411GSBhLA343zmOrmshfqKrk09/KhM5XymMqT1Kv95ZITRHINIUb3aGE
         KYX35/4i166UukpnP+MGKWE6fs5fisULDJsBNO1KxBKediiOpfVH+GKRE0LJ0xpmPda0
         G25uoNZSHTNWFFpJ4RvH+KKLPlaBE7gvNn90UsC/7zVLzedNSMZRLChqs00hRvY2exJu
         veag6CO8fVgPjBJaiVDxlur+WqNfWwQILZavyRfIsdc7Cd8WPbfecg5AecRR7WxU0fbi
         E8wQ==
X-Gm-Message-State: APjAAAW2z2k6YRaUwHW0AEgWDyCkIZcLOgXfr9xFQ2d2ZousHe1KgOuu
        tYBRdwdaRCB4F/kFk+wpitvKP38sios=
X-Google-Smtp-Source: APXvYqzQM4yZJS28wcE0CjsCuLtJKXavwJCtK2FRZ+Lt0MyiHK9n4An0dI5KePInH8trrVSlQd/LUA==
X-Received: by 2002:aa7:94a4:: with SMTP id a4mr2087259pfl.178.1578442757268;
        Tue, 07 Jan 2020 16:19:17 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id v4sm693912pff.174.2020.01.07.16.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:19:16 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v3] reset: qcom-aoss: Allow CONFIG_RESET_QCOM_AOSS to be a tristate
Date:   Wed,  8 Jan 2020 00:19:13 +0000
Message-Id: <20200108001913.28485-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow CONFIG_RESET_QCOM_AOSS to be set as as =m to allow for the
driver to be loaded from a modules.

Also replaces the builtin_platform_driver() line with
module_platform_driver() and adds a MODULE_DEVICE_TABLE() entry.

Cc: Todd Kjos <tkjos@google.com>
Cc: Alistair Delva <adelva@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Fix builtin_platform_driver line in driver code
v3: Add MODULE_DEVICE_TABLE() as suggested by Bjorn
---
 drivers/reset/Kconfig           | 2 +-
 drivers/reset/reset-qcom-aoss.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 3ad7817ce1f0..45e70524af36 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -99,7 +99,7 @@ config RESET_PISTACHIO
 	  This enables the reset driver for ImgTec Pistachio SoCs.
 
 config RESET_QCOM_AOSS
-	bool "Qcom AOSS Reset Driver"
+	tristate "Qcom AOSS Reset Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  This enables the AOSS (always on subsystem) reset driver
diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
index 36db96750450..9333b923dda0 100644
--- a/drivers/reset/reset-qcom-aoss.c
+++ b/drivers/reset/reset-qcom-aoss.c
@@ -118,6 +118,7 @@ static const struct of_device_id qcom_aoss_reset_of_match[] = {
 	{ .compatible = "qcom,sdm845-aoss-cc", .data = &sdm845_aoss_desc },
 	{}
 };
+MODULE_DEVICE_TABLE(of, qcom_aoss_reset_of_match);
 
 static struct platform_driver qcom_aoss_reset_driver = {
 	.probe = qcom_aoss_reset_probe,
@@ -127,7 +128,7 @@ static struct platform_driver qcom_aoss_reset_driver = {
 	},
 };
 
-builtin_platform_driver(qcom_aoss_reset_driver);
+module_platform_driver(qcom_aoss_reset_driver);
 
 MODULE_DESCRIPTION("Qualcomm AOSS Reset Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

