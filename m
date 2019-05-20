Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2133AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA66C206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDe6R5++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfETKM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:12:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33218 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbfETKMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:12:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so7014238pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=psGipp4xyvA6ITMw9MQePCESgWaNPblRsxWV83tCX+4=;
        b=DDe6R5++Fzja9VoGMt+SiLItI4KCRzkHl1b612rdgS5J8T5Qo1eIV3EEf38bAPOSdX
         TBv+I1VgFq1YeFO/fFRQRdPJ6yP5ucgrpKCWk5BCNuPPINN0PWn5aD6QgPmuzNveadlu
         z5b/l/Apk0KMKQQSP15dUy5V2i24M/9JCfl6AGpouxMxxq6jpBGZeJEGhmp0DVEJ9Mgc
         rViySazF3M83zMmXn0ze7FWpzMkzuWVcq1y77Ry53gK5IVKl7fWbhNWrcXAeaEaEwgZo
         IL+bDsrmOJ7riSZ/XjjTj9qBDLdOzEOWfW39uNyHzXJfoylddvQhKcTfId6Sn3+7lWo+
         k4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=psGipp4xyvA6ITMw9MQePCESgWaNPblRsxWV83tCX+4=;
        b=RROmkIk6ym3MvGH2BKgopS+vg0WEqOK5Du7yl08Hg9hzaapEmD70ruajyNTM+o2cDO
         mH3W9AHw6uIOKYnOHIEm9yYemefBcWg9Mt9z6Li/Ajj0Xjv5pK733Xi2LcSinZa3vh/v
         lGElNz4B5VPq4MV0rMg4nMl7PqMSfIYaGYAAl4GW5e0fIcVkuSOri03RVRSl6U+ec8Dx
         49x0qsP63yj328M/seuVje3JWs7tln6vzsdWNOWfJM5uxS1TUz0JWfOuBBSWP05YLyZJ
         xWUMFh3BpnHVe7fZbvtn9NWai4qtMMr1RzznmddBlZvDucZbXAKxWldyLVeBG7Ex8RrX
         UKQQ==
X-Gm-Message-State: APjAAAVOPXrGYyXd6HQL8fimU2p0mjNEo81l3Dy51SlFOyc2DYVczLjE
        s1r/YsBxrAb133luKnX/afWN2w==
X-Google-Smtp-Source: APXvYqyJUQl1Mf5fAZLcOV0IUUXJWaBCvUX3etV6Sos7Hp/LITH/u60ghjIXaOUVvU/apfO53ZFuRA==
X-Received: by 2002:a63:d54f:: with SMTP id v15mr33040134pgi.107.1558347174204;
        Mon, 20 May 2019 03:12:54 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:12:53 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 7/9] dt-bindings: mmc: sprd: Add PHY DLL delay documentation
Date:   Mon, 20 May 2019 18:12:00 +0800
Message-Id: <96f4304c001c0cf81ecc6bec69665d239203b9b7.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce some PHY DLL delays properties to help to sample the PHY clock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
index a285c77..e675397 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
@@ -20,6 +20,23 @@ Optional properties:
 - assigned-clocks: the same with "sdio" clock
 - assigned-clock-parents: the default parent of "sdio" clock
 
+PHY DLL delays are used to delay the data valid window, and align the window
+to sampling clock. PHY DLL delays can be configured by following properties,
+and each property contains 4 cells which are used to configure the clock data
+write line delay value, clock read command line delay value, clock read data
+positive edge delay value and clock read data negative edge delay value.
+Each cell's delay value unit is cycle of the PHY clock.
+
+- sprd,phy-delay-legacy: Delay value for legacy timing.
+- sprd,phy-delay-sd-highspeed: Delay value for SD high-speed timing.
+- sprd,phy-delay-sd-uhs-sdr50: Delay value for SD UHS SDR50 timing.
+- sprd,phy-delay-sd-uhs-sdr104: Delay value for SD UHS SDR50 timing.
+- sprd,phy-delay-mmc-highspeed: Delay value for MMC high-speed timing.
+- sprd,phy-delay-mmc-ddr52: Delay value for MMC DDR52 timing.
+- sprd,phy-delay-mmc-hs200: Delay value for MMC HS200 timing.
+- sprd,phy-delay-mmc-hs400: Delay value for MMC HS400 timing.
+- sprd,phy-delay-mmc-hs400es: Delay value for MMC HS400 enhanced strobe timing.
+
 Examples:
 
 sdio0: sdio@20600000 {
@@ -33,6 +50,7 @@ sdio0: sdio@20600000 {
 	assigned-clocks = <&ap_clk CLK_EMMC_2X>;
 	assigned-clock-parents = <&rpll CLK_RPLL_390M>;
 
+	sprd,phy-delay-sd-uhs-sdr104 = <0x3f 0x7f 0x2e 0x2e>;
 	bus-width = <8>;
 	non-removable;
 	no-sdio;
-- 
1.7.9.5

