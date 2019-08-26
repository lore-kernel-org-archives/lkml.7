Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0BEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D279206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="k+L8HgGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfHZDGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 23:06:39 -0400
Received: from gateway20.websitewelcome.com ([192.185.47.18]:34942 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729179AbfHZDGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:06:39 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 5A3EC400C6E11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 21:01:45 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 25L3imnqbiQer25L3i6nqx; Sun, 25 Aug 2019 22:06:37 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nhx5OiP7r0dYpbGQdFUd0gr/5YT1Ihavje6uRy4hWMQ=; b=k+L8HgGtHnF9vb85fjf0bIhaJn
        4kLqVLiQtaUzgqgNobmb1ASxxWaChh7tMtQw/FPmX3uCLbhJmdn+huWyqQkRx9Yqd12R89xTe0kSW
        Dy1Y9bxs4JWgQ3L3B865+CqSPt8sFZ8OaHtH5tIB+w3Jh618d5sPoM8CPB+4XSis/CURwp+BrVLBA
        1sw2OEjFpOK8UWnJoNYxx5KxxENle5dDrH8oT9NjrpVQEbxigar/jEMF+uZudqwQeHmsvEI7sGZvO
        i4Kxrlm1jSN5+1bcp1GzKsggsdhMIHn6eU2vrEurQd55dIbwlqk6DC5bPrfLw1Q8xB3EG6Z1JSXnO
        bwGmxJAA==;
Received: from [189.152.216.116] (port=45992 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i25L2-003wZG-0L; Sun, 25 Aug 2019 22:06:36 -0500
Date:   Sun, 25 Aug 2019 22:06:34 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Henry Burns <henryburns@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mm/z3fold.c: fix lock/unlock imbalance in z3fold_page_isolate
Message-ID: <20190826030634.GA4379@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i25L2-003wZG-0L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:45992
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lock/unlock imbalance by unlocking *zhdr* before return.

Addresses-Coverity-ID: 1452811 ("Missing unlock")
Fixes: d776aaa9895e ("mm/z3fold.c: fix race between migration and destruction")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 mm/z3fold.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index e31cd9bd4ed5..75b7962439ff 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1406,6 +1406,7 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 				 * should freak out.
 				 */
 				WARN(1, "Z3fold is experiencing kref problems\n");
+				z3fold_page_unlock(zhdr);
 				return false;
 			}
 			z3fold_page_unlock(zhdr);
-- 
2.23.0

