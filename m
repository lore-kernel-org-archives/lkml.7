Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF060C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4D721726
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfE0RWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:22:01 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.218]:29780 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726517AbfE0RWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:22:01 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 1D985BA621
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 12:22:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id VJJwh1UdCiQerVJJwhcK7W; Mon, 27 May 2019 12:22:00 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=35202 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hVJJu-002THu-Vi; Mon, 27 May 2019 12:21:59 -0500
Date:   Mon, 27 May 2019 12:21:58 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] orangefs: fix unused value in __orangefs_setattr
Message-ID: <20190527172158.GA28107@embeddedor>
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
X-Exim-ID: 1hVJJu-002THu-Vi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:35202
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for the return value of posix_acl_chmod() and
fix unused value bug.

Notice that if this check is not in place, the value in
ret is overwritten at line 913, before it can be used:

913	ret = 0;

Addresses-Coverity-ID: 1445565 ("Unused value")
Fixes: df2d7337b570 ("orangefs: let setattr write to cached inode")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/orangefs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 0c337d8bdaab..3608f183d075 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -906,9 +906,12 @@ int __orangefs_setattr(struct inode *inode, struct iattr *iattr)
 	spin_unlock(&inode->i_lock);
 	mark_inode_dirty(inode);
 
-	if (iattr->ia_valid & ATTR_MODE)
+	if (iattr->ia_valid & ATTR_MODE) {
 		/* change mod on a file that has ACLs */
 		ret = posix_acl_chmod(inode, inode->i_mode);
+		if (ret)
+			goto out;
+	}
 
 	ret = 0;
 out:
-- 
2.21.0

