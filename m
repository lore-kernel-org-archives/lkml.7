Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC08C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87E420718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421747;
	bh=ikEzlp6skgbt7ucgJUk6QMGS3qo27ru8EhTypd6fYVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MXVLiwMfkExt0sDtJa/VEdPQk0yR+t/eSXQDSEfysLRS4szgxFhNzTWIktkf7X5l0
	 iHqF8aym0xPVHGwaNeZ7rApZ67+g7UOXf3NS4sGo0qpWDFGBq4w7NTFBg5AVTPCSyO
	 LGmg/xxh2O61Lf8ZREuExd2dIb1PXXu+b/0pcjpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKVKnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbfKVKnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:43:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D53120718;
        Fri, 22 Nov 2019 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419395;
        bh=ikEzlp6skgbt7ucgJUk6QMGS3qo27ru8EhTypd6fYVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtbLd7Ef0iV6zj+jJot5crIla8FyM82q7U+Mqon0O5KB11vQZS0IjeSSBh5W6VJnN
         Kib2lVX553VyKo7BSJhKaJD9oQX7QnPiTuBf6XmxE0s2Fy207NH24Ik51+5RjA55Kb
         vNM4FVjHF6+62TGvxea1Fh8WHtYu4xhCZ2U7jx3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 097/222] ARM: dts: am335x-evm: fix number of cpsw
Date:   Fri, 22 Nov 2019 11:27:17 +0100
Message-Id: <20191122100910.440822090@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
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
index e82432c79f85f..3f3ad09c7cd5f 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -701,6 +701,7 @@
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
 	status = "okay";
+	slaves = <1>;
 };
 
 &davinci_mdio {
@@ -708,15 +709,14 @@
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



