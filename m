Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7E6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324272173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566712526;
	bh=8FnhyEKpggDN3aK+ZfTvFstcWm3nmqWfcrgyRWM7bgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1N9/z3mLjKLQEPhMBMdOwKYxo58AgFArGv8a0u++ZVz+QwKdsU/Lf2aGhGcAyYgNP
	 ZLWRDMHnFH/ByKeloWnG/lMb4Nuf92XEGz+GHGajC+QzVIn/COHmBtsfwgzOAXlpWW
	 ufMvqfFamskEJwkW2O3KxDpBgLklyBM7ZhPaM2+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfHYFzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 01:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbfHYFzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 01:55:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E61D21848;
        Sun, 25 Aug 2019 05:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566712517;
        bh=8FnhyEKpggDN3aK+ZfTvFstcWm3nmqWfcrgyRWM7bgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xdt+hPmlkBtVtaMKDo3trgS5B1o91uybPMx/CjGOyefK3RL7Kq6zYyKh/3K5dmy1C
         bj5o9X+gsHIbEGFJIO08J1ZgpfpksN3eX3A5ux1lwoCOAZTQtpj2UFnfGIVcAeqWKk
         5r0agg3F1Raiu21phfpSC8LnRSQ7kvoWlhICyPzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 9/9] staging: greybus: move es2 to drivers/greybus/
Date:   Sun, 25 Aug 2019 07:54:29 +0200
Message-Id: <20190825055429.18547-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825055429.18547-1-gregkh@linuxfoundation.org>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The es2 Greybus host controller has long been stable, so move it out of
drivers/staging/ to drivers/greybus/

Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/greybus/Kconfig              | 16 ++++++++++++++++
 drivers/greybus/Makefile             |  7 +++++++
 drivers/{staging => }/greybus/arpc.h |  0
 drivers/{staging => }/greybus/es2.c  |  2 +-
 drivers/staging/greybus/Kconfig      | 11 -----------
 drivers/staging/greybus/Makefile     |  5 -----
 6 files changed, 24 insertions(+), 17 deletions(-)
 rename drivers/{staging => }/greybus/arpc.h (100%)
 rename drivers/{staging => }/greybus/es2.c (99%)

diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
index 158d8893114c..b84fcaf8b105 100644
--- a/drivers/greybus/Kconfig
+++ b/drivers/greybus/Kconfig
@@ -14,3 +14,19 @@ menuconfig GREYBUS
 
 	  To compile this code as a module, chose M here: the module
 	  will be called greybus.ko
+
+if GREYBUS
+
+config GREYBUS_ES2
+	tristate "Greybus ES3 USB host controller"
+	depends on USB
+	---help---
+	  Select this option if you have a Toshiba ES3 USB device that
+	  acts as a Greybus "host controller".  This device is a bridge
+	  from a USB device to a Unipro network.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called gb-es2.ko
+
+endif	# GREYBUS
+
diff --git a/drivers/greybus/Makefile b/drivers/greybus/Makefile
index 03b22616ec7d..9bccdd229aa2 100644
--- a/drivers/greybus/Makefile
+++ b/drivers/greybus/Makefile
@@ -17,3 +17,10 @@ obj-$(CONFIG_GREYBUS)		+= greybus.o
 
 # needed for trace events
 ccflags-y += -I$(src)
+
+# Greybus Host controller drivers
+gb-es2-y := es2.o
+
+obj-$(CONFIG_GREYBUS_ES2)	+= gb-es2.o
+
+
diff --git a/drivers/staging/greybus/arpc.h b/drivers/greybus/arpc.h
similarity index 100%
rename from drivers/staging/greybus/arpc.h
rename to drivers/greybus/arpc.h
diff --git a/drivers/staging/greybus/es2.c b/drivers/greybus/es2.c
similarity index 99%
rename from drivers/staging/greybus/es2.c
rename to drivers/greybus/es2.c
index 5b755e76d8a4..366716f11b1a 100644
--- a/drivers/staging/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -15,7 +15,7 @@
 #include <asm/unaligned.h>
 
 #include "arpc.h"
-#include "../../greybus/greybus_trace.h"
+#include "greybus_trace.h"
 
 
 /* Default timeout for USB vendor requests. */
diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
index d03c37e1e6e8..d4777f5a8b90 100644
--- a/drivers/staging/greybus/Kconfig
+++ b/drivers/staging/greybus/Kconfig
@@ -1,17 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if GREYBUS
 
-config GREYBUS_ES2
-	tristate "Greybus ES3 USB host controller"
-	depends on USB
-	---help---
-	  Select this option if you have a Toshiba ES3 USB device that
-	  acts as a Greybus "host controller".  This device is a bridge
-	  from a USB device to a Unipro network.
-
-	  To compile this code as a module, chose M here: the module
-	  will be called gb-es2.ko
-
 config GREYBUS_AUDIO
 	tristate "Greybus Audio Class driver"
 	depends on SOUND
diff --git a/drivers/staging/greybus/Makefile b/drivers/staging/greybus/Makefile
index d16853399c9a..627e44f2a983 100644
--- a/drivers/staging/greybus/Makefile
+++ b/drivers/staging/greybus/Makefile
@@ -2,11 +2,6 @@
 # needed for trace events
 ccflags-y += -I$(src)
 
-# Greybus Host controller drivers
-gb-es2-y := es2.o
-
-obj-$(CONFIG_GREYBUS_ES2)	+= gb-es2.o
-
 # Greybus class drivers
 gb-bootrom-y		:= bootrom.o
 gb-camera-y		:= camera.o
-- 
2.23.0

