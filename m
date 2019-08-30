Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E6EC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D9723427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qz115m9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfH3VcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:32:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfH3VcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=39NAEi3g684PXMyjoj7eaO9DaV5dnuLvRIXXBd6qxDI=; b=Qz115m9El56A1VAJkuL9u1IOU
        6Aq8KcHtm6FDPDIlv8xIBskrKQ4gdTQhgYmdoDcxR7qpfs9i0CLDtOSQfnWgr2X4CCBTlDIKATzsh
        30QSJGWQmAfIg+D5WPgukTpRbN3lZHlc97RxrncHtlrqVJVNxCQ8VEjQW2X8ITj/zKFwohWIrEwf1
        U323vOQcyh9BXwcaq8KM4zLE7O7oDcfWIB2Fi+5wNwZrsrmpu0JKVCnsc5HHSPxV7lL9qPuy+X0Gm
        cUj4UPBgHpe5LNtmkABDHBqj17nSKz5mClIaQotJp9rBsMP9vy8A0Rhr2mgYqtwsKntX3HHm3NH3e
        tq+2WewIg==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3oVI-0005G2-Kx; Fri, 30 Aug 2019 21:32:20 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] IOAT: iop-adma.c: fix printk format warning
Message-ID: <138f82a9-08ad-2bb2-cfce-f3124ec502fc@infradead.org>
Date:   Fri, 30 Aug 2019 14:32:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warning in iop-adma.c (seen on x86_64) by using
%pad:

../drivers/dma/iop-adma.c:118:12: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 6 has type ‘dma_addr_t {aka long long unsigned int}’ [-Wformat=]

Fixes: c211092313b9 ("dmaengine: driver for the iop32x, iop33x, and iop13xx raid engines")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/iop-adma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20190830.orig/drivers/dma/iop-adma.c
+++ linux-next-20190830/drivers/dma/iop-adma.c
@@ -116,9 +116,9 @@ static void __iop_adma_slot_cleanup(stru
 	list_for_each_entry_safe(iter, _iter, &iop_chan->chain,
 					chain_node) {
 		pr_debug("\tcookie: %d slot: %d busy: %d "
-			"this_desc: %#x next_desc: %#llx ack: %d\n",
+			"this_desc: %pad next_desc: %#llx ack: %d\n",
 			iter->async_tx.cookie, iter->idx, busy,
-			iter->async_tx.phys, (u64)iop_desc_get_next_desc(iter),
+			&iter->async_tx.phys, (u64)iop_desc_get_next_desc(iter),
 			async_tx_test_ack(&iter->async_tx));
 		prefetch(_iter);
 		prefetch(&_iter->async_tx);

