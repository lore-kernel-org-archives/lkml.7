Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A2CC4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B39205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381532;
	bh=nk59i1IOXVwOCufAOKgS306v4NGavhc1fPFhC9tp2Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foPxp6TG/S9Lbv3flfJldv54S2HXaLquUYqSRPzAfwh1eA1q2t3M+Kw0+8X7Q2iDk
	 GU0RotaMoeaflU+0dk/n+8N91Cvm5RJpCQieg7FyQo04JWBrOGdSkrBJNBtxyJNjaj
	 t0QSmst7fmeCh/PO6OFuVRO0vRl2s8dfvxRskjSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389362AbfIMNNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388758AbfIMNNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:13:31 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 301E820CC7;
        Fri, 13 Sep 2019 13:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380410;
        bh=nk59i1IOXVwOCufAOKgS306v4NGavhc1fPFhC9tp2Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Io1JnEzFQ3RMCRxhqy6NuvfdnvVHcE4oRmwLfnBPGkP7VIjMrd6LZUo5VSUTZfMa2
         nuQkzNNGQFoMGWw0v3SVGEBFWAT+OSA5k2ihiHtqqOQZrOarLsGwxxcRmhcb78Pqh7
         b4/5V6YFiPR7ymLyLNrv7BR4lR5WUkRhWhcBVeW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 056/190] ARM: davinci: dm646x: define gpio interrupts as separate resources
Date:   Fri, 13 Sep 2019 14:05:11 +0100
Message-Id: <20190913130604.247214425@linuxfoundation.org>
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

[ Upstream commit 2c9c83491f30afbce25796e185cd4d5e36080e31 ]

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
 arch/arm/mach-davinci/dm646x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 6bd2ed069d0d7..d9b93e2806d22 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -442,6 +442,16 @@ static struct resource dm646x_gpio_resources[] = {
 	},
 	{	/* interrupt */
 		.start	= IRQ_DM646X_GPIOBNK0,
+		.end	= IRQ_DM646X_GPIOBNK0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM646X_GPIOBNK1,
+		.end	= IRQ_DM646X_GPIOBNK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM646X_GPIOBNK2,
 		.end	= IRQ_DM646X_GPIOBNK2,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.20.1



