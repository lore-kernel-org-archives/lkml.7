Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A11C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E25220665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599814;
	bh=NxoBKvOcz7H8AfN5GuXdqYMej0H+7W+reYu5jy9Qvuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ekfURhNP1rxyE0WgZsAAHnoXLZcSgQij16E5hNegrfRgzbcuAyUa0SiKZ30284XXv
	 Bmt13PCmg4aoSc3koyGhIU5YTkrbRI/wf4G2/Pgp9g0vNh/qPADF3sda4KQrO33DCe
	 jXjWfvjAm4jQchEbyfmzZIcwHqKxqc68FK5U6bgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389847AbfGHPaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389826AbfGHPaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:30:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA0EF21537;
        Mon,  8 Jul 2019 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599811;
        bh=NxoBKvOcz7H8AfN5GuXdqYMej0H+7W+reYu5jy9Qvuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeCk6c+KWbLgN5utqA+kHsITKhao/zV0trzUGYUzkv7iaZlbof40VGXZ5uYoo8UlW
         LOU0xythJ/66VLY/5WFqfb5N1sQOZ5zge6NJu/XZLZMcL8xmtBuedMZku+MPYNjFpa
         zwRaVJoh7bXPm7nPeceHIVN94EawuaGBKca6zQU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.19 85/90] svcrdma: Ignore source port when computing DRC hash
Date:   Mon,  8 Jul 2019 17:13:52 +0200
Message-Id: <20190708150526.748418758@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

commit 1e091c3bbf51d34d5d96337a59ce5ab2ac3ba2cc upstream.

The DRC appears to be effectively empty after an RPC/RDMA transport
reconnect. The problem is that each connection uses a different
source port, which defeats the DRC hash.

Clients always have to disconnect before they send retransmissions
to reset the connection's credit accounting, thus every retransmit
on NFS/RDMA will miss the DRC.

An NFS/RDMA client's IP source port is meaningless for RDMA
transports. The transport layer typically sets the source port value
on the connection to a random ephemeral port. The server already
ignores it for the "secure port" check. See commit 16e4d93f6de7
("NFSD: Ignore client's source port on RDMA transports").

The Linux NFS server's DRC resolves XID collisions from the same
source IP address by using the checksum of the first 200 bytes of
the RPC call header.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -270,9 +270,14 @@ static void handle_connect_req(struct rd
 	/* Save client advertised inbound read limit for use later in accept. */
 	newxprt->sc_ord = param->initiator_depth;
 
-	/* Set the local and remote addresses in the transport */
 	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
 	svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
+	/* The remote port is arbitrary and not under the control of the
+	 * client ULP. Set it to a fixed value so that the DRC continues
+	 * to be effective after a reconnect.
+	 */
+	rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
+
 	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
 	svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
 


