Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FF8CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 11:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC36620679
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 11:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B42CUxdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfKCLkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 06:40:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfKCLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 06:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gmf67+Ll0+MI5uOPN1vksIbzWN3wBWxYCmVFnmReHxQ=; b=B42CUxdoMboDlC/O9HvyY34JTw
        Ke23nH1DggN/87kcGLu87eMh/Av6uh1pVJ1GEifmFHejCY+oE8rMTkbDHYgrcVqv/5lpzeSxZpPZE
        P01Ao52Of/Y4UhfAwVKjSmkCn7jSDT0lsf6y34QhcYr6f4rvemHoiEkkW/8lwZlBz2dlBjvupOjpk
        k3yDPLKrIlXEdfrc+QNj+b/qWVex12iv34OwRbT5jIEqp4Ev0bPS5Ms9a488+r7TWBRwVGuUL5pWg
        czEtPUmVpWDGYl+eHmIZ9fMdB5wuEvjabLvCdG7rDkl43HMnEVZBPv97Qtg5q4kD5zmgo98TQ7gLe
        esrD+XKQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iREEz-0007q0-KY; Sun, 03 Nov 2019 11:40:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 1/5] XArray: Fix xas_next() with a single entry at 0
Date:   Sun,  3 Nov 2019 03:40:07 -0800
Message-Id: <20191103114012.30027-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191103114012.30027-1-willy@infradead.org>
References: <20191103114012.30027-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If there is only a single entry at 0, the first time we call xas_next(),
we return the entry.  Unfortunately, all subsequent times we call
xas_next(), we also return the entry at 0 instead of noticing that the
xa_index is now greater than zero.  This broke find_get_pages_contig().

Fixes: 64d3e9a9e0cc ("xarray: Step through an XArray")
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/test_xarray.c | 24 ++++++++++++++++++++++++
 lib/xarray.c      |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 9d631a7b6a70..7df4f7f395bf 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1110,6 +1110,28 @@ static noinline void check_find_entry(struct xarray *xa)
 	XA_BUG_ON(xa, !xa_empty(xa));
 }
 
+static noinline void check_move_tiny(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+
+	XA_BUG_ON(xa, !xa_empty(xa));
+	rcu_read_lock();
+	XA_BUG_ON(xa, xas_next(&xas) != NULL);
+	XA_BUG_ON(xa, xas_next(&xas) != NULL);
+	rcu_read_unlock();
+	xa_store_index(xa, 0, GFP_KERNEL);
+	rcu_read_lock();
+	xas_set(&xas, 0);
+	XA_BUG_ON(xa, xas_next(&xas) != xa_mk_index(0));
+	XA_BUG_ON(xa, xas_next(&xas) != NULL);
+	xas_set(&xas, 0);
+	XA_BUG_ON(xa, xas_prev(&xas) != xa_mk_index(0));
+	XA_BUG_ON(xa, xas_prev(&xas) != NULL);
+	rcu_read_unlock();
+	xa_erase_index(xa, 0);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
 static noinline void check_move_small(struct xarray *xa, unsigned long idx)
 {
 	XA_STATE(xas, xa, 0);
@@ -1217,6 +1239,8 @@ static noinline void check_move(struct xarray *xa)
 
 	xa_destroy(xa);
 
+	check_move_tiny(xa);
+
 	for (i = 0; i < 16; i++)
 		check_move_small(xa, 1UL << i);
 
diff --git a/lib/xarray.c b/lib/xarray.c
index 446b956c9188..1237c213f52b 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -994,6 +994,8 @@ void *__xas_prev(struct xa_state *xas)
 
 	if (!xas_frozen(xas->xa_node))
 		xas->xa_index--;
+	if (!xas->xa_node)
+		return set_bounds(xas);
 	if (xas_not_node(xas->xa_node))
 		return xas_load(xas);
 
@@ -1031,6 +1033,8 @@ void *__xas_next(struct xa_state *xas)
 
 	if (!xas_frozen(xas->xa_node))
 		xas->xa_index++;
+	if (!xas->xa_node)
+		return set_bounds(xas);
 	if (xas_not_node(xas->xa_node))
 		return xas_load(xas);
 
-- 
2.24.0.rc1

