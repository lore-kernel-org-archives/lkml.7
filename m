Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B96C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9511D2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFEVJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:09:41 -0400
Received: from gateway20.websitewelcome.com ([192.185.59.4]:17298 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbfFEVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:09:40 -0400
X-Greylist: delayed 1210 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 17:09:40 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id B16BC400CCA3D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2019 14:48:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ycqfh3i8y90onYcqfh5OHF; Wed, 05 Jun 2019 15:49:29 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.120] (port=34964 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hYcqe-0046eo-D3; Wed, 05 Jun 2019 15:49:28 -0500
Date:   Wed, 5 Jun 2019 15:49:26 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ocfs2/dlm: use struct_size() helper
Message-ID: <20190605204926.GA24467@embeddedor>
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
X-Source-IP: 189.250.127.120
X-Source-L: No
X-Exim-ID: 1hYcqe-0046eo-D3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.120]:34964
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct dlm_migratable_lockres 
{
i	...
        struct dlm_migratable_lock ml[0];  // 16 bytes each, begins at byte 112
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(struct dlm_migratable_lockres) + (mres->num_locks * sizeof(struct dlm_migratable_lock))

with:

struct_size(mres, ml, mres->num_locks)

Notice that, in this case, variable sz is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/ocfs2/dlm/dlmrecovery.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index e22d6a115220..064ce5bbc3f6 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -1109,7 +1109,7 @@ static int dlm_send_mig_lockres_msg(struct dlm_ctxt *dlm,
 {
 	u64 mig_cookie = be64_to_cpu(mres->mig_cookie);
 	int mres_total_locks = be32_to_cpu(mres->total_locks);
-	int sz, ret = 0, status = 0;
+	int ret = 0, status = 0;
 	u8 orig_flags = mres->flags,
 	   orig_master = mres->master;
 
@@ -1117,9 +1117,6 @@ static int dlm_send_mig_lockres_msg(struct dlm_ctxt *dlm,
 	if (!mres->num_locks)
 		return 0;
 
-	sz = sizeof(struct dlm_migratable_lockres) +
-		(mres->num_locks * sizeof(struct dlm_migratable_lock));
-
 	/* add an all-done flag if we reached the last lock */
 	orig_flags = mres->flags;
 	BUG_ON(total_locks > mres_total_locks);
@@ -1133,7 +1130,8 @@ static int dlm_send_mig_lockres_msg(struct dlm_ctxt *dlm,
 
 	/* send it */
 	ret = o2net_send_message(DLM_MIG_LOCKRES_MSG, dlm->key, mres,
-				 sz, send_to, &status);
+				 struct_size(mres, ml, mres->num_locks),
+				 send_to, &status);
 	if (ret < 0) {
 		/* XXX: negative status is not handled.
 		 * this will end up killing this node. */
-- 
2.21.0

