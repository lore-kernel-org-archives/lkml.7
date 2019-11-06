Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06FEC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F87921848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="JympPcQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbfKFRKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:10:30 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:23347 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfKFRKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:10:30 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 12:10:29 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1144; q=dns/txt; s=iport;
  t=1573060229; x=1574269829;
  h=from:to:cc:subject:date:message-id;
  bh=i+ZmhryTW5i1S1guIxB3vbaClOwmez7utMMxBN4AE2o=;
  b=JympPcQF2YQcfGcRysvGk+/WYtSwWhi6y0EK6CnYaDdmugPqrtvuRo5J
   RLFHq3tE+/7QkhH4XQBXICYLQOV299ZKe7BGHtXWNFd4vyACp9qq88aI8
   1Vu1YX1uyRiSI2stJgs44KmR8w89sZ6S8dc5O50xTcsDfldg14+3Y1bWq
   w=;
X-IronPort-AV: E=Sophos;i="5.68,275,1569283200"; 
   d="scan'208";a="646579448"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 06 Nov 2019 17:03:24 +0000
Received: from zorba.cisco.com ([10.154.200.26])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTP id xA6H3Nch010301;
        Wed, 6 Nov 2019 17:03:23 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     Sathish Jarugumalli <sjarugum@cisco.com>,
        xe-linux-external@cisco.com, Daniel Walker <dwalker@fifo99.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: net: gianfar: Shortest frame drops at Ethernet port
Date:   Wed,  6 Nov 2019 09:03:20 -0800
Message-Id: <20191106170320.27662-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.200.26, [10.154.200.26]
X-Outbound-Node: alln-core-5.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP has provided the patch for packet drops  at ethernet port
Frames shorter than 60bytes are getting dropped at ethernetport
need to add padding for the shorter range frames to be transmit
the function "eth_skb_pad(skb" provides padding (and CRC) for
packets under 60 bytes

Signed-off-by: Sathish Jarugumalli <sjarugum@cisco.com>
Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <dwalker@fifo99.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 51ad86417cb1..047960b1c76e 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1823,6 +1823,9 @@ static netdev_tx_t gfar_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(do_tstamp))
 		fcb_len = GMAC_FCB_LEN + GMAC_TXPAL_LEN;
 
+	if (eth_skb_pad(skb))
+		return NETDEV_TX_OK;
+
 	/* make space for additional header when fcb is needed */
 	if (fcb_len && unlikely(skb_headroom(skb) < fcb_len)) {
 		struct sk_buff *skb_new;
-- 
2.17.1

