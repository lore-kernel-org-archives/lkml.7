Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EF1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A69A2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nwZd6++K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDKTjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:39:15 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50458 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:39:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3BJcojE097029;
        Thu, 11 Apr 2019 14:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555011530;
        bh=QoTwq2TsQYQs9cX+gn9lCOTA2QWZqg19+qvdESPHsWs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nwZd6++KXRKaon+uOjEU8v9HdCIx5DNy1g2vOSm64g81CEbIqNDwqtQXzdgJbP0Ex
         HXK8jFpriE3POwvYyrjdKyqZeNS49eAxmGyOfpPE4PM1QxMjYKIbHdCCk8cJuMoRsP
         ulIWrBk3/ce8gEK0u7Yg/WljI3aQlReNIs6xVBE8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3BJcoXd025672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 14:38:50 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 14:38:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 14:38:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3BJcnPi021025;
        Thu, 11 Apr 2019 14:38:50 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <marek.behun@nic.cz>, <rdunlap@infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 1/7] leds: multicolor: Add sysfs interface definition
Date:   Thu, 11 Apr 2019 14:38:42 -0500
Message-ID: <20190411193848.23140-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.21.0.5.gaeb582a983
In-Reply-To: <20190411193848.23140-1-dmurphy@ti.com>
References: <20190411193848.23140-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a documentation of LED Multicolor LED class specific
sysfs attributes.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../ABI/testing/sysfs-class-led-multicolor    | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor

diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor b/Documentation/ABI/testing/sysfs-class-led-multicolor
new file mode 100644
index 000000000000..5583ecaa3170
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
@@ -0,0 +1,91 @@
+What:		/sys/class/leds/<led>/colors/sync_enable
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	read/write
+		Writing a 1 to this file will enable the synchronization of all
+		the defined color LEDs within the LED node.  Brightness values
+		for each LED will be stored and written when sync is set to 1.
+		Writing a 0 to this file will disable syncing and allow
+		individual control of the LEDs brightness settings.
+
+What:		/sys/class/leds/<led>/colors/sync
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	write only
+		Writing a 1 to this file while sync_enable is set to 1 will
+		write the current brightness values to all defined LEDs within
+		the LED node.  All LEDs defined will be configured based
+		on the brightness that has been requested.
+
+		If sync_enable is set to 0 then writing a 1 to sync has no
+		affect on the LEDs.
+
+What:		/sys/class/leds/<led>/colors/<led_color>/brightness
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	read/write
+		The led_color directory is dynamically created based on the
+		colors defined by the registrar of the class.
+		The led_color can be but not limited to red, green, blue,
+		white, amber, yellow and violet.  Drivers can also declare a
+		LED color for presentation.  There is one directory per color
+		presented.  The brightness file is created under each
+		led_color directory and controls the individual LED color
+		setting.
+
+		If sync is enabled then	writing the brightness value of the LED
+		is deferred until a 1 is written to
+		/sys/class/leds/<led>/color/sync.  If syncing is
+		disabled then the LED brightness value will be written
+		immediately to the LED driver.
+
+		The value of the color is from 0 to
+		/sys/class/leds/<led>/colors/<led_color>/max_brightness.
+
+What:		/sys/class/leds/<led>/colors/<led_color>/max_brightness
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	read only
+		Maximum brightness level for the LED color, default is
+		255 (LED_FULL).
+
+		If the LED does not support different brightness levels, this
+		should be 1.
+
+What:		/sys/class/leds/<led>/brightness_model/<model_color>
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Jacek Anaszewski <j.anaszewski@samsung.com>
+Description:	read/write
+		This directory contains the defined color models that are read
+		from the firmware node.  The model color will be the read from
+		the firmware node.  The model names should be a color that the
+		LED cluster can produce.
+
+What:		/sys/class/leds/<led>/brightness_model/<model_color>/brightness
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Jacek Anaszewski <j.anaszewski@samsung.com>
+Description:	read/write
+		Writing this file will initiate a synchronized write to the LED
+		cluster to produce the color output defined in the firmware node.
+
+		This value cannot exceed <model_color>/max_brightness.
+		Writing a 0 to this file will cause the LED cluster to turn off.
+
+		The sync and sync_enable files do not have an affect on this as
+		this is a real time update of the LED cluster.
+
+What:		/sys/class/leds/<led>/brightness_model/<model_color>/max_brightness
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Jacek Anaszewski <j.anaszewski@samsung.com>
+Description:	read
+		Reading this file will return the maximum number of brightness
+		levels that are defined in the firmware node for the model color.
+		It should be assumed that the levels are from 1 -> max_brightness
+		and the LED cluster brightness is increasing.
-- 
2.21.0.5.gaeb582a983

