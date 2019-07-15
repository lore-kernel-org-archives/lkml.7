Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A41C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAC320659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHzRqMNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbfGOTrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:47:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38311 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbfGOTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:47:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so17494508ljg.5;
        Mon, 15 Jul 2019 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oaNB0VgkMqI8KUwi7PlCweQO0YQshFa6AuDy+Xlrvbc=;
        b=SHzRqMNssN9zD/fxMNN6o1A/GEZiSVjztNuB5oMkDnFtlr1bstxTTiEIN6m5iZQGjA
         G9QqvEBy9BZV1fsI+Q9rozw4vphWO9PKVXlIwZOLpSIVdT2xsyArolO1gOOlXQQOL7Pc
         gOivW5CQ/E5dtveUQjBi2lHSwiDYredfR3mozN9N7dbxFSCnxDJNPlSx393YeL5JMNxM
         4fd8rjTqvQxamw9h1MB53IVsChOO3h548mpZC7yW0cSqcJ5w+lrlZcO6JwJYyVlirfb0
         fMfKPYrDVtpwSHqGOkbTGRWVv+a46i1SCU57Ts/u7rLZFDa5ZgHZBBklc15LBFvWOybN
         b2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oaNB0VgkMqI8KUwi7PlCweQO0YQshFa6AuDy+Xlrvbc=;
        b=Y5K3WMUy+9m7qyf2zBw2MTLzFeAMeYTzvRG6mdUmfEHcsSCeCUgpnnqApII581Knyk
         Ekgbx/v84XBErnb+ubv/SvZnZw/AONcoL1hJIqOef5zsO64E/u5ExUYOEYMm7GoRWfAb
         EWHwQq6KGRUIM6oTYBbkTHPiUIIUPvMS5qY6L3dj+Bo8eTiIzkVfrH+o9UFUqLEhjbIA
         uP8W2Wpgnr9uBjdhpYYiJYO19ziMfZWeIMl7YuakuMUGw5fjInG1NNYzTWBNAutlZ9By
         dvbY2WOm7ELWuKLjO6zD8Z19xLfGQ5CK6+X5K+vVj0iBcu0WnD+q2cf23O4eyHqaPojI
         UyAQ==
X-Gm-Message-State: APjAAAXko7jCiNfLsuTUriy4IsXvM/7+l2IZM3sK+GxE8wppreH/OXhX
        ggXHltRr9MI1NYRvq3LEM4w=
X-Google-Smtp-Source: APXvYqwAsNrDgVbitSg/0VhSVCFXY7Bg80Sio7mq7FHvgSLvZ4al1o6jo1zYUyYjYpvLQurZGQgAJA==
X-Received: by 2002:a2e:9c19:: with SMTP id s25mr14739967lji.188.1563220025884;
        Mon, 15 Jul 2019 12:47:05 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id y15sm2457311lfg.43.2019.07.15.12.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 12:47:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: regulator: Document regulators coupling of NVIDIA Tegra20/30 SoCs
Date:   Mon, 15 Jul 2019 22:45:01 +0300
Message-Id: <20190715194503.19100-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715194503.19100-1-digetx@gmail.com>
References: <20190715194503.19100-1-digetx@gmail.com>
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

