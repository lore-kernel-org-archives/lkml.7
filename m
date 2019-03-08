Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1499C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823562087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049682;
	bh=48r9z4PHZzoT2regatNpRvlYfgwAts7DfiquMOeI0AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pZTY0kHtdskzLZNbe69Kr2FJYDNnzIaOyLZcvY2binSi3kZuqctN0A4VwtkSBddNu
	 6gbpTejjNqp7imDv8YV1kewSmrBuGBJX6+mxy2d0Chb8Pk1pURkO3iJytQQF0SYVNC
	 uUMKFF8HcxGNHuBuwScmDBWn31uHAjbS6L3y8nPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfCHMyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfCHMyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:54:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526DE2085A;
        Fri,  8 Mar 2019 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049677;
        bh=48r9z4PHZzoT2regatNpRvlYfgwAts7DfiquMOeI0AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKZpg7fA3nKADmekSJp6AGvI/s8mzuVxFg+cN3OD4KeFcMFPUI57Chqp7cpp/stfq
         RGeKDaixmWf+5aRTw9FQHk4RerFn8z4sa7BFmZRIYxB7ay27qQsKkpRPEPsg7CB3bv
         5Dp+j7JhUubo1Ji5BQZ6ttgKaerVPGaAk0/gGFU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Hugne <erik.hugne@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 29/76] tipc: fix RDM/DGRAM connect() regression
Date:   Fri,  8 Mar 2019 13:49:41 +0100
Message-Id: <20190308124915.843903514@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Hugne <erik.hugne@gmail.com>

[ Upstream commit 0e63208915a8d7590d0a6218dadb2a6a00ac705a ]

Fix regression bug introduced in
commit 365ad353c256 ("tipc: reduce risk of user starvation during link
congestion")

Only signal -EDESTADDRREQ for RDM/DGRAM if we don't have a cached
sockaddr.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Signed-off-by: Erik Hugne <erik.hugne@gmail.com>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1320,7 +1320,7 @@ static int __tipc_sendmsg(struct socket
 
 	if (unlikely(!dest)) {
 		dest = &tsk->peer;
-		if (!syn || dest->family != AF_TIPC)
+		if (!syn && dest->family != AF_TIPC)
 			return -EDESTADDRREQ;
 	}
 


