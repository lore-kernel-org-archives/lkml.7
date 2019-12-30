Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA60C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52386206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kRfxtsSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfL3MAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 07:00:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55389 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfL3MAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 07:00:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so7716424pjz.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 04:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jyGtSwgFvChJP9qUZS2htQwi6EMpdKF3tyPpfkjOp/g=;
        b=kRfxtsSQsCzNL6Ua0j2ypLxHJstPdl236RB2VNQVC5gW+22hcGhM+5D7MZFjSa1SEI
         1dDUfqZXoBHdUi0Jan/MPE1Ngh3iDojG+N0qlf/8vYy2/R1gWj/wL2cUaBvfm1sIbiVc
         r66m1tnlizpFIEZyZajhiQxzf1uNufYWMgR9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyGtSwgFvChJP9qUZS2htQwi6EMpdKF3tyPpfkjOp/g=;
        b=h0C7dyqU2tdtbGLBNiYHfMB+yvVqcofOpkp9YwrT7dojmI2GJFnsni3jFmGRqsh0/t
         Hc3C3GFFqs1Y+TwAh4NakIQl5FgowU1llCuJDdIf6rOgd2j1bvWbazshfHBJQxfJj2/q
         9P7eDQ55f74PHjp35O60oBx+Of7Dg63GlHwFUNBV76grNVBDoc8KOdvZd7K9h4BKTxce
         /6Wwel3Ojo5QGJO10RyqVA6cxhcS5YLNHyhOOAvML3rGG9J7aQFqlpM07PDO2Tf737AN
         FEASyxUklumU2lp6GUyw40l+ISvUBFa565LSROLKU2T6u1od9e3IeA75dPjbmX8hwqoU
         jQUA==
X-Gm-Message-State: APjAAAWfIIaILirfHhkFcsvuz3YDnsqW/iAfxtz74+YnZur+iQwSchx5
        aM9t0s9btJA33SuGtoKc514o1Q==
X-Google-Smtp-Source: APXvYqyRLv5fCREtyDwQJMehOfppISQaH6t1nBy3584eULSwQjPKdOuLZiBf4pLQnKYlRI2BVoOmDA==
X-Received: by 2002:a17:90a:930f:: with SMTP id p15mr46096254pjo.2.1577707245545;
        Mon, 30 Dec 2019 04:00:45 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.131])
        by smtp.gmail.com with ESMTPSA id 7sm41894122pfx.52.2019.12.30.04.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 04:00:45 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl-icore-1.5: Remove duplicate phy reset methods
Date:   Mon, 30 Dec 2019 17:30:20 +0530
Message-Id: <20191230120021.32630-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191230120021.32630-1-jagan@amarulasolutions.com>
References: <20191230120021.32630-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Engicam i.CoreM6 1.5 Quad/Dual MIPI dtsi is reusing fec node
from Engicam i.CoreM6 dtsi but have sampe copy of phy-reset-gpio
and phy-mode properties.

So, drop this phy reset methods from imx6qdl-icore-1.5 dsti file.

Cc: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch.

 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi b/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
index d91d46b5898f..0fd7f2e24d9c 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
@@ -25,10 +25,8 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	clocks = <&clks IMX6QDL_CLK_ENET>,
 		 <&clks IMX6QDL_CLK_ENET>,
 		 <&clks IMX6QDL_CLK_ENET_REF>;
-	phy-mode = "rmii";
 	status = "okay";
 };
-- 
2.18.0.321.gffc6fa0e3

