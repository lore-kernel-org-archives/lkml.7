Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00433C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C524C2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqIx/AFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfHHI77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:59:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37908 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfHHI77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:59:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id z14so6484728pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Lo/QmGwP2FIQuGb+OYi0VLHnS1pK1k0BxPE3TRsd2iE=;
        b=GqIx/AFQB7P1U45E89hpLBVv+3HGsvfUpY9UjDWnEW5YG+ZCcVIe8tPIm+j776p28A
         Odye8IaM8yvPGIyy8FDrmiAQmBenGBScVxBnPWXKMGJavrBInN45PU+gdj0OCt9fX69b
         qDR/72w5KxUTcbj0DvdxwJE3K0E6s7RtNmUbmElV8NmqqxG56E4IGCQaPJb2WDnAE73D
         G57arIvCeLvmJu7LjA9o1OnPwC5W6lCiQsTwmYoNVRPcLYZDoKzTYSWwBI2V6RByphQD
         J3mv8k6Lp3jxTflA9a2v+OV6CbTB8acoJy8DUd0gMYQdIYxTzTdVVATVfGVrNUaAyODC
         18QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lo/QmGwP2FIQuGb+OYi0VLHnS1pK1k0BxPE3TRsd2iE=;
        b=n0GUgWQtkBqjcq5OowP9A2o8P62E/RDXR/1VNC0fZJ6Cg8qbYV+fHL2+h+7Xx8oIuK
         MODdEby5OvawVPhUsK7seEMGfp/MYy5AO1Xkqb+jpI7FRtWhejo4FE0zvqJ/WREhlCFS
         2oDSiZZh8ov7ZoBVuAusadRcklbfPCtw9CBbtvidVO8g7erM16+Te7g1g0fUKMJuss26
         bXQNoTQ186J4eh0/xq3JmLfM8lCbzQV/ND9nuH7SJlan/7Udb0zi6CofynVNSk8HrOum
         NN1J/PR/rbKU5UeRE1X5ZhyiyzmRqqOa8rGnGT7ouYaFYgDkisx0LcWXyoXG5n30Es8E
         M9QA==
X-Gm-Message-State: APjAAAWJSVMdNAzec8LiXagCF3GKs2iWLuBB57kKtM7V+INdgFWgWc2i
        AVi6lL0NQsO578Bvkx4Vkmd2pA==
X-Google-Smtp-Source: APXvYqxW/T6rsgg9lq5yhKxRZ6qr0Gz8wiXTFfM7G24btQ7ugy+XtN14vlO3lurTWgF3clv6nNti/g==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr11757419pgj.4.1565254798652;
        Thu, 08 Aug 2019 01:59:58 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b24sm21716254pgw.66.2019.08.08.01.59.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 01:59:58 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     thierry.reding@gmail.com, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM documentation
Date:   Thu,  8 Aug 2019 16:59:38 +0800
Message-Id: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Spreadtrum PWM controller documentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/devicetree/bindings/pwm/pwm-sprd.txt |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
new file mode 100644
index 0000000..e8e0d5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
@@ -0,0 +1,31 @@
+Spreadtrum PWM controller
+
+Spreadtrum SoCs PWM controller provides 4 PWM channels.
+
+Required porperties:
+- compatible : Should be "sprd,ums512-pwm".
+- reg: Physical base address and length of the controller's registers.
+- clocks: The phandle and specifier referencing the controller's clocks.
+- clock-names: Should contain following entries:
+  "source": for PWM source (parent) clock.
+  "pwmn": used to derive the functional clock for PWM channel n (n range: 0 ~ 3).
+  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
+- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+	pwms: pwm@32260000 {
+		compatible = "sprd,ums512-pwm";
+		reg = <0 0x32260000 0 0x10000>;
+		clock-names = "source",
+			"pwm0", "enable0",
+			"pwm1", "enable1",
+			"pwm2", "enable2",
+			"pwm3", "enable3";
+		clocks = <&ext_26m>,
+		       <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
+		       <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
+		       <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
+		       <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
+		#pwm-cells = <2>;
+	};
-- 
1.7.9.5

