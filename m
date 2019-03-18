Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA5C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87729214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901195;
	bh=+vxkZGNzLLaUQ5JXtfIzifwtHvlEgdZ8aMHPUpT1X4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tET2RBIPiMEyEzoislUvgqStkymW+0XJsHNCzd4u1aL4/EUJMmF9Tu1y/uRE4ND7T
	 mRh+0VyV3KUL9WVkwBs5NY0HQ9bUEXLJEe1Z945JasXYB5AnxovKkGE+bTVRf+e/2Z
	 SYJTVVuD72kltNKQS+rwzTwrL5URp2PJrcGic9GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCRJ0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfCRJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:26:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B82472075C;
        Mon, 18 Mar 2019 09:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901191;
        bh=+vxkZGNzLLaUQ5JXtfIzifwtHvlEgdZ8aMHPUpT1X4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FX8dRGcU7x5peFlC1QtHwaTreLqWhT7QtGvth4LSjjjvBrPvU51F5bWcTPUx5NDv4
         h9vDXN0VyfsguxOf9eciBMngLBPpxWao7i3ogIY+qqH2WqelH7JCNCZiBWlI7/RzGD
         IH5u6VF3VUBA+azr6o57IqYUqezm6Jx2h8ilclzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 14/43] pptp: dst_release sk_dst_cache in pptp_sock_destruct
Date:   Mon, 18 Mar 2019 10:24:06 +0100
Message-Id: <20190318083716.291164255@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 9417d81f4f8adfe20a12dd1fadf73a618cbd945d ]

sk_setup_caps() is called to set sk->sk_dst_cache in pptp_connect,
so we have to dst_release(sk->sk_dst_cache) in pptp_sock_destruct,
otherwise, the dst refcnt will leak.

It can be reproduced by this syz log:

  r1 = socket$pptp(0x18, 0x1, 0x2)
  bind$pptp(r1, &(0x7f0000000100)={0x18, 0x2, {0x0, @local}}, 0x1e)
  connect$pptp(r1, &(0x7f0000000000)={0x18, 0x2, {0x3, @remote}}, 0x1e)

Consecutive dmesg warnings will occur:

  unregister_netdevice: waiting for lo to become free. Usage count = 1

v1->v2:
  - use rcu_dereference_protected() instead of rcu_dereference_check(),
    as suggested by Eric.

Fixes: 00959ade36ac ("PPTP: PPP over IPv4 (Point-to-Point Tunneling Protocol)")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/pptp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -532,6 +532,7 @@ static void pptp_sock_destruct(struct so
 		pppox_unbind_sock(sk);
 	}
 	skb_queue_purge(&sk->sk_receive_queue);
+	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
 }
 
 static int pptp_create(struct net *net, struct socket *sock, int kern)


