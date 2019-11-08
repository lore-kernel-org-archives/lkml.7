Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BBFFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F9A207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214491;
	bh=wuXGaCurOLNVfx79qh8djeDpvCXeYHqq5oLCFT/3IoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cH8OGMPNkm30Hfqt+Pt1UU1IAHQNxb3G8CLAmB0HCQCN9tdkwAjGkPiT6N8a1nfvk
	 2uYFnxfSduban72hS+l5tFyuWISFoy6waQJ9kbvgHZBQ526/w5KwS4KyG9o/JNO9f2
	 a7R3h8ULsOvUts2tSJJ2R5MRhfoDHpDVxKA8n7fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbfKHMB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390500AbfKHLnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EC322466;
        Fri,  8 Nov 2019 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213416;
        bh=wuXGaCurOLNVfx79qh8djeDpvCXeYHqq5oLCFT/3IoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQMuBfyi00Ql5kRZmg/M+HKDQNnpzaaxj0v0zx6f0FqPnQYbkreJNOHzvZkj3Q2kU
         YMKgSgVZjlJgPSV0XjpLOVY6sCygQGj2wWomhUGFV5l9XgfJFgmSxOvKk5htlm+X7B
         P//2Aq/zNfIC4+JA0aRh8l/gk6xj7kz5h64VZcuI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 019/103] pinctrl: ingenic: Probe driver at subsys_initcall
Date:   Fri,  8 Nov 2019 06:41:44 -0500
Message-Id: <20191108114310.14363-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
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

