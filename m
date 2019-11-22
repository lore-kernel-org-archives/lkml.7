Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2C42075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401907;
	bh=W70HprwceHM95eqhp/i6jc2jryBT4sBo1lOQnbLjKaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yoF0dqKLi2c+PfH4Tqk6yaVsS4gCC3ElNRrmMBb+zFp2kxiUu9hZ2o0CIXxRsYuk+
	 YL0GUr9RFbuip3uxJi1/C14y0EOOUdRmNloTEmfXNEvFPWuL1mfO8u+T+2P7JjTYGM
	 qdkQ1yChUPO4gHjrQEPv3dNsAPVMf+lwgvWeo9JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfKVFvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:51:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbfKVFvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C4320731;
        Fri, 22 Nov 2019 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401899;
        bh=W70HprwceHM95eqhp/i6jc2jryBT4sBo1lOQnbLjKaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zraj3XOC9qzcRGFtsXh0a2lU6myxiXPguvCx76JH+RjWie28OV9ZdmaTH+bZG/n0t
         N0Eclgduj7YxwXdEcyqteTunAKJC6DgA5C5p9rIlvo0Vt8VVFSdmnCi2yDkQgTuEnZ
         ixuc76009S0J5qbXVZTkGd2KXSSNbwhcrt7rpNf4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 131/219] regulator: tps65910: fix a missing check of return value
Date:   Fri, 22 Nov 2019 00:47:43 -0500
Message-Id: <20191122054911.1750-124-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit cd07e3701fa6a4c68f8493ee1d12caa18d46ec6a ]

tps65910_reg_set_bits() may fail. The fix checks if it fails, and if so,
returns with its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/tps65910-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 02ccdaa226a73..5ebb6ee73f077 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1102,8 +1102,10 @@ static int tps65910_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pmic);
 
 	/* Give control of all register to control port */
-	tps65910_reg_set_bits(pmic->mfd, TPS65910_DEVCTRL,
+	err = tps65910_reg_set_bits(pmic->mfd, TPS65910_DEVCTRL,
 				DEVCTRL_SR_CTL_I2C_SEL_MASK);
+	if (err < 0)
+		return err;
 
 	switch (tps65910_chip_id(tps65910)) {
 	case TPS65910:
-- 
2.20.1

