Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F51C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5790217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909887;
	bh=RCUOOEFSPoIPTcT0oo4nFg3T6VQxpYUL7Yvs6SY36mU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Uo5EagnJWRAPUG2cBToOjUUJHgPIvhZhC0ap1aIp95RSaaaUcRdQj6McJFtFzcTsD
	 ShR24YExRBN1Hw0M3SqmIg6G6M/qY1bzP97J0s/Wa6+v2tdxUNFd/onjWzvn226kj5
	 287XeRj3Hw4Qatz1pI7J6XgqWZ8ZQYIMtaNoGkvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbfC3BaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731481AbfC3BaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3E321773;
        Sat, 30 Mar 2019 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909422;
        bh=RCUOOEFSPoIPTcT0oo4nFg3T6VQxpYUL7Yvs6SY36mU=;
        h=From:To:Cc:Subject:Date:From;
        b=XSFAgra34igHZEurbANja3w7v1yVe0ZPxlGX4siYoVK6m42fM+JXDbUMgbEgh995v
         CbETXCT0mN7jtjK78iiCt7vZxaPGriotGfXyVVdmqXwLMOfgivKRTU/w7mAvtqZw5w
         izMgsMLS9R8oVFKNwY+cF7mCpM1gzXl2kYi/DDCM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 01/37] gpio: pxa: handle corner case of unprobed device
Date:   Fri, 29 Mar 2019 21:29:44 -0400
Message-Id: <20190330013020.379-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Jarzmik <robert.jarzmik@free.fr>

[ Upstream commit 9ce3ebe973bf4073426f35f282c6b955ed802765 ]

In the corner case where the gpio driver probe fails, for whatever
reason, the suspend and resume handlers will still be called as they
have to be registered as syscore operations. This applies as well when
no probe was called while the driver has been built in the kernel.

Nicolas tracked this in :
https://bugzilla.kernel.org/show_bug.cgi?id=200905

Therefore, add a failsafe in these function, and test if a proper probe
succeeded and the driver is functional.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Reported-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pxa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 2943dfc4c470..822ad220f0af 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -776,6 +776,9 @@ static int pxa_gpio_suspend(void)
 	struct pxa_gpio_bank *c;
 	int gpio;
 
+	if (!pchip)
+		return 0;
+
 	for_each_gpio_bank(gpio, c, pchip) {
 		c->saved_gplr = readl_relaxed(c->regbase + GPLR_OFFSET);
 		c->saved_gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
@@ -794,6 +797,9 @@ static void pxa_gpio_resume(void)
 	struct pxa_gpio_bank *c;
 	int gpio;
 
+	if (!pchip)
+		return;
+
 	for_each_gpio_bank(gpio, c, pchip) {
 		/* restore level with set/clear */
 		writel_relaxed(c->saved_gplr, c->regbase + GPSR_OFFSET);
-- 
2.19.1

