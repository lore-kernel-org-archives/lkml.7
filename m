Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F64AC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF64021743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfGPIoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:44:25 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:3237 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfGPIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:44:24 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5d2d8e4d7b6-6e9dd; Tue, 16 Jul 2019 16:43:58 +0800 (CST)
X-RM-TRANSID: 2eeb5d2d8e4d7b6-6e9dd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65d2d8e4cfc6-46186;
        Tue, 16 Jul 2019 16:43:58 +0800 (CST)
X-RM-TRANSID: 2ee65d2d8e4cfc6-46186
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: fix 'passing zero to PTR_ERR()' warning
Date:   Tue, 16 Jul 2019 16:43:50 +0800
Message-Id: <1563266630-6471-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a static code checker warning:
fs/nfs/nfs4idmap.c:331
	nfs_idmap_get_key() warn: passing zero to 'PTR_ERR'

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 fs/nfs/nfs4idmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 1e72963..f71bb7f 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -328,7 +328,7 @@ static ssize_t nfs_idmap_get_key(const char *name, size_t namelen,
 
 	payload = user_key_payload_rcu(rkey);
 	if (IS_ERR_OR_NULL(payload)) {
-		ret = PTR_ERR(payload);
+		ret = PTR_ERR_OR_ZERO(payload);
 		goto out_up;
 	}
 
-- 
1.9.1



