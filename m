Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BD7C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C428520659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562055102;
	bh=tVprYKvwsxtoCkfLdUffkAHSvZ+eIPJRLl2ZFbDPPyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j58QYk91wSStL75S5w8VOKnbPSnvynNXq/LbItiLaEv2FydMXNtQhmoGX5OnsbUor
	 bnfq93EW4fogHHlw+gxCTYuPkwtKJxn+37NBIpSeMMISGMcr/G/XtGxXeMqyJPwV67
	 n84duUmqGvH/0oGMnz5Jnvn/UWz/8Lu76Guwbs8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfGBIKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbfGBIKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:10:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1CDD2184B;
        Tue,  2 Jul 2019 08:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562055003;
        bh=tVprYKvwsxtoCkfLdUffkAHSvZ+eIPJRLl2ZFbDPPyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMRQWj9U9JlBTTha7YhABUQDLqVNrL0AkKR3oqqixPncVMEUWhSzny4lm4pu2aYlm
         k5cEcn7doC3VIzpNxQRiZ7BSOjZtLZmztdpaTGeXW6LKoB8EOhfzSONIMF62/4H8JO
         7tkuB6YmMtyx3a9qhCu3oJmlMH/Hp0LmIEypqFV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fei Li <lifei.shirley@bytedance.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 35/43] tun: wake up waitqueues after IFF_UP is set
Date:   Tue,  2 Jul 2019 10:02:15 +0200
Message-Id: <20190702080125.732708948@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080123.904399496@linuxfoundation.org>
References: <20190702080123.904399496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fei Li <lifei.shirley@bytedance.com>

[ Upstream commit 72b319dc08b4924a29f5e2560ef6d966fa54c429 ]

Currently after setting tap0 link up, the tun code wakes tx/rx waited
queues up in tun_net_open() when .ndo_open() is called, however the
IFF_UP flag has not been set yet. If there's already a wait queue, it
would fail to transmit when checking the IFF_UP flag in tun_sendmsg().
Then the saving vhost_poll_start() will add the wq into wqh until it
is waken up again. Although this works when IFF_UP flag has been set
when tun_chr_poll detects; this is not true if IFF_UP flag has not
been set at that time. Sadly the latter case is a fatal error, as
the wq will never be waken up in future unless later manually
setting link up on purpose.

Fix this by moving the wakeup process into the NETDEV_UP event
notifying process, this makes sure IFF_UP has been set before all
waited queues been waken up.

Signed-off-by: Fei Li <lifei.shirley@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -831,18 +831,8 @@ static void tun_net_uninit(struct net_de
 /* Net device open. */
 static int tun_net_open(struct net_device *dev)
 {
-	struct tun_struct *tun = netdev_priv(dev);
-	int i;
-
 	netif_tx_start_all_queues(dev);
 
-	for (i = 0; i < tun->numqueues; i++) {
-		struct tun_file *tfile;
-
-		tfile = rtnl_dereference(tun->tfiles[i]);
-		tfile->socket.sk->sk_write_space(tfile->socket.sk);
-	}
-
 	return 0;
 }
 
@@ -2826,6 +2816,7 @@ static int tun_device_event(struct notif
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct tun_struct *tun = netdev_priv(dev);
+	int i;
 
 	if (dev->rtnl_link_ops != &tun_link_ops)
 		return NOTIFY_DONE;
@@ -2835,6 +2826,14 @@ static int tun_device_event(struct notif
 		if (tun_queue_resize(tun))
 			return NOTIFY_BAD;
 		break;
+	case NETDEV_UP:
+		for (i = 0; i < tun->numqueues; i++) {
+			struct tun_file *tfile;
+
+			tfile = rtnl_dereference(tun->tfiles[i]);
+			tfile->socket.sk->sk_write_space(tfile->socket.sk);
+		}
+		break;
 	default:
 		break;
 	}


