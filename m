Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76485C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C2521BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbfHGMTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:19:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45986 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfHGMTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:19:42 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hvKuf-0004Os-Kr; Wed, 07 Aug 2019 12:19:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][ocfs2-next] ocfs2: ensure ret is set to zero before returning
Date:   Wed,  7 Aug 2019 13:19:29 +0100
Message-Id: <20190807121929.28918-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A previous commit introduced a regression where variable ret was
originally being set from the return from a call to function
dlm_create_debugfs_subroot and this set was removed. Currently
ret is now uninitialized if no alloction errors are found which
may end up with a bogus check on ret < 0 on the 'leave:' return
path.  Fix this by setting ret to zero on a successful execution
path.

Addresses-Coverity: ("Uninitialzed scalar variable")
Fixes: cba322160ef0 ("ocfs2: further debugfs cleanups")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ocfs2/dlm/dlmdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 5c4218d66dd2..ee6f459f9770 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -2052,6 +2052,7 @@ static struct dlm_ctxt *dlm_alloc_ctxt(const char *domain,
 	mlog(0, "context init: refcount %u\n",
 		  kref_read(&dlm->dlm_refs));
 
+	ret = 0;
 leave:
 	if (ret < 0 && dlm) {
 		if (dlm->master_hash)
-- 
2.20.1

