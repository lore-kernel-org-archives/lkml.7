Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BFFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D739120C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxKCWV0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbfB1N7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:59:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35579 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732517AbfB1N7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:59:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id t13so12841183lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GD//s0JqI+KeAlnmxGXuzGHGexOP9orqqmZkOhYLw7U=;
        b=bxKCWV0plbqK1C5WfZfPpwf6fpbP94JQ/X271V/yQ5/QjJlyWO+wSIazjrGUubTSBD
         QreM+rLgJtP3DejcY1iHhPkN9dEh9EeG6CY0HTwy+GBS0MGSX/Dp/EOzA/WWQyhkuBzZ
         wtYAG9J2Rrkvxle66XhIqeoI2kF038iqHWp3k8aol4M2xcvcrWxY/e4swHu+Wn8OdaFt
         TPxsXx0d8oKTgHlOFo56ALs+JLy1b36GwFDgtIMSD+zRls/6y5/Y5BJlW4BzDFwYbz/F
         D67bwwhIV5FNqWH+Xg2NdwvzFQMVohZb+YVTD5ZBV3sLP7pMAOG/bbjFCEwWH9klV2LX
         7Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GD//s0JqI+KeAlnmxGXuzGHGexOP9orqqmZkOhYLw7U=;
        b=eGK/nxeNXIdAb++kYsFIP6cLQXtMtzCfVlCUVxKqwLDBm56rWKjN4VWv51V7Y1DaWW
         FzLppf+aTAL7snFONV70mVfx0aD7U6/3gm+RWAm04UlZUdM3VvKBYlJlR4w3Z1ZXPUZu
         Y3A8zWd9bkcQ9XBmlYufkTJPbA2CW+FcvAbk2wjbn+JqWL8D4r738tS6+IVK95iiW6jB
         P+d20cQSUX+O8yOT6KyWJVoi+4dDL7nPUgZKmLK+yJBHK0DidTAzzHMHXm11u0OnSi7t
         MqtD744E4NXgyskJHgNvw8R7H8PviQ8gKcZ77OqA2NKL9gLfI7KX78NBDu6mAirdxaf2
         W2xA==
X-Gm-Message-State: AHQUAuYDLnZi0f6Z2V06cuMg37oYVGKH10mdfzBB98iWUu4yUZkCp3eJ
        xiHXFlxd0pF+wNq+LfPIUlUHyw==
X-Google-Smtp-Source: APXvYqwLBvpBuNN3H00hxi679411B3GMNc7DVG02j7EI5Mmnve0xO8zse4d3ORBN/k59dI+VI1ByKg==
X-Received: by 2002:a2e:8694:: with SMTP id l20mr4846832lji.152.1551362375281;
        Thu, 28 Feb 2019 05:59:35 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v20sm4090265ljv.83.2019.02.28.05.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:59:34 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] drivers: firmware: psci: Announce support for OS initiated suspend mode
Date:   Thu, 28 Feb 2019 14:59:19 +0100
Message-Id: <20190228135919.3747-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228135919.3747-1-ulf.hansson@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
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
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 21 ++++++++++++++++++++-
 include/uapi/linux/psci.h    |  5 +++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 14d25b54b9f2..417d43886948 100644
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

