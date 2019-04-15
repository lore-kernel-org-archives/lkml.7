Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A291DC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629C82075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355741;
	bh=Ww13bO5ivsa+ZDedk5xNZhZ5tahw1gwH5n+v+1FeuDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AKANi+b/jPvonToF9TsRom5r4eTnuguMNX1Lh5esy3w5awpJpCC5n5zZNna3Jw+wT
	 D6jy6HBKAnnUZm+kBNUeAOgIxwgKuo4EXGtfSkPiF1+UVfvmTGC3WylyevECsC72XN
	 MaU56DBiyGKzDmBUbgi95ub6yEvA/qYoFMuxIZ5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfDOTN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbfDOTNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 789A3218A1;
        Mon, 15 Apr 2019 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355630;
        bh=Ww13bO5ivsa+ZDedk5xNZhZ5tahw1gwH5n+v+1FeuDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNDE7eUcPCieeK9nGk3qBX+pcFt2NmThP6xp7VlRMEEDFUH/g/tjARUookE5lZg5o
         PH8QK6tcrCZIq3ZfCitbaA4UHQriWpgwP+DImVRUv7lx0qNaiJyHFHIaH7ic0CWFWt
         VmVIogTFenT0SwAhfsytjcuuDjADHJGORdwuWBCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.0 108/117] xprtrdma: Fix helper that drains the transport
Date:   Mon, 15 Apr 2019 21:01:18 +0200
Message-Id: <20190415183750.244509400@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

commit e1ede312f17e96a9c5cda9aaa1cdcf442c1a5da8 upstream.

We want to drain only the RQ first. Otherwise the transport can
deadlock on ->close if there are outstanding Send completions.

Fixes: 6d2d0ee27c7a ("xprtrdma: Replace rpcrdma_receive_wq ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -90,7 +90,7 @@ static void rpcrdma_xprt_drain(struct rp
 	/* Flush Receives, then wait for deferred Reply work
 	 * to complete.
 	 */
-	ib_drain_qp(ia->ri_id->qp);
+	ib_drain_rq(ia->ri_id->qp);
 	drain_workqueue(buf->rb_completion_wq);
 
 	/* Deferred Reply processing might have scheduled


