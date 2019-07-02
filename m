Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F4C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583732184C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054706;
	bh=7DQGuESCLaUEs01XjT2ZWgglXaxb0cRNK0S7RFfDxiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h1Je37qF0u49vufxu13xa9djoAvXJ408Erlz+PS1lDJSf6bdzyacZtRvjy6axKSlo
	 menuMHqgTyUp2MuqfZAtYhbZ2QU7p2TdlPHdHBFT7J+UMjuVpjqXYc2cRM28dAQto9
	 IDDnXdWc5T50N4eHgB+1y+hTw+1+K7lNKenlIEcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfGBIFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfGBIFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:05:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E2821841;
        Tue,  2 Jul 2019 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054700;
        bh=7DQGuESCLaUEs01XjT2ZWgglXaxb0cRNK0S7RFfDxiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aM7wZXtAl4sVeeVkXf9o4pJZErRvptpqpHvdlToIRRJiQA8m3Djh7sEpZR+//Wl0N
         PLKx4q6QOQncRIwEexjPMdvLT7YiUkq/WZ/m0Ax2kH3AYae1s1V7hODhjVHMbZw7eu
         3uOm6GUP9KeD8Ny5E6fnD4p4NB5YeQCIeqWDCrgQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 40/55] tipc: change to use register_pernet_device
Date:   Tue,  2 Jul 2019 10:01:48 +0200
Message-Id: <20190702080126.199587783@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.103022729@linuxfoundation.org>
References: <20190702080124.103022729@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit c492d4c74dd3f87559883ffa0f94a8f1ae3fe5f5 ]

This patch is to fix a dst defcnt leak, which can be reproduced by doing:

  # ip net a c; ip net a s; modprobe tipc
  # ip net e s ip l a n eth1 type veth peer n eth1 netns c
  # ip net e c ip l s lo up; ip net e c ip l s eth1 up
  # ip net e s ip l s lo up; ip net e s ip l s eth1 up
  # ip net e c ip a a 1.1.1.2/8 dev eth1
  # ip net e s ip a a 1.1.1.1/8 dev eth1
  # ip net e c tipc b e m udp n u1 localip 1.1.1.2
  # ip net e s tipc b e m udp n u1 localip 1.1.1.1
  # ip net d c; ip net d s; rmmod tipc

and it will get stuck and keep logging the error:

  unregister_netdevice: waiting for lo to become free. Usage count = 1

The cause is that a dst is held by the udp sock's sk_rx_dst set on udp rx
path with udp_early_demux == 1, and this dst (eventually holding lo dev)
can't be released as bearer's removal in tipc pernet .exit happens after
lo dev's removal, default_device pernet .exit.

 "There are two distinct types of pernet_operations recognized: subsys and
  device.  At creation all subsys init functions are called before device
  init functions, and at destruction all device exit functions are called
  before subsys exit function."

So by calling register_pernet_device instead to register tipc_net_ops, the
pernet .exit() will be invoked earlier than loopback dev's removal when a
netns is being destroyed, as fou/gue does.

Note that vxlan and geneve udp tunnels don't have this issue, as the udp
sock is released in their device ndo_stop().

This fix is also necessary for tipc dst_cache, which will hold dsts on tx
path and I will introduce in my next patch.

Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -132,7 +132,7 @@ static int __init tipc_init(void)
 	if (err)
 		goto out_sysctl;
 
-	err = register_pernet_subsys(&tipc_net_ops);
+	err = register_pernet_device(&tipc_net_ops);
 	if (err)
 		goto out_pernet;
 
@@ -140,7 +140,7 @@ static int __init tipc_init(void)
 	if (err)
 		goto out_socket;
 
-	err = register_pernet_subsys(&tipc_topsrv_net_ops);
+	err = register_pernet_device(&tipc_topsrv_net_ops);
 	if (err)
 		goto out_pernet_topsrv;
 
@@ -151,11 +151,11 @@ static int __init tipc_init(void)
 	pr_info("Started in single node mode\n");
 	return 0;
 out_bearer:
-	unregister_pernet_subsys(&tipc_topsrv_net_ops);
+	unregister_pernet_device(&tipc_topsrv_net_ops);
 out_pernet_topsrv:
 	tipc_socket_stop();
 out_socket:
-	unregister_pernet_subsys(&tipc_net_ops);
+	unregister_pernet_device(&tipc_net_ops);
 out_pernet:
 	tipc_unregister_sysctl();
 out_sysctl:
@@ -170,9 +170,9 @@ out_netlink:
 static void __exit tipc_exit(void)
 {
 	tipc_bearer_cleanup();
-	unregister_pernet_subsys(&tipc_topsrv_net_ops);
+	unregister_pernet_device(&tipc_topsrv_net_ops);
 	tipc_socket_stop();
-	unregister_pernet_subsys(&tipc_net_ops);
+	unregister_pernet_device(&tipc_net_ops);
 	tipc_netlink_stop();
 	tipc_netlink_compat_stop();
 	tipc_unregister_sysctl();


