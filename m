Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62814C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319682184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs+e9alO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfDKWbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:31:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37499 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDKWbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:31:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id v13so7027745ljk.4;
        Thu, 11 Apr 2019 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzQYKWqRiMIwYTZEU2+xPBYnCJG0pAdE5CNZZIOMB2s=;
        b=Zs+e9alOdrUn2QEc8cJJ9Ci9czZi8LxQ+rpzVFPZvY7HPGMbNzsuhZIKXSDfQmSMZb
         r28+emU2odU8YUmTA1C2Bpj4vSfDBQezsiwaWR7UZkuOSPr5zmrzG4ECkf/obeGQf3Cp
         JzuqdhmggUcFSFCLA0f5RQ3I0JPeOzcF9/g2JDGl+jNuqs+KwMwPCSwH0u5tgPxLXgOT
         IThWNs544dp9mm+4r6g0ZRjWvM47WvvOVv6sdYKBRoTXnqKKmddTPScos3KXZWVND66N
         lVsRids9mxkscguTmG+zPvXdgULij0E7+Ke7nwwMYBQUR4BKx/gTfEGHD/O58eaB053D
         MYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzQYKWqRiMIwYTZEU2+xPBYnCJG0pAdE5CNZZIOMB2s=;
        b=QN+9ePilgrdl7vh2/fBdkpB48WXb9vDJOtZTujqmZWC4p+/CcL6wweEfdahbcsK7nO
         amhhrEMEGXzlK69savkphWm9OuP16rlS8OzJXK2vaLwbaP+mL/9ijpOlNy69BX96K9v7
         TExD5iAFvRvvA5cGtbmubC69dVQpYcA5ppLNWF+VopI2nXg9d48JxJPxN9+6/LZXNMpT
         YVGPiWRThhLu0Jqm2ayFnFP6Kydhdfl8ZfjKQ/0Jfu74ewYvngZM/6WUGJ0bbTbU/cyQ
         8wUywa7SJXjOuLxzgkfkJaeLK/jEpBYvnIUxRQeDKEMAqAsbFihWw+b9l1bLLz/RGXdl
         rWNA==
X-Gm-Message-State: APjAAAVmBcHAViKrHtDKUb7b+1VjNaYmHfPZ1PWr3Iib/LAOPmVvXkEn
        wR5qQOkyXk70zW5kh6MeSQw=
X-Google-Smtp-Source: APXvYqyeU+DRsCnQbDbaVoXzr8fx587Lb2AsLZKjmGOshdQ3zyfkvq0z88gfBFz4i9p4DTFCZuwCeg==
X-Received: by 2002:a2e:8550:: with SMTP id u16mr6764203ljj.11.1555021859570;
        Thu, 11 Apr 2019 15:30:59 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id s26sm7948313ljj.52.2019.04.11.15.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:30:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1] ARM: dts: tegra30: Add ACTMON node
Date:   Fri, 12 Apr 2019 01:30:42 +0300
Message-Id: <20190411223042.25809-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACTMON node to the Tegra30's device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index d2b553f76719..e074258d4518 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -370,6 +370,17 @@
 		reg = <0x6000c000 0x150>; /* AHB Arbitration + Gizmo Controller */
 	};
 
+	actmon@6000c800 {
+		compatible = "nvidia,tegra30-actmon";
+		reg = <0x6000c800 0x400>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA30_CLK_ACTMON>,
+			 <&tegra_car TEGRA30_CLK_EMC>;
+		clock-names = "actmon", "emc";
+		resets = <&tegra_car TEGRA30_CLK_ACTMON>;
+		reset-names = "actmon";
+	};
+
 	gpio: gpio@6000d000 {
 		compatible = "nvidia,tegra30-gpio";
 		reg = <0x6000d000 0x1000>;
-- 
2.21.0

