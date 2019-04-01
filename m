Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89F8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872E6206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139240;
	bh=oegOK+2NbcsPCK/XnFVpp7o/4T1vFqZUoSvTIoqu6gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6oZuuFQ7JmBGhF18hYT+r+NkCYnxotHUB7EmRWbbA7gtKHWt+MCpSioDK0srfpLm
	 mYXZMBuaSkBeB05cpbH4+clW1Uf2m09QPJ+8hM5+jzLmceSInc7sX18nLW98/Bqr9T
	 tdQV50hCQDu7dVRJ916a9qnu9GDr1NlrMECRGx9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfDARUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731667AbfDARUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:20:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13769206C0;
        Mon,  1 Apr 2019 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139234;
        bh=oegOK+2NbcsPCK/XnFVpp7o/4T1vFqZUoSvTIoqu6gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0cRVueU7+xAl1LBouVq1V0uD/0JMmEpcsseuy5zIpusALGjPnB3c1474luQTAIvts
         gmBa5dYTD1qZH5GUUsvCfBBOZ76vQwo+espYaSf/eXqEawSA8brS6gHQMs8EFeOXXo
         3hFITgtVwPMPInc3ea4rI0IJyirIIVRqzer3VfVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dean Nelson <dnelson@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 017/107] thunderx: eliminate extra calls to put_page() for pages held for recycling
Date:   Mon,  1 Apr 2019 19:01:32 +0200
Message-Id: <20190401170047.064445862@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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


