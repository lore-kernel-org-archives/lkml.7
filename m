Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593F5C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C7D216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2tMqGfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEHCTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:19:50 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39720 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfEHCTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:19:49 -0400
Received: by mail-yw1-f65.google.com with SMTP id w21so5888936ywd.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0EeoewR//xUbK3i0o/KJF608WXfDbgqdCwHpncewd7E=;
        b=F2tMqGfimKMC2L/JnM/7bmrZTONvFzpTAdMZbSlTIwSP04wXPaAU1dPpOrXlIuxD/n
         WneYhC5DR045ONscF2T55jKKQWX4sZp9owiMRzwCAd4tUP0D1GrHTnmKExrF/LBA7wdD
         uxUjBSjcPUH1PVnjlocdUOhFGLYhYbenYlRm23SKoFmW49lRseOIHlw15k22EfGBO7lO
         Cciwm1pgxXKl/3MwCrc0bCGHN88DV7TYey1jtk2OJ235Fk8WCL+VfqXtjSiCeFtweXv1
         fO9KgFrjwpO9hiSLwh0cSNNBIK+Zgcm1Xt/0XgCFfL90v8r716YLQfoN1ficwFBQOhp9
         8hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0EeoewR//xUbK3i0o/KJF608WXfDbgqdCwHpncewd7E=;
        b=WHKAFDIe0Txx6oq9D3Fm6k5NSbCUR3MiNizc/P3XkAjQrca4ilJbKxrCpr1c3ye87V
         p+YUuaErjTzt50eHe8xIFHnI1ZqsaJwI9BFrclXhjAmxXfRuzno/uVTtAA0FO/z9zgDW
         ROVKGNJ/SU9EcH3kA1OeOqGKvS0yIb1rj1sevVpb2edjvPxj16RJSiRXEHkYg28vehvP
         nCinquDOhFL9vXVycH2XBBM7xb8b4FtXoU/O6fFQtt/GZtSlynarF92SwSnpq7KwWarn
         oYY+7ig077yKJ2qWkdfqtfs5vpf6lnGWDB7s9v9RaoW43EdLtUivLB2XQWCSKfQehyFW
         nLVQ==
X-Gm-Message-State: APjAAAU6upBKaLEuhPNXeSJeK5VMzBSfm2yJ/G+11u+2YAGECDjyYwT3
        BpNiC0YhZcsM4gIZPwrMhX+a0A==
X-Google-Smtp-Source: APXvYqz5tnEZO73T13Fqe5LvB6yCflFzReRwGlAEa8Grn8oeyEROxsQ5uAo34ooaFhVerIbMLdIyCA==
X-Received: by 2002:a81:6d87:: with SMTP id i129mr20365856ywc.424.1557281988734;
        Tue, 07 May 2019 19:19:48 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id s4sm1168116yws.48.2019.05.07.19.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 19:19:47 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Guodong Xu <guodong.xu@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: [PATCH v2 01/11] ARM: dts: hip04: Update coresight DT bindings
Date:   Wed,  8 May 2019 10:18:52 +0800
Message-Id: <20190508021902.10358-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508021902.10358-1-leo.yan@linaro.org>
References: <20190508021902.10358-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight DT bindings have been updated, thus the old compatible strings
are obsolete and the drivers will report warning if DTS uses these
obsolete strings.

This patch switches to the new bindings for CoreSight dynamic funnel and
static replicator, so can dismiss warning during initialisation.

Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm/boot/dts/hip04.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 0f917b272ff3..f58313353519 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -350,7 +350,7 @@
 		/* non-configurable replicators don't show up on the
 		 * AMBA bus.  As such no need to add "arm,primecell".
 		 */
-		compatible = "arm,coresight-replicator";
+		compatible = "arm,coresight-static-replicator";
 
 		out-ports {
 			#address-cells = <1>;
@@ -385,7 +385,7 @@
 		/* non-configurable replicators don't show up on the
 		 * AMBA bus.  As such no need to add "arm,primecell".
 		 */
-		compatible = "arm,coresight-replicator";
+		compatible = "arm,coresight-static-replicator";
 
 		out-ports {
 			#address-cells = <1>;
@@ -420,7 +420,7 @@
 		/* non-configurable replicators don't show up on the
 		 * AMBA bus.  As such no need to add "arm,primecell".
 		 */
-		compatible = "arm,coresight-replicator";
+		compatible = "arm,coresight-static-replicator";
 
 		out-ports {
 			#address-cells = <1>;
@@ -454,7 +454,7 @@
 		/* non-configurable replicators don't show up on the
 		 * AMBA bus.  As such no need to add "arm,primecell".
 		 */
-		compatible = "arm,coresight-replicator";
+		compatible = "arm,coresight-static-replicator";
 
 		out-ports {
 			#address-cells = <1>;
@@ -485,7 +485,7 @@
 	};
 
 	funnel@0,e3c41000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0xe3c41000 0 0x1000>;
 
 		clocks = <&clk_375m>;
@@ -534,7 +534,7 @@
 	};
 
 	funnel@0,e3c81000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0xe3c81000 0 0x1000>;
 
 		clocks = <&clk_375m>;
@@ -583,7 +583,7 @@
 	};
 
 	funnel@0,e3cc1000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0xe3cc1000 0 0x1000>;
 
 		clocks = <&clk_375m>;
@@ -632,7 +632,7 @@
 	};
 
 	funnel@0,e3d01000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0xe3d01000 0 0x1000>;
 
 		clocks = <&clk_375m>;
@@ -681,7 +681,7 @@
 	};
 
 	funnel@0,e3c04000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0xe3c04000 0 0x1000>;
 
 		clocks = <&clk_375m>;
-- 
2.17.1

