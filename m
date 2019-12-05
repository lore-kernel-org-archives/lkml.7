Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B4BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C0E24249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575528907;
	bh=9uH4sDVJnWEj3/ho6ZOYWTTU9xGzpseH9s/QX6LK7OM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mR/Rt+qcDEdpOvvfvECcCEG5C088I63mJbDP8jUVgv+ylenq118U5UoX6XmBPmV76
	 lHjUi6IGmNLBv9AGFIqPps3IveCbm2ZnRYhpIyv7jS1cN0tKgb2XvqyPD6h734Q022
	 h+Wh1AQ5Q3I2E9wcF5MoDizch0ju05bbqVmKRYvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLEGzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfLEGzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:55:05 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7C262077B;
        Thu,  5 Dec 2019 06:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575528905;
        bh=9uH4sDVJnWEj3/ho6ZOYWTTU9xGzpseH9s/QX6LK7OM=;
        h=From:To:Cc:Subject:Date:From;
        b=fl4uu+3QlJtoFRyP92aIq2X2NnLJXFiciOWs6HPSTqrym6tzRbemgp+ySlD8M+Tl7
         HVdyY/m2BCGb2/js8WP+z+6ZmWI+zpuUdKHsHXNmwTe5NNgRxndJI9PSzEH6ImKCpq
         HQ0MVHVP5rjKDPbjz34AxShpNffMMQhIiGVa/JxE=
Received: by wens.tw (Postfix, from userid 1000)
        id DA4DB5FD08; Thu,  5 Dec 2019 14:55:01 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] regulator: axp20x: Fix AXP22x ELDO2 regulator enable bitmask
Date:   Thu,  5 Dec 2019 14:54:57 +0800
Message-Id: <20191205065457.2039-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

A copy-paste error was introduced when bitmasks were converted to
macros, incorrectly setting the enable bitmask for ELDO2 to the one
for ELDO1 for the AXP22x units.

Fix it by using the correct macro.

On affected boards, ELDO1 and/or ELDO2 are used to power the camera,
which is currently unsupported.

Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Small fix. I prefer to have this merged sooner, i.e. not into -next.
Later patches (to be posted) supporting the camera sensor interface
depend on this at runtime to power on the camera correctly.

---
 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 989506bd90b1..fe369cba34fb 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -605,7 +605,7 @@ static const struct regulator_desc axp22x_regulators[] = {
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO1_MASK),
 	AXP_DESC(AXP22X, ELDO2, "eldo2", "eldoin", 700, 3300, 100,
 		 AXP22X_ELDO2_V_OUT, AXP22X_ELDO2_V_OUT_MASK,
-		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO1_MASK),
+		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO2_MASK),
 	AXP_DESC(AXP22X, ELDO3, "eldo3", "eldoin", 700, 3300, 100,
 		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO3_MASK),
-- 
2.24.0

