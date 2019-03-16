Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3863C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC72F21872
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCPDXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:23:22 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34802 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfCPDXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:23:22 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 14501290D4; Fri, 15 Mar 2019 23:23:21 -0400 (EDT)
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <c45c87fd0c966243ac9065ae219a265cade69a83.1552706479.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net] mac8390: Fix mmio access size probe
Date:   Sat, 16 Mar 2019 14:21:19 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bug that Stan reported is as follows. After a restart, a 16-bit NIC
may be incorrectly identified as a 32-bit NIC and stop working.

mac8390 slot.E: Memory length resource not found, probing
mac8390 slot.E: Farallon EtherMac II-C (type farallon)
mac8390 slot.E: MAC 00:00:c5:30:c2:99, IRQ 61, 32 KB shared memory at 0xfeed0000, 32-bit access.

The bug never arises after a cold start and only intermittently after a
warm start. (I didn't investigate why the bug is intermittent.)

It turns out that memcpy_toio() is deprecated and memcmp_withio() also
has issues. Replacing these calls with mmio accessors fixes the problem.

Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 2964db0f5904 ("m68k: Mac DP8390 update")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/8390/mac8390.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/8390/mac8390.c b/drivers/net/ethernet/8390/mac8390.c
index 342ae08ec3c2..d60a86aa8aa8 100644
--- a/drivers/net/ethernet/8390/mac8390.c
+++ b/drivers/net/ethernet/8390/mac8390.c
@@ -153,8 +153,6 @@ static void dayna_block_input(struct net_device *dev, int count,
 static void dayna_block_output(struct net_device *dev, int count,
 			       const unsigned char *buf, int start_page);
 
-#define memcmp_withio(a, b, c)	memcmp((a), (void *)(b), (c))
-
 /* Slow Sane (16-bit chunk memory read/write) Cabletron uses this */
 static void slow_sane_get_8390_hdr(struct net_device *dev,
 				   struct e8390_pkt_hdr *hdr, int ring_page);
@@ -233,19 +231,26 @@ static enum mac8390_type mac8390_ident(struct nubus_rsrc *fres)
 
 static enum mac8390_access mac8390_testio(unsigned long membase)
 {
-	unsigned long outdata = 0xA5A0B5B0;
-	unsigned long indata =  0x00000000;
+	u32 outdata = 0xA5A0B5B0;
+	u32 indata = 0;
+
 	/* Try writing 32 bits */
-	memcpy_toio((void __iomem *)membase, &outdata, 4);
-	/* Now compare them */
-	if (memcmp_withio(&outdata, membase, 4) == 0)
+	nubus_writel(outdata, membase);
+	/* Now read it back */
+	indata = nubus_readl(membase);
+	if (outdata == indata)
 		return ACCESS_32;
+
+	outdata = 0xC5C0D5D0;
+	indata = 0;
+
 	/* Write 16 bit output */
 	word_memcpy_tocard(membase, &outdata, 4);
 	/* Now read it back */
 	word_memcpy_fromcard(&indata, membase, 4);
 	if (outdata == indata)
 		return ACCESS_16;
+
 	return ACCESS_UNKNOWN;
 }
 
-- 
2.19.2

