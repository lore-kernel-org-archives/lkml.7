Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF9C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E8F2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XH+mBmWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfHUB3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:29:11 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.107]:38479 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfHUB3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:29:10 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 1638E19C90
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 20:29:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 0FQyiD2qSdnCe0FQzicDvJ; Tue, 20 Aug 2019 20:29:09 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OOSEwVTKo/XTobrljC1e2coQRLkYFj8WzE8FMIs5SyI=; b=XH+mBmWD2RAMJ8JYeWMJ1U/HPf
        KoNO6ZClPAZwK86TOehOSlEP62WhxzMdphsN+VFDwuETB8qIELEA83UWLX0kV36H61kNPiY1hvhkL
        +5LiUGmxxXwSdiNGPx2cSgFg+9335X8Cg8iSCtwt73VKwkQnxACLytZp+e0jSt+32TVqk5vqmXOKW
        XPqpCrKPbLkpSRq4F7WBFTBZrsnGTl4v7OLDfDFLGVdy1jiDuAuOdcdVlGWHL7QC4RAL/miBo0+B4
        kbb6ALif+LFUvxpNWsAHZkbIqm13eY54Ct3gzvFMNwQpRmiivRw1KRg6IwRAAlbTSXBU8ZRY0QKxR
        HNj2xjDw==;
Received: from cablelink-187-160-61-9.pcs.intercable.net ([187.160.61.9]:54391 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i0FQx-000vE1-WA; Tue, 20 Aug 2019 20:29:08 -0500
Date:   Tue, 20 Aug 2019 20:29:07 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ARC: unwind: Mark expected switch fall-through
Message-ID: <20190821012907.GA29165@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.160.61.9
X-Source-L: No
X-Exim-ID: 1i0FQx-000vE1-WA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-187-160-61-9.pcs.intercable.net (embeddedor) [187.160.61.9]:54391
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings (Building: haps_hs_defconfig arc):

arch/arc/kernel/unwind.c: In function ‘read_pointer’:
./include/linux/compiler.h:328:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
  do {        \
     ^
./include/linux/compiler.h:338:2: note: in expansion of macro ‘__compiletime_assert’
  __compiletime_assert(condition, msg, prefix, suffix)
  ^~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:350:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
arch/arc/kernel/unwind.c:573:3: note: in expansion of macro ‘BUILD_BUG_ON’
   BUILD_BUG_ON(sizeof(u32) != sizeof(value));
   ^~~~~~~~~~~~
arch/arc/kernel/unwind.c:575:2: note: here
  case DW_EH_PE_native:
  ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arc/kernel/unwind.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 445e4d702f43..dc05a63516f5 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -572,6 +572,7 @@ static unsigned long read_pointer(const u8 **pLoc, const void *end,
 #else
 		BUILD_BUG_ON(sizeof(u32) != sizeof(value));
 #endif
+		/* Fall through */
 	case DW_EH_PE_native:
 		if (end < (const void *)(ptr.pul + 1))
 			return 0;
-- 
2.23.0

