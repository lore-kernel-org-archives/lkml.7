Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C3BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1407B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfCSSnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:43:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:57907 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfCSSnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:43:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 11:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,245,1549958400"; 
   d="scan'208";a="330066617"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2019 11:43:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 677A93B3; Tue, 19 Mar 2019 20:43:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/7] x86/boot: Add MMIO byte accessors
Date:   Tue, 19 Mar 2019 21:43:23 +0300
Message-Id: <20190319184325.72807-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

readb() and writeb() would help to access serial device
via MMIO address space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/boot/boot.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 86641b2e83f8..b2a272d3f36b 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -79,6 +79,18 @@ static inline void io_delay(void)
 	asm volatile("outb %%al,%0" : : "dN" (DELAY_PORT));
 }
 
+static inline u8 readb(const volatile void __iomem *addr)
+{
+	u8 v;
+	asm volatile("movb %1,%0" : "=q" (v) : "m" (*(volatile u8 __force *)addr));
+	return v;
+}
+
+static inline void writeb(u8 v, volatile void __iomem *addr)
+{
+	asm volatile("movb %0,%1" : : "q" (v), "m" (*(volatile u8 __force *)addr));
+}
+
 /* These functions are used to reference data in other segments. */
 
 static inline u16 ds(void)
-- 
2.20.1

