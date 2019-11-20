Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CB9C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBEB21906
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IBafvk3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfKTLlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:41:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36941 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbfKTLlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:41:19 -0500
Received: by mail-pj1-f66.google.com with SMTP id f3so4004998pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XG3FqVuwcEK3cEEdmwlKOUvSjQLzYWodVEQZQZxdgGw=;
        b=IBafvk3nhhoTcsHRx+LcFptem/D7w/nySgOpIqNTdynBSbozJ6gJW3N4d5echRt1Y6
         rqZAnABzdwU3cKUigi+mvaFbMw3RMTDMZ1tZAiOkC3tChk9sECnN/o98UDtHYY4APYsH
         vQfV8IJL3KN8+dWtPnrjWI3WtARRXUaEe6Q8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XG3FqVuwcEK3cEEdmwlKOUvSjQLzYWodVEQZQZxdgGw=;
        b=rjze6BBiF9mUxejxr7Bpi/sPazv6MffJiZoB6+wcf/Q1qWV5C+ss1Ft2ONwQuIlcJH
         vZh1oUt3Caze6D0U2mYmzF+3smdxPFvT0S6p2B4SbMP6d94puFjNCacblJQoBwXP5dQR
         uuOD+nHphXtdJLTWCwAYK/CtG0rwVR5noYZdVt4I5Suu3wlM/+u2S4MNEfh4+ZUmUnZ+
         9MjNfHXuGENp0RaE2Tt0RtIvEMUI2X/bk12X0ht7OQVd4HXAULYPwj0WIhvAGLz5P7w/
         I0TkTA1xIgzDrJ4WtqoJetopVQKRaysJiFAtpiXpOaf8rstS48e3MzmKl00KE+fXjwgR
         0I+Q==
X-Gm-Message-State: APjAAAUYHe1i4eiVKdYal/5qfwzBL8iGlVkfTjsLfFUmN6CBGiUZH3Xw
        UNiD3zJ2Pk6rEsmpx7qvUgYYiQ==
X-Google-Smtp-Source: APXvYqxKa0jSG5czR1wxW5TZYm5l7Yz1+Q3BK+S6kuzHUAq2+gY5d3tie4YLeCiftc91wuh1LEOH7Q==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr2526359pla.8.1574250078726;
        Wed, 20 Nov 2019 03:41:18 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id h185sm13492850pgc.87.2019.11.20.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:41:18 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 5/5] arm64: dts: rockchip: Add Radxa Rock Pi N10 initial support
Date:   Wed, 20 Nov 2019 17:09:23 +0530
Message-Id: <20191120113923.11685-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191120113923.11685-1-jagan@amarulasolutions.com>
References: <20191120113923.11685-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi N10 is a Rockchip RK3399Pro based SBC, which has
- VMARC RK3399Pro SOM (as per SMARC standard) from Vamrs.
- Compatible carrier board from Radxa.

VAMRC RK3399Pro SOM need to mount on top of Radxa carrier
board for making Rock Pi N10 SBC.

So, add initial support for Rock Pi N10 by including rk3399,
rk3399pro vamrc-som and raxda carrier board dtsi files.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/rockchip/Makefile           |  1 +
 .../boot/dts/rockchip/rk3399pro-rock-pi-n10.dts | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 48fb631d5451..433033b18170 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -36,3 +36,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
new file mode 100644
index 000000000000..1f7fbaa92c38
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2019 Radxa Limited
+ * Copyright (c) 2019 Amarula Solutions(India)
+ */
+
+/dts-v1/;
+#include "rk3399.dtsi"
+#include "rk3399-opp.dtsi"
+#include "rk3399pro-vmarc-som.dtsi"
+#include <arm/rockchip-radxa-carrierboard.dtsi>
+
+/ {
+	model = "Radxa ROCK Pi N10";
+	compatible = "radxa,rockpi-n10", "rockchip,rk3399pro";
+};
-- 
2.18.0.321.gffc6fa0e3

