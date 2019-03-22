Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED575C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF08D2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260346;
	bh=HEnctarEk+OZmzCNsuCh4rOsl1+QORtHC0TpmFVewaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NCuQKDRh2yooqM0L6oTyvXb5QE45CM7+0ppYpJ99n8qVxyX1jaS+BVf1Bs8URTsAh
	 FqYrlyY5a8OP/uJy1kO9VmP7DhGSuZr12JdO1Yg1+4+WmYsiV0cnylm+112BBbbixf
	 Ts+xBdpwi+pQJiVluabAlKokaavoVM0XrjMlbH48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfCVLbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbfCVLbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F12218B0;
        Fri, 22 Mar 2019 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254301;
        bh=HEnctarEk+OZmzCNsuCh4rOsl1+QORtHC0TpmFVewaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKGMb4A0ocJYwcoeu5YctHCU456526AFqASNMikmW4l1ArBOIvKALjzE3+kVlAvjg
         QVfQqt2nzUYPYf1u4M8NUf4yq2VsJ3hkqTBIGnvyX5Vmd0PbGbfLckMv7VGHfG2bna
         KqeAsWazSnCJrqUYTFtPQMk1nTIbv+JGHlCeMZ70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 093/230] gpio: vf610: Mask all GPIO interrupts
Date:   Fri, 22 Mar 2019 12:13:51 +0100
Message-Id: <20190322111243.141823241@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7ae710f9f8b2cf95297e7bbfe1c09789a7dc43d4 ]

On SoC reset all GPIO interrupts are disable. However, if kexec is
used to boot into a new kernel, the SoC does not experience a
reset. Hence GPIO interrupts can be left enabled from the previous
kernel. It is then possible for the interrupt to fire before an
interrupt handler is registered, resulting in the kernel complaining
of an "unexpected IRQ trap", the interrupt is never cleared, and so
fires again, resulting in an interrupt storm.

Disable all GPIO interrupts before registering the GPIO IRQ chip.

Fixes: 7f2691a19627 ("gpio: vf610: add gpiolib/IRQ chip driver for Vybrid")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-vf610.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 87b950cec6ec..db95c4b99a74 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -227,6 +227,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct vf610_gpio_port *port;
 	struct resource *iores;
 	struct gpio_chip *gc;
+	int i;
 	int ret;
 
 	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
@@ -265,6 +266,10 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	/* Mask all GPIO interrupts */
+	for (i = 0; i < gc->ngpio; i++)
+		vf610_gpio_writel(0, port->base + PORT_PCR(i));
+
 	/* Clear the interrupt status register for all GPIO's */
 	vf610_gpio_writel(~0, port->base + PORT_ISFR);
 
-- 
2.19.1



