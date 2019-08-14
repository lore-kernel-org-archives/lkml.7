Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7AFC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A88D20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803476;
	bh=SLPAbl0S5v24ijhMwrhQHjsg1nWy5Nyv/VKXHzf2oS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mhND+p8jIMCZ31n8+sPAp8jbUaq2bI6ie81+JVRFkQsJ3Aj4iWRoZ1wtO21ArGySP
	 M+nf+Frz6lcty8KtZ71LoZ+jCGrBrLO1eHJQveJYHMiIU8b3Rolse4f0shtrUOGf65
	 SBwFhAZSxB2ijxifdit4zDlwuYK6j1nl7um0lm3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfHNRYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbfHNRG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:06:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F61D20578;
        Wed, 14 Aug 2019 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802388;
        bh=SLPAbl0S5v24ijhMwrhQHjsg1nWy5Nyv/VKXHzf2oS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIio4mLUeQAIeeh2Bm5XPZBcNmg1261zqhg3cKFZstjosCnqXj+Pf4Frbnrqrviko
         +CgOvhtzpzfX7+bCPbbW32/P0hWjJeuK0M/F05ZlbW+psDCWHDjhkPxNFLOa+HtVFC
         SGo4sKst9pwyAXx9rHQaBshnQDLHX4Du9p8NGq7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 106/144] ARM: dts: bcm: bcm47094: add missing #cells for mdio-bus-mux
Date:   Wed, 14 Aug 2019 19:01:02 +0200
Message-Id: <20190814165804.337814534@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3a9d2569e45cb02769cda26fee4a02126867c934 ]

The mdio-bus-mux has no #address-cells/#size-cells property,
which causes a few dtc warnings:

arch/arm/boot/dts/bcm47094-linksys-panamera.dts:129.4-18: Warning (reg_format): /mdio-bus-mux/mdio@200:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/bcm47094-linksys-panamera.dts:128.22-132.5: Warning (avoid_default_addr_size): /mdio-bus-mux/mdio@200: Relying on default #address-cells value
arch/arm/boot/dts/bcm47094-linksys-panamera.dts:128.22-132.5: Warning (avoid_default_addr_size): /mdio-bus-mux/mdio@200: Relying on default #size-cells value

Add the normal cell numbers.

Link: https://lore.kernel.org/r/20190722145618.1155492-1-arnd@arndb.de
Fixes: 2bebdfcdcd0f ("ARM: dts: BCM5301X: Add support for Linksys EA9500")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index 5fd47eec4407e..1679959a3654d 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -126,6 +126,9 @@
 	};
 
 	mdio-bus-mux {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		/* BIT(9) = 1 => external mdio */
 		mdio_ext: mdio@200 {
 			reg = <0x200>;
-- 
2.20.1



