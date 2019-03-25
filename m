Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAF4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F9E20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfCYV72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:59:28 -0400
Received: from muru.com ([72.249.23.125]:42666 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730738AbfCYV7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:59:24 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id EFD1680CC;
        Mon, 25 Mar 2019 21:59:37 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/14] bus: ti-sysc: Pass clockactivity quirk to platform functions
Date:   Mon, 25 Mar 2019 14:58:47 -0700
Message-Id: <20190325215849.13182-13-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the clockactivity quirk set for some modules like i2c,
timers and smartreflex. But we're not passing it to the platform functions
yet. Let's start doing that in preparation of dropping interconnect target
module platform data in favor of device tree based data.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3681,6 +3681,8 @@ int omap_hwmod_init_module(struct device *dev,
 		oh->flags |= HWMOD_INIT_NO_IDLE;
 	if (data->cfg->quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
 		oh->flags |= HWMOD_INIT_NO_RESET;
+	if (data->cfg->quirks & SYSC_QUIRK_USE_CLOCKACT)
+		oh->flags |= HWMOD_SET_DEFAULT_CLOCKACT;
 
 	error = omap_hwmod_check_module(dev, oh, data, sysc_fields,
 					rev_offs, sysc_offs, syss_offs,
-- 
2.21.0
