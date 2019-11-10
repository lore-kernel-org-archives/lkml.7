Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA751C17444
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9627F21D7F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353877;
	bh=BuT6bfjFp5cxw/27srU4vhqsluei9tEzvXuetTk1On4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lGFgjWFkJ1euxHgwiZ41yiLV1/EVlivTTMbNNpDFujT51/YCc9U9pZEHfGnGIOnyJ
	 aAemP5YuG3UCSCsst00th/gXYNzTTFcnGCx0Nwr9GAA5CLUqDfNshAMRdVgFcSiPu4
	 yumxb+X38RllOUpom39bPovL0n+O/p6+fSv+58g0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfKJCog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbfKJCoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:44:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522CD222BE;
        Sun, 10 Nov 2019 02:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353854;
        bh=BuT6bfjFp5cxw/27srU4vhqsluei9tEzvXuetTk1On4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AG2i7VyCt8UdU9hpzvvOtBB3PJVVlGKb6/zyKRzqMqxVdiRmmdA56usNV6HQvzwCH
         bp9NABRQowZiHfcUHHxWYEFdxXWcXWzdgvC0j2bCpZnAv+fw/XFE0hSjCgmygVTI1M
         leqaHfbrhuAAqlWTQThfYAF2WMcSxhXTPKggKHPg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 139/191] ARM: tegra: apalis_t30: fix mmc1 cmd pull-up
Date:   Sat,  9 Nov 2019 21:39:21 -0500
Message-Id: <20191110024013.29782-139-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

[ Upstream commit 1c997fe4becdc6fcbc06e23982ceb65621e6572a ]

Fix MMC1 cmd pin pull-up causing issues on carrier boards without
external pull-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/tegra30-apalis.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 2f807d40c1b79..e749e047db7ab 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -171,14 +171,14 @@
 
 			/* Apalis MMC1 */
 			sdmmc3_clk_pa6 {
-				nvidia,pins = "sdmmc3_clk_pa6",
-					      "sdmmc3_cmd_pa7";
+				nvidia,pins = "sdmmc3_clk_pa6";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc3_dat0_pb7 {
-				nvidia,pins = "sdmmc3_dat0_pb7",
+				nvidia,pins = "sdmmc3_cmd_pa7",
+					      "sdmmc3_dat0_pb7",
 					      "sdmmc3_dat1_pb6",
 					      "sdmmc3_dat2_pb5",
 					      "sdmmc3_dat3_pb4",
-- 
2.20.1

