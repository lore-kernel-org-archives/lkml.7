Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DA2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C627A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iiASSWbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfCYOZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:25:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54628 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfCYOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:24:39 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2PEOXHF084114;
        Mon, 25 Mar 2019 09:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553523873;
        bh=IsTrX3JSvlf2LbJ6dWgzs9JWRzikTQpgSOJMqvaDcEw=;
        h=From:To:CC:Subject:Date;
        b=iiASSWbXI2NcT/ALH1m9QmMFZtqdTlouHeZf5FvERyB1wAt6ZH8XKrMaXAXfNDog/
         qbA1rXBbO+CUO73+Qn9ZvB3HLm1tCurny680ytpIcz/kwpCiBXGepDEgH+8FzXyHxy
         hVhoUl9qhCf/PzRHAsvXx/BkJGGRf58D3KWRWMis=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2PEOXsc023275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 09:24:33 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 09:24:33 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 09:24:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2PEOWTv022478;
        Mon, 25 Mar 2019 09:24:32 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 0/5] TI LMU rework
Date:   Mon, 25 Mar 2019 09:23:58 -0500
Message-ID: <20190325142403.30447-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

I know that it has been a long time but I put some additional effort into this
code.  The TI LMU common code right now handles brightness and ramp up/down
setting for the LM3697.  This so far are the common features I could find.

The LM3697 driver has the ability to assign HVLED strings to specific control
banks as well as assigning different max brightnesses to these strings.

Fault monitoring was removed as the data sheet indicates that this is for
production tests only.

I have plans to add additional LED drivers to use the TI LMU but I figured trying
to add all of them at once would be a daunting review and probably wrought with 
problems.

Dan

Dan Murphy (5):
  dt-bindings: mfd: Update the ramp up/down property
  leds: TI LMU: Add common code for TI LMU devices
  dt-bindings: ti-lmu: Modify dt bindings for the LM3697
  mfd: ti-lmu: Remove support for LM3697
  leds: lm3697: Introduce the lm3697 driver

 .../devicetree/bindings/leds/leds-lm3697.txt  |  77 ++++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  42 +-
 drivers/leds/Kconfig                          |  14 +
 drivers/leds/Makefile                         |   2 +
 drivers/leds/leds-lm3697.c                    | 401 ++++++++++++++++++
 drivers/leds/ti-lmu-led-common.c              | 131 ++++++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/ti-lmu.c                          |  17 -
 include/linux/mfd/ti-lmu-register.h           |  44 --
 include/linux/mfd/ti-lmu.h                    |   1 -
 include/linux/ti-lmu-led-common.h             |  44 ++
 11 files changed, 682 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
 create mode 100644 drivers/leds/leds-lm3697.c
 create mode 100644 drivers/leds/ti-lmu-led-common.c
 create mode 100644 include/linux/ti-lmu-led-common.h

-- 
2.19.0

