Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DECC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3646620873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbfJOOJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:09:18 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49386 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbfJOOJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:09:17 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKNVe-0004HK-Un; Tue, 15 Oct 2019 15:09:11 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKNVe-0000DJ-8u; Tue, 15 Oct 2019 15:09:10 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx: gpc: fix initialiser format
Date:   Tue, 15 Oct 2019 15:09:09 +0100
Message-Id: <20191015140909.778-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the initialiers in imx_gpc_domains C99 format to fix the
following sparse warnings:

drivers/soc/imx/gpc.c:252:30: warning: obsolete array initializer, use C99 syntax
drivers/soc/imx/gpc.c:258:29: warning: obsolete array initializer, use C99 syntax
drivers/soc/imx/gpc.c:269:34: warning: obsolete array initializer, use C99 syntax
drivers/soc/imx/gpc.c:278:30: warning: obsolete array initializer, use C99 syntax

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/soc/imx/gpc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index d9231bd3c691..98b9d9a902ae 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -249,13 +249,13 @@ static struct genpd_power_state imx6_pm_domain_pu_state = {
 };
 
 static struct imx_pm_domain imx_gpc_domains[] = {
-	[GPC_PGC_DOMAIN_ARM] {
+	[GPC_PGC_DOMAIN_ARM] = {
 		.base = {
 			.name = "ARM",
 			.flags = GENPD_FLAG_ALWAYS_ON,
 		},
 	},
-	[GPC_PGC_DOMAIN_PU] {
+	[GPC_PGC_DOMAIN_PU] = {
 		.base = {
 			.name = "PU",
 			.power_off = imx6_pm_domain_power_off,
@@ -266,7 +266,7 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		.reg_offs = 0x260,
 		.cntr_pdn_bit = 0,
 	},
-	[GPC_PGC_DOMAIN_DISPLAY] {
+	[GPC_PGC_DOMAIN_DISPLAY] = {
 		.base = {
 			.name = "DISPLAY",
 			.power_off = imx6_pm_domain_power_off,
@@ -275,7 +275,7 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		.reg_offs = 0x240,
 		.cntr_pdn_bit = 4,
 	},
-	[GPC_PGC_DOMAIN_PCI] {
+	[GPC_PGC_DOMAIN_PCI] = {
 		.base = {
 			.name = "PCI",
 			.power_off = imx6_pm_domain_power_off,
-- 
2.23.0

