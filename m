Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE07C04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38BF2438C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+zrXfoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfFCX77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:59:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44945 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFCX7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:59:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id p67so1447686ljp.11;
        Mon, 03 Jun 2019 16:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbAnG1ukmFrVLshCHIYe2HYKWfeDtwUMPfwzK17P4oA=;
        b=k+zrXfoEnxlAO9IenKfFHydTCpzJUnvI982gF47BQ7RLhRBDgXQMTXwO/PtKtzfK1n
         Npwup4gfqFCzMCjlk/Co+w/kToM1S9skAH12LCMn22yRzJnK6gQkNn2Y9e28xbDpJiw6
         oiXOBbJd83Gu5rASRrzT3RbmH+OA8Bin+Syn9uNBHCVXDs3+XmDmUOme6tQ9E4ZQr2kG
         x9ERUSqzn5MWg4qOPEoelAgU4yuz9KWsea6uHiXYpq6rdJ6HvRWXxg40AwLwXEF3Y+x9
         JAyuvhwvPx5XnK6Jk8IBi6rLG7DEAgyX58snRBArMKP9KdydnHzXiQftXFnPJd5UeR1X
         0nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbAnG1ukmFrVLshCHIYe2HYKWfeDtwUMPfwzK17P4oA=;
        b=DfhIL+tX5wyjs6i4o76HiwOtMiXNgmdctsxwCCbzjIPtknHV077HZKDxTXPcCZ/nrF
         pgbtx/4lFmImLovH8sF2/f1aWNk90EDFoYFIRjGMDKS3lk4LqhoXsNXq7wQMaCHfAfT9
         MIZDEWJtkk28iRFkoxBKL2pT6u6uvcH+FKhhXiOeHsaABsZ3lTlZkUr73jIMXUnztDjD
         vn0ObTP4I36XZ9uwN6IrBMy6XtlmDFJl+BT9KprgkvM5FeCgsaDhO8BfjDbLvXpU+Xs9
         ASp5UBAefY3UfcUPf/YOfqhcS8D54Q47duLzjFGkWbll3mLalEt/KzhWrGRnTa17KThT
         ENKA==
X-Gm-Message-State: APjAAAXaIuQoNHPEf6AL7xb4HWDuP6+NTKeYLKG6nX3MLrXAy0vVOAVb
        0V84zIAAQI9Su2NHnONwPtc=
X-Google-Smtp-Source: APXvYqxO8WhPwnhQSc6b/afFwpUtyVxz6gF1vBB882gzjp1HdWg0fEKNzr7AxVor+RrTyxfs5v0/4Q==
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr15509785ljj.168.1559606391766;
        Mon, 03 Jun 2019 16:59:51 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id n7sm2943151lfi.68.2019.06.03.16.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 16:59:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] dt-bindings: regulator: Document regulators coupling of NVIDIA Tegra20/30 SoC's
Date:   Tue,  4 Jun 2019 02:59:01 +0300
Message-Id: <20190603235904.19097-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603235904.19097-1-digetx@gmail.com>
References: <20190603235904.19097-1-digetx@gmail.com>
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
2.21.0

