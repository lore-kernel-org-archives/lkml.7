Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC710C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEBA20449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050085;
	bh=Cfe2JxJjz4nphg2+LzU/jaWhWLCri+zNrqPUim8TL0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=om4u6mPFoKLT6yAYeiO/PI1uwam2bZcctBhlPZALXHHzm1Iv+IMgUnpn9Ty5qStEL
	 WT4DzHvv6AS8IiEJ5jdnMeLuAV6+E4G2mG5bYVwXZUenz6I8HXEVKPxZMlpOdjAfyu
	 45GgSm24V7rFJLE/uDHyDT2peYIBGzQTcw9xxE2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfCHNBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfCHNBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:01:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C83220811;
        Fri,  8 Mar 2019 13:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050078;
        bh=Cfe2JxJjz4nphg2+LzU/jaWhWLCri+zNrqPUim8TL0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNOq0WNDQCQtEXjTsIaW0pOgrFgJC1OmqoZBi1zERMkLL9TOhzBUtLG2pomWAH8c6
         E1xcKDHKJz/19vW740WLE/owVjtp642GBkutzx/46UT9+s/heLRKrsMxPEczO+YLT3
         ZacJ/hCgG440mBLSPmG4IrlXdurVfOTvNtHRWhO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 37/68] tipc: fix race condition causing hung sendto
Date:   Fri,  8 Mar 2019 13:50:07 +0100
Message-Id: <20190308124912.561575178@linuxfoundation.org>
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
@@ -377,11 +377,13 @@ static int tipc_sk_sock_err(struct socke
 
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
@@ -1961,6 +1963,8 @@ static void tipc_sk_proto_rcv(struct soc
 		return;
 	case SOCK_WAKEUP:
 		tipc_dest_del(&tsk->cong_links, msg_orignode(hdr), 0);
+		/* coupled with smp_rmb() in tipc_wait_for_cond() */
+		smp_wmb();
 		tsk->cong_link_cnt--;
 		wakeup = true;
 		break;


