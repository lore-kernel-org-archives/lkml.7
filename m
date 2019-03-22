Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE3EC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714C1218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258504;
	bh=SlmMQn8UKjqxEKFtDrGA2kG96/vOXNGq0ql6KTE4eVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qlNHUd/eKG8oi0uEPLEvo5mnfPzHoSnsrstoK7ioIkAj/v9RzbTnN2+QcEqm5/uIX
	 J0emqXQblOC7Jagz8YpuvHuU0blzCCtoUr6JE+UwOuZk+cEwVUcFydIVF2OZ5ye/J2
	 MP0AU1mPVHlQPwa18YxwR9bve0G7fOnX1B/mucdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbfCVMHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389011AbfCVMHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:07:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 071FD2082C;
        Fri, 22 Mar 2019 12:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256435;
        bh=SlmMQn8UKjqxEKFtDrGA2kG96/vOXNGq0ql6KTE4eVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WM3feymXiPpBMqbiB6bPDnPuBd9CzqxuG05VGFNplqQdU/CuiZb+dfhbkTqm4t/Bj
         faUsRDRlAbHnA8uUyMgxDH/pBVjRFPOm2XYUiPQpsN9hWxBqFFd0tQ7y5nB/xIreO8
         eEnVHu0C54REloR0DhVMuFEhY8TFP733s4/6P77g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Walton <mark.walton@serialtek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 209/280] gpio: pca953x: Fix dereference of irq data in shutdown
Date:   Fri, 22 Mar 2019 12:16:02 +0100
Message-Id: <20190322111332.450517669@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Walton <mark.walton@serialtek.com>

commit c378b3aa015931a46c91d6ccc2fe04d97801d060 upstream.

If a PCA953x gpio was used as an interrupt and then released,
the shutdown function was trying to extract the pca953x_chip
pointer directly from the irq_data, but in reality was getting
the gpio_chip structure.

The net effect was that the subsequent writes to the data
structure corrupted data in the gpio_chip structure, which wasn't
immediately obvious until attempting to use the GPIO again in the
future, at which point the kernel panics.

This fix correctly extracts the pca953x_chip structure via the
gpio_chip structure, as is correctly done in the other irq
functions.

Fixes: 0a70fe00efea ("gpio: pca953x: Clear irq trigger type on irq shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Walton <mark.walton@serialtek.com>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-pca953x.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -543,7 +543,8 @@ static int pca953x_irq_set_type(struct i
 
 static void pca953x_irq_shutdown(struct irq_data *d)
 {
-	struct pca953x_chip *chip = irq_data_get_irq_chip_data(d);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct pca953x_chip *chip = gpiochip_get_data(gc);
 	u8 mask = 1 << (d->hwirq % BANK_SZ);
 
 	chip->irq_trig_raise[d->hwirq / BANK_SZ] &= ~mask;


