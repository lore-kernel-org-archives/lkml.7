Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B968C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A39621871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570553970;
	bh=dF2A6bAxUEMaFmUvUj+ll27edvmItLZmDILm3HS9nUU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UVUXpk2+NG2w7upsCccWKSjOlQ7FDTrV7n6dHMlSKHcM9CZKmszXfFKvPwS2M58ME
	 jxndFIYX2I/xG72oRlVfy9wnpZDEPl+T9IAQ8T7Xw6yBDzHWMB6dO/I+2UUAnLaCu+
	 kmTInJQtlJVY8ISVeABBjlfXhrWchK+qa/47XJa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfJHQ73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfJHQ73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:59:29 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634C52070B;
        Tue,  8 Oct 2019 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570553968;
        bh=dF2A6bAxUEMaFmUvUj+ll27edvmItLZmDILm3HS9nUU=;
        h=From:To:Cc:Subject:Date:From;
        b=V4ydDdEHj1By7ZtTlpkr4meoeVJ4FOr6t7JqgJ1lyGLu/DQS6rrRwpS43Nw2hXpST
         AJ9gGuDKkQ8oi5rE/w/uiyjwLpSO06r5OmwB8XiZ+yJExHgJdhRTP7EioFtGRYqwbE
         2tZ+B8De839x222LyU2u8aj7JQ5R5C/Z5E5+71hU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lihua Yao <ylhuajnu@outlook.com>
Subject: [PATCH] ARM: dts: s3c64xx: Fix init order of clock providers
Date:   Tue,  8 Oct 2019 18:59:17 +0200
Message-Id: <20191008165917.23908-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lihua Yao <ylhuajnu@outlook.com>

fin_pll is the parent of clock-controller@7e00f000, specify
the dependency to ensure proper initialization order of clock
providers.

without this patch:
[    0.000000] S3C6410 clocks: apll = 0, mpll = 0
[    0.000000]  epll = 0, arm_clk = 0

with this patch:
[    0.000000] S3C6410 clocks: apll = 532000000, mpll = 532000000
[    0.000000]  epll = 24000000, arm_clk = 532000000

Fixes: 3f6d439f2022 ("clk: reverse default clk provider initialization order in of_clk_init()")
Signed-off-by: Lihua Yao <ylhuajnu@outlook.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Sending in author's name because outlook bounces from the lists.
---
 arch/arm/boot/dts/s3c6410-mini6410.dts | 4 ++++
 arch/arm/boot/dts/s3c6410-smdk6410.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 0e159c884f97..1aeac33b0d34 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -165,6 +165,10 @@
 	};
 };
 
+&clocks {
+	clocks = <&fin_pll>;
+};
+
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
diff --git a/arch/arm/boot/dts/s3c6410-smdk6410.dts b/arch/arm/boot/dts/s3c6410-smdk6410.dts
index a9a5689dc462..3bf6c450a26e 100644
--- a/arch/arm/boot/dts/s3c6410-smdk6410.dts
+++ b/arch/arm/boot/dts/s3c6410-smdk6410.dts
@@ -69,6 +69,10 @@
 	};
 };
 
+&clocks {
+	clocks = <&fin_pll>;
+};
+
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
-- 
2.17.1

