Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF00C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DA720578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfG2Ohk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:37:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfG2Ohk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:37:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96013796EB;
        Mon, 29 Jul 2019 14:37:39 +0000 (UTC)
Received: from laptop.jcline.org (ovpn-125-161.rdu2.redhat.com [10.10.125.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6628460C4C;
        Mon, 29 Jul 2019 14:37:39 +0000 (UTC)
Received: from laptop.jcline.org.com (localhost [IPv6:::1])
        by laptop.jcline.org (Postfix) with ESMTP id 71A4F7044064;
        Mon, 29 Jul 2019 10:37:38 -0400 (EDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH v2] Documentation: gpio: fix function links in the HTML docs
Date:   Mon, 29 Jul 2019 10:37:30 -0400
Message-Id: <20190729143730.18660-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 29 Jul 2019 14:37:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shorthand [_data] and [devm_] cause the HTML documentation to not
link to the function documentation properly. This expands the references
to the complete function names with the exception of
devm_gpiochip_remove() which was dropped by commit 48207d7595d2 ("gpio:
drop devm_gpiochip_remove()").

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
New in v2:
  - Rebased onto v5.3-rc2

 Documentation/driver-api/gpio/driver.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index 921c71a3d683..906af220b164 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -69,9 +69,9 @@ driver code:
 
 The code implementing a gpio_chip should support multiple instances of the
 controller, preferably using the driver model. That code will configure each
-gpio_chip and issue ``gpiochip_add[_data]()`` or ``devm_gpiochip_add_data()``.
-Removing a GPIO controller should be rare; use ``[devm_]gpiochip_remove()``
-when it is unavoidable.
+gpio_chip and issue gpiochip_add(), gpiochip_add_data(), or
+devm_gpiochip_add_data().  Removing a GPIO controller should be rare; use
+gpiochip_remove() when it is unavoidable.
 
 Often a gpio_chip is part of an instance-specific structure with states not
 exposed by the GPIO interfaces, such as addressing, power management, and more.
@@ -418,11 +418,11 @@ symbol:
 
 If there is a need to exclude certain GPIO lines from the IRQ domain handled by
 these helpers, we can set .irq.need_valid_mask of the gpiochip before
-``[devm_]gpiochip_add_data()`` is called. This allocates an .irq.valid_mask with as
-many bits set as there are GPIO lines in the chip, each bit representing line
-0..n-1. Drivers can exclude GPIO lines by clearing bits from this mask. The mask
-must be filled in before gpiochip_irqchip_add() or gpiochip_irqchip_add_nested()
-is called.
+devm_gpiochip_add_data() or gpiochip_add_data() is called. This allocates an
+.irq.valid_mask with as many bits set as there are GPIO lines in the chip, each
+bit representing line 0..n-1. Drivers can exclude GPIO lines by clearing bits
+from this mask. The mask must be filled in before gpiochip_irqchip_add() or
+gpiochip_irqchip_add_nested() is called.
 
 To use the helpers please keep the following in mind:
 
-- 
2.21.0

