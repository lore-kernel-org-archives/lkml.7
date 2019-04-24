Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE74C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4256E2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128250;
	bh=aGRFe0HcIB613C85TNsgjSBUr6KvgpVTIziqUNaqMg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RyXwaMq2iB5GopSBGj8tYosg13QBLi+AbxzenlmzoPMOPrBZZd4RqlNh91prNwrnK
	 pVmXWzgQtBpBb/sdPYlcuoGqplfQUkqQYIBDqOwh8stybJGrzPq5vF6xfRAX0HGW1p
	 Xd8vOj4JYqKRx1xfYVi3eEYrj5M3GJRSjpLQv8AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390793AbfDXR3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390050AbfDXR3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:20 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF3A2054F;
        Wed, 24 Apr 2019 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126960;
        bh=aGRFe0HcIB613C85TNsgjSBUr6KvgpVTIziqUNaqMg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFVHgFrXXdgnJSS7RRdRdFySeWZPW8KT7Kt+7VwKgNvNHSQ/zGQ9p62tm62kGC3Uc
         i+BNfsrcvauea4lLdWVlaqJhxAbO1KB0YuINnM+efbc2FBeZVBfIranQ0dizE/mVRb
         TnljEFwBnBa/BWQTHQcrMs3MzPff1AABnBwRpbg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 01/96] bonding: fix event handling for stacked bonds
Date:   Wed, 24 Apr 2019 19:09:06 +0200
Message-Id: <20190424170919.926231805@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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
@@ -3198,8 +3198,12 @@ static int bond_netdev_event(struct noti
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


