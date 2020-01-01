Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4187C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCE12053B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RqOw81rL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgAAQem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 11:34:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36421 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgAAQem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 11:34:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so37284318wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 08:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lUAl0FgZsaETOlCEozFvmaPi6AmPFiieeFXfsFg0uGk=;
        b=RqOw81rLysk4OW3COYbAqrvrnGgzKgxEY9CUIMmlwZNwieZLrrjS/NPi4jjdeB9NOh
         UFUaUg1MRpH4liZ6TMxlvSD/8745RFX4nkFamdrGgRPWlcr9fHDsPYPYTN/tTpM+/FN8
         xbs18aPQpGhl4acZSL9sEpBz86zyJZIWkZF90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lUAl0FgZsaETOlCEozFvmaPi6AmPFiieeFXfsFg0uGk=;
        b=HbS8KYlbnE4KWEbtoBJn/6SZNbAHVPYBDRZsc/fRfnelyqsJXqsj19IesnvpBwqco5
         pGEuSZ8vCEa4BiTqxytS7TpFlzZmUghuE9QCm4dZ3LLoPaTEinDHN8yX9X5XSvhzqsZU
         F6djPdatjZ+LmGz9vJnxCj1Mue6PfoVnqsTOsBBao46HrAF9RPY7oTzsFkysu5J7eU4L
         eEKHSU1+nYUyLa4Z+FLCPefZKCfBYz/5/YqUoUMXQ/QaEzuz4Ok0lNJRoxSUtA3JAMbs
         aN4mMAWouwfojbVcfq0UukWtRUGhZTSLFvh4HwUfoMcT+BXYRDUUQCpqHdFNtQEw8b6T
         4agA==
X-Gm-Message-State: APjAAAXo3EsowTtga7WczhTXVm1Eg0LvAz6KVCsm4o6VfQ5Qhnas1r98
        xu4Q5WROJK6j3anF9zR5TTIjTnrleCo=
X-Google-Smtp-Source: APXvYqx708FWI3xR9nxIfZiFDsBPwFOMrvKz5t8J3iQHkmYvyyAUf9DqFwYllk73fPvnfllt6Zjx8g==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr76044712wrm.210.1577896480509;
        Wed, 01 Jan 2020 08:34:40 -0800 (PST)
Received: from panicking.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id t12sm53063807wrs.96.2020.01.01.08.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 08:34:40 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com
Subject: [PATCH] arm64: dts: imx8mm: Add UART1 UART1_DCE_RTS/CTS pin's mux option #4
Date:   Wed,  1 Jan 2020 17:34:38 +0100
Message-Id: <20200101163438.1761-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to i.MX8MM reference manual Rev.2, 08/2019. According
to the manual the two pins has associated daisy chain so input
register and input value should be set too

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index cffa8991880d..62d16b1d7c5b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -438,10 +438,12 @@
 #define MX8MM_IOMUXC_SAI2_RXC_SIM_M_HSIZE1                                  0x1B4 0x41C 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0                                0x1B8 0x420 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI2_RXD0_SAI5_TX_DATA0                                0x1B8 0x420 0x000 0x1 0x0
+#define MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B                              0x1B8 0x420 0x4F0 0x4 0x2
 #define MX8MM_IOMUXC_SAI2_RXD0_GPIO4_IO23                                   0x1B8 0x420 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI2_RXD0_SIM_M_HSIZE2                                 0x1B8 0x420 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC                                 0x1BC 0x424 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI2_TXFS_SAI5_TX_DATA1                                0x1BC 0x424 0x000 0x1 0x0
+#define MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B                              0x1BC 0x424 0x4F0 0x4 0x2
 #define MX8MM_IOMUXC_SAI2_TXFS_GPIO4_IO24                                   0x1BC 0x424 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI2_TXFS_SIM_M_HWRITE                                 0x1BC 0x424 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK                                  0x1C0 0x428 0x000 0x0 0x0
-- 
2.17.1

