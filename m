Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3A2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE0921823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141177;
	bh=b8J4MxCR33d36gDUpia1X9tMWmKY6k0ovzSnBa1tW+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pfvMkKp/9qQ2lwVimQOaADmJUAEWS5aPy1MnL7dYqqhQxUUsYLguPWBRh/EY5+PV3
	 KA3m4ua2pTELxe6EO/xj69bxN3dH35b6jzYzUNl3+Ff8/sC4POYEC4W3BohOgy/ibm
	 r9X+5jyoZ2qyaHNwg7D3o8sRzIAvY59361ONBGgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfKSF0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:26:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbfKSF0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:26:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2485222A2;
        Tue, 19 Nov 2019 05:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141172;
        bh=b8J4MxCR33d36gDUpia1X9tMWmKY6k0ovzSnBa1tW+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHHJwF7OjwrafC/WByksRFzvnygRH0L2+bZ2KB0couvaVSwbdYvoqBQLvTsjGCJ3y
         E0XmVYfTa2Z0rUZGdwRW/0S+DT0VMxxMVaCUfs2hBvDLpfSL52aPQgVEXsrtbY/VS2
         9THFqHDSSzq3y3vsZ2S7EEeCNVCiKdXhWH/yIekA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/422] pinctrl: ingenic: Probe driver at subsys_initcall
Date:   Tue, 19 Nov 2019 06:14:27 +0100
Message-Id: <20191119051404.162474836@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
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
index 628817c40e3bb..a5accffbc8c91 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -847,4 +847,4 @@ static int __init ingenic_pinctrl_drv_register(void)
 {
 	return platform_driver_register(&ingenic_pinctrl_driver);
 }
-postcore_initcall(ingenic_pinctrl_drv_register);
+subsys_initcall(ingenic_pinctrl_drv_register);
-- 
2.20.1



