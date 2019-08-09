Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E89AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 01:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826F62171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 01:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405376AbfHIBZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 21:25:42 -0400
Received: from foss.arm.com ([217.140.110.172]:40446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404978AbfHIBZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 21:25:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAF6C15AB;
        Thu,  8 Aug 2019 18:25:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 503D43F575;
        Thu,  8 Aug 2019 18:25:37 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>, Jia He <justin.he@arm.com>
Subject: [PATCH 2/2] lib/test_printf: add test of null/invalid pointer dereference for dentry
Date:   Fri,  9 Aug 2019 09:24:57 +0800
Message-Id: <20190809012457.56685-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809012457.56685-1-justin.he@arm.com>
References: <20190809012457.56685-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add some additional test cases of null/invalid pointer dereference
for dentry and file (%pd and %pD)

Signed-off-by: Jia He <justin.he@arm.com>
---
 lib/test_printf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 944eb50f3862..befedffeb476 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -455,6 +455,13 @@ dentry(void)
 	test("foo", "%pd", &test_dentry[0]);
 	test("foo", "%pd2", &test_dentry[0]);
 
+	/* test the null/invalid pointer case for dentry */
+	test("(null)", "%pd", NULL);
+	test("(efault)", "%pd", PTR_INVALID);
+	/* test the null/invalid pointer case for file */
+	test("(null)", "%pD", NULL);
+	test("(efault)", "%pD", PTR_INVALID);
+
 	test("romeo", "%pd", &test_dentry[3]);
 	test("alfa/romeo", "%pd2", &test_dentry[3]);
 	test("bravo/alfa/romeo", "%pd3", &test_dentry[3]);
-- 
2.17.1

