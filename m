Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585BAC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263C620657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="yMnCM/bd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfFQN0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:26:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40469 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFQN0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:26:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so4104206pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=iNOXjuZREAy3pqMzT9qyi/Eg7jLleHcrbZVRNS23Pj8=;
        b=yMnCM/bd6N4IgQjYrAHjB89GSMvMISjAxblDsKtRlxx6VTMWe2kKEcrL8FLDHixrz9
         8uFgCNUDIcPHwdeusscgeQ5lFdTq8R+xkuEI4qabyQB8z41Scmdlwe9rWDxKmpPmZly5
         xJShIZcxnENKNlRsWgyLcODf9fGH/1kSLf+QgBdAJgq9Z1Ty/rG5XT0bFnvw/3dM8B6/
         /QR5sCDTz0obC713me79im/DGCodCmH1WJdrfdF+8mlB0cBeCUaMvbtKNfZG6pmi8G7S
         f77DbylIEDUjyE/PZNcXKur1jnSEwCz9CT45Vt9CAtZmCzJCs86HEobm5ebzVTsOoGzi
         Vy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iNOXjuZREAy3pqMzT9qyi/Eg7jLleHcrbZVRNS23Pj8=;
        b=ZVCA4mh4D9zvQbC2tg4F3qox3Hg+chkti1Dey9bL8obytenYbTJpOeR24Lo9K4YaKG
         JFGHLlyYWM/KOotbSmkBqxj3DQzZBFCOfHVeh90DEXSZArg67wndmFddrC3Hn03ytB1O
         A7Dd35HOcrN+X38Spec63pEIhktdHjYljfAO0JFzV4qfwHY7aKleOYbBQI7VE2MgNWdM
         G4h4LU/Qy79fxhO+8pROrhHcW0D9AIBqEfffn3ljIwBXLRoYeeNUbB7qQiFtg832nxOd
         B0mKffPieiRz3c+DzG/10SLsmjXQYpIIiqAPDGDPErpjrRYbvmjnYVPJXwNAz9LuAdH7
         0gzQ==
X-Gm-Message-State: APjAAAWdUWJYL0nslJqh/RVB1ippDFod0TVbnxLtcnVjF7+6EhmXlf1w
        CtY8T6JKS9d3KEtG/R4y3pRdzw==
X-Google-Smtp-Source: APXvYqw2iDq0Ab7tchmhG+MTOb9wfk/of2zsP9Ugq5BJmQ8olAgmk5dogawvPBuud6IfwEQQ3L7vew==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr89500786plp.71.1560778004780;
        Mon, 17 Jun 2019 06:26:44 -0700 (PDT)
Received: from bogon.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id 135sm16530362pfb.137.2019.06.17.06.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 06:26:44 -0700 (PDT)
From:   Fei Li <lifei.shirley@bytedance.com>
To:     davem@davemloft.net, jasowang@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhengfeiran@bytedance.com, duanxiongchun@bytedance.com,
        Fei Li <lifei.shirley@bytedance.com>
Subject: [PATCH net v2] tun: wake up waitqueues after IFF_UP is set
Date:   Mon, 17 Jun 2019 21:26:36 +0800
Message-Id: <20190617132636.72496-1-lifei.shirley@bytedance.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/tun.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c452d6d831dd..d7c55e0fa8f4 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1014,18 +1014,8 @@ static void tun_net_uninit(struct net_device *dev)
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
 
@@ -3634,6 +3624,7 @@ static int tun_device_event(struct notifier_block *unused,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct tun_struct *tun = netdev_priv(dev);
+	int i;
 
 	if (dev->rtnl_link_ops != &tun_link_ops)
 		return NOTIFY_DONE;
@@ -3643,6 +3634,14 @@ static int tun_device_event(struct notifier_block *unused,
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
-- 
2.11.0

