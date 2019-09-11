Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739B8ECDE2B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BDF20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfIKOjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:39:15 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:33398 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfIKOjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:39:13 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id 0Ef42100105gfCL01Ef4Mu; Wed, 11 Sep 2019 16:39:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i83lv-0006T2-Tj; Wed, 11 Sep 2019 16:39:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i83lv-0003Ou-Qz; Wed, 11 Sep 2019 16:39:03 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 0/5] gpio: Add GPIO Aggregator Driver
Date:   Wed, 11 Sep 2019 16:38:53 +0200
Message-Id: <20190911143858.13024-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

GPIO controllers are exported to userspace using /dev/gpiochip*
character devices.  Access control to these devices is provided by
standard UNIX file system permissions, on an all-or-nothing basis:
either a GPIO controller is accessible for a user, or it is not.
Currently no mechanism exists to control access to individual GPIOs.

Hence this second RFC adds a GPIO driver to aggregate existing GPIOs,
and expose them as a new gpiochip.  This is useful for implementing
access control, and assigning a set of GPIOs to a specific user.
Furthermore, this simplifies and hardens exporting GPIOs to a virtual
machine, as the VM can just grab the full GPIO controller, and no longer
needs to care about which GPIOs to grab and which not, reducing the
attack surface.

Changes compared to v1[1]:
  - Drop "virtual", rename to gpio-aggregator,
  - Create and use new GPIO Forwarder Helper, to allow sharing code with
    the GPIO inverter,
  - Lift limit on the maximum number of GPIOs,
  - Improve parsing of GPIO specifiers,
  - Fix modular build.

To do:
  - Write proper documentation.

Aggregating GPIOs and exposing them as a new gpiochip was suggested in
response to my proof-of-concept for GPIO virtualization with QEMU[2][3].

Aggregated GPIO controllers are instantiated and destroyed by writing to
atribute files in sysfs.  Sample session on r8a7791/koelsch:

  - Unbind LEDs from leds-gpio driver:

	echo leds > /sys/bus/platform/drivers/leds-gpio/unbind

  - Create aggregators:

    $ echo e6052000.gpio 19,20 \
	> /sys/bus/platform/drivers/gpio-aggregator/new_device

    gpio-aggregator.0: gpio 0 => gpio-953 (?)
    gpio-aggregator.0: gpio 1 => gpio-954 (?)
    gpiochip_find_base: found new base at 778
    gpio gpiochip8: (gpio-aggregator.0): added GPIO chardev (254:8)
    gpiochip_setup_dev: registered GPIOs 778 to 779 on device: gpiochip8 (gpio-aggregator.0)

    $ echo e6052000.gpio 21 e6050000.gpio 20-22 \
	> /sys/bus/platform/drivers/gpio-aggregator/new_device

    gpio-aggregator.1: gpio 0 => gpio-955 (?)
    gpio-aggregator.1: gpio 1 => gpio-1012 (?)
    gpio-aggregator.1: gpio 2 => gpio-1013 (?)
    gpio-aggregator.1: gpio 3 => gpio-1014 (?)
    gpiochip_find_base: found new base at 774
    gpio gpiochip9: (gpio-aggregator.1): added GPIO chardev (254:9)
    gpiochip_setup_dev: registered GPIOs 774 to 777 on device: gpiochip9 (gpio-aggregator.1)

  - Adjust permissions on /dev/gpiochip[89] (optional)

  - Control LEDs:

    $ gpioset gpiochip8 0=0 1=1	# LED6 OFF, LED7 ON
    $ gpioset gpiochip8 0=1 1=0	# LED6 ON, LED7 OFF
    $ gpioset gpiochip9 0=0	# LED8 OFF
    $ gpioset gpiochip9 0=1	# LED8 ON

  - Destroy aggregators:

    $ echo gpio-aggregator.0 \
            > /sys/bus/platform/drivers/gpio-aggregator/delete_device
    $ echo gpio-aggregator.1 \
            > /sys/bus/platform/drivers/gpio-aggregator/delete_device

Thanks for your comments!

References:
  - [1] "[PATCH RFC] gpio: Add Virtual Aggregator GPIO Driver"
        (https://lore.kernel.org/lkml/20190705160536.12047-1-geert+renesas@glider.be/)
  - [2] "[PATCH QEMU POC] Add a GPIO backend"
	(https://lore.kernel.org/linux-renesas-soc/20181003152521.23144-1-geert+renesas@glider.be/)
  - [3] "Getting To Blinky: Virt Edition / Making device pass-through
	 work on embedded ARM"
	(https://fosdem.org/2019/schedule/event/vai_getting_to_blinky/)

Geert Uytterhoeven (5):
  gpio: Export gpiod_{request,free}() to modular GPIO code
  gpio: Export gpiochip_get_desc() to modular GPIO code
  gpio: Export gpio_name_to_desc() to modular GPIO code
  gpio: Add GPIO Forwarder Helper
  gpio: Add GPIO Aggregator Driver

 drivers/gpio/Kconfig           |  12 ++
 drivers/gpio/Makefile          |   2 +
 drivers/gpio/gpio-aggregator.c | 333 +++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib-fwd.c     | 272 +++++++++++++++++++++++++++
 drivers/gpio/gpiolib-fwd.h     |  16 ++
 drivers/gpio/gpiolib.c         |   6 +-
 drivers/gpio/gpiolib.h         |   1 +
 7 files changed, 641 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-aggregator.c
 create mode 100644 drivers/gpio/gpiolib-fwd.c
 create mode 100644 drivers/gpio/gpiolib-fwd.h

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
