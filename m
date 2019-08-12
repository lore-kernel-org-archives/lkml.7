Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C2C0650F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 00:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BA920820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 00:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="V+g+WALm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfHLAWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 20:22:04 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.212]:14681 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbfHLAWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 20:22:04 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 5B4FA400CC660
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 19:22:02 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wy65hViRd90onwy65hKnjp; Sun, 11 Aug 2019 19:22:02 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rOOPxfsGYN4ADAoetTEhwGr2GPC2m5yYCGICAwSLA1A=; b=V+g+WALm4X/kwH+wvXaJ6qDBvd
        waEP+UkdGFUylUdlIgI4Nevdkq6rFad044GJxvbyq1DCf2nLjQcTTnBONgh8Q7RNWPJJl1wcngKQ6
        tvWThJyI6b52FptrqWKwwudEfSMuwE5etxuDMPs6dLhsqCNrSzUjAZnuwgzxf1XavDACYLcnN+8eX
        P7p5q+x9/rMd/I9EfZYazn2SocvkmRIr2S1T6o6Oy/C3KqmN5ayXseInCj90f3yPE9aBwV9R3sNo/
        TX+Th24EIsrPyuCUgC0BJAWNlHdNIYzUKq5rDhjO2w7USIw6vW9xrt3zzsArkl5Rg5gJDw3aG/n4V
        Q1Shd5sA==;
Received: from [187.192.11.120] (port=52044 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hwy64-002b9l-LT; Sun, 11 Aug 2019 19:22:00 -0500
Date:   Sun, 11 Aug 2019 19:22:00 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] dmaengine: fsldma: Mark expected switch fall-through
Message-ID: <20190812002159.GA26899@embeddedor>
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
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hwy64-002b9l-LT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:52044
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

Fix the following warning (Building: powerpc-ppa8548_defconfig powerpc):

drivers/dma/fsldma.c: In function ‘fsl_dma_chan_probe’:
drivers/dma/fsldma.c:1165:26: warning: this statement may fall through [-Wimplicit-fallthrough=]
   chan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
   ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/dma/fsldma.c:1166:2: note: here
  case FSL_DMA_IP_83XX:
  ^~~~

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/dma/fsldma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 23e0a356f167..ad72b3f42ffa 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1163,6 +1163,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	switch (chan->feature & FSL_DMA_IP_MASK) {
 	case FSL_DMA_IP_85XX:
 		chan->toggle_ext_pause = fsl_chan_toggle_ext_pause;
+		/* Fall through */
 	case FSL_DMA_IP_83XX:
 		chan->toggle_ext_start = fsl_chan_toggle_ext_start;
 		chan->set_src_loop_size = fsl_chan_set_src_loop_size;
-- 
2.22.0

