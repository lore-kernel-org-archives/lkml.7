Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F620C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F1920863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCSUDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:03:31 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:60580 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfCSUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:03:30 -0400
X-IronPort-AV: E=Sophos;i="5.60,245,1549929600"; 
   d="scan'208";a="81060873"
From:   Jennifer Herbert <jennifer.herbert@citrix.com>
To:     <x86@kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jennifer Herbert <jennifer.herbert@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] xen/pv: Add PV specific legacy_pic struct to expose legacy IRQs.
Date:   Tue, 19 Mar 2019 20:02:19 +0000
Message-ID: <1553025739-92245-1-git-send-email-jennifer.herbert@citrix.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI tables doesn't always contain all IRQs for legacy devices
such as RTC.  Since no PIC controller is visible for a PV linux guest,
under Xen, legacy_pic currently defaults to the null_legacy_pic - with
reports no legacy IRQs.  Since the commit "rtc: cmos: Do not assume
irq 8 for rtc when there are no legacy irqs" by Hans de Goede
(commit id: a1e23a42f1bdc00e32fc4869caef12e4e6272f26), the rtc now
incorrectly decides it has no irq it can use, for some hardware.

This patch rectifies the problem by providing a xen legacy_pic
struct, which is much like the null_legacy_pic except that it
reports NR_IRQS_LEGACY irqs.

Signed-off-by: Jennifer Herbert <jennifer.herbert@citrix.com>
---
 arch/x86/xen/enlighten_pv.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c54a493..7644bdf 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -33,6 +33,7 @@
 #include <linux/gfp.h>
 #include <linux/edd.h>
 #include <linux/frame.h>
+#include <linux/irq.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
@@ -49,6 +50,7 @@
 #include <xen/acpi.h>
 
 #include <asm/paravirt.h>
+#include <asm/i8259.h>
 #include <asm/apic.h>
 #include <asm/page.h>
 #include <asm/xen/pci.h>
@@ -1188,6 +1190,41 @@ static void __init xen_dom0_set_legacy_features(void)
 	x86_platform.legacy.rtc = 1;
 }
 
+/*
+ * The ACPI tables doesn't always contain all IRQ's for legacy devices
+ * such as RTC.  Since no PIC controller is visible, we'd otherwise
+ * default to the null_legacy_pic - with no legacy IRQs.  To allow drivers
+ * to use these IRQs despite this, provide a xen specific legacy_pic
+ * structure, which is noop, other then reporting NR_IRQS_LEGACY irqs.
+ */
+
+static void xen_legacy_pic_noop(void) { };
+static void xen_legacy_pic_uint_noop(unsigned int unused) { };
+static void xen_legacy_pic_int_noop(int unused) { };
+static int xen_legacy_pic_irq_pending_noop(unsigned int irq)
+{
+	return 0;
+}
+
+static int xen_legacy_pic_probe(void)
+{
+	pr_info("Using Xen legacy PIC\n");
+	return nr_legacy_irqs();
+}
+
+struct legacy_pic xen_legacy_pic = {
+	.nr_legacy_irqs = NR_IRQS_LEGACY,
+	.chip = &dummy_irq_chip,
+	.mask = xen_legacy_pic_uint_noop,
+	.unmask = xen_legacy_pic_uint_noop,
+	.mask_all = xen_legacy_pic_noop,
+	.restore_mask = xen_legacy_pic_noop,
+	.init = xen_legacy_pic_int_noop,
+	.probe = xen_legacy_pic_probe,
+	.irq_pending = xen_legacy_pic_irq_pending_noop,
+	.make_irq = xen_legacy_pic_uint_noop,
+};
+
 /* First C function to be called on Xen boot */
 asmlinkage __visible void __init xen_start_kernel(void)
 {
@@ -1267,6 +1304,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	xen_init_capabilities();
 
+	legacy_pic = &xen_legacy_pic;
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * set up the basic apic ops.
-- 
1.8.3.1

