Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCD020870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z0HFe/BK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfCYKNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:13:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45288 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbfCYKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:13:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so6187677pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=Z0HFe/BKRf+mzm5Qxp6iGlZ5rHMkCbVSy/FrWwUTh6eEDbcmxq/pDM5TgBsyXVcU1c
         hpcYxdNwjS5VnKZQHG4KKzd2HkpguSVwG/o09wlYy+fCAoWDbxNQU5Pd5oMZA/Osy5Ya
         y6Bo4I/hwtcoPDF50uBgXfuBpzFM7m100DE18uI1dGxwX1Dnhyw7W8dQnYphpAd/PamQ
         rVerdmN4Dnkq2IugSkndQTNzFOq55RSuH8bJsJkJJgNIu6y/uwVDLda90WXwJfAtX6zB
         cCKcc/upKRz6B2oeVyMY5cAioDr8Gcx8IgdZ7B0muoSiyQw4OEvp+r08UbaAeP9rQJE2
         lmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=Dvio79KDj9el2RhpCmWGe59vYD/uGrFmvc23KMtCcvzuWDx7qKz5F02hh3s8FQ+xF3
         qH9eStZz6/EeTTLmvz8GXDGVhMu98vFVbpx0cSotuZJou0hsgkDZu8IgTeKjDy6ZK5C4
         blebYR+RGpqw3hnJRMn2jDXlsl0fZUG1Qvo7UaQYvziqftsuBEyGrrPoSJeEAiAY1HgV
         OfDLpGN0qUoES9KQ+LssUbnnBm4nJRm8rgGpvzM1Wi4cVaYW7dYX3vSz1mURUBkXxtmJ
         9MshBoHMRrXpnRzbvHP0e59P/CpnwlGF7ILZV4kY2XaZF7/yd5NJjy5LXXzkR2epT2e/
         mpoA==
X-Gm-Message-State: APjAAAUA4nuAX9VyWMRSy4Z0VQVWdKOhef7O7UcUh6i7SAoUL4LWLzw8
        wS5oA7bj2n3v9Jf4M+I2BDgnLQ==
X-Google-Smtp-Source: APXvYqxO1eDwlfMIaxRE997SpkiUMVSXmQq1c+r8MhTURtPNCxPvg+InnM6G/T3wnnXIWRli8I9FBw==
X-Received: by 2002:a17:902:20e8:: with SMTP id v37mr11929210plg.168.1553508803047;
        Mon, 25 Mar 2019 03:13:23 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id v82sm30151298pfa.170.2019.03.25.03.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:13:22 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v11 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Mon, 25 Mar 2019 15:42:58 +0530
Message-Id: <1553508779-9685-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT documentation for PWM controller added.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Compatible string update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
new file mode 100644
index 0000000..36447e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -0,0 +1,33 @@
+SiFive PWM controller
+
+Unlike most other PWM controllers, the SiFive PWM controller currently only
+supports one period for all channels in the PWM. All PWMs need to run at
+the same period. The period also has significant restrictions on the values
+it can achieve, which the driver rounds to the nearest achievable period.
+PWM RTL that corresponds to the IP block version numbers can be found
+here:
+
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
+
+Required properties:
+- compatible: Should be "sifive,<chip>-pwm" and "sifive,pwm<version>".
+  Supported compatible strings are: "sifive,fu540-c000-pwm" for the SiFive
+  PWM v0 as integrated onto the SiFive FU540 chip, and "sifive,pwm0" for the
+  SiFive PWM v0 IP block with no chip integration tweaks.
+  Please refer to sifive-blocks-ip-versioning.txt for details.
+- reg: physical base address and length of the controller's registers
+- clocks: Should contain a clock identifier for the PWM's parent clock.
+- #pwm-cells: Should be 3. See pwm.txt in this directory
+  for a description of the cell format.
+- interrupts: one interrupt per PWM channel
+
+Examples:
+
+pwm:  pwm@10020000 {
+	compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
+	reg = <0x0 0x10020000 0x0 0x1000>;
+	clocks = <&tlclk>;
+	interrupt-parent = <&plic>;
+	interrupts = <42 43 44 45>;
+	#pwm-cells = <3>;
+};
-- 
1.9.1

