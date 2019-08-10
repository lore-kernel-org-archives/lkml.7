Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6291C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781042166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP8gAfog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfHJHtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:49:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41807 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfHJHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:49:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so45696987pls.8;
        Sat, 10 Aug 2019 00:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Fxl2mdmPp+CUi6nNXci38jhpqj842L6ifzHHMtUOyk=;
        b=uP8gAfogmuuyc8Nty1FTGX1G/UO0bdb0TJNAwTZaGKqb69YDaSJXrS7lOqYFAB9G+9
         vVUwTjW6zfAlwa+3VSOLgZOHhuOjeP/QztdvtpmuCaTnyW70pdoz44oUuG6yai9mltYG
         vL8T0QZ/03u5MNdFsUCvO3tv/JBotKrBK76gGkA8LTOk016LSOttZM5/O3AiOmhBe3oA
         FhXeVuF65Xtls+buae6RLCBWTy4JoCGylRqWskDxLg+Z7/mnhp7HCTDLhH9YzF8ZsCfV
         QvOexMWtXWmlvINMxaaUQBggYxUaMyFszpkAyVevbIetoUGOGjaqTNq8GgqzA9EfAkNH
         i2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Fxl2mdmPp+CUi6nNXci38jhpqj842L6ifzHHMtUOyk=;
        b=iAD8dkUDYt+q8HnEwL7NDTfPf125XsTli7NDkNz6THhNHavD4K/X8/cfNiQ3JIvkgz
         vcj3OMiH95mIfdjWP4JShr20CmxSOOJOO8Uh0NWv/kUz1xJFEUIl2p3lYR7vei84rGCt
         WRXtXEiVcN/ZLP7S9vFNy/3P4PNCYViDiXLrNMJ4/CTbwr5vlAAm7AB6RdTalWekBwF9
         J8XxCu5418tlyse13q+OLZ6wc73MZWjAF0QosHgsslmlpZb5Rl3O9HaQXVyEYOlDvsZ9
         DOzMhCANMwklCIU38Kb071Zz7gBU6qwvi3rC36/40na6Sg//8mLQ+TvCyqozD3Pw2SlW
         OtXA==
X-Gm-Message-State: APjAAAXIjk0+MADhlg54auOKSJwt51Z53FaaQ8N0cVrRF8Tes5Pua564
        Y++2xQd4ndbhy+ZxljCD5GW7au2f4II=
X-Google-Smtp-Source: APXvYqxutsqH9VLG5WfGs4442uET5bn66jGGLEIJo8hjA6+Mr/GeZNwxcv9K72emALQZsvy1/6vMIQ==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6mr23541722plk.14.1565423382598;
        Sat, 10 Aug 2019 00:49:42 -0700 (PDT)
Received: from localhost.localdomain ([219.91.196.106])
        by smtp.gmail.com with ESMTPSA id c98sm7769318pje.1.2019.08.10.00.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Aug 2019 00:49:42 -0700 (PDT)
From:   Raag Jadav <raagjadav@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH 2/2] dt-bindings: regulator: act8865 regulator modes and suspend states
Date:   Sat, 10 Aug 2019 13:18:55 +0530
Message-Id: <1565423335-3213-3-git-send-email-raagjadav@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565423335-3213-1-git-send-email-raagjadav@gmail.com>
References: <1565423335-3213-1-git-send-email-raagjadav@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for act8865 regulator modes and suspend states.
Add active-semi,8865-regulator.h file for device tree binding constants
for act8865 regulators.

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
---
 .../bindings/regulator/act8865-regulator.txt       | 27 +++++++++++++++++++--
 .../regulator/active-semi,8865-regulator.h         | 28 ++++++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/regulator/active-semi,8865-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
index 3ae9f10..b9f58e4 100644
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
index 0000000..15473db
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
2.7.4

