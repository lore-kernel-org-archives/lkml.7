Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D820C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523D5222D9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642019;
	bh=aZoWN10Nz1jaXQcyMMAW7mBPOrCR5zcxUc8nfzrtGUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZFYP/fcl3ZeAoLi81d8a1xZgUx7A0JrQ0jSvhd+1u9Te91NxSji7HEK+TdCgqblGm
	 DIeSCZy9vk+dHZorFGSHZDuD9gb0aMjw4PpTX4L3q9hqmndEQmdOZxP8hf5rwJLAYn
	 Zjughup1VjNTtCGNqRzdO4rMki1E4ytVp3RCOIQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfL2Rxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732496AbfL2Rxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:53:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E290206DB;
        Sun, 29 Dec 2019 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642014;
        bh=aZoWN10Nz1jaXQcyMMAW7mBPOrCR5zcxUc8nfzrtGUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZSh7JnnpPBJl6GoZJUFkEvweZCguN4P8QnOkMz1lGQaoTYxRg8gdDwn/B2MdN5rm
         wwOPJiXSKkFM8EMRQO6BHCMeEFUdDTeqF1oNw+uCT/melK34TRknHwON+wklSAz3Gb
         S8CS5WAUbM9wZ/IKIG9VpO/cCpYB3SvwrE11n1oI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        ralf@linux-mips.org, jhogan@kernel.org, john@phrozen.org,
        NeilBrown <neil@brown.name>, linux-mips@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 306/434] MIPS: ralink: enable PCI support only if driver for mt7621 SoC is selected
Date:   Sun, 29 Dec 2019 18:25:59 +0100
Message-Id: <20191229172722.278894483@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergio Paracuellos <sergio.paracuellos@gmail.com>

[ Upstream commit 3b2fa0c92686562ac0b8cf00c0326a45814f8e18 ]

Some versions of SoC MT7621 have three PCI express hosts. Some boards
make use of those PCI through the staging driver mt7621-pci. Recently
PCI support has been removed from MT7621 Soc kernel configuration due
to a build error. This makes imposible to compile staging driver and
produces a regression for gnubee based boards. Enable support for PCI
again but enable it only if staging mt7621-pci driver is selected.

Fixes: c4d48cf5e2f0 ("MIPS: ralink: deactivate PCI support for SOC_MT7621")
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: john@phrozen.org
Cc: NeilBrown <neil@brown.name>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Link: https://lore.kernel.org/r/20191019081233.7337-1-sergio.paracuellos@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/ralink/Kconfig           | 1 +
 drivers/staging/mt7621-pci/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 1434fa60f3db..94e9ce994494 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -51,6 +51,7 @@ choice
 		select MIPS_GIC
 		select COMMON_CLK
 		select CLKSRC_MIPS_GIC
+		select HAVE_PCI if PCI_MT7621
 endchoice
 
 choice
diff --git a/drivers/staging/mt7621-pci/Kconfig b/drivers/staging/mt7621-pci/Kconfig
index af928b75a940..ce58042f2f21 100644
--- a/drivers/staging/mt7621-pci/Kconfig
+++ b/drivers/staging/mt7621-pci/Kconfig
@@ -2,7 +2,6 @@
 config PCI_MT7621
 	tristate "MediaTek MT7621 PCI Controller"
 	depends on RALINK
-	depends on PCI
 	select PCI_DRIVERS_GENERIC
 	help
 	  This selects a driver for the MediaTek MT7621 PCI Controller.
-- 
2.20.1



