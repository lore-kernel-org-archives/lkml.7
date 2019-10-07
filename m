Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E4C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8602E206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfJGTrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:47:41 -0400
Received: from www17.your-server.de ([213.133.104.17]:42296 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:47:40 -0400
X-Greylist: delayed 1120 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Oct 2019 15:47:39 EDT
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1iHYgk-0000RR-24; Mon, 07 Oct 2019 21:28:58 +0200
Received: from [2a02:908:4c22:ec00:8ad5:993:4cda:a89f] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1iHYgj-000I8G-RV; Mon, 07 Oct 2019 21:28:57 +0200
From:   Thomas Meyer <thomas@m3y3r.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] kernel/groups.c: use bsearch library function
Date:   Mon,  7 Oct 2019 21:26:32 +0200
Message-Id: <20191007192632.29535-1-thomas@m3y3r.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25595/Mon Oct  7 10:28:44 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b7b2562f7252 ("kernel/groups.c: use sort library function")
introduced the sort library function.
also use the bsearch library function instead of open-coding the binary
search.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 kernel/groups.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/groups.c b/kernel/groups.c
index daae2f2dc6d4f..69561a9cb4d39 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -2,6 +2,7 @@
 /*
  * Supplementary group IDs
  */
+#include <linux/bsearch.h>
 #include <linux/cred.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -96,22 +97,12 @@ EXPORT_SYMBOL(groups_sort);
 /* a simple bsearch */
 int groups_search(const struct group_info *group_info, kgid_t grp)
 {
-	unsigned int left, right;
-
 	if (!group_info)
 		return 0;
 
-	left = 0;
-	right = group_info->ngroups;
-	while (left < right) {
-		unsigned int mid = (left+right)/2;
-		if (gid_gt(grp, group_info->gid[mid]))
-			left = mid + 1;
-		else if (gid_lt(grp, group_info->gid[mid]))
-			right = mid;
-		else
-			return 1;
-	}
+	if (bsearch(&grp, group_info->gid, group_info->ngroups,
+		    sizeof(*group_info->gid), gid_cmp))
+		return 1;
 	return 0;
 }
 
-- 
2.21.0

