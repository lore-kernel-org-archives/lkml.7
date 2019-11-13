Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EC1C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A885C222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611059;
	bh=5ZZg/xigrTA2+oyrMBGTOMx97kcHllNc7EFKeSaV/nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1aUvXboQfmhfDYsfM6YfsDMPKQIkNl0uXY/p54TggjIDK5Nv+AzX7mXzcFY68suV
	 qUO+GEyzYzCfX2yolfjCBBAuY4uMsNxPqYVP0uSq2zFHjHSjsj2wx7xyu0FZcJQmGn
	 bpJiYgnFsQhx0YkVcHLVFks4Dvumg3gGAph5OE+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfKMCK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:10:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730189AbfKMB7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:59:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E74982245C;
        Wed, 13 Nov 2019 01:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610345;
        bh=5ZZg/xigrTA2+oyrMBGTOMx97kcHllNc7EFKeSaV/nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2wlO7nX42rkhdsh5Tcqz6SaRMPhupdg/d15Oxzo7UQd0uMBQkGVsH7kombVhMYRB
         8rWLg8DSVdk9jiPBt4HcTLZS1iYKhLlCW9OFkInDm2K6WDlZHxqBsn3PAeHtb1mboS
         FufOOeSijuyMmEkdhkbRmg/02s9jV25mkULuS7eY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 098/115] pinctrl: gemini: Mask and set properly
Date:   Tue, 12 Nov 2019 20:56:05 -0500
Message-Id: <20191113015622.11592-98-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
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
index 39e6221e71000..05441dc2519d2 100644
--- a/drivers/pinctrl/pinctrl-gemini.c
+++ b/drivers/pinctrl/pinctrl-gemini.c
@@ -2164,7 +2164,8 @@ static int gemini_pmx_set_mux(struct pinctrl_dev *pctldev,
 		 func->name, grp->name);
 
 	regmap_read(pmx->map, GLOBAL_MISC_CTRL, &before);
-	regmap_update_bits(pmx->map, GLOBAL_MISC_CTRL, grp->mask,
+	regmap_update_bits(pmx->map, GLOBAL_MISC_CTRL,
+			   grp->mask | grp->value,
 			   grp->value);
 	regmap_read(pmx->map, GLOBAL_MISC_CTRL, &after);
 
-- 
2.20.1

