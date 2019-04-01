Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10551C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C3721929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138363;
	bh=jZhqP+ix/87xNaXZ5059xypc/gSwhmt9jsyczVVufTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1SLdIzOwciKaaSrgjVz8GCn5FpnXVukpuvL+anyU6wabigd7gC4G8wDLvVWcJEdvh
	 Sx4AFX4Cf/l0LQoZuVIg4+Ojsb/rAe5TxLRgg6NnSGR2FpHqAgYv/+VRyDgMwAXPLl
	 U0wdvK3x4RGU0gaXSTM++dyqTixcHW1+KSruDbqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfDARGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbfDARGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:06:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1161221924;
        Mon,  1 Apr 2019 17:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138360;
        bh=jZhqP+ix/87xNaXZ5059xypc/gSwhmt9jsyczVVufTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOFJdUU8k8zaVnY0SVc+hSJRfryX+tmYhBmXhKizDizgO3IqwEMQFZLsFgCosU0SG
         K0FYdglB2+X491ELzT8BLwFcp/WOxFm0LizQ7g9TTdvVewoc9j8x55mzdiddGMz1+W
         TeSN0A6VcHRKhSMjQfdXqsH/Upt7c248LPJDCS00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stan Johnson <userm57@yahoo.com>
Subject: [PATCH 5.0 008/146] mac8390: Fix mmio access size probe
Date:   Mon,  1 Apr 2019 19:00:20 +0200
Message-Id: <20190401170049.120012300@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit bb9e5c5bcd76f4474eac3baf643d7a39f7bac7bb ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/8390/mac8390.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/8390/mac8390.c
+++ b/drivers/net/ethernet/8390/mac8390.c
@@ -153,8 +153,6 @@ static void dayna_block_input(struct net
 static void dayna_block_output(struct net_device *dev, int count,
 			       const unsigned char *buf, int start_page);
 
-#define memcmp_withio(a, b, c)	memcmp((a), (void *)(b), (c))
-
 /* Slow Sane (16-bit chunk memory read/write) Cabletron uses this */
 static void slow_sane_get_8390_hdr(struct net_device *dev,
 				   struct e8390_pkt_hdr *hdr, int ring_page);
@@ -233,19 +231,26 @@ static enum mac8390_type mac8390_ident(s
 
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
 


