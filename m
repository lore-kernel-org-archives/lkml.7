Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB728C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80FC20863
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482917;
	bh=RL3VTwoYNaMQ2dxJNaxQX5/1piSs+VnP9B2rKEvymJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pcNlm8/UlzIaHICWjK0+btlZMWahiri4Z+gwaSe/3LeloiGrrKlYY+Ph3RhQ7WdFn
	 d1txyLoqVqX9zC/isXqdSz1Ws+2UJgR8/lydHSpschCjaCIYqZsv4hDXLLvMOsSg7W
	 aQITvlSRnqIXy0sutfgPdHl+XoTDigElqz5UYgUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfLDSIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:08:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730904AbfLDSI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:08:26 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A5642084B;
        Wed,  4 Dec 2019 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482905;
        bh=RL3VTwoYNaMQ2dxJNaxQX5/1piSs+VnP9B2rKEvymJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoIUKhabt5k1QnXK38QANDBOBiGqU59MMBLLJZtm9f0+XpGOuHx5bU9r98VIpHy5g
         p1kgob7ZCQ8ULxC8u8PwaKdbAyFgGVTmAiYQ7L2zZZwS2y2QTCXooCKqNLU3kT9ikV
         B9RX9TFcGFDmQH5A3/BAYkXZyKuFeladmb4zSSDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harini Katakam <harini.katakam@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.14 180/209] net: macb: Fix SUBNS increment and increase resolution
Date:   Wed,  4 Dec 2019 18:56:32 +0100
Message-Id: <20191204175335.881089154@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
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
@@ -457,7 +457,11 @@
 
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
 


