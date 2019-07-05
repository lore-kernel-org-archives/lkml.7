Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9128C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CFA2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfGELFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:05:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40909 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfGELFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:05:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hjM2B-0008LA-W0; Fri, 05 Jul 2019 11:05:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] ubifs: remove redundant assignment to pointer fname
Date:   Fri,  5 Jul 2019 12:05:43 +0100
Message-Id: <20190705110543.31428-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer fname is being assigned with a value that is never
read because the function returns after the assignment. The assignment
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: fix up commit message

---
 fs/ubifs/debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 92fe5c5ed78a..95da71e13fc8 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2817,7 +2817,6 @@ void dbg_debugfs_init_fs(struct ubifs_info *c)
 		     c->vi.ubi_num, c->vi.vol_id);
 	if (n == UBIFS_DFS_DIR_LEN) {
 		/* The array size is too small */
-		fname = UBIFS_DFS_DIR_NAME;
 		return;
 	}
 
-- 
2.20.1

