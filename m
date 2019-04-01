Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A86C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348C821929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138319;
	bh=x5BRezBiPtxQGQDUXshgssybnj4dcrJVEWmJ4nXCKMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9wjMo2CtS+zhteECPQ+pn+yTylviVgxa3o4A0hzorMRwH5ekav7RXZxjue2POfk8
	 lCDK87MjH5F37w7XxTgfvMX6k1D1KLLOQqYeNUzFsPXD8LdUXu8OZ0/R3g4VGijyi0
	 cmqBFPYJ88SJ162NWaMln062+O2q8hQQzJ0x0aYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfDARFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbfDARFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC3A21925;
        Mon,  1 Apr 2019 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138316;
        bh=x5BRezBiPtxQGQDUXshgssybnj4dcrJVEWmJ4nXCKMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avu/D9QZL4bhzk62DkTc2V861I68tP/YhZvxsBfhRBrB78W2Y5MA86fN+t0ho6DOA
         Eaz4G5q038awN26Tlb28Aoh1n+xIHamtR8+TlhEUWfBEJKWf3CENhenBp31XB9StsY
         WYnMCi6G82HFGcKcx31EwsrxxLD5QvbOb1yJnJjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dean Nelson <dnelson@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 030/146] thunderx: eliminate extra calls to put_page() for pages held for recycling
Date:   Mon,  1 Apr 2019 19:00:42 +0200
Message-Id: <20190401170051.085412279@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Dean Nelson <dnelson@redhat.com>

[ Upstream commit cd35ef91490ad8049dd180bb060aff7ee192eda9 ]

For the non-XDP case, commit 773225388dae15e72790 ("net: thunderx: Optimize
page recycling for XDP") added code to nicvf_free_rbdr() that, when releasing
the additional receive buffer page reference held for recycling, repeatedly
calls put_page() until the page's _refcount goes to zero. Which results in
the page being freed.

This is not okay if the page's _refcount was greater than 1 (in the non-XDP
case), because nicvf_free_rbdr() should not be subtracting more than what
nicvf_alloc_page() had previously added to the page's _refcount, which was
only 1 (in the non-XDP case).

This can arise if a received packet is still being processed and the receive
buffer (i.e., skb->head) has not yet been freed via skb_free_head() when
nicvf_free_rbdr() is spinning through the aforementioned put_page() loop.

If this should occur, when the received packet finishes processing and
skb_free_head() is called, various problems can ensue. Exactly what, depends on
whether the page has already been reallocated or not, anything from "BUG: Bad
page state ... ", to "Unable to handle kernel NULL pointer dereference ..." or
"Unable to handle kernel paging request...".

So this patch changes nicvf_free_rbdr() to only call put_page() once for pages
held for recycling (in the non-XDP case).

Fixes: 773225388dae ("net: thunderx: Optimize page recycling for XDP")
Signed-off-by: Dean Nelson <dnelson@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -364,11 +364,10 @@ static void nicvf_free_rbdr(struct nicvf
 	while (head < rbdr->pgcnt) {
 		pgcache = &rbdr->pgcache[head];
 		if (pgcache->page && page_ref_count(pgcache->page) != 0) {
-			if (!rbdr->is_xdp) {
-				put_page(pgcache->page);
-				continue;
+			if (rbdr->is_xdp) {
+				page_ref_sub(pgcache->page,
+					     pgcache->ref_count - 1);
 			}
-			page_ref_sub(pgcache->page, pgcache->ref_count - 1);
 			put_page(pgcache->page);
 		}
 		head++;


