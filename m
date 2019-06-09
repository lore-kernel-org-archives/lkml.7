Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B7BC468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63B72067C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100424;
	bh=4U4izcSaOKzl/o61twDWLKRT4NOa+abMyqiXhluokoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QTvFnBtpJaMSVgc14WbRd8zlb8yQFYA9uXj2rbzC5FPiKSnbegDU9D06eO6IWx5gn
	 omafiCTkehJo9580viuIAtA2TRE7PuWuua9pza+zvO5LyHHjSkJAMTwKQmFrLJLT80
	 qE96iN97sAJ+3dkDQFxxLs/q0d+rUKKzcj5z3bBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbfFIQ5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732638AbfFIQ5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:57:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDE472084A;
        Sun,  9 Jun 2019 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099467;
        bh=4U4izcSaOKzl/o61twDWLKRT4NOa+abMyqiXhluokoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkdbZlwxPLlQKIcXQzL7r1J4RAlBw0rPUOPTqkkWeMMZxdtaU2BothWlLbS7BNy8V
         i6IrwCWwC4Nl3dlAjiMFCgXnnUHqzhiSpVhlidr4Tbue9uCoQPGO7MRfiP89Y7Zawe
         Uc5mUCp0el885jbTiU4ujzSZPEPyUL7FsnU7dhOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.4 043/241] NFS4: Fix v4.0 client state corruption when mount
Date:   Sun,  9 Jun 2019 18:39:45 +0200
Message-Id: <20190609164149.018303773@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangXiaoxu <zhangxiaoxu5@huawei.com>

commit f02f3755dbd14fb935d24b14650fff9ba92243b8 upstream.

stat command with soft mount never return after server is stopped.

When alloc a new client, the state of the client will be set to
NFS4CLNT_LEASE_EXPIRED.

When the server is stopped, the state manager will work, and accord
the state to recover. But the state is NFS4CLNT_LEASE_EXPIRED, it
will drain the slot table and lead other task to wait queue, until
the client recovered. Then the stat command is hung.

When discover server trunking, the client will renew the lease,
but check the client state, it lead the client state corruption.

So, we need to call state manager to recover it when detect server
ip trunking.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4state.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -140,6 +140,10 @@ int nfs40_discover_server_trunking(struc
 		/* Sustain the lease, even if it's empty.  If the clientid4
 		 * goes stale it's of no use for trunking discovery. */
 		nfs4_schedule_state_renewal(*result);
+
+		/* If the client state need to recover, do it. */
+		if (clp->cl_state)
+			nfs4_schedule_state_manager(clp);
 	}
 out:
 	return status;


