Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD70C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0917205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414107;
	bh=bwamKd7iJugdJM08yF7xZRy1HWxJ7NbPKVtw5jZbJSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cT2uB08uNAewqexmnvp/Q8KIUE7dEdTCjhw/ixmwv24Z5RDC0TZzNCW/D5KzjGbQ3
	 WGEjR3m0ksR4MTT5YjlYRNJyN8XP+0vHouFtIjV43TJGTREK+dSdLn+yKrKsK59rQa
	 ksYl+qXBPXHLtRwYPcasZib8Illsd3moCQNQ77zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfCLSIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfCLRMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:14 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E515C2087C;
        Tue, 12 Mar 2019 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410734;
        bh=bwamKd7iJugdJM08yF7xZRy1HWxJ7NbPKVtw5jZbJSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iu6z86szABI+u7in2zncxEuA/oDtxVjdSiBI8kfkX1bjzQnFBc795bGiZfF4Rux6h
         bV4Bt9g1UYWl+2qN8xc3csQDDR/Z97b9VHtqbRCaw4XwS9qh4+z5vIRizwjwd/Qo6j
         wiTv/xcWs1+rtDsPv29nVeCp6925figD49oV/2U0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 037/171] gpio: vf610: Mask all GPIO interrupts
Date:   Tue, 12 Mar 2019 10:06:57 -0700
Message-Id: <20190312170351.268280430@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 5960396c8d9a..222170a1715f 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -250,6 +250,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct vf610_gpio_port *port;
 	struct resource *iores;
 	struct gpio_chip *gc;
+	int i;
 	int ret;
 
 	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
@@ -289,6 +290,10 @@ static int vf610_gpio_probe(struct platform_device *pdev)
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



