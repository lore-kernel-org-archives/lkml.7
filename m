Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42805C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012A220684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414771;
	bh=o2kukSFFfU0mbQWuJGg0mw6F6cIceRtU2S4LX75rTso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VxNCEkL+hZaUMDVMrR+nIk2tOM1piw84KUafGsQpd80ggYYVEijG2yRJpPT7kVCoY
	 xT2izmdrzc40XhsWbQtmFUCALHkl4u1ecGAbb2Yt66SwnYmqS6KkevEas65o1RFXR5
	 56FYNglqnSm2Md+9lbBkqp3WhehGlVNh1Ktu3Dg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfLCWjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:39:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfLCWjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:39:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC5F2084F;
        Tue,  3 Dec 2019 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412760;
        bh=o2kukSFFfU0mbQWuJGg0mw6F6cIceRtU2S4LX75rTso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1vZRE1lxwufewIgVTxLwyx4G0Zchq7TdzMECJlDzClZvyh+jATbe95XIyUPYJbuof
         53dzIQEJO9jzR9Xu74vh0Zo594uV+4ylarL0tNkPLq2ZIWjIBDUq093xJroNEC1Xtk
         eZaBv/8TxFXWXpUmZnF0nbxHC9TJho2+FhoxYQxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Menglong Dong <dong.menglong@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 17/46] macvlan: schedule bc_work even if error
Date:   Tue,  3 Dec 2019 23:35:37 +0100
Message-Id: <20191203212733.796192448@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

[ Upstream commit 1d7ea55668878bb350979c377fc72509dd6f5b21 ]

While enqueueing a broadcast skb to port->bc_queue, schedule_work()
is called to add port->bc_work, which processes the skbs in
bc_queue, to "events" work queue. If port->bc_queue is full, the
skb will be discarded and schedule_work(&port->bc_work) won't be
called. However, if port->bc_queue is full and port->bc_work is not
running or pending, port->bc_queue will keep full and schedule_work()
won't be called any more, and all broadcast skbs to macvlan will be
discarded. This case can happen:

macvlan_process_broadcast() is the pending function of port->bc_work,
it moves all the skbs in port->bc_queue to the queue "list", and
processes the skbs in "list". During this, new skbs will keep being
added to port->bc_queue in macvlan_broadcast_enqueue(), and
port->bc_queue may already full when macvlan_process_broadcast()
return. This may happen, especially when there are a lot of real-time
threads and the process is preempted.

Fix this by calling schedule_work(&port->bc_work) even if
port->bc_work is full in macvlan_broadcast_enqueue().

Fixes: 412ca1550cbe ("macvlan: Move broadcasts into a work queue")
Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macvlan.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -359,10 +359,11 @@ static void macvlan_broadcast_enqueue(st
 	}
 	spin_unlock(&port->bc_queue.lock);
 
+	schedule_work(&port->bc_work);
+
 	if (err)
 		goto free_nskb;
 
-	schedule_work(&port->bc_work);
 	return;
 
 free_nskb:


