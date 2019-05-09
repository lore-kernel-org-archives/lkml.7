Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AFAC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F4721019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RwjDRorZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ar31+3M3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEIBrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:47:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfEIBrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:47:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9833A60850; Thu,  9 May 2019 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557366442;
        bh=9rdLCUt1L7AFehmpyE7HdkJhWiTHmika/QMX7/o7pCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwjDRorZwpBgD6+a7BfemykODFvTIegs5vhmQoZq7/4n9dZjQSdkQe0cBSxAM+xF4
         jOwS18X2Rfzp90CZ9C1v8/0s3zstKwuKDuoy4hTX6TuG4xutMPDEVG2c5YzbVrN9AF
         RqjEItoOdn9uOZ7d1t2xotukGU8z7Ku7RqGTrbEo=
Received: from th-lint-015.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 384526081E;
        Thu,  9 May 2019 01:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557366441;
        bh=9rdLCUt1L7AFehmpyE7HdkJhWiTHmika/QMX7/o7pCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ar31+3M3z/rN7xzmoojW/GP84szDsT2hCoebyuYeHRucoaAzTK75bNIE/9iJ3jyaN
         Et3cl14q13+IHNT+8x6aM+u7ogOVQBVPlKiqhsYE2/Zu0gaaETnixJwvD1sS1pVC1h
         VLx5VLvWfWTRGeGyvvI21HQRlZ9/ULhJLKyCb1n0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 384526081E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     sudeep.holla@arm.com, julien.thierry@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH] kernel/panic: Use SYSTEM_RESET2 command for warm reset
Date:   Wed,  8 May 2019 18:47:12 -0700
Message-Id: <1557366432-352469-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <ce0b66f5d00e760f87ddeeacbc40b956@codeaurora.org>
References: <ce0b66f5d00e760f87ddeeacbc40b956@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms may need warm reboot support when kernel crashed
for post mortem analysis instead of cold reboot. So use config
CONFIG_WARM_REBOOT_ON_PANIC and SYSTEM_RESET2 psci command
support for warm reset.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 kernel/panic.c    |  4 ++++
 lib/Kconfig.debug | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index c1fcaad..6ab6675 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -198,6 +198,10 @@ void panic(const char *fmt, ...)
 
 	console_verbose();
 	bust_spinlocks(1);
+#ifdef CONFIG_WARM_REBOOT_ON_PANIC
+	/* Configure for warm reboot instead of cold reboot. */
+	reboot_mode = REBOOT_WARM;
+#endif
 	va_start(args, fmt);
 	len = vscnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d695ec1..2a727d8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1000,6 +1000,16 @@ config PANIC_TIMEOUT
 	  value n > 0 will wait n seconds before rebooting, while a timeout
 	  value n < 0 will reboot immediately.
 
+config WARM_REBOOT_ON_PANIC
+	bool "Warm reboot instead of cold reboot for panic"
+	default n
+	help
+	  Some vendor platform may need warm reboot instead of cold reboot
+	  for debugging. Before vendor specific power off driver is
+	  probed, platform always gets cold reset. By setting Y here and
+	  support for PSCI V1.1 is present from firmware, platform would
+	  get warm reset instead of cold reset.
+
 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
 	depends on DEBUG_KERNEL && PROC_FS
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

