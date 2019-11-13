Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C11C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB4B2246F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610140;
	bh=B9AoKmD1xmcv4P7KtG1+SP2sJt/qlkpf6OAJSMxaA8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i/akwdAt9d0jhwOIG6EYmtCN52IlzkMuBxSYWO1EG6skhS2BENcuZrU6wmo+rOAlt
	 SUR50p48bI7fnzeTA8RhkBnBwX0r73EkqwpsN+X/VZFM80Pb+nWnql5+Qb5034e3n8
	 mbxckC5ET6qzgsmYczbgokfHRIs8Qn+hWs0ImXkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfKMBzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:55:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbfKMBzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:55:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C8672245A;
        Wed, 13 Nov 2019 01:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610131;
        bh=B9AoKmD1xmcv4P7KtG1+SP2sJt/qlkpf6OAJSMxaA8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iD6t2O3Ja1pf6aTHu8Y00fmvsikbd7xeoS9lQ+YHzvpT/qBb8aGVga2bElEf+WaYD
         w5KLVXm2N6pRYXiCBb/QUnb2ZAIRXnRLidY6Uxx+vhHedQoCnF0CxtHQbZ8mPjToJY
         fbt99eLNCg4HTYtST/AvKKOfU3+lTyfDFLyitBMQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 181/209] pinctrl: gemini: Mask and set properly
Date:   Tue, 12 Nov 2019 20:49:57 -0500
Message-Id: <20191113015025.9685-181-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit d17f477c5bc6b4a5dd9f51ae263870da132a8e89 ]

The code was written under the assumption that the
regmap_update_bits() would mask the bits in the mask and
set the bits in the value.

It missed the points that it will not set bits in the value
unless these are also masked in the mask. Set value bits
that are not in the mask will simply be ignored.

Fixes: 06351d133dea ("pinctrl: add a Gemini SoC pin controller")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-gemini.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-gemini.c b/drivers/pinctrl/pinctrl-gemini.c
index fa7d998e1d5a8..1e484a36ff07e 100644
--- a/drivers/pinctrl/pinctrl-gemini.c
+++ b/drivers/pinctrl/pinctrl-gemini.c
@@ -2184,7 +2184,8 @@ static int gemini_pmx_set_mux(struct pinctrl_dev *pctldev,
 		 func->name, grp->name);
 
 	regmap_read(pmx->map, GLOBAL_MISC_CTRL, &before);
-	regmap_update_bits(pmx->map, GLOBAL_MISC_CTRL, grp->mask,
+	regmap_update_bits(pmx->map, GLOBAL_MISC_CTRL,
+			   grp->mask | grp->value,
 			   grp->value);
 	regmap_read(pmx->map, GLOBAL_MISC_CTRL, &after);
 
-- 
2.20.1

