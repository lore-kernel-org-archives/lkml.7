Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DEAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956D02073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfH2JMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:12:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40096 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2JMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:12:50 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i3GTr-0004pV-N2; Thu, 29 Aug 2019 09:12:36 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, harry.pan@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] x86/hpet: Disable HPET on Intel Coffe Lake
Date:   Thu, 29 Aug 2019 17:12:32 +0800
Message-Id: <20190829091232.15065-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Coffee Lake platforms have skewed HPET timer once the SoCs entered
PC10, and marked TSC as unstable clocksource as result.

Harry Pan identified it's a firmware bug [1].

To prevent creating a circular dependency between HPET and TSC, let's
disable HPET on affected platforms.

[1]: https://lore.kernel.org/lkml/20190516090651.1396-1-harry.pan@intel.com/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203183

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 arch/x86/kernel/hpet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c6f791bc481e..07e9ec6f85b6 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -7,7 +7,9 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/hpet.h>
+#include <asm/intel-family.h>
 #include <asm/time.h>
 
 #undef  pr_fmt
@@ -806,6 +808,12 @@ static bool __init hpet_counting(void)
 	return false;
 }
 
+static const struct x86_cpu_id hpet_blacklist[] __initconst = {
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_MOBILE },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_DESKTOP },
+	{ }
+};
+
 /**
  * hpet_enable - Try to setup the HPET timer. Returns 1 on success.
  */
@@ -819,6 +827,9 @@ int __init hpet_enable(void)
 	if (!is_hpet_capable())
 		return 0;
 
+	if (!hpet_force_user && x86_match_cpu(hpet_blacklist))
+		return 0;
+
 	hpet_set_mapping();
 	if (!hpet_virt_address)
 		return 0;
-- 
2.17.1

