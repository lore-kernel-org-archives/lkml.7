Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1AAC2D0C8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784D3206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfLWBz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:55:26 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:45643 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfLWBz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:55:26 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id B0F03628B6642F5D2DA1;
        Mon, 23 Dec 2019 09:55:21 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id xBN1r3cI034081;
        Mon, 23 Dec 2019 09:53:03 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019122309530535-1467765 ;
          Mon, 23 Dec 2019 09:53:05 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     steffen.klassert@secunet.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn, Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] xfrm: Use kmem_cache_zalloc() instead of kmem_cache_alloc() with flag GFP_ZERO.
Date:   Mon, 23 Dec 2019 09:53:02 +0800
Message-Id: <1577065982-25751-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-12-23 09:53:05,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-12-23 09:53:04,
        Serialize complete at 2019-12-23 09:53:04
X-MAIL: mse-fl2.zte.com.cn xBN1r3cI034081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Zijiang <huang.zijiang@zte.com.cn>

Use kmem_cache_zalloc instead of manually setting kmem_cache_alloc
with flag GFP_ZERO since kzalloc sets allocated memory
to zero.

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index a5dc319..adfa279 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -612,7 +612,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 {
     struct xfrm_state *x;
 
-    x = kmem_cache_alloc(xfrm_state_cache, GFP_ATOMIC | __GFP_ZERO);
+x = kmem_cache_zalloc(xfrm_state_cache, GFP_ATOMIC);
 
     if (x) {
         write_pnet(&x->xs_net, net);
-- 
1.9.1

