Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A18214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="utxYvj54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbfDAHfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:35:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40248 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfDAHfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:35:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so4300671pgo.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kDMNCM0YvYeZqtot2GRHpNcY9E8tglH3IcASS00BoF4=;
        b=utxYvj540UavPGe7nWbn7hZ7060G4j1YwBlc8LRme4+U/0ussNphs8Ne7JE/1mBqFD
         oXQSTW0RCgdqIl6alHGxi33LM5T/XyOSSNekNV17sFwM+0ZafcpBSQET7JvcqnptdgWb
         /0lAP5p4VUoqI2rMwlQa0ktfTKS6JlvLHZysUGWDOpxplM1+S1cOu0ulfQCxIAEFKCHF
         Tteopevy7REOtFS6OfWHawxcrk8yrE8f1mdbBGx0TSve/aB9blUB6j6TXaX2gFcqQMFD
         v/atOXkEBaPTuF8txEp36rs5C06w4BgSoBaeNC/f39NlSKR0+jKRWSzLK7cgLcbshJJR
         Cttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kDMNCM0YvYeZqtot2GRHpNcY9E8tglH3IcASS00BoF4=;
        b=kO+Aytcl2txTwfUg54DKVqsAlhnP0j84cEFkQc1XuQwIhWwQ9iz4I9IaGQXJ3VXLIb
         /Q73qleVOpZgR8dcoDmUehcEOtp9TaC1E+xLLsJKnMaHv9q26fFMuZMlNECjXo6DD83f
         gp9HbMe3GXrBo2/Vmx+z4KqyOfc9jiB5QKi2BRTHcB+lBKEx3F9yWQSH/EhK/EuQDHuS
         JQnMJ3rhaiWpcVeBpBPbCexX3bz/op39jiOP7adHSH2RF2Q1isGiazC4aZJrxyh/JDwl
         Hzlxuv/06dZ+bbhGXdKZcB01WBTOqZSqPWvWYGn2eGzlT/vlWPVgznW186dAcFji87H8
         bDDw==
X-Gm-Message-State: APjAAAUp9HiGFYfO5UQRb3UOLqRpovFJk09IZOtcvlIXBNcmPI604JdP
        8L3UefvRrhHJY4F51lfMhz9x4w==
X-Google-Smtp-Source: APXvYqzQ084oWg50qHBKP9j5XjHJz3nxh68djKwMJlZteUtg//jK0yQ7Ca3kCI0XQrVEGAA0rF/vhw==
X-Received: by 2002:a65:50c2:: with SMTP id s2mr51495856pgp.112.1554104138597;
        Mon, 01 Apr 2019 00:35:38 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id r3sm30585532pgb.82.2019.04.01.00.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 00:35:37 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH] x86/reboot: Use efi reboot for Acer TravelMate X514-51T
Date:   Mon,  1 Apr 2019 15:35:14 +0800
Message-Id: <20190401073514.2785-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon reboot, the Acer TravelMate X514-51T laptop appears to complete the
shutdown process, but then it hangs in BIOS POST with a black screen.

The problem is intermittent - at some points it has appeared related to
Secure Boot settings or different kernel builds, but ultimately we have
not been able to identify the exact conditions that trigger the issue to
come and go.

However, after extensive testing, we observe that using the EFI reboot
method reliably avoids the issue in all cases.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=203119
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 arch/x86/kernel/reboot.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 725624b6c0c0..145bdfb56a9a 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -81,6 +81,19 @@ static int __init set_bios_reboot(const struct dmi_system_id *d)
 	return 0;
 }
 
+/*
+ * Some machines require the "reboot=e" commandline options
+ */
+static int __init set_efi_reboot(const struct dmi_system_id *d)
+{
+	if (reboot_type != BOOT_EFI) {
+		reboot_type = BOOT_EFI;
+		pr_info("%s series board detected. Selecting %s-method for reboot.\n",
+			d->ident, "EFI");
+	}
+	return 0;
+}
+
 void __noreturn machine_real_restart(unsigned int type)
 {
 	local_irq_disable();
@@ -166,6 +179,14 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "AOA110"),
 		},
 	},
+	{	/* Handle reboot issue on Acer TravelMate X514-51T */
+		.callback = set_efi_reboot,
+		.ident = "Acer TravelMate X514-51T",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate X514-51T"),
+		},
+	},
 
 	/* Apple */
 	{	/* Handle problems with rebooting on Apple MacBook5 */
-- 
2.20.1

