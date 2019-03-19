Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3502175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCSSnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:43:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:30130 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfCSSne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:43:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 11:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,245,1549958400"; 
   d="scan'208";a="142065955"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2019 11:43:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F8B447B; Tue, 19 Mar 2019 20:43:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 7/7] x86/boot: Support nocfg parameter for earlyprintk
Date:   Tue, 19 Mar 2019 21:43:25 +0300
Message-Id: <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If by BIOS or by other means the serial port is configured
user might want to skip reconfiguration in the boot code.

Add support of 'nocfg' parameter to earlyprintk.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/boot/early_serial_console.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index cfc9e55cd68a..5b4a81bf5d0e 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -80,9 +80,10 @@ static void early_serial_use_mmio_accessors(void)
 	serial_out = mem8_serial_out;
 }
 
-static void early_serial_init(unsigned long port, int baud)
+static void early_serial_init(unsigned long port, int baud, bool configure)
 {
-	early_serial_configure(port, baud);
+	if (configure)
+		early_serial_configure(port, baud);
 
 	early_serial_base = port;
 }
@@ -101,12 +102,22 @@ static unsigned long parse_serial_port(const char *arg, int off, int *pos)
 	return port;
 }
 
+static bool parse_serial_configure(const char *arg, int off, int *pos)
+{
+	if (strncmp(arg + off, "nocfg", 5))
+		return true;
+
+	*pos = off + 5;
+	return false;
+}
+
 static void parse_earlyprintk(void)
 {
 	int baud = DEFAULT_BAUD;
 	char arg[64];
 	int pos = 0;
 	unsigned long port = 0;
+	bool configure = true;
 
 	if (cmdline_find_option("earlyprintk", arg, sizeof(arg)) > 0) {
 		char *e;
@@ -146,6 +157,11 @@ static void parse_earlyprintk(void)
 			early_serial_use_io_accessors();
 		}
 
+		if (arg[pos] == ',')
+			pos++;
+
+		configure = parse_serial_configure(arg, pos, &pos);
+
 		if (arg[pos] == ',')
 			pos++;
 
@@ -155,7 +171,7 @@ static void parse_earlyprintk(void)
 	}
 
 	if (port)
-		early_serial_init(port, baud);
+		early_serial_init(port, baud, configure);
 }
 
 #define BASE_BAUD (1843200/16)
@@ -179,6 +195,7 @@ static void parse_console_uart8250(void)
 	char optstr[64], *options;
 	int baud = DEFAULT_BAUD;
 	unsigned long port = 0;
+	bool configure = true;
 
 	/*
 	 * console=uart8250,io,0x3f8,115200n8
@@ -204,7 +221,7 @@ static void parse_console_uart8250(void)
 		baud = probe_baud(port);
 
 	if (port)
-		early_serial_init(port, baud);
+		early_serial_init(port, baud, configure);
 }
 
 void console_init(void)
-- 
2.20.1

