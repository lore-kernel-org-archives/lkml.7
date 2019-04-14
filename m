Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADB2C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E62520850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAIF2Sxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDNSFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:05:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39914 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNSFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:05:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so7471430pga.6;
        Sun, 14 Apr 2019 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gB//55n8L81QHySU4Rumr2vNcZinl2RY4UOA+QeaZEo=;
        b=cAIF2SxhZbsfckrOlZqqE+aLqHVl6WCL07E71Hl52pBbuNmjQuEvQ/SupTgqxEbU2M
         Wh6TYW53ml9+rlUYTE1eZlKLI5VfNok+RhgJljOQ67Lc5DZjRFyZ2j7LoEIsOCi1slME
         Wn1B+2V7rMRoLaadrTILdJ+vTBR7lw5Z8ZsmfsNTVz7+6KKS9KIAIwAaUBJTxHyK1bH/
         xuJ389Keh0R9W3tNPPj1eznj3sZ29rmiE4MN8JMgr19RrUU7SkG9N0bPhWNEZHPf1WX8
         pdU/5TFDdUw7ETXGXWMSAu3Pop+0t3rjy5i2XQ1GaKJi4uvBMYWcJ/4UeEDyqDM32d5W
         A3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gB//55n8L81QHySU4Rumr2vNcZinl2RY4UOA+QeaZEo=;
        b=IlG6dcecv6/NEvQSisBlBIH3uZ53q0jWAkJlULIVZIFMvCsNk3NPF2VyfzaAdSIjNb
         Kbow2n1nKu7Z1uMOwDkh4lgjcMywHGhJOBqd5PyqYZ0wqaJCJ9Ozkhlzqgq9qk7b59lc
         tKe+88oIK/Bd/GVxLs7bC1GNjVZx1XPi9gIdyGbjqYoyck6J9+pG/7RwV5I6SEXUFxTS
         d2IhXCTaAhG4/9/yeTp1KazhAKyIGcxg3ASSrX13uYwwqaaMxygogIQ//F7JFOzbqXbX
         1s64Gy6QegJq532VKT+1xyz4MduBTAM2gwtthzUBItULs5vNhuZr67YLYFO9J5mLbBsn
         qILg==
X-Gm-Message-State: APjAAAVn28JcPjt14apPBy9qdgc08rNRJBW6XHbElEwdLo1KxM8EMO3c
        wykhGuCT7JFatViBTJSDQ4EwtTSQ
X-Google-Smtp-Source: APXvYqzVG62rq00uqy5vNFinsdNUpOa6//8LudPdMJJcKUlWBkw/Ocs1HY8qjilzu5tj5OWGVa7bLg==
X-Received: by 2002:a62:cfc4:: with SMTP id b187mr69632257pfg.130.1555265152002;
        Sun, 14 Apr 2019 11:05:52 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e7sm43359712pfc.132.2019.04.14.11.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 11:05:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/6] regulator: core: Introduce API for machine-specific regulators coupling
Date:   Sun, 14 Apr 2019 20:59:34 +0300
Message-Id: <20190414175939.12368-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414175939.12368-1-digetx@gmail.com>
References: <20190414175939.12368-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now regulator core supports only one type of regulators coupling,
the "voltage max-spread" which keeps voltages of coupled regulators in a
given range. A more sophisticated coupling may be required in practice,
one example is the NVIDIA Tegra SoC's which besides the max-spreading
have other restrictions that must be adhered. Introduce API that allow
platforms to provide their own custom coupling algorithms.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c          | 18 ++++++++++++++++++
 include/linux/regulator/machine.h | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 186a37675b50..a98af47e0feb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -59,6 +59,8 @@ static bool has_full_constraints;
 
 static struct dentry *debugfs_root;
 
+static struct regulators_coupler *machine_regulators_coupler;
+
 /*
  * struct regulator_map
  *
@@ -3596,6 +3598,12 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 		return -EPERM;
 	}
 
+	if (n_coupled > 1 &&
+	    machine_regulators_coupler &&
+	    machine_regulators_coupler->balance_voltage)
+		return machine_regulators_coupler->balance_voltage(
+				machine_regulators_coupler, rdev, state);
+
 	for (i = 0; i < n_coupled; i++)
 		c_rdev_done[i] = false;
 
@@ -4706,6 +4714,16 @@ static int regulator_register_resolve_supply(struct device *dev, void *data)
 	return 0;
 }
 
+int regulators_coupler_register(struct regulators_coupler *coupler)
+{
+	if (WARN_ON(machine_regulators_coupler))
+		return -EBUSY;
+
+	machine_regulators_coupler = coupler;
+
+	return 0;
+}
+
 static void regulator_resolve_coupling(struct regulator_dev *rdev)
 {
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 1d34a70ffda2..f15c8c5f7f6c 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -19,6 +19,7 @@
 #include <linux/suspend.h>
 
 struct regulator;
+struct regulator_dev;
 
 /*
  * Regulator operation constraint flags. These flags are used to enable
@@ -265,4 +266,22 @@ static inline int regulator_suspend_finish(void)
 	return 0;
 }
 
+/**
+ * struct regulators_coupler - machine-specific regulators coupler
+ *
+ * A custom regulators coupler allows platform to customize coupling
+ * algorithm.
+ *
+ * @balance_voltage: Callback invoked when voltage of a coupled regulator is
+ *                   changing. The callee should perform voltage balancing
+ *                   and change voltage of the coupled regulators.
+ */
+struct regulators_coupler {
+	int (*balance_voltage)(struct regulators_coupler *coupler,
+			       struct regulator_dev *rdev,
+			       suspend_state_t state);
+};
+
+int regulators_coupler_register(struct regulators_coupler *coupler);
+
 #endif
-- 
2.21.0

