Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E464EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6CD2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfC1NNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:13:53 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:52606 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfC1NNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:13:53 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id tRDr1z0073XaVaC01RDrtC; Thu, 28 Mar 2019 14:13:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h9Uqt-0005Fi-1J; Thu, 28 Mar 2019 14:13:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1h9Uqs-0004uc-VA; Thu, 28 Mar 2019 14:13:50 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] gpio: Failure path fixes
Date:   Thu, 28 Mar 2019 14:13:46 +0100
Message-Id: <20190328131349.18838-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus, Bartosz,

After making a silly mistake in a pin control driver, pinctrl driver
initialization failed, causing an avalanche of GPIO driver failures, and
I was greeted by the following scary messages:

    OF: ERROR: Bad of_node_put() on /soc/gpio@e6050000
    ...
    WARNING: CPU: 0 PID: 1 at lib/refcount.c:156 kobject_get+0x38/0x4c
    ...
    WARNING: CPU: 0 PID: 1 at lib/refcount.c:190 refcount_sub_and_test_checked+0x3c/0xa8

The first two patches fix bugs in related error paths, after which the
messages are gone.
The third patch is a drive-by fix for function comment.

Thanks for your comments!

Geert Uytterhoeven (3):
  gpio: of: Fix of_gpiochip_add() error path
  gpio: Fix gpiochip_add_data_with_key() error path
  gpio: Remove obsolete comment about gpiochip_free_hogs() usage

 drivers/gpio/gpiolib-of.c |  8 +++++++-
 drivers/gpio/gpiolib.c    | 14 ++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
