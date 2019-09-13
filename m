Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4505FC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEED205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381535;
	bh=JVGjqJW7nOPat5g2yjbUwef9IMjQa/v6mJBO8qTVE5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PPcavyiIUOkb1pyCe7hrpkppVTtRnXDs5+i/TkwRzHjfsoqJhXrcbz4j7OEg5t+OL
	 SBWJmtOeFn8w2DL/nVoy5eukrJqDs5dVkPWfDChXVZLTJwR853nr9YHM9NMMG5bTbU
	 pEyRFQNf0N16nJFQmMp4+zwHAlS1Fnd3urAg6J9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391632AbfIMNcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388760AbfIMNNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:13:34 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367F2208C0;
        Fri, 13 Sep 2019 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380413;
        bh=JVGjqJW7nOPat5g2yjbUwef9IMjQa/v6mJBO8qTVE5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSmXOEpUS9OazwT+BAf86/7PbbtD9Hlo4sEJwm+TFYr1LwHGMyz/nTJSqDSxq/iD6
         qneqO8TgcbGDZhhehVbMjb1YN73ryNMW8my9AY5qRKRu006puIDKaGBxe/naS5tXXx
         4nV/d52RErOWzTKVmmKmonMbhhC7lsiAV+l8J1d0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 057/190] ARM: davinci: dm355: define gpio interrupts as separate resources
Date:   Fri, 13 Sep 2019 14:05:12 +0100
Message-Id: <20190913130604.320198748@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 27db7baab640ea28d7994eda943fef170e347081 ]

Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
IRQ numbering") the davinci GPIO driver fails to probe if we boot
in legacy mode from any of the board files. Since the driver now
expects every interrupt to be defined as a separate resource, split
the definition of IRQ resources instead of having a single continuous
interrupt range.

Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ numbering")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-davinci/dm355.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9f7d38d12c888..2b0f5d97ab7c1 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -548,6 +548,36 @@ static struct resource dm355_gpio_resources[] = {
 	},
 	{	/* interrupt */
 		.start	= IRQ_DM355_GPIOBNK0,
+		.end	= IRQ_DM355_GPIOBNK0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK1,
+		.end	= IRQ_DM355_GPIOBNK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK2,
+		.end	= IRQ_DM355_GPIOBNK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK3,
+		.end	= IRQ_DM355_GPIOBNK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK4,
+		.end	= IRQ_DM355_GPIOBNK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK5,
+		.end	= IRQ_DM355_GPIOBNK5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM355_GPIOBNK6,
 		.end	= IRQ_DM355_GPIOBNK6,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.20.1



