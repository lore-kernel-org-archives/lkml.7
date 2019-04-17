Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1E3C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6C7204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="tYytOG40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfDQF2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:28:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41735 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfDQF2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:28:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id d1so11450667plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 22:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5EwPg/bQEcUkZv671ATjbqlANxdDhHB9TcL2j0wyrQ=;
        b=tYytOG404GSsMz3HoX+6UiM54xLYZ5XuZkCZxFiMWa5/iAmfRE7LyXmVW8d+gDOr3Q
         3mBchf99H41AnzQBcRq1ushw3McoNUoFych5e4asVq07KLoYF1Vq1/Otg5l5jt/Q6o6D
         dXGAwRhv1UA7Y0xxRorzfpRyvqrQrhIPjpvNULoDFRj0I/4thJ0iE1AUZ1M8/YIrUune
         WPXwaJmkqmx0zhj5doY8nEswJHur/A4WMFaiFWNbtdpMapFeaxo0GosPMVIsG+rEbwV6
         Z8Pwl4dlqAz6T+Ey7mT+X4FP2gm7Cs1+db8EBdIW+JLdYOSxXfUaQhJErTOz6+OmMzN0
         lKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5EwPg/bQEcUkZv671ATjbqlANxdDhHB9TcL2j0wyrQ=;
        b=Y4qtMa6LWM8p9YrfDl3iymJatKhZXvUoDDlSMh6y89YIWKJGT31L3t1LieGODWhMrf
         7B70VRX6ycEkusxupRHtPo9KNfnLZUiGdzkhxuDknpXnz2/BkMcKFAz0jz2LAHPM5nq/
         ed1O/ZDc1zORtAnxXSXzmfOZElqGawHsK1AG19y3k0jkpBU9SjEobV4q4orRB4Whikad
         4QWvTd7mAKPmoaXF+V+uSKUGeT7qK3rLjvK6nkxQ9izVmlvUGOI1RmLAPb5BWNjcWh9C
         ztxpaXCCkCluNcf7bF6AE/XlQX1nrzJq/6s+i0EibqO0YfIy8QRbjD8ngbVOIJ1hkpPu
         5AUg==
X-Gm-Message-State: APjAAAWo5/UOm68sDKgUB7mVNHXuF7y9M+yKYckqPteqMj8FnSOIC27d
        P87HvuRi36ld/MhFvPndzC9YyQ==
X-Google-Smtp-Source: APXvYqwkWxqMMwAYuuBCAX7/YID5v7TAJru4jOTlBMfjCfNJ03Y6N/A9wK1wuev1jBnFyvzOisL8XQ==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr63474916pld.232.1555478894838;
        Tue, 16 Apr 2019 22:28:14 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id g2sm87911381pfd.134.2019.04.16.22.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 22:28:14 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, lenb@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com,
        rjw@rjwysocki.net
Subject: Detecting x86 LAPIC timer frequency from CPUID data
Date:   Wed, 17 Apr 2019 13:28:10 +0800
Message-Id: <20190417052810.3052-1-drake@endlessm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPUID.0x16 leaf provides "Bus (Reference) Frequency (in MHz)".

In the thread "No 8254 PIT & no HPET on new Intel N3350 platforms
causes kernel panic during early boot" we are exploring ways to have
the kernel avoid using the PIT/HPET IRQ0 timer in more cases, and
Thomas Gleixner suggested that we could use this CPUID data to set
lapic_timer_frequency, avoiding the need for calibrate_APIC_clock()
to measure the APIC clock against the IRQ0 timer.

I'm thinking of the the following code change, however I get
unexpected results on Intel i7-8565U (Whiskey Lake). When
booting without this change, and with apic=notscdeadline (so that
APIC clock gets calibrated and used), the bus speed is detected as
23MHz:

 ... lapic delta = 149994
 ... PM-Timer delta = 357939
 ... PM-Timer result ok
 ..... delta 149994
 ..... mult: 6442193
 ..... calibration result: 23999
 ..... CPU clock speed is 1991.0916 MHz.
 ..... host bus clock speed is 23.0999 MHz.

However the CPUID.0x16 ECX reports a 100MHz bus speed on this device,
so this code change would produce a significantly different calibration.

Am I doing anything obviously wrong?

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3fae23834069..6c51ce842f86 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -679,6 +679,16 @@ static unsigned long cpu_khz_from_cpuid(void)
 
 	cpuid(0x16, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * If bus frequency is provided in CPUID data, set
+	 * global lapic_timer_frequency to bus_clock_cycles/jiffy.
+	 * This avoids having to calibrate the APIC timer later.
+	 */
+	if (ecx_bus_mhz)
+		lapic_timer_frequency = (ecx_bus_mhz * 1000000) / HZ;
+#endif
+
 	return eax_base_mhz * 1000;
 }
 
-- 
2.19.1

