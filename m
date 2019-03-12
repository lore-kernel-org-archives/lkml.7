Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A20C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75DE2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lGu+GYtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCLILv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:11:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37733 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfCLILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:11:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so1238982pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=lGu+GYtXCa2KasGFdXUqJUz+iwF2LhIXbYg01AKZ+WKV4SBVy6niGFyEFdS9XxtHj3
         gLhfKpQeKbe9PWH4HVoBu3mbnWLeCJMPxSA7Rf57/aonJtxSbL7+yVzbwYKCaP3+DoBg
         pb6sLhJT2FEiGojX8DeuCxrky18XzPEyvESbmrIkbcPoPYDPvPA2qNo+XMqGZLid2Wls
         zm4oJ4Bxd2InuKitan2TnPkaz1MUkYaHGNdcVSJjDlflDsQ33OSaLCTXgPp0Wgg/0quZ
         kXPqNmMAq+A0zobyTXwaUMnHrcouyVWFjXnXbwXI+NmADWhk3I92gh8BLRq5jDUNo10A
         9HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=GowI6TEB/YL20aLNkH/SpaSwz9+CuwceN+G1LrRK/HrU12mHuY9hmfx4TsR5CBrQOs
         UNI1ctrC9b166IeuwlvzvXCXW1n8fvIk1EmdAf083XP20wf7whB8k+62zIRNZh3T/a3P
         rqMcJ8IUE8hX57QRlaNUuWZz+XAkXV04yP6hXAaHUfd7uRlOva9PKq1V+kH6+UCzaCGH
         HFXiXV2GtCr4iCzni5i8Wytt70Uz0jyY9Beran6kB8glwBfiIFt+pUPMs+TmpMo6q1wB
         o7aSNvTY4Pzgzcb1cc7fsPm5nxQ6JigFv3FJKnTm1iaw32mPSmhuUJDXbuBMgP+f1LA1
         9MHg==
X-Gm-Message-State: APjAAAVNKD/y7ErXnwNSsQSdcX1b0xo9SSWD4RYqXrx4aSjOEPgmMPgH
        DIqQOLTEESxxjcnf6Dlk0LryaA==
X-Google-Smtp-Source: APXvYqwg28NUQM1tdtYjUyUtv4zmoULOuJaBTJuEYzhP/D9nixTYJJhbLvG73H95w1fSDzInBbmWVw==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr33245296pla.139.1552378309879;
        Tue, 12 Mar 2019 01:11:49 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id o5sm3687795pgc.16.2019.03.12.01.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Mar 2019 01:11:49 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v9 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Tue, 12 Mar 2019 13:41:28 +0530
Message-Id: <1552378289-27245-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
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

