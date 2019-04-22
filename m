Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35374C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C4D21738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWXLAik9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfDVRyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:54:25 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:46923 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDVRyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:54:25 -0400
Received: by mail-yb1-f201.google.com with SMTP id d193so10246716ybh.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9YVB8fdkLopCxdifBnQcYBFkzaoHF/WFJeGhNgDoYnk=;
        b=EWXLAik9zBK+zprNwt4ntx9u8HnshJqb39SD13hNQiQnsd7gbvkR8Qx3J5eJJg8gR4
         Jh1Dhoa5t07ZTgwy6IenqxWApZTEUxNJbkfWdvaSMswLZx48RCc75OJ3bPy4y9nQCh3h
         so2HKNZY3XePkZR64RGZ9QVebGQcomMsOBN1T+XzosvSmrU7a3/dqYvEGkiDH//IKcMX
         jU2Tc6lCx7+R8GnQtOAYaYc68qNgX85NdEdvCfIJzrKl6oW0FRH1M021Aj8CIh6wuSZV
         HTXrnFvgzT0wweAo2vsN4qjfPHdf9OMIOQ/hEga5DfdxEYHWfiGq/azmqIx4Kq0B0KPl
         aRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9YVB8fdkLopCxdifBnQcYBFkzaoHF/WFJeGhNgDoYnk=;
        b=XUdAFgT/inpnO6YGsXDaTHV9IlHwgDwwVYCh6HCGAfs/RjEouBO6FQtWJALvXfY8kI
         dsJig6dl3UahpbnC80vrfekVoyQW7OCcHG/BKvRW42CongZL9ATPc8ch0FZY4riTmyZl
         VhrBTUTjgk7RLHO3p+uHryyOGf+woj1cqPu00ugk1n7oTguNldkQOQZnjrqqBy7ovoPM
         Fwk2hlzfaLVbXS3oENKU/rjHRa/RsPTSrCG6CUF9RO6Il6U4njPyK1JqRF/heY9Wx4on
         Ug28VPbs+X2PXfo+YcndO7VarC8hakCtlMffgQDehDmhajbLfdjcOJFGDcp9KGgduB3W
         7Zdg==
X-Gm-Message-State: APjAAAWMkoXN6PLYkkfwJN1JmdotyvFPOiw4YIcKW9kgRaX7voMfDyyI
        xPixjgP2BD+GsvG2/BvOX9kOT1lChQ9M
X-Google-Smtp-Source: APXvYqx6Ab/84FHOjVrW01ph7oQS2rfIQ6a0PH3ocmJxRbyeVHmBD7PucYtZpxOJNVkAUYH7Sj4BGTk8gS6Z
X-Received: by 2002:a0d:e84a:: with SMTP id r71mr13975022ywe.270.1555955664128;
 Mon, 22 Apr 2019 10:54:24 -0700 (PDT)
Date:   Mon, 22 Apr 2019 10:54:19 -0700
Message-Id: <20190422175419.189895-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2] soc: add aspeed folder and misc drivers
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        joel@jms.id.au, andrew@aj.id.au
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a SoC folder for the ASPEED parts and place the misc drivers
currently present into this folder.  These drivers are not generic part
drivers, but rather only apply to the ASPEED SoCs.

Signed-off-by: Patrick Venture <venture@google.com>
---
v2:
 Added configuration option for ASPEED to soc/Makefile
---
 drivers/misc/Kconfig                          | 16 ----------------
 drivers/misc/Makefile                         |  2 --
 drivers/soc/Kconfig                           |  1 +
 drivers/soc/Makefile                          |  1 +
 drivers/soc/aspeed/Kconfig                    | 19 +++++++++++++++++++
 drivers/soc/aspeed/Makefile                   |  2 ++
 .../{misc => soc/aspeed}/aspeed-lpc-ctrl.c    |  0
 .../{misc => soc/aspeed}/aspeed-lpc-snoop.c   |  0
 8 files changed, 23 insertions(+), 18 deletions(-)
 create mode 100644 drivers/soc/aspeed/Kconfig
 create mode 100644 drivers/soc/aspeed/Makefile
 rename drivers/{misc => soc/aspeed}/aspeed-lpc-ctrl.c (100%)
 rename drivers/{misc => soc/aspeed}/aspeed-lpc-snoop.c (100%)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42ab8ec92a04..b80cb6af0cb4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -496,22 +496,6 @@ config VEXPRESS_SYSCFG
 	  bus. System Configuration interface is one of the possible means
 	  of generating transactions on this bus.
 
-config ASPEED_LPC_CTRL
-	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
-	tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
-	---help---
-	  Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
-	  ioctl()s, the driver also provides a read/write interface to a BMC ram
-	  region where the host LPC read/write region can be buffered.
-
-config ASPEED_LPC_SNOOP
-	tristate "Aspeed ast2500 HOST LPC snoop support"
-	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
-	help
-	  Provides a driver to control the LPC snoop interface which
-	  allows the BMC to listen on and save the data written by
-	  the host to an arbitrary LPC I/O port.
-
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d5b7d3404dc7..b9affcdaa3d6 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -54,8 +54,6 @@ obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
-obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
-obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index c07b4a85253f..b750a88547c7 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/actions/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
+source "drivers/soc/aspeed/Kconfig"
 source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 90b686e586c6..814128fe479f 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
+obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
new file mode 100644
index 000000000000..457282cd1da5
--- /dev/null
+++ b/drivers/soc/aspeed/Kconfig
@@ -0,0 +1,19 @@
+menu "Aspeed SoC drivers"
+
+config ASPEED_LPC_CTRL
+	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
+	tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
+	---help---
+	  Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
+	  ioctl()s, the driver also provides a read/write interface to a BMC ram
+	  region where the host LPC read/write region can be buffered.
+
+config ASPEED_LPC_SNOOP
+	tristate "Aspeed ast2500 HOST LPC snoop support"
+	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
+	help
+	  Provides a driver to control the LPC snoop interface which
+	  allows the BMC to listen on and save the data written by
+	  the host to an arbitrary LPC I/O port.
+
+
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
new file mode 100644
index 000000000000..cfaa9adc67b5
--- /dev/null
+++ b/drivers/soc/aspeed/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
+obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
similarity index 100%
rename from drivers/misc/aspeed-lpc-ctrl.c
rename to drivers/soc/aspeed/aspeed-lpc-ctrl.c
diff --git a/drivers/misc/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
similarity index 100%
rename from drivers/misc/aspeed-lpc-snoop.c
rename to drivers/soc/aspeed/aspeed-lpc-snoop.c
-- 
2.21.0.593.g511ec345e18-goog

