Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8449C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE31420650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392697AbfIFIqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:46:02 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:33688 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391700AbfIFIpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:45:44 -0400
Received: from ramsan ([84.194.98.4])
        by baptiste.telenet-ops.be with bizsmtp
        id y8lg2000x05gfCL018lhml; Fri, 06 Sep 2019 10:45:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i69sC-0003Mz-T2; Fri, 06 Sep 2019 10:45:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i69sC-0005h1-QK; Fri, 06 Sep 2019 10:45:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] gpio: API boundary cleanups
Date:   Fri,  6 Sep 2019 10:45:35 +0200
Message-Id: <20190906084539.21838-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus, Bartosz,

This patch series contains various API boundary cleanups for gpiolib:
  - The first two patches make two functions private,
  - The last two patches switch the remaining gpiolib exported functions
    from EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL().

After this there is only a single GPIO driver function exported with
EXPORT_SYMBOL();

    drivers/gpio/gpio-htc-egpio.c:EXPORT_SYMBOL(htc_egpio_get_wakeup_irq);

I believe this symbol was never used upstream, and may be a relic of the
original out-of-tree code the htc-egpio was based on.  I don't know if
there (still) exist out-of-tree users of the symbol.

Thanks for your comments!

Geert Uytterhoeven (4):
  gpio: of: Make of_get_named_gpiod_flags() private
  gpio: of: Make of_gpio_simple_xlate() private
  gpio: of: Switch to EXPORT_SYMBOL_GPL()
  gpio: devres: Switch to EXPORT_SYMBOL_GPL()

 drivers/gpio/gpiolib-devres.c | 28 ++++++++++++++--------------
 drivers/gpio/gpiolib-of.c     | 16 ++++++++--------
 drivers/gpio/gpiolib-of.h     |  7 -------
 include/linux/of_gpio.h       | 11 -----------
 4 files changed, 22 insertions(+), 40 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
