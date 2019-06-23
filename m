Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B382C48BE4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 21:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB97C206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 21:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+YAUT/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfFWVKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 17:10:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32853 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFWVKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 17:10:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so10636963ljg.0;
        Sun, 23 Jun 2019 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oaNB0VgkMqI8KUwi7PlCweQO0YQshFa6AuDy+Xlrvbc=;
        b=H+YAUT/B8cryPNK5EDaq+LtoW6joAetYRIuIsSJ5ed322Vpu/4CdVXIsoCmNaG7x4U
         xugBjkrQpBfqQUkzJ32nV0qfC2ri92xIm9GNeUAb+Om2kqhIyf3akxEnY1ZdJqd1vqI6
         HAXsGgTwxa6dp/3yCYSMpVf6vOSEJ0i8kSiBBm9kTNO7ZpCw7+cuzFH2koO6h1tPEfmC
         3q+wrGRfFZDbeUz0qdKkjNnx/bOlD+A8VF/qew4KX7eqdVj/ApuIke3fSLcvWrbMxZlY
         EhzorK5n+XE/j137KlnFFzNlMDgZLw04nZBT88Emv93hIgKSjB6e0JbY+HjDJoWEACds
         3a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oaNB0VgkMqI8KUwi7PlCweQO0YQshFa6AuDy+Xlrvbc=;
        b=s6JPgXFWDXGH56yGpP+MEcgLpzjem1z0UvG7r/XhdHzjEpnkgTkt2bSDql7mBpI1fF
         ul3CUApzyhJM2Q934AJIe1ERAIP8Yi/GsfbrFYqa7k5EbU6UULJelsS+rwE5oK1qduwJ
         NKY18nk+DtdFK8/gkBJXK9vMr4dklkU5JsXMajC+Y7JotKmyIg3gshTcOrBZik1da2Yp
         pUio37O2EnzfQdW4EF2LUMw7bnyTX30slcHSJ5q8xZEOCMfbHAmHlzBAeEKvTs+dKIMN
         5fwUyQrVgL+KlIzawoTDPJFr9CWH10iQzT0Ok2JLZ5V70iFJFbb3C+21pXKnqA96dG2Y
         Pw1w==
X-Gm-Message-State: APjAAAUluB8FsrQmraEYIJ3Os9SPCULGuDy3CzEsSBUesad2z06Bj3Dr
        sWm90NxSA8vwE+7+qzEAkwk=
X-Google-Smtp-Source: APXvYqxZzQkcPCPYZGOtz2Z1ARbNMV1KmySo8pc0DpoGiL+myC1utaacyggmVvU7KYe71eO3jNb+1Q==
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr10269105ljs.54.1561324231686;
        Sun, 23 Jun 2019 14:10:31 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id b11sm1431125ljf.8.2019.06.23.14.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:10:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] dt-bindings: regulator: Document regulators coupling of NVIDIA Tegra20/30 SoCs
Date:   Mon, 24 Jun 2019 00:08:33 +0300
Message-Id: <20190623210835.26281-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623210835.26281-1-digetx@gmail.com>
References: <20190623210835.26281-1-digetx@gmail.com>
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

