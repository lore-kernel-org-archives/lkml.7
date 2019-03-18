Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DC62075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901228;
	bh=xuGhrMhVz3zaaYtF5wWqhDEOrMlAGjbRM44hQ9EneKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wwsi9kDgHZYJpNYC+qnBC3c7ZUQThU8I1cf3EI8qddvRSNrjryYU/pAKAE3kkpVI0
	 OzPtXmrdwtbMAO0xuH4b/qcUknC6GsGKUzu59+3D+LmbUK5UmDjUm+J333DOTanhsd
	 X9pgN900eY+ajCagOL9AxbmpKTWMwqHQyKAajnBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfCRJ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfCRJ1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:04 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AFC02063F;
        Mon, 18 Mar 2019 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901223;
        bh=xuGhrMhVz3zaaYtF5wWqhDEOrMlAGjbRM44hQ9EneKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9wcgMpMj8GjCbC6wRBwOvEjNgNwUgR6nFNlo6sKKWVn0QFWFgIUVbpKPDXE2PRLK
         7iuDxxXHfFhuIjIjCNdlWlvNJMUW9R2vaf5kqt5kIGjHuj2OAfz2qi3obvPttCMyLY
         BGJUaswUf0jPVBRpnfkrIs3CFHIsy1NXfY+1gmq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 23/43] vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()
Date:   Mon, 18 Mar 2019 10:24:15 +0100
Message-Id: <20190318083716.551338675@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1657,6 +1657,14 @@ static int vxlan_rcv(struct sock *sk, st
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
@@ -1664,6 +1672,9 @@ static int vxlan_rcv(struct sock *sk, st
 	u64_stats_update_end(&stats->syncp);
 
 	gro_cells_receive(&vxlan->gro_cells, skb);
+
+	rcu_read_unlock();
+
 	return 0;
 
 drop:


