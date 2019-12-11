Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2586C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AC22077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079894;
	bh=73y6llFQMMIZCQOShezk0KW2VUlhcWIdRCpboFMbUQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xcsu3KbLv7CBJ13JnoXDYsbKrQwFArX0GvIB3H5AF3vua1PGJLBhcozAZ6mlS4AHF
	 ghWI11JCqoL/gB4him2i6MVaJ557HuAP439HTzmid7OPoq17E9o2blnNqDEjoLxGxe
	 EXZcWkvY36bNIFsKOkvvyFV9+Lzmq4sf07eBP2Zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbfLKP6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbfLKPOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB3D24658;
        Wed, 11 Dec 2019 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077281;
        bh=73y6llFQMMIZCQOShezk0KW2VUlhcWIdRCpboFMbUQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4REs6tj9TLnSwAH1IkyFAzkQgEv4AnZ7mB9x3mYxgM3tjm/i852ReLVG6Hv+jWvX
         eKcbFOp/xw264X0g+QwWZG7ap5PrObrvwv90irYqINYyQGaeEtMuzMZMI0VD9I+z44
         JL1KcChbXwVmCGTT80l04pVwYvdiqa/gzbajxzVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.3 048/105] SUNRPC: Avoid RPC delays when exiting suspend
Date:   Wed, 11 Dec 2019 16:05:37 +0100
Message-Id: <20191211150241.052599321@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 66eb3add452aa1be65ad536da99fac4b8f620b74 upstream.

Jon Hunter: "I have been tracking down another suspend/NFS related
issue where again I am seeing random delays exiting suspend. The delays
can be up to a couple minutes in the worst case and this is causing a
suspend test we have to fail."

Change the use of a deferrable work to a standard delayed one.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 7e0a0e38fcfea ("SUNRPC: Replace the queue timer with a delayed work function")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -260,7 +260,7 @@ static void __rpc_init_priority_wait_que
 	rpc_reset_waitqueue_priority(queue);
 	queue->qlen = 0;
 	queue->timer_list.expires = 0;
-	INIT_DEFERRABLE_WORK(&queue->timer_list.dwork, __rpc_queue_timer_fn);
+	INIT_DELAYED_WORK(&queue->timer_list.dwork, __rpc_queue_timer_fn);
 	INIT_LIST_HEAD(&queue->timer_list.list);
 	rpc_assign_waitqueue_name(queue, qname);
 }


