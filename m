Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EA3C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7DC2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfEQKpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:45:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38469 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfEQKpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:45:19 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hRaMX-0004R0-63; Fri, 17 May 2019 12:45:17 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hRaMW-0002i5-Oc; Fri, 17 May 2019 12:45:16 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     ecryptfs@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@canonical.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ecryptfs: use print_hex_dump_bytes for hexdump
Date:   Fri, 17 May 2019 12:45:15 +0200
Message-Id: <20190517104515.10371-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kernel has nice hexdump facilities, use them rather a homebrew
hexdump function.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ecryptfs/debug.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/ecryptfs/debug.c b/fs/ecryptfs/debug.c
index 3d2bdf546ec6..ee9d8ac4a809 100644
--- a/fs/ecryptfs/debug.c
+++ b/fs/ecryptfs/debug.c
@@ -97,25 +97,9 @@ void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok)
  */
 void ecryptfs_dump_hex(char *data, int bytes)
 {
-	int i = 0;
-	int add_newline = 1;
-
 	if (ecryptfs_verbosity < 1)
 		return;
-	if (bytes != 0) {
-		printk(KERN_DEBUG "0x%.2x.", (unsigned char)data[i]);
-		i++;
-	}
-	while (i < bytes) {
-		printk("0x%.2x.", (unsigned char)data[i]);
-		i++;
-		if (i % 16 == 0) {
-			printk("\n");
-			add_newline = 0;
-		} else
-			add_newline = 1;
-	}
-	if (add_newline)
-		printk("\n");
-}
 
+	print_hex_dump(KERN_DEBUG, "ecryptfs: ", DUMP_PREFIX_OFFSET, 16, 1,
+		       data, bytes, false);
+}
-- 
2.20.1

