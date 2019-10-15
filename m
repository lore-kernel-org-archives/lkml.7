Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C91ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88647205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfJOPg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:36:27 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52459 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJOPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:36:27 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKOrw-0006ZY-Ry; Tue, 15 Oct 2019 16:36:16 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKOrw-0001V2-De; Tue, 15 Oct 2019 16:36:16 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] decompressor: fix undeclared items
Date:   Tue, 15 Oct 2019 16:36:15 +0100
Message-Id: <20191015153615.5721-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The follow items are not declared but also not exported
so use __attribute__((__externally_visible__)) to silence
the following sparse warnings:

 ./include/linux/decompress/mm.h:31:30: warning: symbol 'malloc_ptr' was not declared. Should it be static?
./include/linux/decompress/mm.h:32:20: warning: symbol 'malloc_count' was not declared. Should it be static?
arch/arm/boot/compressed/decompress.c:59:5: warning: symbol 'do_decompress' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/compressed/decompress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index aa075d8372ea..8f4969916151 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -9,7 +9,7 @@
 #include "misc.h"
 
 #define STATIC static
-#define STATIC_RW_DATA	/* non-static please */
+#define STATIC_RW_DATA	__attribute__((__externally_visible__)) /* non-static please */
 
 /* Diagnostic functions */
 #ifdef DEBUG
@@ -56,7 +56,8 @@ extern char * strchrnul(const char *, int);
 #include "../../../../lib/decompress_unlz4.c"
 #endif
 
-int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
+int __attribute__((__externally_visible__))
+do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
 {
 	return __decompress(input, len, NULL, NULL, output, 0, NULL, error);
 }
-- 
2.23.0

