Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EC3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2679D2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaW900pJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfCMIhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:37:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36475 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfCMIhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:37:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id v10so761148lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=49oAUcefl7Qs60t5vd0C3ulsmkkBE/5vo7x8P2YQaHM=;
        b=AaW900pJqH+ZvraqyUDS8w9k7SNv6l9CJOI6zb+S6ZGSC+ZtfC3ivkC+d1hO8U7zeF
         vWZvnMcRTcLkzbe0HB8fZu9dSaZQtPfSiFc+vkeFKKEHasb4AkRFa8BwFAiTGsFw7wHw
         u5wXvEwgKu2yP6sjiYHUjL63Nw4xsq2+SC5c7SIuURaiClnK8+SUcTg54Inu2H+FkAm4
         bHO8PPsXCEW3QDaaJ34JrQlPQ9GBrHBj7CtfWCIQ4zM6cXVgj41lCL2Jak84pnuXvkS/
         5lEKE86L+2wi3J2SNJmSryHE+qBIqdZCpyD3Xdx0VLeVRenmgE6jVZeqboxv0xzU7/Uu
         mj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=49oAUcefl7Qs60t5vd0C3ulsmkkBE/5vo7x8P2YQaHM=;
        b=MdL/swQPwqbqF0JbdOTJMK14Z9lWr/mS/mnRejiUx78yAj/zB5lIMwbkxSU6dG3jwH
         iPHxRxeWNPJBwGuGKpgW78dGrFH71GbN4oNCOITwigsfzcEXS0mWUh2eefzYKJ2Z8q4+
         PtwOQ732AHc7i9IDl/lREvuyyL3HHaiJpARib1ShcfpPXYoTlABSvb80cg6rLn6dd4Cm
         /Io3LDGEsVFjFzBNDcQGtjUi7SdGZ60gQic6LvILNbVCI1/oGhWx5iolXpe8MOx9lDbQ
         ZBUNcMi4NNNBmBMmejUqO9eErYK3wro5nOTpzR6maELdLF6yeetbo8JTzVicH0x1lgt/
         mikA==
X-Gm-Message-State: APjAAAWA2Ei7EJglrGVJG2DUZuCxW3dH2iHKJ0T/tMIyLb+cg/lPR44r
        HbOigNcg/xUQ9loOH2SKYke30w==
X-Google-Smtp-Source: APXvYqwM1UOmFchmb8FVNYUvMVbDbX1oYR4zYTRQUF7J3df0h9Vim0zVOeF0kvjf7PGcN1Mbj1ABKg==
X-Received: by 2002:a2e:9204:: with SMTP id k4mr17998616ljg.0.1552466232444;
        Wed, 13 Mar 2019 01:37:12 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a23sm1707716ljd.20.2019.03.13.01.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 01:37:11 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] drivers: firmware: psci: Announce support for OS initiated suspend mode
Date:   Wed, 13 Mar 2019 09:36:59 +0100
Message-Id: <20190313083659.7100-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190313083659.7100-1-ulf.hansson@linaro.org>
References: <20190313083659.7100-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSCI firmware v1.0+, supports two different modes for CPU_SUSPEND. The
Platform Coordinated mode, which is the default and mandatory mode, while
support for the OS initiated (OSI) mode is optional.

In some cases it's interesting for the user/developer to know if the OSI
mode is supported by the PSCI FW. Therefore, let's print a message to the
log, if that is the case.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/firmware/psci/psci.c | 21 ++++++++++++++++++++-
 include/uapi/linux/psci.h    |  5 +++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e480e0af632c..eabd01383cd6 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -95,6 +95,11 @@ static inline bool psci_has_ext_power_state(void)
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
+static inline bool psci_has_osi_support(void)
+{
+	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
+}
+
 static inline bool psci_power_state_loses_context(u32 state)
 {
 	const u32 mask = psci_has_ext_power_state() ?
@@ -659,10 +664,24 @@ static int __init psci_0_1_init(struct device_node *np)
 	return 0;
 }
 
+static int __init psci_1_0_init(struct device_node *np)
+{
+	int err;
+
+	err = psci_0_2_init(np);
+	if (err)
+		return err;
+
+	if (psci_has_osi_support())
+		pr_info("OSI mode supported.\n");
+
+	return 0;
+}
+
 static const struct of_device_id psci_of_match[] __initconst = {
 	{ .compatible = "arm,psci",	.data = psci_0_1_init},
 	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
-	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
+	{ .compatible = "arm,psci-1.0",	.data = psci_1_0_init},
 	{},
 };
 
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index b3bcabe380da..581f72085c33 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -49,6 +49,7 @@
 
 #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
 #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
+#define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
 
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
 
@@ -97,6 +98,10 @@
 #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK	\
 			(0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
 
+#define PSCI_1_0_OS_INITIATED			BIT(0)
+#define PSCI_1_0_SUSPEND_MODE_PC		0
+#define PSCI_1_0_SUSPEND_MODE_OSI		1
+
 /* PSCI return values (inclusive of all PSCI versions) */
 #define PSCI_RET_SUCCESS			0
 #define PSCI_RET_NOT_SUPPORTED			-1
-- 
2.17.1

