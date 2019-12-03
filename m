Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB7FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A9D20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="y2yy33aQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfLCU50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:57:26 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:46863 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfLCU5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:57:25 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fb4926cd;
        Tue, 3 Dec 2019 20:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=We/tViqcNSYyTT+iqYw0DQdfrxM=; b=y2yy33aQtdKHY/kHDnHh
        hsMHQG5pe3IbrbK1MlDFz+yNgFh/zm44ZrAuWW/tcrNL/3qM2SQ6TOzjS1/lS6Vh
        oltVIUx4FQ5UZ/1RdgJvBcfo/apDl4dseyILbBFqVkau+um8oqkYd1ofeyHhKZrL
        vWJsHibHM6+lvMKmUrQTHqIKdCZ8LENU44FyRzKj92EtWpB+SxsVA9Xf4NHFoz5E
        h++KU4dfEJYT72dHveRBF6/0ZRC1RH07JY80mF0pDr3YhKnQfX8UcKWvUVRQO3rq
        iTETzDmOhiLSQaEmIQrRETnHbjkwzeB20S9b2yVpmfBEwV7e0/GHzsUaGuAxT7Mz
        KA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 388e7a3f (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 3 Dec 2019 20:02:43 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Feng Tang <feng.tang@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: [PATCH] x86/quirks: disable HPET on Intel Coffee Lake Refresh platforms
Date:   Tue,  3 Dec 2019 21:57:16 +0100
Message-Id: <20191203205716.1228-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up of fc5db58539b4 ("x86/quirks: Disable HPET on Intel
Coffe Lake platforms"), which addressed the issue for 8th generation
Coffee Lake. Intel has released Coffee Lake again for 9th generation,
apparently still with the same bug:

clocksource: timekeeping watchdog on CPU3: Marking clocksource 'tsc' as unstable because the skew is too large:
clocksource:                       'hpet' wd_now: 24f422b8 wd_last: 247dea41 mask: ffffffff
clocksource:                       'tsc' cs_now: 144d927c4e cs_last: 140ba6e2a0 mask: ffffffffffffffff
tsc: Marking TSC unstable due to clocksource watchdog
TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
sched_clock: Marking unstable (26553416234, 4203921)<-(26567277071, -9656937)
clocksource: Switched to clocksource hpet

So, we add another quirk for the chipset

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/early-quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 4cba91ec8049..a73f88dd7f86 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -712,6 +712,8 @@ static struct chipset early_qrk[] __initdata = {
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	{ PCI_VENDOR_ID_INTEL, 0x3e20,
+		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
 	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
 	{}
-- 
2.24.0

