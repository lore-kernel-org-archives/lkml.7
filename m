Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D2FFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7069A214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239874;
	bh=OV3+KawSCH4I2fCMM3ZoupY9DZ5nbP5HeefYhUfwV3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rnFOkp5hy1q/VDVLUKTXSg7ib8dAMi5PceEEg2LZ8/nTkMxXagnJ3MEMuM3ICAbOH
	 n5PL7zgwDOUPXLaMlYrFeO+NYD657wEsMKFVeMKNrpNhbdq4HG4HuOmClqbZqTfSzQ
	 FTSstR3OlJsQfmYpLZxpAEBbOP/cQEDHkqo0fMUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391019AbfKHTEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:04:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390990AbfKHTE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:04:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B7E2067B;
        Fri,  8 Nov 2019 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239866;
        bh=OV3+KawSCH4I2fCMM3ZoupY9DZ5nbP5HeefYhUfwV3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOHCU/Aoqs1U45vfqvobztHKKOR9peykNtT5PP+oGMm2mVW2DPQxsVmrcGkYi6rJ4
         Luj8AUI+7AHUjjhnJitKQCR6Dpz84YNxrKtvA3yYIAeC/DKXB7UkG/cVUrOnhXR+yf
         +8crPnXngJi22ltDCXQ3Ok6sFZhWVsB8wut3K8/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 001/140] regulator: of: fix suspend-min/max-voltage parsing
Date:   Fri,  8 Nov 2019 19:48:49 +0100
Message-Id: <20191108174900.345308978@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
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
index 9112faa6a9a0e..38dd06fbab384 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -231,12 +231,12 @@ static int of_get_regulation_constraints(struct device *dev,
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



