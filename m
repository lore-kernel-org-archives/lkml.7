Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8EFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CEE21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127922;
	bh=nwvbiVZH5kS4HxXVX8OS5u+d4I6uHw15UCBqenIF13c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qgKbSTEuLSM20s1xxUFb0l5vf1YnDBQaJj5rjafVODZXeHyQDWCkNBm6T8HK7CttR
	 qG4HDutag4lqeB5WJsiHVpdqUjQO4zkFHFqWb80+VQIjJaoblCobyc9XhWEbCeqv6y
	 yzvJXfYGNjgy6lDD8H6Nie/I/kqn6mJw5yDM6Ipg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392045AbfDXRpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391044AbfDXRdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:33:35 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0CD2054F;
        Wed, 24 Apr 2019 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127214;
        bh=nwvbiVZH5kS4HxXVX8OS5u+d4I6uHw15UCBqenIF13c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcmiJvhzAVe0N4yGEb/CZGnkU2MZTb6PttwoVaMZMCGsAb8yIoMvOYP+tcY2UUT/U
         X/CdK3AbKC4YLNO9FQE0f2LWq3yQkxKl3oh1SqWfS0K0FzDOTskRbw4qZF0PxiSdMI
         ZLQjoBkppx0v+sNmRKhze+YBLZC6ZPQDJThAO4rw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 001/115] bonding: fix event handling for stacked bonds
Date:   Wed, 24 Apr 2019 19:08:57 +0200
Message-Id: <20190424170924.965996081@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 92480b3977fd3884649d404cbbaf839b70035699 ]

When a bond is enslaved to another bond, bond_netdev_event() only
handles the event as if the bond is a master, and skips treating the
bond as a slave.

This leads to a refcount leak on the slave, since we don't remove the
adjacency to its master and the master holds a reference on the slave.

Reproducer:
  ip link add bondL type bond
  ip link add bondU type bond
  ip link set bondL master bondU
  ip link del bondL

No "Fixes:" tag, this code is older than git history.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3214,8 +3214,12 @@ static int bond_netdev_event(struct noti
 		return NOTIFY_DONE;
 
 	if (event_dev->flags & IFF_MASTER) {
+		int ret;
+
 		netdev_dbg(event_dev, "IFF_MASTER\n");
-		return bond_master_netdev_event(event, event_dev);
+		ret = bond_master_netdev_event(event, event_dev);
+		if (ret != NOTIFY_DONE)
+			return ret;
 	}
 
 	if (event_dev->flags & IFF_SLAVE) {


