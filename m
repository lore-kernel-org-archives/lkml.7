Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1070BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C2820B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfJIHHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:07:25 -0400
Received: from hera.iit.uni-miskolc.hu ([193.6.5.4]:34756 "EHLO
        hera.iit.uni-miskolc.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJIHHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:07:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTP id D7BDE1F83;
        Wed,  9 Oct 2019 08:19:30 +0200 (CEST)
X-Virus-Scanned: Kamavis at iit.uni-miskolc.hu
Received: from hera.iit.uni-miskolc.hu ([127.0.0.1])
        by localhost (hera.iit.uni-miskolc.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NUBQPBRn3Pgm; Wed,  9 Oct 2019 08:19:22 +0200 (CEST)
Received: from titan.hitronhub.home (unknown [IPv6:2a02:8109:a180:54c:226:9eff:fe30:2af8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: szucst@iit.uni-miskolc.hu)
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTPSA id C03BA1F84;
        Wed,  9 Oct 2019 08:19:16 +0200 (CEST)
From:   =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH] arm64: tegra: enable PWM fan on Jetson Nano
Date:   Wed,  9 Oct 2019 08:18:55 +0200
Message-Id: <20191009061855.4415-1-tszucs@protonmail.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PWM fan and extend CPU thermal zones for monitoring and fan control.
This will trigger the PWM fan on J15 and cool down the system if necessary.

Signed-off-by: Tamás Szűcs <tszucs@protonmail.ch>
---
 .../boot/dts/nvidia/tegra210-p3450-0000.dts   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index 9d17ec707bce..43c3613e7217 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -552,6 +552,70 @@
 		};
 	};
 
+	fan: fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm 3 45334>;
+
+		cooling-levels = <0 64 128 255>;
+		#cooling-cells = <2>;
+	};
+
+	thermal-zones {
+		cpu {
+			polling-delay = <0>;
+			polling-delay-passive = <500>;
+			status = "okay";
+
+			trips {
+				cpu_trip_critical: critical {
+					temperature = <96500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				cpu_trip_hot: hot {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_trip_active: active {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_trip_passive: passive {
+					temperature = <30000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				cpu-critical {
+					cooling-device = <&fan 3 3>;
+					trip = <&cpu_trip_critical>;
+				};
+
+				cpu-hot {
+					cooling-device = <&fan 2 2>;
+					trip = <&cpu_trip_hot>;
+				};
+
+				cpu-active {
+					cooling-device = <&fan 1 1>;
+					trip = <&cpu_trip_active>;
+				};
+
+				cpu-passive {
+					cooling-device = <&fan 0 0>;
+					trip = <&cpu_trip_passive>;
+				};
+			};
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
-- 
2.20.1

