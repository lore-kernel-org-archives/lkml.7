Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B42421906
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356002;
	bh=NY2/WXeLgbU38UgFHYEQiKpq5bkNsLud5EMI5YodW7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=maAAfDdDL5x816oL82PSM7p56AQ/qUrZpE1UJBv1xeo+f6jFSEZjakFiPK46/sxQH
	 LBWjMDw11ijscwRL4nmxigSyoEX/XaTal9wZ4BFW2FIbDuPSkarZV8EU/sE8UwEb88
	 KCBFLBJM58zzeTIwCzTnx3nNxA3HcNfPmWgsHFfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfDOTKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbfDOTKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE55218A1;
        Mon, 15 Apr 2019 19:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355403;
        bh=NY2/WXeLgbU38UgFHYEQiKpq5bkNsLud5EMI5YodW7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WqyUSiOWmiM68inKjfFKOwzfgH/Y8cPmGe/2lq4ZSwhmN3mD6QH4XKaMgV3U0uAGa
         LmOGUQ3p3xObmPdH0E6AbRvkqyUES6BrBT9wIf4Se+bLbP0lE+7zCRzW2CNYz9LEeS
         svesbfGcLWfnvjo8pdSfa7BfLSyu/zCDnGVjJhtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+86b5c7c236a22616a72f@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 022/117] sctp: initialize _pad of sockaddr_in before copying to user memory
Date:   Mon, 15 Apr 2019 20:59:52 +0200
Message-Id: <20190415183746.031345650@linuxfoundation.org>
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

[ Upstream commit 09279e615c81ce55e04835970601ae286e3facbe ]

Syzbot report a kernel-infoleak:

  BUG: KMSAN: kernel-infoleak in _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
  Call Trace:
    _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
    copy_to_user include/linux/uaccess.h:174 [inline]
    sctp_getsockopt_peer_addrs net/sctp/socket.c:5911 [inline]
    sctp_getsockopt+0x1668e/0x17f70 net/sctp/socket.c:7562
    ...
  Uninit was stored to memory at:
    sctp_transport_init net/sctp/transport.c:61 [inline]
    sctp_transport_new+0x16d/0x9a0 net/sctp/transport.c:115
    sctp_assoc_add_peer+0x532/0x1f70 net/sctp/associola.c:637
    sctp_process_param net/sctp/sm_make_chunk.c:2548 [inline]
    sctp_process_init+0x1a1b/0x3ed0 net/sctp/sm_make_chunk.c:2361
    ...
  Bytes 8-15 of 16 are uninitialized

It was caused by that th _pad field (the 8-15 bytes) of a v4 addr (saved in
struct sockaddr_in) wasn't initialized, but directly copied to user memory
in sctp_getsockopt_peer_addrs().

So fix it by calling memset(addr->v4.sin_zero, 0, 8) to initialize _pad of
sockaddr_in before copying it to user memory in sctp_v4_addr_to_user(), as
sctp_v6_addr_to_user() does.

Reported-by: syzbot+86b5c7c236a22616a72f@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Tested-by: Alexander Potapenko <glider@google.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 6abc8b274270..951afdeea5e9 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -600,6 +600,7 @@ static struct sock *sctp_v4_create_accept_sk(struct sock *sk,
 static int sctp_v4_addr_to_user(struct sctp_sock *sp, union sctp_addr *addr)
 {
 	/* No address mapping for V4 sockets */
+	memset(addr->v4.sin_zero, 0, sizeof(addr->v4.sin_zero));
 	return sizeof(struct sockaddr_in);
 }
 
-- 
2.19.1



