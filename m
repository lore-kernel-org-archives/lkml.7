Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC21C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A8020CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380422;
	bh=YvyDWklJCrKfGCt1MB3mRdFJB9/QsF7+nu9ikBe8SpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1jy+9EK+zVoNSXBljg/W2iS4GM6g9A0qcsjpoTtK11nISGex0xxkczLmkqj8+Uqdo
	 Hag1X8H4lqJqCiaJZUwK/f2kSuxAw2x+WEx0iZ9hPMC3IElCVtaB/5jz8lfLK1K5kD
	 PdfHgLQSjB+54RImmcHL8nfnEMvMRJNx3ZczkZnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbfIMNNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389360AbfIMNNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:13:38 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30193208C0;
        Fri, 13 Sep 2019 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380416;
        bh=YvyDWklJCrKfGCt1MB3mRdFJB9/QsF7+nu9ikBe8SpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MazBOqsq4HDKssN0VCoqT4vRlnhJ4uP29RGiWjGHBmMw3ORqe0wMzk2D/d6CXEOk1
         8C7lWhSeYc5OnZq/sxPcqD7mnraX937qqdi4lfJDsrvroow4pOiqYvBKYlzXnhn8H2
         LFdO6mfi/t42NJY6tGVcbMgdrxZc5eyTyHGJvLhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/190] ARM: davinci: dm644x: define gpio interrupts as separate resources
Date:   Fri, 13 Sep 2019 14:05:13 +0100
Message-Id: <20190913130604.393093655@linuxfoundation.org>
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

[ Upstream commit adcf60ce14c8250761af9de907eb6c7d096c26d3 ]

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
 arch/arm/mach-davinci/dm644x.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 0720da7809a69..de1ec6dc01e94 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -492,6 +492,26 @@ static struct resource dm644_gpio_resources[] = {
 	},
 	{	/* interrupt */
 		.start	= IRQ_GPIOBNK0,
+		.end	= IRQ_GPIOBNK0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_GPIOBNK1,
+		.end	= IRQ_GPIOBNK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_GPIOBNK2,
+		.end	= IRQ_GPIOBNK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_GPIOBNK3,
+		.end	= IRQ_GPIOBNK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_GPIOBNK4,
 		.end	= IRQ_GPIOBNK4,
 		.flags	= IORESOURCE_IRQ,
 	},
-- 
2.20.1



