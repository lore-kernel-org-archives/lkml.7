Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA472085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049907;
	bh=GG0E1X/DNvEBBeEcM4q1cM9S6b90b9qDzCRdOqDQEQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HTzaT6j38kSfDASTsJqPyvuZGdqsP6+Sa1txozJDraEmarZUPFlsmS0JZFDb1BZB6
	 axy88TvovH/boUpNVt0nRbYgFu8iJXC6MN7uRj2DoWPpoz8fv7T2lX7ahdwU9tClC5
	 GiAQIrDhd/RldO66SQMDwEZMIe1pz054eeQPLrws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfCHM6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbfCHM6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:58:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EDF22085A;
        Fri,  8 Mar 2019 12:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049903;
        bh=GG0E1X/DNvEBBeEcM4q1cM9S6b90b9qDzCRdOqDQEQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeUcgL6Odhe1Gf3+JVG5KZfRscYS+JKesjMLXFcDaqaB2wwZgk4TTXRN8Ky/131+e
         WK0LmlPN+4LHTKvnI81J/6kQZwVcc8NJ0ZQQPJ/SnpRFjm0xNZanxkJje1GJ3fNahs
         AIGYOfIIyJ7XAuipFjKe4gCOMY4izjgUFF4x/b1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Hugne <erik.hugne@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 22/68] tipc: fix RDM/DGRAM connect() regression
Date:   Fri,  8 Mar 2019 13:49:52 +0100
Message-Id: <20190308124911.920642072@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1318,7 +1318,7 @@ static int __tipc_sendmsg(struct socket
 
 	if (unlikely(!dest)) {
 		dest = &tsk->peer;
-		if (!syn || dest->family != AF_TIPC)
+		if (!syn && dest->family != AF_TIPC)
 			return -EDESTADDRREQ;
 	}
 


