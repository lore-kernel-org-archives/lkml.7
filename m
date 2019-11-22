Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43612C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDAE2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574422002;
	bh=wFarCmC1vgEJ83u0SNHI/6bTj2VuSACrgAQl9SOjl9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uAd/d7kha/A6mosTujUxrWwji51fYTsGfHdEibqdcAqORjy+y82HTVFo+ZN2cJBOy
	 3NnDTI1p9WGNRzFSUjyeheoqdPFkrF2UyuM3hOB+p8RntIyoqbYnWKA+RRPv1qbVSi
	 wDdyUn9c56QYEtNSZZGiA8hU0PVyWYb/hc+ODu24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfKVL0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfKVKeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:34:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E129920656;
        Fri, 22 Nov 2019 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418847;
        bh=wFarCmC1vgEJ83u0SNHI/6bTj2VuSACrgAQl9SOjl9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AziTzzy1jeP3ExBoO2HQG5T2OnVtjRuXxekg99FlgqQ2gBp0nLnzjyRSt91aLdeUl
         749XEcT5C5/2a97SS2fNT9wIAnUoy/h5LAOgKguHt0B/rS2M1YNSyn9uVX+E7W9JFS
         nHW1oMkWXvipjQj2hcd2/z5BpnHTYw+pJL+3WEwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 070/159] ARM: dts: am335x-evm: fix number of cpsw
Date:   Fri, 22 Nov 2019 11:27:41 +0100
Message-Id: <20191122100756.409105340@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
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
index d9d00ab863a21..2b8614e406f03 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -697,6 +697,7 @@
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
 	status = "okay";
+	slaves = <1>;
 };
 
 &davinci_mdio {
@@ -704,15 +705,14 @@
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



