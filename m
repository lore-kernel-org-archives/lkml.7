Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E54C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172B02087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901212;
	bh=J16TXg8Bj0+0EpZ2O/ctswJBPOwntF8WzyHcNaG1GfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cpMKrl/FejPfBKxehoYNlfOuuv6gORcKPkIwU2DeHMuWGULpHPVm361CkAvafsyHg
	 T1i0QZ6Ja7q3X6iL7nCbUd6mryewR9TuwfJCrY1H/oE2nrOw9nNzwH/lqJx3rdwLMN
	 ++p1osev5YFgD4vTRktnJsbC2Jj0CXO/BLInbCPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfCRJ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbfCRJ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:26:47 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC59821773;
        Mon, 18 Mar 2019 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901207;
        bh=J16TXg8Bj0+0EpZ2O/ctswJBPOwntF8WzyHcNaG1GfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HrswCXeHh1A9LwCZSMWKVD/WxC4r5K32x0TafwZLy+PKIJLGEyJp76eSQQJCWtODp
         pyB+ZLeK6F00Hq3MaymiE7LcBRKhGQzSqcf+IiupB0Z5C0COpovLWNwtkd2hw5OhgJ
         JY5Lu5kPx4U69qr3FkMb2Cp/Jr3UubS+H5SfzGcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 19/43] tcp: do not report TCP_CM_INQ of 0 for closed connections
Date:   Mon, 18 Mar 2019 10:24:11 +0100
Message-Id: <20190318083716.428723811@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
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

From: Soheil Hassas Yeganeh <soheil@google.com>

[ Upstream commit 6466e715651f9f358e60c5ea4880e4731325827f ]

Returning 0 as inq to userspace indicates there is no more data to
read, and the application needs to wait for EPOLLIN. For a connection
that has received FIN from the remote peer, however, the application
must continue reading until getting EOF (return value of 0
from tcp_recvmsg) or an error, if edge-triggered epoll (EPOLLET) is
being used. Otherwise, the application will never receive a new
EPOLLIN, since there is no epoll edge after the FIN.

Return 1 when there is no data left on the queue but the
connection has received FIN, so that the applications continue
reading.

Fixes: b75eba76d3d72 (tcp: send in-queue bytes in cmsg upon read)
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1914,6 +1914,11 @@ static int tcp_inq_hint(struct sock *sk)
 		inq = tp->rcv_nxt - tp->copied_seq;
 		release_sock(sk);
 	}
+	/* After receiving a FIN, tell the user-space to continue reading
+	 * by returning a non-zero inq.
+	 */
+	if (inq == 0 && sock_flag(sk, SOCK_DONE))
+		inq = 1;
 	return inq;
 }
 


