Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5EBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB9B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfCSSnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:43:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:18381 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfCSSna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:43:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 11:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,245,1549958400"; 
   d="scan'208";a="135648403"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Mar 2019 11:43:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 539AB235; Tue, 19 Mar 2019 20:43:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/7] x86/boot: Split out parse_serial_port() helper for earlyprintk
Date:   Tue, 19 Mar 2019 21:43:21 +0300
Message-Id: <20190319184325.72807-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced helper will be used later on to parse serial port
in different type of earlyprintk command line arguments.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/boot/early_serial_console.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 05d02cd4de99..85a227a21f95 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -66,6 +66,20 @@ static void early_serial_init(unsigned long port, int baud)
 	early_serial_base = port;
 }
 
+static unsigned long parse_serial_port(const char *arg, int off, int *pos)
+{
+	unsigned long port;
+	char *e;
+
+	port = simple_strtoull(arg + off, &e, 16);
+	if (port == 0 || arg + off == e)
+		port = DEFAULT_SERIAL_PORT;
+	else
+		*pos = e - arg;
+
+	return port;
+}
+
 static void parse_earlyprintk(void)
 {
 	int baud = DEFAULT_BAUD;
@@ -91,11 +105,7 @@ static void parse_earlyprintk(void)
 		 *	"ttyS0,115200"
 		 */
 		if (pos == 7 && !strncmp(arg + pos, "0x", 2)) {
-			port = simple_strtoull(arg + pos, &e, 16);
-			if (port == 0 || arg + pos == e)
-				port = DEFAULT_SERIAL_PORT;
-			else
-				pos = e - arg;
+			port = parse_serial_port(arg, pos + 0, &pos);
 			early_serial_use_io_accessors();
 		} else if (!strncmp(arg + pos, "ttyS", 4)) {
 			static const int bases[] = { 0x3f8, 0x2f8 };
-- 
2.20.1

