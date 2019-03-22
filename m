Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E33C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F02A21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254424;
	bh=8D+fuASwKHMhJGJLzIOCvl2uszBmh0t2zQQLNNyrvwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y2U0H2naczokJbr/WRPLgZcO3Qeswmuq5NabO4uj5bRta4r0Uo2wdZ32u9jLDBdfA
	 7HL/6RqR3Rn0AMWBzAq4oPNU5xO5640c29gytegpEArlpo4xu3tvgqA+NrtKffwT/T
	 2wufAx4v20A0+BsUfRVMCaVDV6TvBN27jmeRxKug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfCVLdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbfCVLdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA85221916;
        Fri, 22 Mar 2019 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254417;
        bh=8D+fuASwKHMhJGJLzIOCvl2uszBmh0t2zQQLNNyrvwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SM2e+5Yj6wQFpeRBDhwuj+fFAiW5rocXKL0Bp9dHVTmclgdemUJvBitcmzvX2Dt3L
         DME3ygtaJrz8k9jJbu6lEHemvNaRBed+Q1KbQafBqnrNdQR0YlDrqvlEJsSCP474aK
         DPcnoU+3Td3cleSsyMSq6pbT/UpBEVjlSBHDIy74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 130/230] pptp: dst_release sk_dst_cache in pptp_sock_destruct
Date:   Fri, 22 Mar 2019 12:14:28 +0100
Message-Id: <20190322111245.810761709@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -577,6 +577,7 @@ static void pptp_sock_destruct(struct so
 		pppox_unbind_sock(sk);
 	}
 	skb_queue_purge(&sk->sk_receive_queue);
+	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
 }
 
 static int pptp_create(struct net *net, struct socket *sock, int kern)


