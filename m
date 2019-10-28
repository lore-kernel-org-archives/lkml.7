Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBDBCA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C0E20679
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WoVLRJRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbfJ1HEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:04:51 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.142]:12027 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732101AbfJ1HEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:04:50 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 79D364013
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 02:04:49 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Oz57iQARaVUVYOz57i1wGR; Mon, 28 Oct 2019 02:04:49 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cc1Lq/1I6uaUptz7nqvA6hsrq7d4wgFlwqeS4oYmYzU=; b=WoVLRJRJ59aEd0sJv0mgkAnfA6
        ZwEXpix02KGKjEbIw+HFzZ4aiMfvGWbufEN5SopsynMu7MJPd5GpQW6fNuuYtWAmfY+PCptigBnoi
        HJmG4SsWFG4lsAg2cJE0v3UWQOJ2xyUtGnJMIqQOXmBNDO8n+662Yxg8MGnuQxq8DPLn29U1ttsN8
        C/ErRTaDE1Uv4APq0v0LvoX8voeiR/YCsggjKYKrFbRwoQoio6edcrjnRgmH58lr02y+2PzFcWScl
        Kenk96P6DgVuCtjE7REdkTLemeGS8AWPVkIZvaNBp2/6p5yDjyBJD61/zID6Dha8Vl5NSEeg98R0a
        r6TuMI0g==;
Received: from [187.192.2.30] (port=58482 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iOz56-0046Kp-7m; Mon, 28 Oct 2019 02:04:48 -0500
Date:   Mon, 28 Oct 2019 02:04:47 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Egor Pomozov <epomozov@marvell.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergey Samoilenko <sergey.samoilenko@aquantia.com>,
        Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] net: aquantia: fix error handling in aq_ptp_poll
Message-ID: <20191028070447.GA3659@embeddedor>
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
X-Source-IP: 187.192.2.30
X-Source-L: No
X-Exim-ID: 1iOz56-0046Kp-7m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.2.30]:58482
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix currenty ignored returned error by properly checking *err* after
calling aq_nic->aq_hw_ops->hw_ring_hwts_rx_fill().

Addresses-Coverity-ID: 1487357 ("Unused value")
Fixes: 04a1839950d9 ("net: aquantia: implement data PTP datapath")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 3ec08415e53e..92b666f7d242 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -678,6 +678,8 @@ static int aq_ptp_poll(struct napi_struct *napi, int budget)
 
 		err = aq_nic->aq_hw_ops->hw_ring_hwts_rx_fill(aq_nic->aq_hw,
 							      &aq_ptp->hwts_rx);
+		if (err < 0)
+			goto err_exit;
 
 		was_cleaned = true;
 	}
-- 
2.23.0

