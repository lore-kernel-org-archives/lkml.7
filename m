Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A803CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0EE206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IdJ6fdlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438331AbfITMZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:25:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49434 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408945AbfITMZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:25:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8KCPjSE071956;
        Fri, 20 Sep 2019 07:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568982346;
        bh=4TyJ5sizsTzi/H33Mo1wWvezZRRG5B0ADthV0dE35aI=;
        h=From:To:CC:Subject:Date;
        b=IdJ6fdlLW78lRCYMwbOIiIJJH0hm/utSpaDmuL7BnOW0hrXUBEs8hNmJEcrFlfHrg
         vBGuPCRihgLp7Vc0vqbafd1xUib/UxZhh9VnpIiKb6my1chGPfrvpHjXyXdv10eem9
         UKbql1OR93ipflY4bQ/FpbA91lUqlRPdfDTleveY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8KCPj2X095282;
        Fri, 20 Sep 2019 07:25:45 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 20
 Sep 2019 07:25:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 20 Sep 2019 07:25:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8KCPiY1016302;
        Fri, 20 Sep 2019 07:25:45 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <daniel.thompson@linaro.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmurphy@ti.com>, <tomi.valkeinen@ti.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v4 0/3] leds: Add control of the voltage/current regulator to the LED core
Date:   Fri, 20 Sep 2019 14:25:22 +0200
Message-ID: <20190920122525.15712-1-jjhiblot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes it possible for the LED core to manage the power supply
of a LED. It uses the regulator API to disable/enable the power if when the
LED is turned on/off.
This is especially useful in situations where the LED driver/controller is
not supplying the power.
Because updating a regulator state can block, it is always defered to
set_brightness_delayed().

changes in v4:
- Add a new patch to make led_set_brightness_sync() use
  led_set_brightness_nosleep() and then wait the work to be done
- Rework how the core knows how the regulator needs to be updated.

changes in v3:
- reword device-tree description
- reword commit log
- remove regulator updates from functions used in atomic context. If the
  regulator must be updated, it is defered to a workqueue.
- Fix led_set_brightness_sync() to work with the non-blocking function
  __led_set_brightness()

changes in v2:
- use devm_regulator_get_optional() to avoid using the dummy regulator and
  do some unnecessary work

Jean-Jacques Hiblot (3):
  led: make led_set_brightness_sync() use led_set_brightness_nosleep()
  dt-bindings: leds: document the "power-supply" property
  leds: Add control of the voltage/current regulator to the LED core

 .../devicetree/bindings/leds/common.txt       |  6 ++
 drivers/leds/led-class.c                      | 17 ++++
 drivers/leds/led-core.c                       | 77 +++++++++++++++++--
 drivers/leds/leds.h                           |  3 +
 include/linux/leds.h                          |  5 ++
 5 files changed, 101 insertions(+), 7 deletions(-)

-- 
2.17.1

