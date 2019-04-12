Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6901EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C012083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfDLK5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:57:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50769 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDLK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:57:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hEtsE-0002eK-9O; Fri, 12 Apr 2019 10:57:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] orangefs: remove redundant code
Date:   Fri, 12 Apr 2019 11:57:33 +0100
Message-Id: <20190412105733.25976-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check of inode->i_state & I_DIRTY_PAGES is redundant as it
just does the same actions as the following code when the condition
is false.  Although it shows the intention of what to do when
I_DIRTY_PAGES is set I think removing the redunant check is preferable.

Addresses-Coverity: ("Identical code for different branches")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/orangefs/orangefs-utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 523e7f9fc2e9..d4b7ae763186 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -253,10 +253,6 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 			write_inode_now(inode, 1);
 			goto again;
 		}
-		if (inode->i_state & I_DIRTY_PAGES) {
-			spin_unlock(&inode->i_lock);
-			return 0;
-		}
 		spin_unlock(&inode->i_lock);
 		return 0;
 	}
-- 
2.20.1

