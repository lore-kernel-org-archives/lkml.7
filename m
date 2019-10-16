Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6720C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63C620650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404586AbfJPKPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:15:12 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45673 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfJPKPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:15:12 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKgKf-00037D-3d; Wed, 16 Oct 2019 11:15:05 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKgKe-0008GZ-Dh; Wed, 16 Oct 2019 11:15:04 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: fix type of sup->hash_algo
Date:   Wed, 16 Oct 2019 11:15:03 +0100
Message-Id: <20191016101503.31731-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sup->hash_algo is a __le16, and whilst 0xffff is
the same in __le16 and u16, it would be better to use
cpu_to_le16() anyway (which should deal with constants)
and silence the following sparse warning:

fs/ubifs/sb.c:187:32: warning: incorrect type in assignment (different base types)
fs/ubifs/sb.c:187:32:    expected restricted __le16 [usertype] hash_algo
fs/ubifs/sb.c:187:32:    got int

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Richard Weinberger <richard@nod.at>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 fs/ubifs/sb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index a551eb3e9b89..2b7c04bf8983 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -184,7 +184,7 @@ static int create_default_filesystem(struct ubifs_info *c)
 		if (err)
 			goto out;
 	} else {
-		sup->hash_algo = 0xffff;
+		sup->hash_algo = cpu_to_le16(0xffff);
 	}
 
 	sup->ch.node_type  = UBIFS_SB_NODE;
-- 
2.23.0

