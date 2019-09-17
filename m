Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAA3C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3330421852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfIQPkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:40:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51065 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbfIQPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:40:28 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAFaZ-0003ZZ-HU; Tue, 17 Sep 2019 17:40:23 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAFaY-0003yb-FZ; Tue, 17 Sep 2019 17:40:22 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     zhang.chunyan@linaro.org, dianders@chromium.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        ckeepax@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/3] regulator: core: fix boot-on regulators use_count usage
Date:   Tue, 17 Sep 2019 17:40:19 +0200
Message-Id: <20190917154021.14693-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917154021.14693-1-m.felsch@pengutronix.de>
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1fc12b05895e ("regulator: core: Avoid propagating to
supplies when possible") regulators marked with boot-on can't be
disabled anymore because the commit handles always-on and boot-on
regulators the same way.

Now commit 05f224ca6693 ("regulator: core: Clean enabling always-on
regulators + their supplies") changed the regulator_resolve_supply()
logic a bit by using 'use_count'. So we can't just skip the
'use_count++' during set_machine_constraints(). The easiest way I found
is to correct the 'use_count' just before returning the rdev device
during regulator_register().

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/regulator/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e0c0cf462004..f9444f509440 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5170,6 +5170,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	/* try to resolve regulators supply since a new one was registered */
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_register_resolve_supply);
+
+	/* cleanup use_count -> boot-on marked regulators can be disabled */
+	if (rdev->constraints->boot_on && !rdev->constraints->always_on)
+		rdev->use_count--;
+
 	kfree(config);
 	return rdev;
 
-- 
2.20.1

