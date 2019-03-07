Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46C5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67E520835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="nnV5pRac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfCGMxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:53:41 -0500
Received: from mail.nic.cz ([217.31.204.67]:34489 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfCGMxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:53:20 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id A610C634F0;
        Thu,  7 Mar 2019 13:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551963195; bh=rixfWlKdsNKKRkO+/3K3yt+OiJZhsfqX5K+CLuyse/A=;
        h=From:To:Date;
        b=nnV5pRac1lILZ4jgSzlWHycEzgW0fMcEhqVsuC5iqrc1aK7A8RwjjcC+twUCfxJuS
         ECuQ6C+UCX2ESIpMkJyYOnV1Rxqr596Bphvr1dtTpSFvANfObgTbTisBOgCc0/Cboa
         P8vFUqS2TW75mcSIz1oc7ijmoLuyogJ6p8qNZTB4=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 armsoc/drivers/bus+gpio 5/5] dt-bindings: gpio: Document GPIOs via Moxtet bus
Date:   Thu,  7 Mar 2019 13:52:51 +0100
Message-Id: <20190307125251.724-6-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190307125251.724-1-marek.behun@nic.cz>
References: <20190307125251.724-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of the device tree bindings for GPIOs
on the devices connected via Moxtet bus.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/gpio/gpio-moxtet.txt   | 18 ++++++++++++++++++
 MAINTAINERS                                    |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-moxtet.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
new file mode 100644
index 000000000000..410759de9f09
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
@@ -0,0 +1,18 @@
+Turris Mox Moxtet GPIO expander via Moxtet bus
+
+Required properties:
+ - compatible		: Should be "cznic,moxtet-gpio".
+ - gpio-controller	: Marks the device node as a GPIO controller.
+ - #gpio-cells		: Should be two. For consumer use see gpio.txt.
+
+Other properties are required for a Moxtet bus device, please refer to
+Documentation/devicetree/bindings/bus/moxtet.txt.
+
+Example:
+
+	moxtet_sfp: gpio@0 {
+		compatible = "cznic,moxtet-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0>;
+	}
diff --git a/MAINTAINERS b/MAINTAINERS
index 6af384154ce5..ccb979f64431 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1505,6 +1505,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/debugfs-moxtet
 F:	Documentation/ABI/testing/sysfs-bus-moxtet-devices
 F:	Documentation/devicetree/bindings/bus/moxtet.txt
+F:	Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
 F:	include/linux/moxtet.h
 F:	drivers/bus/moxtet.c
 F:	drivers/gpio/gpio-moxtet.c
-- 
2.19.2

