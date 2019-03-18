Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FB3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF737213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e+P49rUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfCRVRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:17:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfCRVRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:To:From:
        Sender:Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1w7a+dbYnqKB3SZi8lXID/YS2OOIjB8Oy2rvILtQyeE=; b=e+P49rUKaC4/zUFINSHUhudtW
        aEpSl/tg8coSzZbnh94iLMkAitQQSFaPT6MuZce78uCYOlp8yZhlfMY+ZfxG4jKOtDOdCdgZM5yPK
        4BVuusF9eEfwtxJcgkN24GZM3yFphF3Xy017Vp1Y1CHsVluE4n3pxIwqCFSgiU5oNHJ0t439a2MLi
        YASjuZy3ywsoKbz6aqPrOmiINC8oiPtlKvKlNMyi9rHUoh1cFLtZMfrZAYLh4OmlpF6bv8Kcu4ML1
        1/iouc4QNvefXnV521h4kaTnWziq3vtCQ7XT0eHALh+2EfdES/Y5Ov7A6Pw/UIOXHwmAq7buEVa2t
        Pz9VyLCbQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5zdD-0000uk-Fo; Mon, 18 Mar 2019 21:17:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Johan Hovold <johan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Roger Quadros <rogerq@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Mans Rullgard <mans@mansr.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Convert USB subsystem to XArray
Date:   Mon, 18 Mar 2019 14:17:09 -0700
Message-Id: <20190318211713.3462-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to remove the IDR and radix tree APIs from the kernel.
This patch series converts all the IDRs and radix trees in the USB
subsystem to use the XArray APIs.  Testing of these patches has been
minimal, mostly limited to compilation testing.  I would be grateful if
you could take these patches through your tree.  To cut down on wasted
electrons, only this cover letter is being distributed to everyone
listed by get-maintainers; the patches can be found on the linux-usb
mailing list.

Please check these patches over carefully and test them; there may be
off-by-one errors, locking mistakes, or various other failures on my part.

Substantive interface changes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 - The IDR and radix tree required callers to handle their own locking.
   The XArray embeds a spinlock which is taken for modifications to
   the data structure; plain lookups occur under the RCU read lock or
   under the spinlock.
 - You can take the spinlock yourself (xa_lock() and friends) to protect
   related data.
 - idr_alloc() returned -ENOSPC, radix_tree_insert() returned -EEXIST.
   xa_insert() and xa_alloc() return -EBUSY.
 - The search keys which the radix tree calls "tags", the XArray calls
   "marks".
 - There is no preloading in the XArray API.  Most users of the
   preloading APIs only needed to use it because they were trying to
   allocate under their own spinlock.  If your locking is exceptionally
   complicated, you may need to use xa_insert() with a NULL pointer.
 - The radix tree provided GFP flags as part of the tree definition;
   the XArray (like the IDR) passes GFP flags at the point of allocation.
 - radix_tree_insert() of a NULL pointer was not well-specified.  The
   XArray treats it as reserving the entry (it reads back as NULL but
   a subsequent xa_insert() to that slot will fail).
 - xa_alloc() and xa_alloc_cyclic() need the XArray initialised with
   XA_FLAGS_ALLOC or XA_FLAGS_ALLOC1.  If the allocation is 1-based,
   then specifying a limit on the allocation which includes 0 will
   never allocate ID 0.
 - xa_alloc_cyclic() returns 1 if the allocation wraps, unlike
   idr_alloc_cyclic() which provides no indication.
 - There is no equivalent to idr_for_each(); the xa_for_each() iterator
   is similar to idr_for_each_entry().
 - idr_replace() has no exact equivalent.  Some users relied on its exact
   semantics of only storing if the entry was non-NULL, but all users of
   idr_replace() were able to use xa_store() or xa_cmpxchg().
 - The family of radix tree gang lookup functions have been replaced with
   xa_extract().

Matthew Wilcox (4):
  usb: Convert xhci-mem to XArray
  cdc-acm: Convert acm_minors to XArray
  usb: Convert usb_bus_idr to XArray
  usb/serial: Convert serial_minors to XArray

 drivers/usb/class/cdc-acm.c     | 33 ++++++-------
 drivers/usb/core/devices.c      | 10 ++--
 drivers/usb/core/hcd.c          | 40 ++++-----------
 drivers/usb/core/usb.c          |  1 -
 drivers/usb/host/r8a66597-hcd.c |  4 +-
 drivers/usb/host/xhci-mem.c     | 86 ++++++++++++---------------------
 drivers/usb/host/xhci.h         |  5 +-
 drivers/usb/mon/mon_main.c      |  7 ++-
 drivers/usb/serial/usb-serial.c | 21 ++++----
 include/linux/usb/hcd.h         |  3 +-
 10 files changed, 74 insertions(+), 136 deletions(-)

-- 
2.20.1

