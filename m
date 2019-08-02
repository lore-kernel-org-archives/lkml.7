Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C441C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EC42064A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739686;
	bh=IT/nPQmLVMr0/q8u+khDrqWAleTbLW533zhfaYi2BZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QZRwD3eeJ5UwNorSXr49+2hea+eD2uVvoK6juE5ZGs9GXXOa1q2mpPcW+ZDKHzhuK
	 p5KIJtxTBFfw2K2OGHL0FZfN5/HaNp/MQmLhAmRQjjFGL6hcMb5bEBue1QOjK3kbZR
	 vvS5OCrBGeJwe9TjGxOql5H8HG7P49fB1xhGq+3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406433AbfHBJyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406234AbfHBJyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:54:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD9320665;
        Fri,  2 Aug 2019 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739680;
        bh=IT/nPQmLVMr0/q8u+khDrqWAleTbLW533zhfaYi2BZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GT+zm7cScVp1K9FsUWXMqweAcszy3/+jLG7l/3/SfMDMgU000HlBPvTHADcCgTlgl
         6lIAlJ8WxeZDOZaUFLD6vZs1roUekOaLGTL1ArrcHSkyylJ9d/5BBvgisCw3N/FIvZ
         Cuw/rms5RJ5PnKGRAOxKUBFqeaSV4t0zSoKcx8k0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stan Hu <stanhu@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Qian Lu <luqia@amazon.com>
Subject: [PATCH 4.14 03/25] NFS: Fix dentry revalidation on NFSv4 lookup
Date:   Fri,  2 Aug 2019 11:39:35 +0200
Message-Id: <20190802092100.091227808@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092058.428079740@linuxfoundation.org>
References: <20190802092058.428079740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit be189f7e7f03de35887e5a85ddcf39b91b5d7fc1 upstream.

We need to ensure that inode and dentry revalidation occurs correctly
on reopen of a file that is already open. Currently, we can end up
not revalidating either in the case of NFSv4.0, due to the 'cached open'
path.
Let's fix that by ensuring that we only do cached open for the special
cases of open recovery and delegation return.

Reported-by: Stan Hu <stanhu@gmail.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Qian Lu <luqia@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4proc.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1317,12 +1317,20 @@ static bool nfs4_mode_match_open_stateid
 	return false;
 }
 
-static int can_open_cached(struct nfs4_state *state, fmode_t mode, int open_mode)
+static int can_open_cached(struct nfs4_state *state, fmode_t mode,
+		int open_mode, enum open_claim_type4 claim)
 {
 	int ret = 0;
 
 	if (open_mode & (O_EXCL|O_TRUNC))
 		goto out;
+	switch (claim) {
+	case NFS4_OPEN_CLAIM_NULL:
+	case NFS4_OPEN_CLAIM_FH:
+		goto out;
+	default:
+		break;
+	}
 	switch (mode & (FMODE_READ|FMODE_WRITE)) {
 		case FMODE_READ:
 			ret |= test_bit(NFS_O_RDONLY_STATE, &state->flags) != 0
@@ -1617,7 +1625,7 @@ static struct nfs4_state *nfs4_try_open_
 
 	for (;;) {
 		spin_lock(&state->owner->so_lock);
-		if (can_open_cached(state, fmode, open_mode)) {
+		if (can_open_cached(state, fmode, open_mode, claim)) {
 			update_open_stateflags(state, fmode);
 			spin_unlock(&state->owner->so_lock);
 			goto out_return_state;
@@ -2141,7 +2149,8 @@ static void nfs4_open_prepare(struct rpc
 	if (data->state != NULL) {
 		struct nfs_delegation *delegation;
 
-		if (can_open_cached(data->state, data->o_arg.fmode, data->o_arg.open_flags))
+		if (can_open_cached(data->state, data->o_arg.fmode,
+					data->o_arg.open_flags, claim))
 			goto out_no_action;
 		rcu_read_lock();
 		delegation = rcu_dereference(NFS_I(data->state->inode)->delegation);


