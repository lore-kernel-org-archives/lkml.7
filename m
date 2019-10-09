Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB32C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B97206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642323;
	bh=DoZbOJkyEpxr8O1/upunQtXlKDIbBtKBteci4Ek32YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IHBo18TAdrAj+0EqtzaGTwpPO4TdoFJhySA6J7BLhHLQTd7X7hCXluRBKwSAA0/mh
	 BXCa9/DkE2Id20X1sSV6v1feWUDtJWAS6NIpmaSMjbuDqLP8q9eNlp6wFnWlu2fbEu
	 WPFDfs/B1O4B3ugL7Ongq6wgR91tcgkPkrXooPco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbfJIRcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732022AbfJIRX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:23:58 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF5821924;
        Wed,  9 Oct 2019 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641837;
        bh=DoZbOJkyEpxr8O1/upunQtXlKDIbBtKBteci4Ek32YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMUaA+33yBwQpvpW40a/0NOMqftl1YMbIgCFNIyAfmInPWs0CQWlVZi1wghCe6QOn
         RfHvIjY8dp4q5eNr2bUtNQhEsZazvWKNnq40FXMG8q3wUzdimXUsySDhK4KNKjI2Q5
         5zfNbcbwS2ZgL/EEm5gNnNSG6Yzsb+CBDAOvw5rI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Suman Anna <s-anna@ti.com>, Sasha Levin <sashal@kernel.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 16/68] ARM: OMAP2+: Add missing LCDC midlemode for am335x
Date:   Wed,  9 Oct 2019 13:04:55 -0400
Message-Id: <20191009170547.32204-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 17529d43b21c72466e9109d602c6f5c360a1a9e8 ]

TRM "Table 13-34. SYSCONFIG Register Field Descriptions" lists both
standbymode and idlemode that should be just the sidle and midle
registers where midle is currently unconfigured for lcdc_sysc. As
the dts data has been generated based on lcdc_sysc, we now have an
empty "ti,sysc-midle" property.

And so we currently get a warning for lcdc because of a difference
with dts provided configuration compared to the legacy platform
data. This is because lcdc has SYSC_HAS_MIDLEMODE configured in
the platform data without configuring the modes.

Let's fix the issue by adding the missing midlemode to lcdc_sysc,
and configuring the "ti,sysc-midle" property based on the TRM
values.

Fixes: f711c575cfec ("ARM: dts: am335x: Add l4 interconnect hierarchy and ti-sysc data")
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>
Cc: Suman Anna <s-anna@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am33xx-l4.dtsi           | 4 +++-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 1515f4f914999..3287cf695b5a4 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -2038,7 +2038,9 @@
 			reg = <0xe000 0x4>,
 			      <0xe054 0x4>;
 			reg-names = "rev", "sysc";
-			ti,sysc-midle ;
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
 			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
 					<SYSC_IDLE_NO>,
 					<SYSC_IDLE_SMART>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index c965af275e341..81d9912f17c85 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -231,8 +231,9 @@ static struct omap_hwmod am33xx_control_hwmod = {
 static struct omap_hwmod_class_sysconfig lcdc_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x54,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			  MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART,
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };
 
-- 
2.20.1

