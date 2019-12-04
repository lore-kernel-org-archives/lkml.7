Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6EAC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6A620675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483102;
	bh=ugYxtUEhfaxxCeJcLPhxQolv4YrUrUZ2A46DJSr1QSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f4l7RDtR/t1SW8nbYp1cO6ehkFKUTcHRmY5tggqdy/Y9B1rWELwdj44281pnTc9VS
	 JAFWogWvumfD5Hu+/zL6YXekbcMwYeIXyDZup0YGX7ETxAZYaBe81VHC/rTnO4zmxF
	 rz/jkEHs95LFHJWPwdpXK+YtqH32io9Xhc7uS868=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfLDSLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731490AbfLDSLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:11:39 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E1820674;
        Wed,  4 Dec 2019 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483098;
        bh=ugYxtUEhfaxxCeJcLPhxQolv4YrUrUZ2A46DJSr1QSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nETSGms7TScCQQUGVXB3PAgM+i57TJQKjuz0q1P5n9uhOiAdoLTQaPrPAoHZClLt9
         L5N6dS+2gyBAcdx/RgLIOppR+d1l6Pew/xrM/A9k+9Cgwd6qwtoWQk/3NfV/TzL77C
         zKjaEgsr0py/doo8dAaiJk3S4DcD6fZqqGnV0h/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 052/125] drivers/regulator: fix a missing check of return value
Date:   Wed,  4 Dec 2019 18:55:57 +0100
Message-Id: <20191204175322.157146415@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 966e927bf8cc6a44f8b72582a1d6d3ffc73b12ad ]

If palmas_smps_read() fails, we should not use the read data in "reg"
which may contain random value. The fix inserts a check for the return
value of palmas_smps_read(): If it fails, we return the error code
upstream and stop using "reg".

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/palmas-regulator.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index f11d41dad9c13..1eb605b6f0492 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -435,13 +435,16 @@ static int palmas_ldo_write(struct palmas *palmas, unsigned int reg,
 static int palmas_set_mode_smps(struct regulator_dev *dev, unsigned int mode)
 {
 	int id = rdev_get_id(dev);
+	int ret;
 	struct palmas_pmic *pmic = rdev_get_drvdata(dev);
 	struct palmas_pmic_driver_data *ddata = pmic->palmas->pmic_ddata;
 	struct palmas_regs_info *rinfo = &ddata->palmas_regs_info[id];
 	unsigned int reg;
 	bool rail_enable = true;
 
-	palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
+	ret = palmas_smps_read(pmic->palmas, rinfo->ctrl_addr, &reg);
+	if (ret)
+		return ret;
 
 	reg &= ~PALMAS_SMPS12_CTRL_MODE_ACTIVE_MASK;
 
-- 
2.20.1



