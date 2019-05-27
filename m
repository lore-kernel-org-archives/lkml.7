Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF45FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5820208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfE0QyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:54:16 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.107]:41161 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfE0QyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:54:16 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 7A564137DA
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:54:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id VIt5h7IzR2PzOVIt5hU6vL; Mon, 27 May 2019 11:54:15 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=34508 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hVIt4-002E4y-E6; Mon, 27 May 2019 11:54:14 -0500
Date:   Mon, 27 May 2019 11:54:13 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] afs: Fix logically dead code in afs_update_cell
Message-ID: <20190527165413.GA26714@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hVIt4-002E4y-E6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:34508
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix logically dead code in switch statement.

Notice that *ret* is updated with -ENOMEM before the switch statement
at 395:

395                 switch (ret) {
396                 case -ENODATA:
397                 case -EDESTADDRREQ:
398                         vllist->status = DNS_LOOKUP_GOT_NOT_FOUND;
399                         break;
400                 case -EAGAIN:
401                 case -ECONNREFUSED:
402                         vllist->status = DNS_LOOKUP_GOT_TEMP_FAILURE;
403                         break;
404                 default:
405                         vllist->status = DNS_LOOKUP_GOT_LOCAL_FAILURE;
406                         break;
407                 }

hence, the code in the switch (except for the default case) makes
no sense and is logically dead.

Fix this by removing the *ret* assignment at 390:

390	ret = -ENOMEM;

which is apparently wrong.

Addresses-Coverity-ID: 1445439 ("Logically dead code")
Fixes: d5c32c89b208 ("afs: Fix cell DNS lookup")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/afs/cell.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 9c3b07ba2222..980de60bf060 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -387,7 +387,6 @@ static int afs_update_cell(struct afs_cell *cell)
 		if (ret == -ENOMEM)
 			goto out_wake;
 
-		ret = -ENOMEM;
 		vllist = afs_alloc_vlserver_list(0);
 		if (!vllist)
 			goto out_wake;
-- 
2.21.0

