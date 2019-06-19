Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203AEC31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F00206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560948171;
	bh=1iswHEKvg2N6GFKVSrd6ivye0IWOxcy+C74XG2ERJsg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=u+4uL2rCGrxKbKct9pSyrN120zelR3pkuSchCNKVuqTG705JGfokjNvCrkTwr6U2N
	 ghuyRVer9MbPSYk6NmIH9WlZ3fceIU/dIhku03qrzx39aTT3+Wz8/tbBCRVZs6mWG+
	 7HtMXfuUP6yLwTwMH3swwAug8u2iZJ0cCfm/xGkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfFSMmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfFSMmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:42:49 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE1EF214AF;
        Wed, 19 Jun 2019 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560948168;
        bh=1iswHEKvg2N6GFKVSrd6ivye0IWOxcy+C74XG2ERJsg=;
        h=From:To:Cc:Subject:Date:From;
        b=JgJwMZptZUvOqcBvcdXvtgsqNx17SlRbDIx/rSD1FVT3s2GoPQUJbd64Oeh6nzYpI
         FDT04Ylqzmi8R+NW7w47hUXk9qwGbPDsW9ysemPJnrRMTNPHa80Yh3gYTQElBfRHs1
         O2fghrXjC+1ogUvuIuub8nYG/ghaxbJmmcAnI3AQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Georg Waibel <georg.waibel@sensor-technik.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        stable@vger.kernel.org
Subject: [PATCH] regulator: s2mps11: Fix ERR_PTR dereference on GPIO lookup failure
Date:   Wed, 19 Jun 2019 14:42:39 +0200
Message-Id: <1560948159-21926-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_gpiod_get_from_of_node() call returns ERR_PTR, it is assigned
into an array of GPIO descriptors and used later because such error is
not treated as critical thus it is not propagated back to the probe
function.

All code later expects that such GPIO descriptor is either a NULL or
proper value.  This later might lead to dereference of ERR_PTR.

Only devices with S2MPS14 flavor are affected (other do not control
regulators with GPIOs).

Fixes: 1c984942f0a4 ("regulator: s2mps11: Pass descriptor instead of GPIO number")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

The exact error condition was not tested because I do not have board
with S2MPS14.
---
 drivers/regulator/s2mps11.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 134c62db36c5..af9bf10b4c33 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -824,6 +824,7 @@ static void s2mps14_pmic_dt_parse_ext_control_gpio(struct platform_device *pdev,
 		if (IS_ERR(gpio[reg])) {
 			dev_err(&pdev->dev, "Failed to get control GPIO for %d/%s\n",
 				reg, rdata[reg].name);
+			gpio[reg] = NULL;
 			continue;
 		}
 		if (gpio[reg])
-- 
2.7.4

