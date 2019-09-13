Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DA4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9610420CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380414;
	bh=fTdydRAG0ACdJvI0xiVA1m9//UbvpqcZy5jCvHIbrFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dTnfLDf8I+dBXDH9hYMP50MMecDh9xIK2Eed/gCaHZx7P360eALkwi/hExWfLOtVf
	 kdIDv692f3zVyqeE8BNbyxUH0dkLbsdk0A79ebkLlSWqbPuI2Uxy3qjPgVOwmtrPPZ
	 gFiZZkBtTrrMhHNuypA/PVnfVbsncdWwJJKuIH9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389353AbfIMNNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388760AbfIMNN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:13:28 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C54D208C0;
        Fri, 13 Sep 2019 13:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380407;
        bh=fTdydRAG0ACdJvI0xiVA1m9//UbvpqcZy5jCvHIbrFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HA3pMpTJehNK2EnnmR6zRJT7CG7eOBMqbPetSLHFwT0Vowj6939LQt/IA7WbyGdCX
         DniR7LKnlLer9DWghvXAUI87Rw/Y8gdrsiAzWqscZFyAJrhWZW59oyycviNmY4oWeM
         o+cIvb+ehV9sQQAwM7EOCjIYNSQlYg3r0N7Ewlmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/190] ARM: davinci: dm365: define gpio interrupts as separate resources
Date:   Fri, 13 Sep 2019 14:05:10 +0100
Message-Id: <20190913130604.171670390@linuxfoundation.org>
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

[ Upstream commit 193c04374e281a56c7d4f96e66d329671945bebe ]

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
 arch/arm/mach-davinci/dm365.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index abcf2a5ed89b5..42665914166a3 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -267,6 +267,41 @@ static struct resource dm365_gpio_resources[] = {
 	},
 	{	/* interrupt */
 		.start	= IRQ_DM365_GPIO0,
+		.end	= IRQ_DM365_GPIO0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO1,
+		.end	= IRQ_DM365_GPIO1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO2,
+		.end	= IRQ_DM365_GPIO2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO3,
+		.end	= IRQ_DM365_GPIO3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO4,
+		.end	= IRQ_DM365_GPIO4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO5,
+		.end	= IRQ_DM365_GPIO5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO6,
+		.end	= IRQ_DM365_GPIO6,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DM365_GPIO7,
 		.end	= IRQ_DM365_GPIO7,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.20.1



