Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0A4C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7DE2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239670;
	bh=OskzKgyekS9GSE+7yGkOwIcQl8F2JurHkstQr69ZI+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bz1U4/bc55sslDw5xDIqGdhAtX/SPBX/rgV4mjxigU4+H9pqDozLUQgUIyQRyuVOa
	 NzF//ebmDyuJ7OhlZB279TTBrOyRIExPq26dd600qTDfkbMa0DefkVDsc97d4sAyy7
	 CYQCwwkDqRAKdu+sIm/XgMHMyrayLIq6L4Mw8jbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbfKHTBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730159AbfKHTBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:01:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6383A222C5;
        Fri,  8 Nov 2019 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239664;
        bh=OskzKgyekS9GSE+7yGkOwIcQl8F2JurHkstQr69ZI+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjWHb3OZBlnB2YWF1LjMG46WFH+0CXEfoYLGT7uTdCBa5OST3K9QpSvgP/T6pYyEe
         Db6crgLRaih4C5cVn/IsNlZ+vy9LLf8Hy9c9h6RhVtBfnQO93EzzW2ioKVPDfxoCg2
         OqTJ5uFFHc75YBhezqIu0yiZ1QxT9X5ieM37Bdr8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 02/79] regulator: of: fix suspend-min/max-voltage parsing
Date:   Fri,  8 Nov 2019 19:49:42 +0100
Message-Id: <20191108174746.476200211@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 131cb1210d4b58acb0695707dad2eb90dcb50a2a ]

Currently the regulator-suspend-min/max-microvolt must be within the
root regulator node but the dt-bindings specifies it as subnode
properties for the regulator-state-[mem/disk/standby] node. The only DT
using this bindings currently is the at91-sama5d2_xplained.dts and this
DT uses it correctly. I don't know if it isn't tested but it can't work
without this fix.

Fixes: f7efad10b5c4 ("regulator: add PM suspend and resume hooks")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Link: https://lore.kernel.org/r/20190917154021.14693-3-m.felsch@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/of_regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 210fc20f7de7a..b255590aef36e 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -214,12 +214,12 @@ static void of_get_regulation_constraints(struct device_node *np,
 					"regulator-off-in-suspend"))
 			suspend_state->enabled = DISABLE_IN_SUSPEND;
 
-		if (!of_property_read_u32(np, "regulator-suspend-min-microvolt",
-					  &pval))
+		if (!of_property_read_u32(suspend_np,
+				"regulator-suspend-min-microvolt", &pval))
 			suspend_state->min_uV = pval;
 
-		if (!of_property_read_u32(np, "regulator-suspend-max-microvolt",
-					  &pval))
+		if (!of_property_read_u32(suspend_np,
+				"regulator-suspend-max-microvolt", &pval))
 			suspend_state->max_uV = pval;
 
 		if (!of_property_read_u32(suspend_np,
-- 
2.20.1



