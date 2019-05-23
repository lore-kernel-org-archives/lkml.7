Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55428C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F9B217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638990;
	bh=MW32hsEj+bBsxFl2lvUcnJoAOxMKjk7PbtOnPJNOI0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OpU0FWGoS1+viX8xRWy1ntqOOfCt7cJKTE/BPkYH1cCGhdBw7tzvtqWlw7IS/KpN2
	 Xfaw6W047l7lt7LXcG04mpazBQCSBhJeKS+fjjWXmilF6SP9szVsDt9LpiiVKhvWOq
	 3IwhYPKoEbAPTLX5MtiA/rD7FjY1IbHkiwcOd2o8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbfEWTQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389191AbfEWTQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:16:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC292133D;
        Thu, 23 May 2019 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638986;
        bh=MW32hsEj+bBsxFl2lvUcnJoAOxMKjk7PbtOnPJNOI0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vMFNak5ZMzenS5Zt7t1mHI+r6zh5sHosz9s3Md1XoRNzKRWNW3qNN9HuX5aJmnFaA
         UKW95wzJa6Yyv1ftQDxyw0yulvDXCwvBVcIhc4GgakvWys8ZJraV5eiU2ZJK9HYBGB
         rBc8/uOoFvBrt0whQ7QSfqi4ZxFxB1GONkKbf6yU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.19 037/114] NFS4: Fix v4.0 client state corruption when mount
Date:   Thu, 23 May 2019 21:05:36 +0200
Message-Id: <20190523181735.144281654@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
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
@@ -159,6 +159,10 @@ int nfs40_discover_server_trunking(struc
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


