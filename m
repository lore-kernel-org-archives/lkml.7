Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C992C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EB6229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecyOax51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbfGYPVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:21:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40123 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388803AbfGYPU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:20:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so34831508lff.7;
        Thu, 25 Jul 2019 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oaNB0VgkMqI8KUwi7PlCweQO0YQshFa6AuDy+Xlrvbc=;
        b=ecyOax51arbftnrVqm0+kTLuexojyaUDmTHohNaSbOrzgwtR0npPQzqNfEPP6PQSMz
         sMTyiv627gamhDyF+i4noFlEuYBnNg4VYyd7uFGkEIFXWXsa0ld3TcZCH/dAWdPwqg6u
         UOH7bGPokgkSAUeX1UxA9iXwcCOowy+L2OEpVeId7YuogVN+QI1ftQ12MwzLkEXsDK5n
         MQbZnDK+Xp4ZKkR9FeNpGeLyxYXHP7uiFYask8I7/O1lONE7iUW+6ZoGNj5OXrmzvXmX
         anMCToTQjekD/kDniETJS5hmMM7Zvcrc6x3cqI/gqqi+MWch1nSRZ35CupfYCdkUzudY
         OK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oaNB0VgkMqI8KUwi7PlCweQO0YQshFa6AuDy+Xlrvbc=;
        b=jQXMRJMn0zAyxDE8K7rg1cxBerefjC19wfnsnPpDwuYAW4nGj0X924X+JibCj+hHKd
         u9APl188gJGrQGESrYDVrFA/DNHllMxWMhNNKYqqo2j2gozaM4vVV2525RjwR9SxIAbK
         vunj8H1UMeFJEE3JoxQMBliWHKvibP5jgfjnf4J5F6BRTXi5DlLumECmTGhJ9GUij0MK
         aTBca4u11xvrzWbwvFG2U8eW8e4rg/RtpyyxLZHbWdJN0YakxhwMxvtc4Zt+EXqrBizt
         bBjiRJOs8nywZXqMB5jGSWiuylQ3lm2sxMeHxOAcO7bIfranKAdmv/0cJLLzSvPsj8Nl
         ADkg==
X-Gm-Message-State: APjAAAXbpCE+/AipGYBLok7teJhbcRfagnOD2jTxAHjXpF3/OHPO0QL+
        /D5+srZRqmY7rUl47mDA1s40ZmhH
X-Google-Smtp-Source: APXvYqwjqJ+TYb1I+mdF1Lhyep7vnPZbAe5TlKlYYDRw5+1Lp0A+4MAnSypPB8U/oKPeMeu2du0Bjw==
X-Received: by 2002:ac2:4839:: with SMTP id 25mr41599465lft.79.1564068057143;
        Thu, 25 Jul 2019 08:20:57 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id e87sm10452281ljf.54.2019.07.25.08.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:20:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: regulator: Document regulators coupling of NVIDIA Tegra20/30 SoCs
Date:   Thu, 25 Jul 2019 18:18:30 +0300
Message-Id: <20190725151832.9802-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190725151832.9802-1-digetx@gmail.com>
References: <20190725151832.9802-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is voltage coupling between three regulators on Tegra20 boards and
between two on Tegra30. The voltage coupling is a SoC-level feature and
thus it is mandatory and common for all of the Tegra boards.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../nvidia,tegra-regulators-coupling.txt      | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt

diff --git a/Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt b/Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
new file mode 100644
index 000000000000..4bf2dbf7c6cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
@@ -0,0 +1,65 @@
+NVIDIA Tegra Regulators Coupling
+================================
+
+NVIDIA Tegra SoC's have a mandatory voltage-coupling between regulators.
+Thus on Tegra20 there are 3 coupled regulators and on NVIDIA Tegra30
+there are 2.
+
+Tegra20 voltage coupling
+------------------------
+
+On Tegra20 SoC's there are 3 coupled regulators: CORE, RTC and CPU.
+The CORE and RTC voltages shall be in a range of 170mV from each other
+and they both shall be higher than the CPU voltage by at least 120mV.
+
+Tegra30 voltage coupling
+------------------------
+
+On Tegra30 SoC's there are 2 coupled regulators: CORE and CPU. The CORE
+and CPU voltages shall be in a range of 300mV from each other and CORE
+voltage shall be higher than the CPU by N mV, where N depends on the CPU
+voltage.
+
+Required properties:
+- nvidia,tegra-core-regulator: Boolean property that designates regulator
+  as the "Core domain" voltage regulator.
+- nvidia,tegra-rtc-regulator: Boolean property that designates regulator
+  as the "RTC domain" voltage regulator.
+- nvidia,tegra-cpu-regulator: Boolean property that designates regulator
+  as the "CPU domain" voltage regulator.
+
+Example:
+
+	pmic {
+		regulators {
+			core_vdd_reg: core {
+				regulator-name = "vdd_core";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-coupled-with = <&rtc_vdd_reg &cpu_vdd_reg>;
+				regulator-coupled-max-spread = <170000 550000>;
+
+				nvidia,tegra-core-regulator;
+			};
+
+			rtc_vdd_reg: rtc {
+				regulator-name = "vdd_rtc";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-coupled-with = <&core_vdd_reg &cpu_vdd_reg>;
+				regulator-coupled-max-spread = <170000 550000>;
+
+				nvidia,tegra-rtc-regulator;
+			};
+
+			cpu_vdd_reg: cpu {
+				regulator-name = "vdd_cpu";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1125000>;
+				regulator-coupled-with = <&core_vdd_reg &rtc_vdd_reg>;
+				regulator-coupled-max-spread = <550000 550000>;
+
+				nvidia,tegra-cpu-regulator;
+			};
+		};
+	};
-- 
2.22.0

