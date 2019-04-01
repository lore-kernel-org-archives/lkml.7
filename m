Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49232C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1530C20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HnUvzP4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbfDAReT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:34:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33132 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbfDAReP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:34:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31HY3iU012072;
        Mon, 1 Apr 2019 12:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554140043;
        bh=nVTzF3ZsJhZcdBwTpUvvEXweKXa6yyasZxp5U0uP2RU=;
        h=From:To:CC:Subject:Date;
        b=HnUvzP4GEZl/4tLY/X0h+eWFLougT726H9YOsfvQJEa6GWgL6gXTCHcDArhCDExjp
         A2DkBAtwOm1c5x7BHL5+y7dUycbpGFQBUZkUuWolSdxBND0XHwGl+jA1hka0fFZANQ
         V1zjjO2yfGBWkDhyTp2tpDQpHTKT1/BoQtU5FUZk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31HY3EQ071780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 12:34:03 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 12:34:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 12:34:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31HY3lK015158;
        Mon, 1 Apr 2019 12:34:03 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <marek.behun@nic.cz>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 0/5] MultiColor LED framework Documentation
Date:   Mon, 1 Apr 2019 12:33:55 -0500
Message-ID: <20190401173400.14238-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am RFCing these patches to start this Multicolor framework as it appears we
have a few devices that need to leverage a framework like this.

I have attempted to create as much documentation as possible and have no issue
in combining documents into a single document but I think this patchset is logical.

I have also added the dt-bindings patch that include the COLOR_ID and COLOR_NAME
and documented the existing patch on the mail list.  I have added this only for
demonstration purposes.

Finally the code itself is a work in progress that at the very least will create
a colors directory as well as the associated colors.  The code works in principle
but I need to scrub it for issues.  The framework code also does not contain the
available brightness support as this seems to be a sticky point.

Dan

Dan Murphy (5):
  leds: multicolor: Add sysfs interface definition
  dt: bindings: Add multicolor class dt bindings documention
  documention: leds: Add multicolor class documentation
  dt-bindings: leds: Add LED_COLOR_ID and COLOR_NAME definitions
  leds: multicolor: Introduce a multicolor class definition

 .../ABI/testing/sysfs-class-led-multicolor    |  91 ++++
 .../bindings/leds/leds-class-multicolor.txt   | 140 ++++++
 Documentation/leds/leds-class-multicolor.txt  |  99 +++++
 drivers/leds/Kconfig                          |  10 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/led-class-multicolor.c           | 411 ++++++++++++++++++
 include/dt-bindings/leds/common.h             |  19 +
 include/linux/led-class-multicolor.h          |  69 +++
 8 files changed, 840 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor
 create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
 create mode 100644 Documentation/leds/leds-class-multicolor.txt
 create mode 100644 drivers/leds/led-class-multicolor.c
 create mode 100644 include/linux/led-class-multicolor.h

-- 
2.19.0

