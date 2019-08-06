Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808BAC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520C820717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfHFPPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:15:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:53860 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfHFPPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:15:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 08:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="176656459"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2019 08:15:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B86EC162; Tue,  6 Aug 2019 18:15:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] tracing: Be more clever when dumping hex in __print_hex()
Date:   Tue,  6 Aug 2019 18:15:43 +0300
Message-Id: <20190806151543.86061-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hex dump as many as 16 bytes at once in trace_print_hex_seq()
instead of byte-by-byte approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fix length calculation, so, when buf_len=16 it won't indefinitely loop
 kernel/trace/trace_output.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index cab4a5398f1d..d54ce252b05a 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -219,10 +219,10 @@ trace_print_hex_seq(struct trace_seq *p, const unsigned char *buf, int buf_len,
 {
 	int i;
 	const char *ret = trace_seq_buffer_ptr(p);
+	const char *fmt = concatenate ? "%*phN" : "%*ph";
 
-	for (i = 0; i < buf_len; i++)
-		trace_seq_printf(p, "%s%2.2x", concatenate || i == 0 ? "" : " ",
-				 buf[i]);
+	for (i = 0; i < buf_len; i += 16)
+		trace_seq_printf(p, fmt, min(buf_len - i, 16), &buf[i]);
 	trace_seq_putc(p, 0);
 
 	return ret;
-- 
2.20.1

