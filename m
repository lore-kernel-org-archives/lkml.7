Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB76BC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7554206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nKEfuAB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfL3MAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 07:00:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38803 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfL3MAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 07:00:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so17891352pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 04:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezrVDS5UNFy526/k6xxwjbva2ps41hVNTGiteYBwEkE=;
        b=nKEfuAB6AxAjy1HQQ5U3+ZB9VsG0LkmLXSDo5Wyk3qnHrCDiUqy0E4kNmXeZWLT6JI
         u0s5HnERvkbFXI3lliq4dAaCUOgywP90OlnMIvmSl7humnVVlTiMcBVuPJmXBRlxCPpa
         +Aah8BUmEYRwB3Rie2QVCVr22m2FQwGCPF02w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezrVDS5UNFy526/k6xxwjbva2ps41hVNTGiteYBwEkE=;
        b=KVEA/EeHgw/xQWSOBI1+Iy2oL6qwD2TnBruR+J5fG4RFYvixQAEVqR2GvOiwyMMwT7
         PHe9ip/9k/e0Ngc8IqQhQxm+7dCSUjebWvAAFCUaGNCSxVVnoxVyrgRTSxQ40HrZ2PmC
         dg3B/OygoVL2ngHy1fU9jbDOPSinQDPns/1JttOyTEO5AfNjRUXFSk37c5rEKmQYKOz9
         D5Mrrr58ujoPDsyle4hrvaFn8BS/Ony2SlJqVhl6dpudF+95S9ljjmuZecKGKqPvX37E
         lDmarFOa+6T0P96+O/FygMWqmP3xBX/sJmeFCpJJmvR58CCFCxvEYGGhAY2CGF7fI8ZA
         v0BQ==
X-Gm-Message-State: APjAAAVs5uZ98MFPWIK1rcv7dSu29sqgEKpUevAwP0EVz4E6KahA/fuo
        6osi22MyyX6WfshNlcTWi97rIw==
X-Google-Smtp-Source: APXvYqz3WmGiAkWomBOwfRYvqVaLlN3X2e+0i07536YKbLHagirtJCCzdsXri4tRkucoNaHJ33cBdQ==
X-Received: by 2002:a63:447:: with SMTP id 68mr73426628pge.364.1577707240026;
        Mon, 30 Dec 2019 04:00:40 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.131])
        by smtp.gmail.com with ESMTPSA id 7sm41894122pfx.52.2019.12.30.04.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 04:00:39 -0800 (PST)
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
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v2 1/3] ARM: dts: imx6q-icore-mipi: Use 1.5 version of i.Core MX6DL
Date:   Mon, 30 Dec 2019 17:30:19 +0530
Message-Id: <20191230120021.32630-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EDIMM STARTER KIT i.Core 1.5 MIPI Evaluation is based on
the 1.5 version of the i.Core MX6 cpu module. The 1.5 version
differs from the original one for a few details, including the
ethernet PHY interface clock provider.

With this commit, the ethernet interface works properly:
SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver

While before using the 1.5 version, ethernet failed to startup
do to un-clocked PHY interface:
fec 2188000.ethernet eth0: could not attach to PHY

Similar fix has merged for i.Core MX6Q but missed to update for DL.

Fixes: a8039f2dd089 ("ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support")
Cc: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Add Michael s-o-b

 arch/arm/boot/dts/imx6dl-icore-mipi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-icore-mipi.dts b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
index e43bccb78ab2..d8f3821a0ffd 100644
--- a/arch/arm/boot/dts/imx6dl-icore-mipi.dts
+++ b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
-#include "imx6qdl-icore.dtsi"
+#include "imx6qdl-icore-1.5.dtsi"
 
 / {
 	model = "Engicam i.CoreM6 DualLite/Solo MIPI Starter Kit";
-- 
2.18.0.321.gffc6fa0e3

