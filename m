Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E660DC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA882735B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395428;
	bh=xD4SwbmKMgnKva+3Vs4w7KV6g2YB0d9n4kNJYhyBxhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YvSqwvHp5OCzM1us/GClB9o6gKVcWfJoxXeiK8k+pbiPzIzHMeyFstr0hhOFprCO+
	 cOjLVJIVsLzun6/RfpfXPwjD7qDPxIsNaM/qa0YCc0L09mmZYeAY0zucfmxuBETpe8
	 jAhDPgPnJQAr0pUuxeJ1xdiepkFcaXbQE1JSALLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfFANXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729087AbfFANXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:23:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF25327333;
        Sat,  1 Jun 2019 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395423;
        bh=xD4SwbmKMgnKva+3Vs4w7KV6g2YB0d9n4kNJYhyBxhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMI0mueoKai3680o9NDgppVI/sEe0EAra9SyXj9HgJXHAHEdQuOimx3nCKdtdXFVc
         2yt4UvJMgZmwfYf0+ptqx1W/RnSQ01KbFpKcKGL9nSdtXtv0L6fKjnRLJ+ednha5qo
         akzE8cuJKPAtt/EeoahS87bJYJW7CixFF3r6Wa8c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 055/141] watchdog: Use depends instead of select for pretimeout governors
Date:   Sat,  1 Jun 2019 09:20:31 -0400
Message-Id: <20190601132158.25821-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit f627ac0e12cd2736e60b9f5782ecec1d97251f77 ]

Watchdog pretimeout governors were enabled from the default governor
selection using "select". As a result, the default governor was always
built into the kernel, even if no watchdog driver was loaded. By using
"depends on" instead of "select", we are in better control, and the
governors can all be built as modules. At the same time, set the default
configuration option for pretimeout governors to match WATCHDOG_CORE
(meaning all pretimeout governors are by default enabled if pretimeout
support is enabled).

The practical impact of this change is minimal. Previously, selecting
a default governor automatically enabled that governor. Now, a default
governor can only be selected if that governor has been enabled.
Consequently, the order of governor selection is now reversed: The
governor selection is now first, followed by default governor selection.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/Kconfig | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5ea8909a41f95..8c9ea3cd9c601 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1972,6 +1972,20 @@ config WATCHDOG_PRETIMEOUT_GOV
 
 if WATCHDOG_PRETIMEOUT_GOV
 
+config WATCHDOG_PRETIMEOUT_GOV_NOOP
+	tristate "Noop watchdog pretimeout governor"
+	default WATCHDOG_CORE
+	help
+	  Noop watchdog pretimeout governor, only an informational
+	  message is added to kernel log buffer.
+
+config WATCHDOG_PRETIMEOUT_GOV_PANIC
+	tristate "Panic watchdog pretimeout governor"
+	default WATCHDOG_CORE
+	help
+	  Panic watchdog pretimeout governor, on watchdog pretimeout
+	  event put the kernel into panic.
+
 choice
 	prompt "Default Watchdog Pretimeout Governor"
 	default WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
@@ -1982,7 +1996,7 @@ choice
 
 config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
 	bool "noop"
-	select WATCHDOG_PRETIMEOUT_GOV_NOOP
+	depends on WATCHDOG_PRETIMEOUT_GOV_NOOP
 	help
 	  Use noop watchdog pretimeout governor by default. If noop
 	  governor is selected by a user, write a short message to
@@ -1990,7 +2004,7 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP
 
 config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
 	bool "panic"
-	select WATCHDOG_PRETIMEOUT_GOV_PANIC
+	depends on WATCHDOG_PRETIMEOUT_GOV_PANIC
 	help
 	  Use panic watchdog pretimeout governor by default, if
 	  a watchdog pretimeout event happens, consider that
@@ -1998,18 +2012,6 @@ config WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC
 
 endchoice
 
-config WATCHDOG_PRETIMEOUT_GOV_NOOP
-	tristate "Noop watchdog pretimeout governor"
-	help
-	  Noop watchdog pretimeout governor, only an informational
-	  message is added to kernel log buffer.
-
-config WATCHDOG_PRETIMEOUT_GOV_PANIC
-	tristate "Panic watchdog pretimeout governor"
-	help
-	  Panic watchdog pretimeout governor, on watchdog pretimeout
-	  event put the kernel into panic.
-
 endif # WATCHDOG_PRETIMEOUT_GOV
 
 endif # WATCHDOG
-- 
2.20.1

