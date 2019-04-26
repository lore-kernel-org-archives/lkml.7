Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A77DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE13206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="SWEyh+e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfDZIbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:31:43 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:56107 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfDZIbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:31:42 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 3C7E5A6C69;
        Fri, 26 Apr 2019 10:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1556267499;
        bh=Is9qQ6K+sh46hK3N5KZM07kXt89OjVvh92tHpZRwnN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWEyh+e25VNPstPk8VUyeWrxZGZv4VyqsJ1KdHWwRmkJDJSOO52wOvIR+8TBvU/St
         mgOo7Etf8TZNHE681DUjFCpAmaWlAezIaxgneWRRcRnoD2VYPH5Izp3DzmlSehwm08
         0/cfw+Ue3F1ZduP8ilbQIjYubjrfG/8j6knJhwwg=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RFC PATCH 1/4] dt-bindings: input: Add support for the MPR121 without interrupt line
Date:   Fri, 26 Apr 2019 10:30:17 +0200
Message-Id: <1556267420-93219-2-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1556267420-93219-1-git-send-email-michal.vokac@ysoft.com>
References: <1556267420-93219-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, the MPR121 controller uses separate interrupt line to notify
the I2C host that a key was touched/released. To support platforms that
can not use the interrupt line, polling of the MPR121 registers can be
used.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 .../bindings/input/mpr121-touchkey-polled.txt      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mpr121-touchkey-polled.txt

diff --git a/Documentation/devicetree/bindings/input/mpr121-touchkey-polled.txt b/Documentation/devicetree/bindings/input/mpr121-touchkey-polled.txt
new file mode 100644
index 000000000000..6bb1d312614c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mpr121-touchkey-polled.txt
@@ -0,0 +1,26 @@
+* Freescale MPR121 Controller without interrupt line
+
+Required Properties:
+- compatible:		Should be "fsl,mpr121-touchkey-polled"
+- reg:			The I2C slave address of the device.
+- vdd-supply:		Phandle to the Vdd power supply.
+- linux,keycodes:	Specifies an array of numeric keycode values to
+			be used for reporting button presses. The array can
+			contain up to 12 entries.
+
+Optional Properties:
+- autorepeat:		Enable autorepeat feature.
+
+Example:
+
+#include "dt-bindings/input/input.h"
+
+	touchkeys: keys@5a {
+		compatible = "fsl,mpr121-touchkey-polled";
+		reg = <0x5a>;
+		autorepeat;
+		vdd-supply = <&ldo4_reg>;
+		linux,keycodes = <KEY_0>, <KEY_1>, <KEY_2>, <KEY_3>,
+				<KEY_4> <KEY_5>, <KEY_6>, <KEY_7>,
+				<KEY_8>, <KEY_9>, <KEY_A>, <KEY_B>;
+	};
-- 
2.1.4

