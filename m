Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE5FC41514
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8152173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566712520;
	bh=WqDsH5W012CUCaMyJsxca2TIWS391JkXf1pOc73H0tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I7wHWuvamldqwjWCgxyF0iEvt9gMkTRUM1qs9UR2bD3N5l7CHKdIEvqjC2M6zj+X+
	 7dk10J9WglrtZxvLKVGUunBPFHxhCwgMgXniuGytuVRqFr5xwnr/XUOGHI0rguE+NJ
	 lDRvhqO+rfZrK9ZWw6p8TAALrrHcSBgljplKYGDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfHYFzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 01:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfHYFzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 01:55:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7242173E;
        Sun, 25 Aug 2019 05:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566712514;
        bh=WqDsH5W012CUCaMyJsxca2TIWS391JkXf1pOc73H0tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAR2K7Agj6SiL2jG4oX+yTlmTeApAsO49SPVQNPVoGrLxzW/VIrmoDxbH+Qujdqzy
         HFJeBhffLAuBegAapW52n9x59nQcw203Hp4CZNRQqR5VFW8i/oEa7GAvxU2n1CFIpo
         ViMHsbEyKUgGVNNu3LPEj2ZoAnxL4GghL12e56rQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 8/9] staging: greybus: move the greybus core to drivers/greybus
Date:   Sun, 25 Aug 2019 07:54:28 +0200
Message-Id: <20190825055429.18547-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825055429.18547-1-gregkh@linuxfoundation.org>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Greybus core code has been stable for a long time, and has been
shipping for many years in millions of phones.  With the advent of a
recent Google Summer of Code project, and a number of new devices in the
works from various companies, it is time to get the core greybus code
out of staging as it really is going to be with us for a while.

Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: greybus-dev@lists.linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS                                   |  3 +++
 drivers/Kconfig                               |  2 ++
 drivers/Makefile                              |  1 +
 drivers/greybus/Kconfig                       | 16 ++++++++++++++++
 drivers/greybus/Makefile                      | 19 +++++++++++++++++++
 drivers/{staging => }/greybus/bundle.c        |  0
 drivers/{staging => }/greybus/connection.c    |  0
 drivers/{staging => }/greybus/control.c       |  0
 drivers/{staging => }/greybus/core.c          |  0
 drivers/{staging => }/greybus/debugfs.c       |  0
 drivers/{staging => }/greybus/greybus_trace.h |  0
 drivers/{staging => }/greybus/hd.c            |  0
 drivers/{staging => }/greybus/interface.c     |  0
 drivers/{staging => }/greybus/manifest.c      |  0
 drivers/{staging => }/greybus/module.c        |  0
 drivers/{staging => }/greybus/operation.c     |  0
 drivers/{staging => }/greybus/svc.c           |  0
 drivers/{staging => }/greybus/svc_watchdog.c  |  0
 drivers/staging/greybus/Kconfig               | 16 ----------------
 drivers/staging/greybus/Makefile              | 17 -----------------
 drivers/staging/greybus/es2.c                 |  2 +-
 21 files changed, 42 insertions(+), 34 deletions(-)
 create mode 100644 drivers/greybus/Kconfig
 create mode 100644 drivers/greybus/Makefile
 rename drivers/{staging => }/greybus/bundle.c (100%)
 rename drivers/{staging => }/greybus/connection.c (100%)
 rename drivers/{staging => }/greybus/control.c (100%)
 rename drivers/{staging => }/greybus/core.c (100%)
 rename drivers/{staging => }/greybus/debugfs.c (100%)
 rename drivers/{staging => }/greybus/greybus_trace.h (100%)
 rename drivers/{staging => }/greybus/hd.c (100%)
 rename drivers/{staging => }/greybus/interface.c (100%)
 rename drivers/{staging => }/greybus/manifest.c (100%)
 rename drivers/{staging => }/greybus/module.c (100%)
 rename drivers/{staging => }/greybus/operation.c (100%)
 rename drivers/{staging => }/greybus/svc.c (100%)
 rename drivers/{staging => }/greybus/svc_watchdog.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f38cba2c581..e3242687cd19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7003,6 +7003,9 @@ M:	Alex Elder <elder@kernel.org>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 S:	Maintained
 F:	drivers/staging/greybus/
+F:	drivers/greybus/
+F:	include/linux/greybus.h
+F:	include/linux/greybus/
 L:	greybus-dev@lists.linaro.org (moderated for non-subscribers)
 
 GREYBUS UART PROTOCOLS DRIVERS
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 61cf4ea2c229..7dce76ae7369 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -146,6 +146,8 @@ source "drivers/hv/Kconfig"
 
 source "drivers/xen/Kconfig"
 
+source "drivers/greybus/Kconfig"
+
 source "drivers/staging/Kconfig"
 
 source "drivers/platform/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 6d37564e783c..73df8e5a2fce 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -148,6 +148,7 @@ obj-$(CONFIG_BCMA)		+= bcma/
 obj-$(CONFIG_VHOST_RING)	+= vhost/
 obj-$(CONFIG_VHOST)		+= vhost/
 obj-$(CONFIG_VLYNQ)		+= vlynq/
+obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_STAGING)		+= staging/
 obj-y				+= platform/
 
diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
new file mode 100644
index 000000000000..158d8893114c
--- /dev/null
+++ b/drivers/greybus/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+menuconfig GREYBUS
+	tristate "Greybus support"
+	depends on SYSFS
+	---help---
+	  This option enables the Greybus driver core.  Greybus is an
+	  hardware protocol that was designed to provide Unipro with a
+	  sane application layer.  It was originally designed for the
+	  ARA project, a module phone system, but has shown up in other
+	  phones, and can be tunneled over other busses in order to
+	  control hardware devices.
+
+	  Say Y here to enable support for these types of drivers.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called greybus.ko
diff --git a/drivers/greybus/Makefile b/drivers/greybus/Makefile
new file mode 100644
index 000000000000..03b22616ec7d
--- /dev/null
+++ b/drivers/greybus/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+# Greybus core
+greybus-y :=	core.o		\
+		debugfs.o	\
+		hd.o		\
+		manifest.o	\
+		module.o	\
+		interface.o	\
+		bundle.o	\
+		connection.o	\
+		control.o	\
+		svc.o		\
+		svc_watchdog.o	\
+		operation.o
+
+obj-$(CONFIG_GREYBUS)		+= greybus.o
+
+# needed for trace events
+ccflags-y += -I$(src)
diff --git a/drivers/staging/greybus/bundle.c b/drivers/greybus/bundle.c
similarity index 100%
rename from drivers/staging/greybus/bundle.c
rename to drivers/greybus/bundle.c
diff --git a/drivers/staging/greybus/connection.c b/drivers/greybus/connection.c
similarity index 100%
rename from drivers/staging/greybus/connection.c
rename to drivers/greybus/connection.c
diff --git a/drivers/staging/greybus/control.c b/drivers/greybus/control.c
similarity index 100%
rename from drivers/staging/greybus/control.c
rename to drivers/greybus/control.c
diff --git a/drivers/staging/greybus/core.c b/drivers/greybus/core.c
similarity index 100%
rename from drivers/staging/greybus/core.c
rename to drivers/greybus/core.c
diff --git a/drivers/staging/greybus/debugfs.c b/drivers/greybus/debugfs.c
similarity index 100%
rename from drivers/staging/greybus/debugfs.c
rename to drivers/greybus/debugfs.c
diff --git a/drivers/staging/greybus/greybus_trace.h b/drivers/greybus/greybus_trace.h
similarity index 100%
rename from drivers/staging/greybus/greybus_trace.h
rename to drivers/greybus/greybus_trace.h
diff --git a/drivers/staging/greybus/hd.c b/drivers/greybus/hd.c
similarity index 100%
rename from drivers/staging/greybus/hd.c
rename to drivers/greybus/hd.c
diff --git a/drivers/staging/greybus/interface.c b/drivers/greybus/interface.c
similarity index 100%
rename from drivers/staging/greybus/interface.c
rename to drivers/greybus/interface.c
diff --git a/drivers/staging/greybus/manifest.c b/drivers/greybus/manifest.c
similarity index 100%
rename from drivers/staging/greybus/manifest.c
rename to drivers/greybus/manifest.c
diff --git a/drivers/staging/greybus/module.c b/drivers/greybus/module.c
similarity index 100%
rename from drivers/staging/greybus/module.c
rename to drivers/greybus/module.c
diff --git a/drivers/staging/greybus/operation.c b/drivers/greybus/operation.c
similarity index 100%
rename from drivers/staging/greybus/operation.c
rename to drivers/greybus/operation.c
diff --git a/drivers/staging/greybus/svc.c b/drivers/greybus/svc.c
similarity index 100%
rename from drivers/staging/greybus/svc.c
rename to drivers/greybus/svc.c
diff --git a/drivers/staging/greybus/svc_watchdog.c b/drivers/greybus/svc_watchdog.c
similarity index 100%
rename from drivers/staging/greybus/svc_watchdog.c
rename to drivers/greybus/svc_watchdog.c
diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
index 4894c3514955..d03c37e1e6e8 100644
--- a/drivers/staging/greybus/Kconfig
+++ b/drivers/staging/greybus/Kconfig
@@ -1,20 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-menuconfig GREYBUS
-	tristate "Greybus support"
-	depends on SYSFS
-	---help---
-	  This option enables the Greybus driver core.  Greybus is an
-	  hardware protocol that was designed to provide Unipro with a
-	  sane application layer.  It was originally designed for the
-	  ARA project, a module phone system, but has shown up in other
-	  phones, and can be tunneled over other busses in order to
-	  control hardware devices.
-
-	  Say Y here to enable support for these types of drivers.
-
-	  To compile this code as a module, chose M here: the module
-	  will be called greybus.ko
-
 if GREYBUS
 
 config GREYBUS_ES2
diff --git a/drivers/staging/greybus/Makefile b/drivers/staging/greybus/Makefile
index 2551ed16b742..d16853399c9a 100644
--- a/drivers/staging/greybus/Makefile
+++ b/drivers/staging/greybus/Makefile
@@ -1,24 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-# Greybus core
-greybus-y :=	core.o		\
-		debugfs.o	\
-		hd.o		\
-		manifest.o	\
-		module.o	\
-		interface.o	\
-		bundle.o	\
-		connection.o	\
-		control.o	\
-		svc.o		\
-		svc_watchdog.o	\
-		operation.o
-
-obj-$(CONFIG_GREYBUS)		+= greybus.o
-
 # needed for trace events
 ccflags-y += -I$(src)
 
-
 # Greybus Host controller drivers
 gb-es2-y := es2.o
 
diff --git a/drivers/staging/greybus/es2.c b/drivers/staging/greybus/es2.c
index 366716f11b1a..5b755e76d8a4 100644
--- a/drivers/staging/greybus/es2.c
+++ b/drivers/staging/greybus/es2.c
@@ -15,7 +15,7 @@
 #include <asm/unaligned.h>
 
 #include "arpc.h"
-#include "greybus_trace.h"
+#include "../../greybus/greybus_trace.h"
 
 
 /* Default timeout for USB vendor requests. */
-- 
2.23.0

