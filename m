Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400F7C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0833E208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142056;
	bh=/3FHlrPbUfoEx5bggvBQp3kcC9rdCI47yRWd8XnLZ5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OjX63zblJlMjWuAmd8AuoqAeRz17ourGOFHxFjsIoOwAuXmaoGP4SgZ6kKEUNDDoL
	 3mo6UaWfcxC96z1g3tbVe+agnHLG455iOzFGw9adv6tV0u24cKoBEKUBKsKb5pCF9I
	 rROiHysEp90+jjGUXgRa78r3pqLywsrU7c5DKGb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfKSFky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbfKSFkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:40:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A46F21783;
        Tue, 19 Nov 2019 05:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142050;
        bh=/3FHlrPbUfoEx5bggvBQp3kcC9rdCI47yRWd8XnLZ5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXQZsg/TJsnCvn0PdoljzU/V4KL6qe/WDudwTcFLdxOLa7u6txIxqzhcD5uqzZ4T9
         iA4Ts38uY3dIHvRmGSrxxUkpp6L3LK+D9go0cGTNNxY31VgNz94J/uXKg/EpuhIAQa
         PCjWtyG3d14qE6qDea6Rab8ACqtD4HvwBcAp4gRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 372/422] ARM: tegra: colibri_t30: fix mcp2515 can controller interrupt polarity
Date:   Tue, 19 Nov 2019 06:19:29 +0100
Message-Id: <20191119051423.117492613@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

[ Upstream commit 503fcd8464fb6cd18073e97dec59b933930655d6 ]

Fix the MCP2515 SPI CAN controller interrupt polarity which according
to its datasheet defaults to low-active aka falling edge.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 16e1f387aa6db..a0c550e26738f 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -79,7 +79,8 @@
 			reg = <0>;
 			clocks = <&clk16m>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_EDGE_RISING>;
+			/* CAN_INT */
+			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_EDGE_FALLING>;
 			spi-max-frequency = <10000000>;
 		};
 		spidev0: spi@1 {
-- 
2.20.1



