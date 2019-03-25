Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37485C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E19320645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfCYWAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:00:11 -0400
Received: from muru.com ([72.249.23.125]:42594 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730501AbfCYV7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:59:02 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 77EAD819C;
        Mon, 25 Mar 2019 21:59:14 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 02/14] bus: ti-sysc: Handle missed no-idle property in addition to no-idle-on-init
Date:   Mon, 25 Mar 2019 14:58:37 -0700
Message-Id: <20190325215849.13182-3-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have ti,no-idle in use in addition to ti,no-idle-on-init but we're
missing handling for it in the ti-sysc interconnect target module driver.

Let's also group the idle defines together and update the binding
documentation for it.

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/bus/ti-sysc.txt | 2 ++
 arch/arm/mach-omap2/omap_hwmod.c                  | 2 ++
 drivers/bus/ti-sysc.c                             | 5 ++++-
 include/linux/platform_data/ti-sysc.h             | 5 +++--
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -94,6 +94,8 @@ Optional properties:
 
 - ti,no-idle-on-init	interconnect target module should not be idled at init
 
+- ti,no-idle		interconnect target module should not be idled
+
 Example: Single instance of MUSB controller on omap4 using interconnect ranges
 using offsets from l4_cfg second segment (0x4a000000 + 0x80000 = 0x4a0ab000):
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3675,6 +3675,8 @@ int omap_hwmod_init_module(struct device *dev,
 	if (error)
 		return error;
 
+	if (data->cfg->quirks & SYSC_QUIRK_NO_IDLE)
+		oh->flags |= HWMOD_NO_IDLE;
 	if (data->cfg->quirks & SYSC_QUIRK_NO_IDLE_ON_INIT)
 		oh->flags |= HWMOD_INIT_NO_IDLE;
 	if (data->cfg->quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -920,7 +920,8 @@ static int sysc_init_module(struct sysc *ddata)
 {
 	int error;
 
-	if (ddata->cfg.quirks & SYSC_QUIRK_NO_IDLE_ON_INIT) {
+	if (ddata->cfg.quirks &
+	    (SYSC_QUIRK_NO_IDLE | SYSC_QUIRK_NO_IDLE_ON_INIT)) {
 		ddata->revision = sysc_read_revision(ddata);
 		goto rev_quirks;
 	}
@@ -1281,6 +1282,8 @@ static const struct sysc_dts_quirk sysc_dts_quirks[] = {
 	  .mask = SYSC_QUIRK_NO_IDLE_ON_INIT, },
 	{ .name = "ti,no-reset-on-init",
 	  .mask = SYSC_QUIRK_NO_RESET_ON_INIT, },
+	{ .name = "ti,no-idle",
+	  .mask = SYSC_QUIRK_NO_IDLE, },
 };
 
 static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -46,8 +46,9 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
-#define SYSC_QUIRK_LEGACY_IDLE		BIT(8)
-#define SYSC_QUIRK_RESET_STATUS		BIT(7)
+#define SYSC_QUIRK_LEGACY_IDLE		BIT(9)
+#define SYSC_QUIRK_RESET_STATUS		BIT(8)
+#define SYSC_QUIRK_NO_IDLE		BIT(7)
 #define SYSC_QUIRK_NO_IDLE_ON_INIT	BIT(6)
 #define SYSC_QUIRK_NO_RESET_ON_INIT	BIT(5)
 #define SYSC_QUIRK_OPT_CLKS_NEEDED	BIT(4)
-- 
2.21.0
