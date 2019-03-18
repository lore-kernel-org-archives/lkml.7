Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C36FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F3F214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901534;
	bh=gIPrQ/M3ZA2nK1Mo5PbuxPEpH1KwJVaVzxO/Xu3KmzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ifmytuO+0+OFDgMxbM+Om92Wv2Mavy3QWiP7Syrgh1/oCoR0a2Y4o8VPnDPytE/kw
	 usJQyGzcvo41CcJN4Xax9SHbuM8hxU6vTihK9odQBVHvYLJ24s7q1zXfVdemX6iJfc
	 AsyZ1onhw6f0mDH85S3kBfmnj/eoTt8cd7dIF1CY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfCRJcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbfCRJcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:32:08 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CEAC2083D;
        Mon, 18 Mar 2019 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901528;
        bh=gIPrQ/M3ZA2nK1Mo5PbuxPEpH1KwJVaVzxO/Xu3KmzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3wYbaN5m15NbaoHNtTLxXIV8NCoXBGqTS037q5sKDwAfaQXc4Ww4vdg/3WCdMD5t
         eDcwW9WeoQbfgSLJ1B1ht2nrrMvGAYjx8za8VIarKoxPchihQOAaCGn5b5Gcu+svVe
         YRHcljkV/6X8d4oVftLLofr230D0y/gaF/UlaEOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 21/52] vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()
Date:   Mon, 18 Mar 2019 10:25:18 +0100
Message-Id: <20190318084016.064100121@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 59cbf56fcd98ba2a715b6e97c4e43f773f956393 ]

Same reasons than the ones explained in commit 4179cb5a4c92
("vxlan: test dev->flags & IFF_UP before calling netif_rx()")

netif_rx() or gro_cells_receive() must be called under a strict contract.

At device dismantle phase, core networking clears IFF_UP
and flush_all_backlogs() is called after rcu grace period
to make sure no incoming packet might be in a cpu backlog
and still referencing the device.

A similar protocol is used for gro_cells infrastructure, as
gro_cells_destroy() will be called only after a full rcu
grace period is observed after IFF_UP has been cleared.

Most drivers call netif_rx() from their interrupt handler,
and since the interrupts are disabled at device dismantle,
netif_rx() does not have to check dev->flags & IFF_UP

Virtual drivers do not have this guarantee, and must
therefore make the check themselves.

Otherwise we risk use-after-free and/or crashes.

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1469,6 +1469,14 @@ static int vxlan_rcv(struct sock *sk, st
 		goto drop;
 	}
 
+	rcu_read_lock();
+
+	if (unlikely(!(vxlan->dev->flags & IFF_UP))) {
+		rcu_read_unlock();
+		atomic_long_inc(&vxlan->dev->rx_dropped);
+		goto drop;
+	}
+
 	stats = this_cpu_ptr(vxlan->dev->tstats);
 	u64_stats_update_begin(&stats->syncp);
 	stats->rx_packets++;
@@ -1476,6 +1484,9 @@ static int vxlan_rcv(struct sock *sk, st
 	u64_stats_update_end(&stats->syncp);
 
 	gro_cells_receive(&vxlan->gro_cells, skb);
+
+	rcu_read_unlock();
+
 	return 0;
 
 drop:


