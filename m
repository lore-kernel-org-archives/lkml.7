Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD69C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5063D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412179;
	bh=1f3+k/HohAtiYgnYjcUzHsz7XPHKWOl+kElL+8y5Hec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rbaa50L3IiVo/zcdkyJBNUyHh3FAZBkzwPCOEaaGWrVOYPdVLMTvqImTPZNt8mruZ
	 VVgRRftIvjRRL9o7VuigFVmLCMcWRMn/tDYkku0pl6PLSc3UzQgpIXd53OH8hMSdUF
	 s/oMMjwOUb60A8lSY1ZhMZVv/+1oDjH7w87w32xU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfCLRQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbfCLRPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:38 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9909321741;
        Tue, 12 Mar 2019 17:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410937;
        bh=1f3+k/HohAtiYgnYjcUzHsz7XPHKWOl+kElL+8y5Hec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRkQX+tVkWzgT1sLAosR5AIK6/Y7IdX1/3uo5VUj0PozxqYZl3Ww+4iq87NE8JA+H
         a6rhCg70k80Ly2Ye0beClOBEFPh/G2XBXTmHUg4TgdMKfS2SYHVmpo8ZP8eFY9DMX1
         o3YALAYJX74BRDzHMR7eTrzrICgN+EncFIPktPsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Hugne <erik.hugne@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 013/135] tipc: fix RDM/DGRAM connect() regression
Date:   Tue, 12 Mar 2019 10:07:40 -0700
Message-Id: <20190312170342.353442271@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -943,7 +943,7 @@ static int __tipc_sendmsg(struct socket
 
 	if (unlikely(!dest)) {
 		dest = &tsk->peer;
-		if (!syn || dest->family != AF_TIPC)
+		if (!syn && dest->family != AF_TIPC)
 			return -EDESTADDRREQ;
 	}
 


