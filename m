Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A826BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7BF2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450573;
	bh=OV3+KawSCH4I2fCMM3ZoupY9DZ5nbP5HeefYhUfwV3A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xHN5LXcXjK0W/RHVosJ2jyfnUlZbT9oVXPbe8xyZSzesujH3pp65g5r88EYUxGeaJ
	 em/W1vcETvxt1ia6P/H2VipfFsAskvd5hk3gdnOu6BMr9MxBwA47AgKaHlZ70anb1+
	 qvpPqsiZ3xYJYeGOucuHeFZ+ed40DHPlBUMv4qHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfJ3Ptc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfJ3Ptc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:49:32 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1857B20656;
        Wed, 30 Oct 2019 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450571;
        bh=OV3+KawSCH4I2fCMM3ZoupY9DZ5nbP5HeefYhUfwV3A=;
        h=From:To:Cc:Subject:Date:From;
        b=oJokxHXKFyr0ZCf+ftMGBOV23Max+sI19oLm7i64k2ZY6tqLHVuTeLkj53mMya43l
         Pf+9yXVC5BNYdsH3VhjBDi17NriF+NDtOgirzJRvMpCRblHIVOoQaRp7yPEhRd1mi1
         k+yepDpjSEtXt+Fwagf1ndhT9R5I/5p0oJoeuDpE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 01/81] regulator: of: fix suspend-min/max-voltage parsing
Date:   Wed, 30 Oct 2019 11:48:07 -0400
Message-Id: <20191030154928.9432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

