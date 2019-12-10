Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69B9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EF42077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="kBJPEpmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfLJAPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:15:49 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:57229 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLJAPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:15:49 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8178C2304C;
        Tue, 10 Dec 2019 01:15:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575936947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wSUPiehHumsTgPhza1Uxhk4PKH7aRjIwy6oBQhIf3xI=;
        b=kBJPEpmEMHRyIKAhEIzhJjZNk3ThFHeYyYTCnm+NH8t4JUj9kaCcJc/NkJgUVi1GtV0o/D
        Xgx+q/Mi7yzMGI/NYd0XfyAcSNO1xW2O3H9CoWf3B5Rw2IvHN90IxV2XSki1E3SYEcyQ1g
        Tz4NJN0wbam9mJW5UBo6IxdgNrVKuLM=
From:   Michael Walle <michael@walle.cc>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH net-next] enetc: add software timestamping
Date:   Tue, 10 Dec 2019 01:15:37 +0100
Message-Id: <20191210001537.25630-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 8178C2304C
X-Spamd-Result: default: False [4.90 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.657];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a software TX timestamp and add it to the ethtool query
interface.

skb_tx_timestamp() is also needed if one would like to use PHY
timestamping.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/ethernet/freescale/enetc/enetc.c         | 2 ++
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 17739906c966..2ee4a2cd4780 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -227,6 +227,8 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 	enetc_bdr_idx_inc(tx_ring, &i);
 	tx_ring->next_to_use = i;
 
+	skb_tx_timestamp(skb);
+
 	/* let H/W know BD ring has been updated */
 	enetc_wr_reg(tx_ring->tpir, i); /* includes wmb() */
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 880a8ed8bb47..301ee0dde02d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -579,6 +579,7 @@ static int enetc_get_ts_info(struct net_device *ndev,
 			   (1 << HWTSTAMP_FILTER_ALL);
 #else
 	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
+				SOF_TIMESTAMPING_TX_SOFTWARE |
 				SOF_TIMESTAMPING_SOFTWARE;
 #endif
 	return 0;
-- 
2.20.1

