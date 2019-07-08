Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AE7C606AA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC7920665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jX7CUX1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfGHK1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 06:27:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58912 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfGHK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 06:27:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x68AR7Mh046374;
        Mon, 8 Jul 2019 05:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562581627;
        bh=HwCXjka0RmqRpxs+JE1gaFV+rhErQ4TXr2QzAWjVo4c=;
        h=From:To:CC:Subject:Date;
        b=jX7CUX1tXXxMIRIotb4+unqebNpm42gFjFydr1TLL9mTSgL31TN7iw8W1O5zySCM+
         epIJHiMbmt3SLWT5a5Aur4XYvMwF6LsqcaENw6uf2NBwykB4nmjZi5LTGRgvJiU3rX
         5v4uFvwEB+UUuZWEqqX6DLOstZh+jhu77vnG1EI0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x68AR7wg067624
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jul 2019 05:27:07 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 8 Jul
 2019 05:27:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 8 Jul 2019 05:27:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x68AR6iR027045;
        Mon, 8 Jul 2019 05:27:06 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>
CC:     <dmurphy@ti.com>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <tomi.valkeinen@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v2 0/4] Add a generic driver for LED-based backlight
Date:   Mon, 8 Jul 2019 12:26:56 +0200
Message-ID: <20190708102700.23138-1-jjhiblot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to add a led-backlight driver, similar to pwm-backlight,
but using a LED class device underneath.

A few years ago (2015), Tomi Valkeinen posted a series implementing a
backlight driver on top of a LED device:
https://patchwork.kernel.org/patch/7293991/
https://patchwork.kernel.org/patch/7294001/
https://patchwork.kernel.org/patch/7293981/

The discussion stopped because Tomi lacked the time to work on it.

The series affects the LED core and add a new backlight driver.

changes in v2:
- bkl: the backlight can use more than one LED. As a consequence don't make
  the backlight device a child of a LED controller.
- bkl: make brightness-levels and default-brightness-level optional
- bkl: removed the option to use a GPIO enable.
- bkl: removed the option to use a regulator. It should be handled by the
  LED core
- led: removed the mechanism to bind a child device for each LED
- led: improve the way of_get_led() works and add a managed version of it

Jean-Jacques Hiblot (2):
  leds: Add managed API to get a LED from a device driver
  dt-bindings: backlight: Add led-backlight binding

Tomi Valkeinen (2):
  leds: Add of_led_get() and led_put()
  backlight: add led-backlight driver

 .../bindings/leds/backlight/led-backlight.txt |  29 +++
 drivers/leds/led-class.c                      |  92 +++++++
 drivers/video/backlight/Kconfig               |   7 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/led_bl.c              | 235 ++++++++++++++++++
 include/linux/leds.h                          |   6 +
 6 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
 create mode 100644 drivers/video/backlight/led_bl.c

-- 
2.17.1

