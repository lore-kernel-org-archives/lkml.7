Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DD9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B626D2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428345;
	bh=Hf6q3RVLx0RTBYeYq9ySadC1n+VmlTVFJ7TzbNYwkRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kB8L2bYbX+IMwRCwBHHxNsttFzZi1GzX0XpHvf4sqwDydR6xkVbwWLphGIvkZScK8
	 jNTe8JW7FbaiPG8MMmDIYBafQ8Up+nafOt7wxAN+T6IrhLGRmQORqy3KViRFOurGal
	 I1YBvVpmHuU6CsV7lqJe6MK3IWaF9NAQqM1NfoGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfG2TZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbfG2TZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:25:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BEC221773;
        Mon, 29 Jul 2019 19:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428341;
        bh=Hf6q3RVLx0RTBYeYq9ySadC1n+VmlTVFJ7TzbNYwkRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3Kw6SgWpVnhWPT7FBcLV9CAxEPX+0jEF6AWR1A5VSMIcmUVJQJAKYE97PIc/2JI8
         aCfPuOk9WX+v32kWNyoH6BjxPPf6iP/9kQa9Y0uAYsHJ6043XY/qcUnUbQKj+rdbDd
         gcRf90Q335yu/whNVFGcnY73XLy3n6k2g0kyxV/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 045/293] gpio: omap: fix lack of irqstatus_raw0 for OMAP4
Date:   Mon, 29 Jul 2019 21:18:56 +0200
Message-Id: <20190729190826.445716184@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 64ea3e9094a1f13b96c33244a3fb3a0f45690bd2 ]

Commit 384ebe1c2849 ("gpio/omap: Add DT support to GPIO driver") added
the register definition tables to the gpio-omap driver. Subsequently to
that commit, commit 4e962e8998cc ("gpio/omap: remove cpu_is_omapxxxx()
checks from *_runtime_resume()") added definitions for irqstatus_raw*
registers to the legacy OMAP4 definitions, but missed the DT
definitions.

This causes an unintentional change of behaviour for the 1.101 errata
workaround on OMAP4 platforms. Fix this oversight.

Fixes: 4e962e8998cc ("gpio/omap: remove cpu_is_omapxxxx() checks from *_runtime_resume()")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-omap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 83c6843db50c..abe54659b1f4 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1604,6 +1604,8 @@ static struct omap_gpio_reg_offs omap4_gpio_regs = {
 	.clr_dataout =		OMAP4_GPIO_CLEARDATAOUT,
 	.irqstatus =		OMAP4_GPIO_IRQSTATUS0,
 	.irqstatus2 =		OMAP4_GPIO_IRQSTATUS1,
+	.irqstatus_raw0 =	OMAP4_GPIO_IRQSTATUSRAW0,
+	.irqstatus_raw1 =	OMAP4_GPIO_IRQSTATUSRAW1,
 	.irqenable =		OMAP4_GPIO_IRQSTATUSSET0,
 	.irqenable2 =		OMAP4_GPIO_IRQSTATUSSET1,
 	.set_irqenable =	OMAP4_GPIO_IRQSTATUSSET0,
-- 
2.20.1



