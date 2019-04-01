Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA9EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE77B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141151;
	bh=scHO8Hlt3p7MSGXsfkhENYV+d/8SBiW+x80bCdTfzeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DSGQ67GmD2Wk7QWWE1zz7TyA578PCRSy3Uhe1j/Sa9ga1vP7y3N9XEx/E4RqhhnzN
	 mL8oe+qe+wq8+FWo97pTtf5F+PhxfX9tsSzWUO5xjMz4MCXqn+mAO24DziqrH94Hfj
	 zBlKn5dC3jceVkic+N3jOujEHBqwnq1zege5rLlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfDARwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732377AbfDAR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:26:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629F42063F;
        Mon,  1 Apr 2019 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139597;
        bh=scHO8Hlt3p7MSGXsfkhENYV+d/8SBiW+x80bCdTfzeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsWYhc7ICJrdLyRIIGOSJDCD7yF2TObagMgKw0Uv0XHiKMimortYxY2/fqecnCTp5
         pwwgTFJeaFRy12n4/fweqYDqB0J6n0fcS8zPkZI3xp42olkFeSJVwmJDoTD/A7vYG1
         duZ+Vj7Nzs2LywT/PsYAwNdIRl+VHZoXGFYG/H/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 15/56] tun: properly test for IFF_UP
Date:   Mon,  1 Apr 2019 19:02:31 +0200
Message-Id: <20190401170104.716838996@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4477138fa0ae4e1b699786ef0600863ea6e6c61c ]

Same reasons than the ones explained in commit 4179cb5a4c92
("vxlan: test dev->flags & IFF_UP before calling netif_rx()")

netif_rx_ni() or napi_gro_frags() must be called under a strict contract.

At device dismantle phase, core networking clears IFF_UP
and flush_all_backlogs() is called after rcu grace period
to make sure no incoming packet might be in a cpu backlog
and still referencing the device.

A similar protocol is used for gro layer.

Most drivers call netif_rx() from their interrupt handler,
and since the interrupts are disabled at device dismantle,
netif_rx() does not have to check dev->flags & IFF_UP

Virtual drivers do not have this guarantee, and must
therefore make the check themselves.

Fixes: 1bd4978a88ac ("tun: honor IFF_UP in tun_get_user()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1194,9 +1194,6 @@ static ssize_t tun_get_user(struct tun_s
 	u32 rxhash;
 	ssize_t n;
 
-	if (!(tun->dev->flags & IFF_UP))
-		return -EIO;
-
 	if (!(tun->flags & IFF_NO_PI)) {
 		if (len < sizeof(pi))
 			return -EINVAL;
@@ -1273,9 +1270,11 @@ static ssize_t tun_get_user(struct tun_s
 		err = skb_copy_datagram_from_iter(skb, 0, from, len);
 
 	if (err) {
+		err = -EFAULT;
+drop:
 		this_cpu_inc(tun->pcpu_stats->rx_dropped);
 		kfree_skb(skb);
-		return -EFAULT;
+		return err;
 	}
 
 	err = virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun));
@@ -1327,7 +1326,15 @@ static ssize_t tun_get_user(struct tun_s
 	skb_probe_transport_header(skb, 0);
 
 	rxhash = skb_get_hash(skb);
+
+	rcu_read_lock();
+	if (unlikely(!(tun->dev->flags & IFF_UP))) {
+		err = -EIO;
+		goto drop;
+	}
+
 	netif_rx_ni(skb);
+	rcu_read_unlock();
 
 	stats = get_cpu_ptr(tun->pcpu_stats);
 	u64_stats_update_begin(&stats->syncp);


