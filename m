Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967E7C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60245208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142462;
	bh=wuXGaCurOLNVfx79qh8djeDpvCXeYHqq5oLCFT/3IoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oKaiiZP919PyPDMThbIV8yCHKSW+2e0tHnIWfFdTAdd/rDXdu1pIZEQVJpas/f2CC
	 v2pzQiL79e3i+rfxhbgsVm1JCARDsCFg07CVMkcSdVbF0svJyn/flKRnT/efy3iYT4
	 jbDFSrfl9+ABNqvxaAfFN+4yMIJ3X1T/gscPiafs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfKSFrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbfKSFrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:47:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1158D2071B;
        Tue, 19 Nov 2019 05:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142452;
        bh=wuXGaCurOLNVfx79qh8djeDpvCXeYHqq5oLCFT/3IoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WA78rO9wQg6OpiIXiZW7ewND2n5jMMBWQSwpOJZEz1EiL+2TbouySpLUzobK5Xswv
         wxn74EyDb0NsEgS+boFmD3V1MmQWLT/j77bUDxldlDpNyCjffN2WTg0EPxZIblSG/z
         ZamXsqF6e8CECRCbJTm9+Vk7Gmrji7ohO/ntCyJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 046/239] pinctrl: ingenic: Probe driver at subsys_initcall
Date:   Tue, 19 Nov 2019 06:17:26 +0100
Message-Id: <20191119051306.506990365@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit 556a36a71ed80e17ade49225b58513ea3c9e4558 ]

Using postcore_initcall() makes the driver try to initialize way too
early.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-ingenic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 103aaab413570..1541f8cba5562 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -849,4 +849,4 @@ static int __init ingenic_pinctrl_drv_register(void)
 {
 	return platform_driver_register(&ingenic_pinctrl_driver);
 }
-postcore_initcall(ingenic_pinctrl_drv_register);
+subsys_initcall(ingenic_pinctrl_drv_register);
-- 
2.20.1



