Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFD2ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3888B214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfJKOwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:52:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:11795 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfJKOwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:52:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 07:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="193554670"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2019 07:52:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB58F16A; Fri, 11 Oct 2019 17:52:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ipmi: use %*ph to print small buffer
Date:   Fri, 11 Oct 2019 17:52:13 +0300
Message-Id: <20191011145213.65082-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andy.shevchenko@gmail.com>

Use %*ph format to print small buffer as hex string.

The change is safe since the specifier can handle up to 64 bytes and taking
into account the buffer size of 100 bytes on stack the function has never been
used to dump more than 32 bytes. Note, this also avoids potential buffer
overflow if the length of the input buffer is bigger.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 2aab80e19ae0..d0cefd95fa57 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -48,14 +48,7 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 static void ipmi_debug_msg(const char *title, unsigned char *data,
 			   unsigned int len)
 {
-	int i, pos;
-	char buf[100];
-
-	pos = snprintf(buf, sizeof(buf), "%s: ", title);
-	for (i = 0; i < len; i++)
-		pos += snprintf(buf + pos, sizeof(buf) - pos,
-				" %2.2x", data[i]);
-	pr_debug("%s\n", buf);
+	pr_debug("%s: %*ph\n", title, len, buf);
 }
 #else
 static void ipmi_debug_msg(const char *title, unsigned char *data,
-- 
2.23.0

