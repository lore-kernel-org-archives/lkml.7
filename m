Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C9C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D541E20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr4ohbDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfDERaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:30:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44765 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbfDERaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:30:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so3631566pfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b8MdsrY8wn1unMunG5fO8xg6tFLnnMeursiPoS3s4Kw=;
        b=Dr4ohbDbUA/byTPuMbHNDk+RbqPQlrO7HtoEb2DFgjzFhRKy9PLU0ecU6M9WPtH91n
         mbfxROYDWD9r9LWRSBK+9e2nkJJHs1eUar9wrQRZ6oWCg1IaIKoPWEPhi/DZBCguwO51
         /NntSYT+YrzZDdZPsdHCJpH/J7JXFOQ5LJ1sO1em81JXLY5xTBtfwb/7aWf9CXOhx50/
         iPBqLwKqRxEXlWEtp8rz+ikOdufZNTIAinxpr/HSj10nTZV5mvGRDJMEK+gbXJcUQJ8i
         bz1Xk+JWXq6kCs+qQGj4S67LfwG6erpvxE0VURQcMhyBwLq+u2LMpE55dJ8QJOgXdCTD
         AswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b8MdsrY8wn1unMunG5fO8xg6tFLnnMeursiPoS3s4Kw=;
        b=p7pCY1xEnakxSlLQOAIxrTdOuWC8tkx1cF7S1G0mEro8qkodu1+kkeVcznhAfXzjxB
         bUJtPOh/0HHht5TVLUHJ7NWKZxY3oiHbZw+PTM9JvfLmVl85hTej0aQ86i8vFXFvBG5Z
         9Pq1lxD+dpp8CE9zHZW8uTAf50XnO13QCK/z2z8X2Dh7jgWc+izmkTSAZdZ95KL2FH0N
         V1xTZJpPj+y9v3CRD/LIKu85ef8vaq92q27aIvkMuPjWvYpKZ0sGrze8sLOhmjTKT92Q
         +uo3yI/LbPOUpGaWXED4crCvTPcb6n4GDW08xuQokO2kH2k+OE1rRYpVUHE0kN+ZmQAU
         ZLrw==
X-Gm-Message-State: APjAAAXj8WcYrj/CkMXoLqxG6LWJh49o75g5NgMgF8oOcq7BCAe+H6/p
        qmBhOA/PJNGAwufAVarMTDBKmX6i
X-Google-Smtp-Source: APXvYqw4o+f+AcRSgHyU+5hHHE0u6CgUG3Pd1sQUPmbYN6IcD1Mwxcuv0yV7EJS9LaKtFW1KUbUiyg==
X-Received: by 2002:a63:408:: with SMTP id 8mr13224327pge.334.1554485419654;
        Fri, 05 Apr 2019 10:30:19 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 17sm49206730pfw.65.2019.04.05.10.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:30:18 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] arm64: dts: imx8mq: Add a node for SRC IP block
Date:   Fri,  5 Apr 2019 10:30:01 -0700
Message-Id: <20190405173004.13277-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405173004.13277-1-andrew.smirnov@gmail.com>
References: <20190405173004.13277-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for reset controller IP block found on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 3de390777af1..83d023aaa048 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -450,6 +450,12 @@
 				              "clk_ext3", "clk_ext4";
 			};
 
+			src: reset-controller@30390000 {
+				compatible = "fsl,imx8mq-src", "syscon";
+				reg = <0x30390000 0x10000>;
+				#reset-cells = <1>;
+			};
+
 			gpc: gpc@303a0000 {
 				compatible = "fsl,imx8mq-gpc";
 				reg = <0x303a0000 0x10000>;
-- 
2.20.1

