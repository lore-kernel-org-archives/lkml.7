Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B82FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641D520656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215120;
	bh=b8J4MxCR33d36gDUpia1X9tMWmKY6k0ovzSnBa1tW+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O9SgbMkEoxAWAwQrSXITEUG7yjTT8BWOgKxD+xvLCTdzxfBcpB58c1ya76SGR2TSa
	 g4mBgl6BOUF3mD8r3gZ2t4539sB1qRNFJaVwMDHdg1ugzc2oMtW84MhXmNb1Pf1e5o
	 yVpl7dYNz4uRwHoHHl4w7TyNl9qa8RZM+kQuqMus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfKHLiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732752AbfKHLij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0834420869;
        Fri,  8 Nov 2019 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213118;
        bh=b8J4MxCR33d36gDUpia1X9tMWmKY6k0ovzSnBa1tW+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z20l18vjnP1kOM49pgk7tZQfaK5ADDSl+8yIU6Gxg4/lsYzGdENXUDOGCBE5cK/0J
         FBI7P4xkf91V1q21MRj2oXr156rcX88k2PTqvHvZJXhV+1537r1FT9ZTwQJtt+c1t9
         LdLa/0pv5ZYkHbk9c3RGzHt10DvDjp1jBAB3ph7M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 038/205] pinctrl: ingenic: Probe driver at subsys_initcall
Date:   Fri,  8 Nov 2019 06:35:05 -0500
Message-Id: <20191108113752.12502-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

