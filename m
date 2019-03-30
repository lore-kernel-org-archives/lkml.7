Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE27DC10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A497021773
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909340;
	bh=hH1uzSL2wUAqDKa5Db1ZaxJpggmglsG5piYbWiLYvOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kY1LVwooOPd1ROWL1dD5BACP/ma2sihWRZZGYVBJMK76KxfHrYlAioGZdqM+GQRZX
	 pt+Ko1TmyY//vDK5SWj5EuG9Oic5nAaILCPGYNsi1AV65eKDH/PrwrC/YdJf9/rmO6
	 5Kzx3AD0l4FfDjJTZr1gTXCFvLTwHAagsIj+/bl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfC3B27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbfC3B26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:28:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6264D2184C;
        Sat, 30 Mar 2019 01:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909337;
        bh=hH1uzSL2wUAqDKa5Db1ZaxJpggmglsG5piYbWiLYvOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xsGywjR2WCMv8OYX23Mmo/bcibbJmdlw74DPSV5EwULq0eNVwAnQcdUzktZSM1d/C
         LyoqwoLcxzL65n23B2GZkT0kKYOtKFU7czt3fPbuCgb9RbHwO/gzGQONKJhpqtBr8O
         A7+R5ZSyO+qwyaoEYwF6XR0FVIaY/x6ICrn1ugLA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/57] gpio: pxa: handle corner case of unprobed device
Date:   Fri, 29 Mar 2019 21:27:55 -0400
Message-Id: <20190330012854.32212-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
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
index eb27fa76e8fc..bcc6be4a5cb2 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -777,6 +777,9 @@ static int pxa_gpio_suspend(void)
 	struct pxa_gpio_bank *c;
 	int gpio;
 
+	if (!pchip)
+		return 0;
+
 	for_each_gpio_bank(gpio, c, pchip) {
 		c->saved_gplr = readl_relaxed(c->regbase + GPLR_OFFSET);
 		c->saved_gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
@@ -795,6 +798,9 @@ static void pxa_gpio_resume(void)
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

