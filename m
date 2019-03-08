Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1943C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A8720449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050232;
	bh=wEb/+RPUnL59VPW0YqOpsh7w2Abx5Yny1r2yDHna8hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=amu6z6zMmzhQg7iP+bGgBrB+7dmnamx+9dTLcWkB54I3ymibUFVXEJ0cj+eHl113Z
	 v8QRJhrjXVp90vYhgxKoHMXhcpHM9of7HSJDwldPA1N+zDxqklB7Ip/lYF/y5orTY7
	 9OWwXMHnYxdQF1uGZoYYK2jqB6RIx6uKJTc59SIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfCHM6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:58:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfCHM6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:58:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 600D220449;
        Fri,  8 Mar 2019 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049909;
        bh=wEb/+RPUnL59VPW0YqOpsh7w2Abx5Yny1r2yDHna8hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgA48w5JRAIzjE6Mswj33qNNNig8JXUIA12qbcwsilIoIcMCD5y8SFZjuLK7a6+Jd
         eA4mb5SLc6O0XOXe1W8GAsvG5otDo1NJ7WE8df4j5tyOAXfMv7Mi9kKdeC9A4cDF24
         ijfi22tKfZ9FuFjKHFUNFVkSlQaAsG5Tv4mWL33w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 24/68] geneve: correctly handle ipv6.disable module parameter
Date:   Fri,  8 Mar 2019 13:49:54 +0100
Message-Id: <20190308124912.004670027@linuxfoundation.org>
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

From: Jiri Benc <jbenc@redhat.com>

[ Upstream commit cf1c9ccba7308e48a68fa77f476287d9d614e4c7 ]

When IPv6 is compiled but disabled at runtime, geneve_sock_add returns
-EAFNOSUPPORT. For metadata based tunnels, this causes failure of the whole
operation of bringing up the tunnel.

Ignore failure of IPv6 socket creation for metadata based tunnels caused by
IPv6 not being available.

This is the same fix as what commit d074bf960044 ("vxlan: correctly handle
ipv6.disable module parameter") is doing for vxlan.

Note there's also commit c0a47e44c098 ("geneve: should not call rt6_lookup()
when ipv6 was disabled") which fixes a similar issue but for regular
tunnels, while this patch is needed for metadata based tunnels.

Signed-off-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/geneve.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -636,15 +636,20 @@ out:
 static int geneve_open(struct net_device *dev)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
-	bool ipv6 = !!(geneve->info.mode & IP_TUNNEL_INFO_IPV6);
 	bool metadata = geneve->collect_md;
+	bool ipv4, ipv6;
 	int ret = 0;
 
+	ipv6 = geneve->info.mode & IP_TUNNEL_INFO_IPV6 || metadata;
+	ipv4 = !ipv6 || metadata;
 #if IS_ENABLED(CONFIG_IPV6)
-	if (ipv6 || metadata)
+	if (ipv6) {
 		ret = geneve_sock_add(geneve, true);
+		if (ret < 0 && ret != -EAFNOSUPPORT)
+			ipv4 = false;
+	}
 #endif
-	if (!ret && (!ipv6 || metadata))
+	if (ipv4)
 		ret = geneve_sock_add(geneve, false);
 	if (ret < 0)
 		geneve_sock_release(geneve);


