Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B11C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C923B2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="n8RtI46E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfH2TNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:13:16 -0400
Received: from gateway20.websitewelcome.com ([192.185.44.20]:34821 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727146AbfH2TNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:13:15 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id A5647400CE53E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:08:10 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3Pr8iyhmgiQer3Pr8iI1dK; Thu, 29 Aug 2019 14:13:14 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LZLOm2++l1naemUsyzQnXFmXAnTsZQhTqpdUzFnNKxY=; b=n8RtI46EYyP6e+aDhBNoWMs7nk
        Q+sWYV8NGP79X12UG3yhnImVmD0HmY1asw6EteejVBZmtp7cmpjVbAVh1wif5UbNtnmJ7ohrNOuBR
        eF4m5iQf/ikkAE9UkI0ESE/U99WCQfUbbsFKKvUG29KppSjMyApmMjmAU8J5yOyWwJ80zXDqcu9PD
        7r/0XPaK5SPCzDLJrZs+mPcrCHfVtJLU72qdWu5WtSubne3TDuFNX5N4HLsgo1ebujytab7mjMz6q
        AaUcBCVU8Eijl3ejKYSL4dLYDEFWFo5BsxlYGX1vg/DyHs81YhtirfQOycW0bDma/GZk+Q+WhQYSX
        sJ2H6Z0Q==;
Received: from [189.152.216.116] (port=45196 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i3Pr7-001vxh-AQ; Thu, 29 Aug 2019 14:13:13 -0500
Date:   Thu, 29 Aug 2019 14:13:12 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mm/z3fold.c: remove useless code in z3fold_page_isolate
Message-ID: <20190829191312.GA20298@embeddedor>
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
X-Exim-ID: 1i3Pr7-001vxh-AQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:45196
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate and useless code.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 mm/z3fold.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 75b7962439ff..044b7075d0ba 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1400,15 +1400,13 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 			 * can call the release logic.
 			 */
 			if (unlikely(kref_put(&zhdr->refcount,
-					      release_z3fold_page_locked))) {
+					      release_z3fold_page_locked)))
 				/*
 				 * If we get here we have kref problems, so we
 				 * should freak out.
 				 */
 				WARN(1, "Z3fold is experiencing kref problems\n");
-				z3fold_page_unlock(zhdr);
-				return false;
-			}
+
 			z3fold_page_unlock(zhdr);
 			return false;
 		}
-- 
2.23.0

