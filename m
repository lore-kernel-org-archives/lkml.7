Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E987C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA132085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UChTsU1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfIKSBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:01:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52580 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbfIKSBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:01:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8BI1H9n088970;
        Wed, 11 Sep 2019 13:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568224877;
        bh=oUljA5ErHiv3YWcu3yuKsuunIS40fEW3qS+g1aItKiw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UChTsU1dCAtXaIyQ71deQGp1W/ZAu97k1O0muKusVMoUrsyU/4x1jEKCmyBrsvBQB
         9aBLxWdKhZ9OtcUdC74uE492ZoXVZk9GknEFyu33rEaoegfdTYqMRSgAZdbluictvB
         fEYLDllfPQ4z7N0Ciy1VnKP3nFLCmTFF833nVimU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8BI1HXw009326
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Sep 2019 13:01:17 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 11
 Sep 2019 13:01:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 11 Sep 2019 13:01:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8BI1GMV040976;
        Wed, 11 Sep 2019 13:01:16 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 1/9] leds: multicolor: Add sysfs interface definition
Date:   Wed, 11 Sep 2019 13:01:07 -0500
Message-ID: <20190911180115.21035-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
In-Reply-To: <20190911180115.21035-1-dmurphy@ti.com>
References: <20190911180115.21035-1-dmurphy@ti.com>
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
 .../ABI/testing/sysfs-class-led-multicolor    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor

diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor b/Documentation/ABI/testing/sysfs-class-led-multicolor
new file mode 100644
index 000000000000..4ea54c2ad4c8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
@@ -0,0 +1,73 @@
+What:		/sys/class/leds/<led>/brightness
+Date:		Sept 2019
+KernelVersion:	5.5
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	read/write
+		The multicolor class will redirect the device drivers call back
+		function for brightness control to the multicolor class
+		brightness control function.
+
+		Writing to this file will update all LEDs within the group to a
+		calculated percentage of what each color LED in the group is set
+		to.  The percentage is calculated via the equation below:
+
+		led_brightness = requested_value * led_color_intensity/led_color_max_intensity
+
+		For additional details please refer to
+		Documentation/leds/leds-class-multicolor.rst.
+
+		The value of the color is from 0 to
+		/sys/class/leds/<led>/max_brightness.
+
+What:		/sys/class/leds/<led>/colors/color_mix
+Date:		Sept 2019
+KernelVersion:	5.5
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	read/write
+		The values written to this file should contain the intensity
+		values of each multicolor LED within the colors directory. The
+		index of given color is reported by the color_id file present in
+		colors/<color> directory. The index determines the position in
+		the sequence of	intensities on which the related intensity
+		should be passed to this file.
+
+		For additional details please refer to
+		Documentation/leds/leds-class-multicolor.rst.
+
+What:		/sys/class/leds/<led>/colors/<led_color>/color_id
+Date:		Sept 2019
+KernelVersion:	5.5
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	read only
+		This file when read will return the index of the color in the
+		color_mix.
+
+		For additional details please refer to
+		Documentation/leds/leds-class-multicolor.rst.
+
+What:		/sys/class/leds/<led>/colors/<led_color>/intensity
+Date:		Sept 2019
+KernelVersion:	5.5
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	read/write
+		The led_color directory is dynamically created based on the
+		colors defined by the registrar of the class.
+		The led_color can be but not limited to red, green, blue,
+		white, amber, yellow and violet.  There is one directory per color
+		presented.  The brightness file is created under each
+		led_color directory and controls the individual LED color
+		setting.
+
+		The value of the color is from 0 to
+		/sys/class/leds/<led>/colors/<led_color>/max_intensity.
+
+What:		/sys/class/leds/<led>/colors/<led_color>/max_intensity
+Date:		Sept 2019
+KernelVersion:	5.5
+Contact:	Dan Murphy <dmurphy@ti.com>
+Description:	read only
+		Maximum intensity level for the LED color, default is
+		255 (LED_FULL).
+
+		If the LED does not support different intensity levels, this
+		should be 1.
-- 
2.22.0.214.g8dca754b1e

