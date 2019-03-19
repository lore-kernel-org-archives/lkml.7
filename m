Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A480C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D779C20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfCSSn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:43:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:57905 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbfCSSnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:43:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 11:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,245,1549958400"; 
   d="scan'208";a="330066616"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2019 11:43:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7391B474; Tue, 19 Mar 2019 20:43:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 6/7] x86/boot: Introduce MMIO accessors and their support in earlyprintk
Date:   Tue, 19 Mar 2019 21:43:24 +0300
Message-Id: <20190319184325.72807-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user supplied serial base address via kernel command line and
at the same time the word 'mmio' is present, use MMIO accessors.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/boot/early_serial_console.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 98aee6c6e374..cfc9e55cd68a 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -33,6 +33,20 @@ static void io_serial_out(unsigned long addr, int offset, int value)
 	outb(value, addr + offset);
 }
 
+static void mem8_serial_out(unsigned long addr, int offset, int value)
+{
+	u8 __iomem *vaddr = (u8 __iomem *)addr;
+	/* shift implied by pointer type */
+	writeb(value, vaddr + offset);
+}
+
+static unsigned int mem8_serial_in(unsigned long addr, int offset)
+{
+	u8 __iomem *vaddr = (u8 __iomem *)addr;
+	/* shift implied by pointer type */
+	return readb(vaddr + offset);
+}
+
 static void early_serial_configure(unsigned long port, int baud)
 {
 	unsigned char c;
@@ -59,6 +73,13 @@ static void early_serial_use_io_accessors(void)
 	serial_out = io_serial_out;
 }
 
+static void early_serial_use_mmio_accessors(void)
+{
+	/* It is memory mapped - assume 8-bit alignment */
+	serial_in = mem8_serial_in;
+	serial_out = mem8_serial_out;
+}
+
 static void early_serial_init(unsigned long port, int baud)
 {
 	early_serial_configure(port, baud);
@@ -101,12 +122,16 @@ static void parse_earlyprintk(void)
 		/*
 		 * make sure we have
 		 *	"serial,0x3f8,115200"
+		 *	"serial,mmio,0xff010180,115200"
 		 *	"serial,ttyS0,115200"
 		 *	"ttyS0,115200"
 		 */
 		if (pos == 7 && !strncmp(arg + pos, "0x", 2)) {
 			port = parse_serial_port(arg, pos + 0, &pos);
 			early_serial_use_io_accessors();
+		} else if (pos == 7 && !strncmp(arg + pos, "mmio,0x", 7)) {
+			port = parse_serial_port(arg, pos + 5, &pos);
+			early_serial_use_mmio_accessors();
 		} else if (!strncmp(arg + pos, "ttyS", 4)) {
 			static const int bases[] = { 0x3f8, 0x2f8 };
 			int idx = 0;
-- 
2.20.1

