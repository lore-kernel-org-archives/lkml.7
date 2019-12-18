Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3080FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E0421D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfLRIiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:38:54 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55259 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfLRIix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:38:53 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ihUr3-0000xG-JZ; Wed, 18 Dec 2019 09:38:49 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ihUr0-0000lb-L0; Wed, 18 Dec 2019 09:38:46 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] serdev: fix builds with CONFIG_SERIAL_DEV_BUS=m
Date:   Wed, 18 Dec 2019 09:38:42 +0100
Message-Id: <20191218083842.14882-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <201912181000.82Z7czbN%lkp@intel.com>
References: <201912181000.82Z7czbN%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 54edb425346a ("serdev: simplify Makefile") broke builds with
serdev configured as module. I don't understand it completely yet, but
it seems that

	obj-$(CONFIG_SERIAL_DEV_BUS) += serdev/

in drivers/tty/Makefile with CONFIG_SERIAL_DEV_BUS=m doesn't result in
code that is added using obj-y in drivers/tty/serdev/Makefile being
compiled. So instead of dropping $(CONFIG_SERIAL_DEV_BUS) in serdev's
Makefile, drop it in drivers/tty/Makefile.

Fixes: 54edb425346a ("serdev: simplify Makefile")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

as Greg already added the offending patch to tty-next I assume it is
frozen and cannot be dropped any more, so here is an incremental fix.

Best regards
Uwe

 drivers/tty/Makefile        | 2 +-
 drivers/tty/serdev/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 020b1cd9294f..6b2a21d4e0bb 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_R3964)		+= n_r3964.o
 obj-y				+= vt/
 obj-$(CONFIG_HVC_DRIVER)	+= hvc/
 obj-y				+= serial/
-obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
+obj-y				+= serdev/
 
 # tty drivers
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
index f71bb931735b..078417e5b068 100644
--- a/drivers/tty/serdev/Makefile
+++ b/drivers/tty/serdev/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 serdev-objs := core.o
 
-obj-y += serdev.o
+obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
 
 obj-$(CONFIG_SERIAL_DEV_CTRL_TTYPORT) += serdev-ttyport.o
-- 
2.24.0

