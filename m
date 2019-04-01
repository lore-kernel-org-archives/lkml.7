Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB88D21934
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138290;
	bh=V/HXieac/3YRNzKTkhqjnZ+MuLAXrS7iBeyyZGJ1SNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wBhf9Yvbt23Od9AhrXAt0Sv1NVPunLUNzYgsf6qixY3GU0qmCQXdyFtGAldMqgP14
	 Adu/jWadMn/YZGQfe5UT6w/OA+yB8vmMUZX96x9oGZM5V05L1WAO8svNMh4M1XQ11S
	 fxoFkpI9Obzx07JJVNNcpaPME4rHNiB3TtAHokK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfDAREt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbfDAREs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:04:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA26F21925;
        Mon,  1 Apr 2019 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138288;
        bh=V/HXieac/3YRNzKTkhqjnZ+MuLAXrS7iBeyyZGJ1SNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhUVK6sYKYy7T6VKNz2DZw3pb9NCp12uCeCD9oQqbBX3NC9zTHzt+lvpG9lN8fWMS
         PAtrxf7WVSjNE90XhtHMYbKlf7d+6zhgwtpW91XfjYoQD8WGheCb87sncTfakB6wgQ
         r72h0y9jcJop/0ekFSwbhdh1h9E7s1mSK2qfRDBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Hugne <erik.hugne@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 023/146] tipc: allow service ranges to be connect()ed on RDM/DGRAM
Date:   Mon,  1 Apr 2019 19:00:35 +0200
Message-Id: <20190401170050.527573315@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Hugne <erik.hugne@gmail.com>

[ Upstream commit ea239314fe42ace880bdd834256834679346c80e ]

We move the check that prevents connecting service ranges to after
the RDM/DGRAM check, and move address sanity control to a separate
function that also validates the service range.

Fixes: 23998835be98 ("tipc: improve address sanity check in tipc_connect()")
Signed-off-by: Erik Hugne <erik.hugne@gmail.com>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2349,6 +2349,16 @@ static int tipc_wait_for_connect(struct
 	return 0;
 }
 
+static bool tipc_sockaddr_is_sane(struct sockaddr_tipc *addr)
+{
+	if (addr->family != AF_TIPC)
+		return false;
+	if (addr->addrtype == TIPC_SERVICE_RANGE)
+		return (addr->addr.nameseq.lower <= addr->addr.nameseq.upper);
+	return (addr->addrtype == TIPC_SERVICE_ADDR ||
+		addr->addrtype == TIPC_SOCKET_ADDR);
+}
+
 /**
  * tipc_connect - establish a connection to another TIPC port
  * @sock: socket structure
@@ -2384,18 +2394,18 @@ static int tipc_connect(struct socket *s
 		if (!tipc_sk_type_connectionless(sk))
 			res = -EINVAL;
 		goto exit;
-	} else if (dst->family != AF_TIPC) {
-		res = -EINVAL;
 	}
-	if (dst->addrtype != TIPC_ADDR_ID && dst->addrtype != TIPC_ADDR_NAME)
+	if (!tipc_sockaddr_is_sane(dst)) {
 		res = -EINVAL;
-	if (res)
 		goto exit;
-
+	}
 	/* DGRAM/RDM connect(), just save the destaddr */
 	if (tipc_sk_type_connectionless(sk)) {
 		memcpy(&tsk->peer, dest, destlen);
 		goto exit;
+	} else if (dst->addrtype == TIPC_SERVICE_RANGE) {
+		res = -EINVAL;
+		goto exit;
 	}
 
 	previous = sk->sk_state;


