Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54448C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C2E2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g69hp4Wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403776AbfFKFpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:45:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37659 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391271AbfFKFpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:45:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so5845535pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=g69hp4WtKBXVs/W2OQRi6i7+BJJ9NA/B3UZrmnFwSIpxPOXdV+4SehL9/1NeJUiApl
         JaaOQQjCNWD+PpFRhB34XF2kPoPa/mF17bH1OZPaeGDkY+hiEQwG3OuNoQSiCxpuEl07
         pB1/dW+l1cwlC2FlB2aQL/4O6Rt2oM7V+42rmb54lxlzfZSAOPc6PyE+snhm1uXqfpTc
         11kMCPgQ2Ile4qANa1CjSNT6I68030nkwfkIdQ1+z26YVvJsmOO5Y/T5TUZFKBrC8TH7
         yATQ6MwMJ9dESxrqa9Z1tGRmeBL8dzJnlv9k1F6bPGxrhP8n5PVjUKMa0DAdkpsPhaEV
         32hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=GjFhMce2EZiAA2WfZvxMHn2VvSMPSV+iN30N9LeuhaRMFdSz3CZNyN9NhQqv3dUzcR
         owDEmWwsp71whwSw+5qaMXpQh2DLhS1L1ytHnuUjCwEQxVxHwZdnFjNHHO2oqLSuzOCr
         QRG7MnBgmCcb7ABanoxapZu6EZNCdjtNB/912FRMLZv08N6YWRkMYmr9OuKSAfVUckQH
         tPwsFqqx16JneaxGSxPeeIO5bb4bT/3JwisIahQI2u0DZGf/OeL0MkM/h68bu/NG/jTO
         KRenQiVEx1URsiu4XV7RcHDC7s169thnDr3fXVyQ+8WorFw5NRKbYq9s24pc3iC8ogKd
         FhDw==
X-Gm-Message-State: APjAAAWXDLzeyLUr7KFJad1QyHs5GAKxKiXjBFsn+mykhsauetwdU4eF
        1KvVMGPuODMk0PQvqVj6926Z9w==
X-Google-Smtp-Source: APXvYqy7aPHGjbrwSUE5dKDEjSmoZTsNPoob8c9BNG2BjQeSH6XN6wjbcyQNmng43AiT09d172xG7A==
X-Received: by 2002:a63:f957:: with SMTP id q23mr19080988pgk.326.1560231918364;
        Mon, 10 Jun 2019 22:45:18 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id d35sm11609228pgm.31.2019.06.10.22.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jun 2019 22:45:17 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v13 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Tue, 11 Jun 2019 11:14:43 +0530
Message-Id: <1560231884-15694-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560231884-15694-1-git-send-email-yash.shah@sifive.com>
References: <1560231884-15694-1-git-send-email-yash.shah@sifive.com>
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

