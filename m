Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B712C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C77B20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A+Lp22au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCRLrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:47:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46960 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfCRLrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:47:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id a22so11164256pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 04:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=A+Lp22au2IpiEUVbLQYCzRe6O7nA6kXOrqv8Cdn/PvL07941Cd3VH9jUMGSq1HXljq
         HV2IzoZcAV50LLpaXdzsTq2f7i5vDawmDhKwpKFem8xsYtR4v9HQMoze8rN+iN9kygY/
         pyypyp0Ptir2ZNJJ6PLM0J6sbewyKi/4HaqKihYK19Kl0c/Pm6u2gn0Gk/cVpVYPNyjF
         j7rTuLwMf0AkqzyLA4r4amdE7Ywm8F9spqavN76WwGYqQpwSf3VL01g+V4QPjGQ7RKBi
         HX9JCBLxu5KSW36RlvrEu+a/RmnR+3SPK9sbX3H0m2SaN/PY77MetIXqKQRxTAFeJqr3
         CgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=PifpnH+1CvC6oMuOoTOHXZ5bnjQw3SMs4/3SQHrMNj7cqcSiYFZ+f5ghkLuqMLi8zr
         HX3h4phH+yJxu/Nr2C95Yn6qtc14vY1XhMjvBEgXGzL4SHyeDWRUHs1u+NIIsyH4gZle
         /p/T1+LdML7Hv8HeDFtCoiGxcfU2qQPTzIehNma6UdurBCnQFDoibuklObZo1YGOLMeq
         oW16sSDoNC8Fyu21K+NTjjO6q4c02Mb69oyBwf3whcQSE0HVy+1baUBw0HNk7iGb6q2U
         CWGOt58oRdoHD86CIf4f1OVWAttFf9ro0GszYHJdF9FPaLr6aFbsQSRvx/0V5fvlen13
         nvmg==
X-Gm-Message-State: APjAAAV7H/xGFBV3BUWxKqrVu2iLdRWZMaesRhU5HEzWKbuF795D/Val
        9+czSAEuymc0JhttXtGuJvfjYw==
X-Google-Smtp-Source: APXvYqwRagNey96hwUm9IdsdRvPDwJX50uH6Y5an/dovc8WW5a2tuWGdIkYfFedo31e1zy46KFPpIw==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr19414188pla.177.1552909664951;
        Mon, 18 Mar 2019 04:47:44 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id p5sm14403911pfn.154.2019.03.18.04.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 04:47:44 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v10 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Mon, 18 Mar 2019 17:17:13 +0530
Message-Id: <1552909634-18757-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552909634-18757-1-git-send-email-yash.shah@sifive.com>
References: <1552909634-18757-1-git-send-email-yash.shah@sifive.com>
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

