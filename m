Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2C9ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F0D20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="iWCnoGxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbfJOTKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:10:39 -0400
Received: from gateway30.websitewelcome.com ([192.185.196.18]:42479 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389323AbfJOTKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:10:38 -0400
X-Greylist: delayed 1397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Oct 2019 15:10:37 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id EF3783B3E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:47:18 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id KRqoi6mzjPUvSKRqoigmUU; Tue, 15 Oct 2019 13:47:18 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ylsOLtlHy0yELn95rm6leLOAaujCpaVYbsqRrnqooSg=; b=iWCnoGxsnxYjGPaXkBCyHWfTq2
        HJG4FcIp5GHwd3eXjbCCqMNeevLjnHhCvBCd759outDoOte8McPV7BaRPRHiIUG6E6HD5yJUscPLG
        9n7+RiZc+o7meo2iuVYmPnrRZ1zlFV5RputOPMet64VEzZIz3v2EW8fffL+zPAaHrjITKuNGK6T6X
        3UpjCkVsWDox1owp7C0+Ikd0MsbL3kkWNdqeeP62mGo89NOaEMDUqm5ZQBCLQ7fjEB6GW3BWwyH4x
        Y+WNu5fS+dcZiLxuSSas8xKmfpJ/S7xe9m2wTv2mnHc7cGrlzSY7zLY5K1BBzudKqKf7ZAvk37tqM
        gbvRJWvQ==;
Received: from [187.192.22.73] (port=41390 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iKRqn-001fgo-4G; Tue, 15 Oct 2019 13:47:17 -0500
Date:   Tue, 15 Oct 2019 13:46:57 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] linux/bitmap.h: fix potential sign-extension overflow
Message-ID: <20191015184657.GA26541@embeddedor>
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
X-Source-IP: 187.192.22.73
X-Source-L: No
X-Exim-ID: 1iKRqn-001fgo-4G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.22.73]:41390
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In expression 0xff << offset, left shifting by more than 31 bits has
undefined behavior. Notice that the shift amount, *offset*, can be as
much as 63.

Fix this by adding suffix ULL to integer 0xFF.

Addresses-Coverity: 1487071 ("Bad bit shift operation")
Fixes: d33f5cbaadd8 ("bitops: introduce the for_each_set_clump8 macro")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 include/linux/bitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 942871bfe47e..96f91db25b06 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -520,7 +520,7 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	const size_t index = BIT_WORD(start);
 	const unsigned long offset = start % BITS_PER_LONG;
 
-	map[index] &= ~(0xFF << offset);
+	map[index] &= ~(0xFFULL << offset);
 	map[index] |= value << offset;
 }
 
-- 
2.23.0

