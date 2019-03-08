Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E48C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8765F20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050393;
	bh=mcYFfNv44XvfdF/A6GCKikNdO/9MYXOThIaV5NLujH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BdzXzNKQDz8IJdcxj2PSpebJek6pKQaeLoC6qGBKFpOhFX6h9yDQ628bnGC8GG0Ol
	 VmOyAiIlWfl2kHOvCU3ii702MFaSTRPcVhQpNzgtyrApjA5NSZSAO6aYUpNcCFqi/8
	 jZ85oMtCSkbr4kEyyei4U1Veqf9Jj3NmLCLUV1Uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfCHMzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:55:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfCHMzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 424392085A;
        Fri,  8 Mar 2019 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049721;
        bh=mcYFfNv44XvfdF/A6GCKikNdO/9MYXOThIaV5NLujH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/LA+n01BptBa/l6VGdeQl76pcPIL2sc+Ih5iqyTqPHZ97K3fRv1hFL4xHCIkvVeb
         MqWm4yGqY9uYfgmvnXDSIcI1OPfazLvUEJUcHANnILOMLVAGfJQTm20wKF0wqKgfwz
         QQJ6ZAVav/YHqWb0lNr6oHgJ36xojcyLUtae6q+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 44/76] tipc: fix race condition causing hung sendto
Date:   Fri,  8 Mar 2019 13:49:56 +0100
Message-Id: <20190308124916.378083107@linuxfoundation.org>
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

From: Tung Nguyen <tung.q.nguyen@dektech.com.au>

[ Upstream commit bfd07f3dd4f111b884d7922b37eb239280f83d8c ]

When sending multicast messages via blocking socket,
if sending link is congested (tsk->cong_link_cnt is set to 1),
the sending thread will be put into sleeping state. However,
tipc_sk_filter_rcv() is called under socket spin lock but
tipc_wait_for_cond() is not. So, there is no guarantee that
the setting of tsk->cong_link_cnt to 0 in tipc_sk_proto_rcv() in
CPU-1 will be perceived by CPU-0. If that is the case, the sending
thread in CPU-0 after being waken up, will continue to see
tsk->cong_link_cnt as 1 and put the sending thread into sleeping
state again. The sending thread will sleep forever.

CPU-0                                | CPU-1
tipc_wait_for_cond()                 |
{                                    |
 // condition_ = !tsk->cong_link_cnt |
 while ((rc_ = !(condition_))) {     |
  ...                                |
  release_sock(sk_);                 |
  wait_woken();                      |
                                     | if (!sock_owned_by_user(sk))
                                     |  tipc_sk_filter_rcv()
                                     |  {
                                     |   ...
                                     |   tipc_sk_proto_rcv()
                                     |   {
                                     |    ...
                                     |    tsk->cong_link_cnt--;
                                     |    ...
                                     |    sk->sk_write_space(sk);
                                     |    ...
                                     |   }
                                     |   ...
                                     |  }
  sched_annotate_sleep();            |
  lock_sock(sk_);                    |
  remove_wait_queue();               |
 }                                   |
}                                    |

This commit fixes it by adding memory barrier to tipc_sk_proto_rcv()
and tipc_wait_for_cond().

Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -376,11 +376,13 @@ static int tipc_sk_sock_err(struct socke
 
 #define tipc_wait_for_cond(sock_, timeo_, condition_)			       \
 ({                                                                             \
+	DEFINE_WAIT_FUNC(wait_, woken_wake_function);                          \
 	struct sock *sk_;						       \
 	int rc_;							       \
 									       \
 	while ((rc_ = !(condition_))) {					       \
-		DEFINE_WAIT_FUNC(wait_, woken_wake_function);	               \
+		/* coupled with smp_wmb() in tipc_sk_proto_rcv() */            \
+		smp_rmb();                                                     \
 		sk_ = (sock_)->sk;					       \
 		rc_ = tipc_sk_sock_err((sock_), timeo_);		       \
 		if (rc_)						       \
@@ -1968,6 +1970,8 @@ static void tipc_sk_proto_rcv(struct soc
 		return;
 	case SOCK_WAKEUP:
 		tipc_dest_del(&tsk->cong_links, msg_orignode(hdr), 0);
+		/* coupled with smp_rmb() in tipc_wait_for_cond() */
+		smp_wmb();
 		tsk->cong_link_cnt--;
 		wakeup = true;
 		break;


