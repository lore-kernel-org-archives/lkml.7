Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F161CC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A4D21823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141840;
	bh=VHqwNr/2MI7GULDENmCysXqgEJ5Gz68MXJ5DolXPSlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x1Yq4xkbYP8zEBfwqQKk8hgHpFxOIkFJTYb9dC8H8RXmaQGJgCZpceYANSoaxSlNb
	 Vng2+DuClyFNSu7Kg3hMErUViuokjMvfvb1nsSWsut1MkzX/DGKnBFW+IcwWHqjxr2
	 ifOyctOHIbLKcFy7pZR+NTySZK3NXDbrKQLJlRaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfKSFhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfKSFhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:37:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E492221823;
        Tue, 19 Nov 2019 05:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141833;
        bh=VHqwNr/2MI7GULDENmCysXqgEJ5Gz68MXJ5DolXPSlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvQKEFJxYricu7D1larYF6UuD0qcjc1yHzVqO7SllOlh3tsPoYdPaVIjua7qOwQtM
         0NiLHmMqBpX9w2TSZdBBXud6+t5S/3gzL+leHTGOrivdnmnS62U2EI4xKPNyw5ZjPg
         9s72HrrN5YPu/l8Pq5SZr8AdymGusLQF5LhxL+KU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 296/422] ARM: dts: am335x-evm: fix number of cpsw
Date:   Tue, 19 Nov 2019 06:18:13 +0100
Message-Id: <20191119051418.171853121@linuxfoundation.org>
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

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit dcbf6b18d81bcdc51390ca1b258c17e2e13b7d0c ]

am335x-evm has only one CPSW external port physically wired, but DT defines
2 ext. ports. As result, PHY connection failure reported for the second
ext. port.

Update DT to reflect am335x-evm board HW configuration, and, while here,
switch to use phy-handle instead of phy_id.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-evm.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 20bbb899b3b76..cc59e42c91342 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -731,6 +731,7 @@
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
 	status = "okay";
+	slaves = <1>;
 };
 
 &davinci_mdio {
@@ -738,15 +739,14 @@
 	pinctrl-0 = <&davinci_mdio_default>;
 	pinctrl-1 = <&davinci_mdio_sleep>;
 	status = "okay";
-};
 
-&cpsw_emac0 {
-	phy_id = <&davinci_mdio>, <0>;
-	phy-mode = "rgmii-txid";
+	ethphy0: ethernet-phy@0 {
+		reg = <0>;
+	};
 };
 
-&cpsw_emac1 {
-	phy_id = <&davinci_mdio>, <1>;
+&cpsw_emac0 {
+	phy-handle = <&ethphy0>;
 	phy-mode = "rgmii-txid";
 };
 
-- 
2.20.1



