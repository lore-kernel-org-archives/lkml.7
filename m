Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D53C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BF520652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610960;
	bh=yoddK5QqcQmZGItL79TOqBxBAOmkqU6Un+jyd8hak3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xj4KF6ROo62SrL4CNbIm2EBWqFbL+BUFRT488uh3DEx5d8gN5J+wyDk4E+UIwVyGh
	 lnGSBKlbRCwCsi19jLcJwnI0oX/IcniGUPj9hKCcOXrZPa6uGYs9DwHAPJJ1HHBjt5
	 CShUAb5O0FkVUPvTv8thtGS2tkgG/IbbfL0RCC04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391874AbfDRSJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391573AbfDRSJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB0820652;
        Thu, 18 Apr 2019 18:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610956;
        bh=yoddK5QqcQmZGItL79TOqBxBAOmkqU6Un+jyd8hak3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+FvfvJ8lFf003xKpyp3P2ibPiFDNozhrLxdN4ChLykg2YCCKbTpFwdT03EahZL3d
         KQJMjjpxkUb0me/fkyTX2hLO3li7aEc5iS1U9axCcVft59Ou60y6hMUmDap1Vlj+NB
         /jWYviKduPuQ9K3SoqW3qK2B+J9UPgSvuvzes9NI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 28/50] gpio: pxa: handle corner case of unprobed device
Date:   Thu, 18 Apr 2019 19:57:39 +0200
Message-Id: <20190418160426.247037254@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 7a6305884f97..32d22bdf7164 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -774,6 +774,9 @@ static int pxa_gpio_suspend(void)
 	struct pxa_gpio_bank *c;
 	int gpio;
 
+	if (!pchip)
+		return 0;
+
 	for_each_gpio_bank(gpio, c, pchip) {
 		c->saved_gplr = readl_relaxed(c->regbase + GPLR_OFFSET);
 		c->saved_gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
@@ -792,6 +795,9 @@ static void pxa_gpio_resume(void)
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



