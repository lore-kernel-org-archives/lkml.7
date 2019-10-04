Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0824EC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A49222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I/JTOs7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbfJDQHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:07:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58834 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389968AbfJDQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:07:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x94G7RnY076403;
        Fri, 4 Oct 2019 11:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570205247;
        bh=EQy/Mm3OOex5bExLsCtlrPlLzadZWkr+8aDvqHfvdSI=;
        h=From:To:CC:Subject:Date;
        b=I/JTOs7taQszVTeNMzIs9b/wmhp3+R+jIlFmj7ExwAwvudz7nxBQtcqJjhIgGI/LH
         +6EvdJRWB3RHu2SS3sLybB4EQw4ecU4hFnRPhPxrFDcH9eErM1T9isz7aGLzLP9QuO
         8cfAogtspSJBB2m6IsjbkQ/yiWys0eHGePygkPtQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x94G7RvC025365
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Oct 2019 11:07:27 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 4 Oct
 2019 11:07:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 4 Oct 2019 11:07:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x94G7QSN129119;
        Fri, 4 Oct 2019 11:07:26 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmurphy@ti.com>, <tomi.valkeinen@ti.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v6 0/2] leds: Add control of the voltage/current regulator to the LED core
Date:   Fri, 4 Oct 2019 18:07:22 +0200
Message-ID: <20191004160724.18390-1-jjhiblot@ti.com>
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
Because updating a regulator state can block, it is always a defered job.

Note: this series relies on led_cdev->dev->of_node being populated [0]

[0] https://lkml.org/lkml/2019/10/3/139

changes in v6:
- Introduce a new property in DT binding to delay turning OFF the regulator
  The idea is to keep the regulator ON for some time after the LED is turned
  off in order to not change the regulator state when the LED is blinking.
- Use an atomic to track the state of the regulator to ensure consistency.
- Remove changes in led_set_brightness_sync().

changes in v5:
- fixed build error in led_set_brightness_sync(). Explain the role of
  flush__work()

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

Jean-Jacques Hiblot (2):
  dt-bindings: leds: document the "power-supply" property
  leds: Add control of the voltage/current regulator to the LED core

 .../devicetree/bindings/leds/common.txt       |  14 ++
 drivers/leds/led-class.c                      |  21 +++
 drivers/leds/led-core.c                       | 122 +++++++++++++++++-
 drivers/leds/leds.h                           |  18 +++
 include/linux/leds.h                          |   8 ++
 5 files changed, 181 insertions(+), 2 deletions(-)

-- 
2.17.1

