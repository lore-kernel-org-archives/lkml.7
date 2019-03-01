Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BFFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3801F2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DyQG+7z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbfCAKxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:53:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43353 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbfCAKxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:53:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id l11so11262060pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 02:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=DyQG+7z8Z0oltD7YrfBCC9G15K0lTzWOrPjEd6ijYuONRTRwjqt0OPBJ1yLBzZvh6q
         xwnBH4RFFwx+Rk+tXfvvLyocHEDASpYI+Zz5h5DViVn2oqFvK/4aRZTG1fkDcx7PlbTu
         t26YkzYcHDgvX0wO0pY6ctp9HfEbqMYzyx695fJG+E2XY2zKL4WXmp6INU0wpUZ1tEBB
         erxyw68g3BHp66frm5YZofeuYlCXLVfLHx5a+fV16uhiRJN5Cvp+/poiiegcJ+6WPbT3
         u6dYbh1vSubotnzC5eh5OfIjza1PHGJ9emoDNA52psskcnNAMSI/DCmy9G97E9Dd78Pf
         0yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NvS/bA472zdii99ejJQCZ5ekFJyNtU3GhsdHX2kjcM=;
        b=QRxU/OC9lbujaudo7dxVHI3I+G7f9pElnv8zvWBhuNg2ypUPhH26YfEptumJJK8KoI
         99jxRtwXhLi2RAFBb+jR43uX5CmNcPxpVAOO8V5B/gaF6kwznH5lBZK54Roe5WuRZ6Fx
         W6MbCUt2RPWX4sR3gyAQ6Ucyetku90ku3hoBw4/GtOkaAm2XT+NVns8wlnxcQI0Z8uL4
         nKkaush5+AeQ20+Dc40MYElfba54IWp4ByBfFRBcqtDTqtmOxLxY72jz0fXBTLhyCYRp
         oOlNiNVQT3YUlbafhNj0t0mxD5SKzRNYvPKeR7o8Or0N/W0teP6X54Ml8evIVsUw20ao
         zcIQ==
X-Gm-Message-State: APjAAAU9Po1V7eHa5CPu7VWZ8QaHPm02m7Ksq0MVldgjeB+KZnzJ7P09
        8KkzOgs0DRJKE9WEJi5AuO8qiQ==
X-Google-Smtp-Source: APXvYqyfHMBdI76HvSYhF7xIVLPnbcQzoRf0dxaaVvteSYlzsFKqXECsvMuqvb/jEXyR0nEHJ2Bfcw==
X-Received: by 2002:a63:f556:: with SMTP id e22mr4195570pgk.321.1551437626621;
        Fri, 01 Mar 2019 02:53:46 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id k74sm49239164pfb.172.2019.03.01.02.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Mar 2019 02:53:45 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v8 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Fri,  1 Mar 2019 16:23:18 +0530
Message-Id: <1551437599-29509-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
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

