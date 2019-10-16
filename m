Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AFEC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FDD20650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390211AbfJPKEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:04:22 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45155 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfJPKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:04:22 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKgA8-0002jl-As; Wed, 16 Oct 2019 11:04:12 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKgA7-0004VB-RR; Wed, 16 Oct 2019 11:04:11 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: force prandom result to __le32
Date:   Wed, 16 Oct 2019 11:04:09 +0100
Message-Id: <20191016100409.17262-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In set_dent_cookie() the result of prandom_u32() is
assinged to an __le32 type. Make this a forced conversion
to remove the following sparse warning:

fs/ubifs/journal.c:506:30: warning: incorrect type in assignment (different base types)
fs/ubifs/journal.c:506:30:    expected restricted __le32 [usertype] cookie
fs/ubifs/journal.c:506:30:    got unsigned int

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Richard Weinberger <richard@nod.at>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 fs/ubifs/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 4fd9683b8245..d6136f7c1cfc 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -503,7 +503,7 @@ static void mark_inode_clean(struct ubifs_info *c, struct ubifs_inode *ui)
 static void set_dent_cookie(struct ubifs_info *c, struct ubifs_dent_node *dent)
 {
 	if (c->double_hash)
-		dent->cookie = prandom_u32();
+		dent->cookie = (__force __le32) prandom_u32();
 	else
 		dent->cookie = 0;
 }
-- 
2.23.0

