Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726BCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E85D20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCSSnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:43:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:62476 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbfCSSna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:43:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 11:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,245,1549958400"; 
   d="scan'208";a="135435380"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2019 11:43:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5CA17339; Tue, 19 Mar 2019 20:43:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/7] x86/boot: Allow longer parameter list for earlyprintk
Date:   Tue, 19 Mar 2019 21:43:22 +0300
Message-Id: <20190319184325.72807-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow longer parameter list, up to 64 characters, for earlyprintk
to support new coming parameters.

If the parsed string is longer than this buffer it will be cut up by
the buffer size.

No functional change intended.

Note, that 'console' case is already covered.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/boot/early_serial_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 85a227a21f95..98aee6c6e374 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -83,7 +83,7 @@ static unsigned long parse_serial_port(const char *arg, int off, int *pos)
 static void parse_earlyprintk(void)
 {
 	int baud = DEFAULT_BAUD;
-	char arg[32];
+	char arg[64];
 	int pos = 0;
 	unsigned long port = 0;
 
-- 
2.20.1

