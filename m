Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2872BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23F42053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413967;
	bh=CnEdM3U0NbENBr3wv6tYegfDKbkCd9CqgvhugeRso1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j3FSs+n2So6Agv9Qb77SBGeb5ZTruyAyf51gKkGbQkoKW0nwrRPBDVVy6fn6JsS9t
	 sH0IlNd74drhMqPAte/t6ybNWnpXxwoR5fHJoiDQq2HjvHiwHiXVJsU+BVhIKFpNvK
	 8TzHa7HvEP7CTPC+e6UX6s7aLn+DmW5prihbc888=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfLCW70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbfLCW7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:59:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAFEA20674;
        Tue,  3 Dec 2019 22:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413961;
        bh=CnEdM3U0NbENBr3wv6tYegfDKbkCd9CqgvhugeRso1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ylrokXlZucFlFg9ok6iEzuupZXxDR3oVEVyicjtDibLRl3IGGUkiiYJmxfJORB5I
         1rux4M0emdIO+ykkYwnSn+KclKBKMnqtj76l1Hj3hSLSPKv2o7iwsFJju+6HBhOGNy
         QejTYaoZ5TWPI6mq7OkA8Rd8mOzYRnPyN5ctDy5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harini Katakam <harini.katakam@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 296/321] net: macb: Fix SUBNS increment and increase resolution
Date:   Tue,  3 Dec 2019 23:36:02 +0100
Message-Id: <20191203223442.552220690@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>

commit 7ad342bc58cc5197cd2f12a3c30b3949528c6d83 upstream.

The subns increment register has 24 bits as follows:
RegBit[15:0] = Subns[23:8]; RegBit[31:24] = Subns[7:0]

Fix the same in the driver and increase sub ns resolution to the
best capable, 24 bits. This should be the case on all GEM versions
that this PTP driver supports.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/cadence/macb.h     |    6 +++++-
 drivers/net/ethernet/cadence/macb_ptp.c |    5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -499,7 +499,11 @@
 
 /* Bitfields in TISUBN */
 #define GEM_SUBNSINCR_OFFSET			0
-#define GEM_SUBNSINCR_SIZE			16
+#define GEM_SUBNSINCRL_OFFSET			24
+#define GEM_SUBNSINCRL_SIZE			8
+#define GEM_SUBNSINCRH_OFFSET			0
+#define GEM_SUBNSINCRH_SIZE			16
+#define GEM_SUBNSINCR_SIZE			24
 
 /* Bitfields in TI */
 #define GEM_NSINCR_OFFSET			0
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -115,7 +115,10 @@ static int gem_tsu_incr_set(struct macb
 	 * to take effect.
 	 */
 	spin_lock_irqsave(&bp->tsu_clk_lock, flags);
-	gem_writel(bp, TISUBN, GEM_BF(SUBNSINCR, incr_spec->sub_ns));
+	/* RegBit[15:0] = Subns[23:8]; RegBit[31:24] = Subns[7:0] */
+	gem_writel(bp, TISUBN, GEM_BF(SUBNSINCRL, incr_spec->sub_ns) |
+		   GEM_BF(SUBNSINCRH, (incr_spec->sub_ns >>
+			  GEM_SUBNSINCRL_SIZE)));
 	gem_writel(bp, TI, GEM_BF(NSINCR, incr_spec->ns));
 	spin_unlock_irqrestore(&bp->tsu_clk_lock, flags);
 


