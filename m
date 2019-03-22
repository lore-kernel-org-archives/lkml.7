Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70186C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAA821900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257071;
	bh=3xQ6+0tMkP0xGagftQc+a0u+ihHU2NMEowSpa+VcYrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aK8JLTWIfpMlDqR/ZJsaYVSI8e+VOf/i5KXtYS9IKhI46Ku868+UOy/l/+/8HUSDU
	 UP+EJfUoHlnQRD577EDzWgHecSFc5kxvvIdE5CYDS7eDZDm8yRNsWjikE7Hx9pyASg
	 E70efXv3cQLNZp+6caCSgpndsmPBniOt5E0/MniA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390421AbfCVMRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389940AbfCVMRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8959B21900;
        Fri, 22 Mar 2019 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257066;
        bh=3xQ6+0tMkP0xGagftQc+a0u+ihHU2NMEowSpa+VcYrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wztqbj0mJ1r5STsnt/NROFOJhZCEzRFiI5XR8hNylQaVI3+eUQhjQIW6fHGCV4hoi
         MxO5DL4iQR55kuakM8Q+Duux7ID8zdmHOisBSAg3EOoxXQEsECo87XQ5YYhRe4s9G7
         sYx7H4Pr1JVqAduEWIV9Zzgb6qI6Kk6VLslE7CmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Walton <mark.walton@serialtek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.0 120/238] gpio: pca953x: Fix dereference of irq data in shutdown
Date:   Fri, 22 Mar 2019 12:15:39 +0100
Message-Id: <20190322111305.608632715@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -587,7 +587,8 @@ static int pca953x_irq_set_type(struct i
 
 static void pca953x_irq_shutdown(struct irq_data *d)
 {
-	struct pca953x_chip *chip = irq_data_get_irq_chip_data(d);
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct pca953x_chip *chip = gpiochip_get_data(gc);
 	u8 mask = 1 << (d->hwirq % BANK_SZ);
 
 	chip->irq_trig_raise[d->hwirq / BANK_SZ] &= ~mask;


