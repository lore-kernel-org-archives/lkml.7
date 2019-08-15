Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B271EC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1D7208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889279;
	bh=eDDWPSyqTQzfPWXdKfz0vrNw7rMeN/JuyLrMVyAA4yA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zGlifK9IqG+6Wc4gJG9n7UtnvZTbHVbZZRepWKBKUxxBtx+rEaKGtrKz/0SRbex0Z
	 KbdhfTw678+2A0FTvzLT2ZO8JwvIWL6hEOhs3bMG6wAQv+86deG420tYzLgWdUpdnr
	 hjvUpGrwIzjj1AnXHz1EoAFt9Mds9MBdtYdsBaAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfHOROi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:38 -0400
Received: from mail-ed1-f98.google.com ([209.85.208.98]:39411 "EHLO
        mail-ed1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbfHOROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:37 -0400
Received: by mail-ed1-f98.google.com with SMTP id g8so2703507edm.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=Z7ZxsDgfWU46Ybcjy2/C5BgvQB81y4GKF7sm31CzdrM=;
        b=kUKTIEsUicryBa13q2lzf6993xZbRUKGCqRLHvngbZAXLytussytbYSmhw520w4/oa
         niFFtF4TDu0HWd3i7mbRedCRoLoAyx7pZfn6um2QCBFl3x6yUcpD3e8J5BLJ7dwYCy1Z
         cAxlZFhvgW1EMGrrLXUiQlkc1qM3aJCZuHqyK337Y35A+FMggVzG9tlJTqJ0bsuNhXbP
         4A8Zgsvirxm2Yom73iE4c/YzYyuvJpVcqUKAtYE0vKVLlhXrEKlvdfgp9j8T/YFofKQ3
         Xl7E7kPRut6laIAb3iDGIHrioLn71h6y3CqMK4KhfEk5Kk2nN+/eFMZlze1byMKrmw4d
         nXRg==
X-Gm-Message-State: APjAAAW3ji7rSknTbp8KW/YL8NbQMfChGJfSTlkY1aDP3oIFeBcGCzTa
        jVu/ftYotF5C7M/yT5G5NbCJTN7yMwODz2aYAIdpa3OlNBAMh5cjTV9za08kkTHxaw==
X-Google-Smtp-Source: APXvYqzi4mE6JEqoZ4pkdHHrkjGFjr3tCHkQB1uiMMh1QmQ6fxIcRujGg6T/odlByK8WT3k/pcQ2CowbXPyk
X-Received: by 2002:a50:d1c6:: with SMTP id i6mr6519505edg.110.1565889275471;
        Thu, 15 Aug 2019 10:14:35 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id me22sm13772ejb.69.2019.08.15.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:35 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKd-00052t-5K; Thu, 15 Aug 2019 17:14:35 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A604C2742B9E; Thu, 15 Aug 2019 18:14:34 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "regulator: act8865 regulator modes and suspend states" to the regulator tree
In-Reply-To: <1565721176-8955-3-git-send-email-raagjadav@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171434.A604C2742B9E@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8865 regulator modes and suspend states

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From ff461ebfd4b7051d9b79ca023741e6c2d960a912 Mon Sep 17 00:00:00 2001
From: Raag Jadav <raagjadav@gmail.com>
Date: Wed, 14 Aug 2019 00:02:56 +0530
Subject: [PATCH] regulator: act8865 regulator modes and suspend states

Add documentation for act8865 regulator modes and suspend states.
Add active-semi,8865-regulator.h file for device tree binding constants
for act8865 regulators.

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
Link: https://lore.kernel.org/r/1565721176-8955-3-git-send-email-raagjadav@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/act8865-regulator.txt  | 27 ++++++++++++++++--
 .../regulator/active-semi,8865-regulator.h    | 28 +++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/regulator/active-semi,8865-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
index 3ae9f1088845..b9f58e480349 100644
--- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
@@ -34,6 +34,9 @@ Optional input supply properties:
   - inl67-supply: The input supply for LDO_REG3 and LDO_REG4
 
 Any standard regulator properties can be used to configure the single regulator.
+regulator-initial-mode, regulator-allowed-modes and regulator-mode could be specified
+for act8865 using mode values from dt-bindings/regulator/active-semi,8865-regulator.h
+file.
 
 The valid names for regulators are:
 	- for act8846:
@@ -47,6 +50,8 @@ The valid names for regulators are:
 Example:
 --------
 
+#include <dt-bindings/regulator/active-semi,8865-regulator.h>
+
 		i2c1: i2c@f0018000 {
 			pmic: act8865@5b {
 				compatible = "active-semi,act8865";
@@ -65,9 +70,19 @@ Example:
 						regulator-name = "VCC_1V2";
 						regulator-min-microvolt = <1100000>;
 						regulator-max-microvolt = <1300000>;
-						regulator-suspend-mem-microvolt = <1150000>;
-						regulator-suspend-standby-microvolt = <1150000>;
 						regulator-always-on;
+
+						regulator-allowed-modes = <ACT8865_REGULATOR_MODE_FIXED>,
+									  <ACT8865_REGULATOR_MODE_LOWPOWER>;
+						regulator-initial-mode = <ACT8865_REGULATOR_MODE_FIXED>;
+
+						regulator-state-mem {
+							regulator-on-in-suspend;
+							regulator-suspend-min-microvolt = <1150000>;
+							regulator-suspend-max-microvolt = <1150000>;
+							regulator-changeable-in-suspend;
+							regulator-mode = <ACT8865_REGULATOR_MODE_LOWPOWER>;
+						};
 					};
 
 					vcc_3v3_reg: DCDC_REG3 {
@@ -82,6 +97,14 @@ Example:
 						regulator-min-microvolt = <3300000>;
 						regulator-max-microvolt = <3300000>;
 						regulator-always-on;
+
+						regulator-allowed-modes = <ACT8865_REGULATOR_MODE_NORMAL>,
+									  <ACT8865_REGULATOR_MODE_LOWPOWER>;
+						regulator-initial-mode = <ACT8865_REGULATOR_MODE_NORMAL>;
+
+						regulator-state-mem {
+							regulator-off-in-suspend;
+						};
 					};
 
 					vddfuse_reg: LDO_REG2 {
diff --git a/include/dt-bindings/regulator/active-semi,8865-regulator.h b/include/dt-bindings/regulator/active-semi,8865-regulator.h
new file mode 100644
index 000000000000..15473dbeaf38
--- /dev/null
+++ b/include/dt-bindings/regulator/active-semi,8865-regulator.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device Tree binding constants for the ACT8865 PMIC regulators
+ */
+
+#ifndef _DT_BINDINGS_REGULATOR_ACT8865_H
+#define _DT_BINDINGS_REGULATOR_ACT8865_H
+
+/*
+ * These constants should be used to specify regulator modes in device tree for
+ * ACT8865 regulators as follows:
+ * ACT8865_REGULATOR_MODE_FIXED:	It is specific to DCDC regulators and it
+ *					specifies the usage of fixed-frequency
+ *					PWM.
+ *
+ * ACT8865_REGULATOR_MODE_NORMAL:	It is specific to LDO regulators and it
+ *					specifies the usage of normal mode.
+ *
+ * ACT8865_REGULATOR_MODE_LOWPOWER:	For DCDC and LDO regulators; it specify
+ *					the usage of proprietary power-saving
+ *					mode.
+ */
+
+#define ACT8865_REGULATOR_MODE_FIXED		1
+#define ACT8865_REGULATOR_MODE_NORMAL		2
+#define ACT8865_REGULATOR_MODE_LOWPOWER	3
+
+#endif
-- 
2.20.1

