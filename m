Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A01CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3EF21873
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="HYHREAfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfCOA74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:59:56 -0400
Received: from mail.nic.cz ([217.31.204.67]:46463 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfCOA7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:59:55 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 7882C63462;
        Fri, 15 Mar 2019 01:59:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1552611593; bh=GoRJPRI6WaQHy1KESItlOO2dhech22ScmKeyyC603fA=;
        h=From:To:Date;
        b=HYHREAfB+oTuVUVl3g2ngjw17YOq/BVg2jG3Vh79JVVEI2Fu0zfnnrLtMh/7mwSvm
         qiZ02GPzImEpRsp5gcP2ojEQvm7jLHELx+lVsTOKCvoFcL5t6DXOfz5056SN9+s7Xj
         i67QKDvOuryV6ZgxlCUmMbL1sNqbHha6lXGI+PEw=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v3 mailbox+firmware 3/6] arm64: dts: marvell: armada-37xx: add mailbox node
Date:   Fri, 15 Mar 2019 01:59:23 +0100
Message-Id: <20190315005926.5994-4-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190315005926.5994-1-marek.behun@nic.cz>
References: <20190315005926.5994-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the rWTM BIU mailbox node for communication with the secure
processor.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 87cc84aae6ac..b2e55576b806 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -419,6 +419,13 @@
 				clocks = <&nb_periph_clk 15>;
 			};
 
+			rwtm: mailbox@b0000 {
+				compatible = "marvell,armada-3700-rwtm-mailbox";
+				reg = <0xb0000 0x100>;
+				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+				#mbox-cells = <1>;
+			};
+
 			sdhci1: sdhci@d0000 {
 				compatible = "marvell,armada-3700-sdhci",
 					     "marvell,sdhci-xenon";
-- 
2.19.2

