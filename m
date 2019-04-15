Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A83C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3210D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aZ+v0R1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfDOPdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:33:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47042 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfDOPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:33:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3FFXVCt019996;
        Mon, 15 Apr 2019 10:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555342411;
        bh=o3AHcBA70TtrgcXTvaec3S4QIqbkcPzZypbqJaXtdTU=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=aZ+v0R1YGYrGfmqrVLrnH86aoPTqGDk0uA2W28iTmxk9RQdiA5AEXALaTb/ycAX8U
         CpqqCkZM1nbU4kYOnQkOGp9DO/LoP5C1z1iCFv/hCFz2++ZrJJVvl1okzT9aR44Rd3
         IX4EOEYYwX2JvbQPAebJE/Ewy1P1CwhYsXhbTMpA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3FFXV1p090596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Apr 2019 10:33:31 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 15
 Apr 2019 10:33:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 15 Apr 2019 10:33:30 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3FFXTjY041063;
        Mon, 15 Apr 2019 10:33:30 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <arvid.brodin@alten.se>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next PATCH v2 3/3] net: hsr: add tx stats for master interface
Date:   Mon, 15 Apr 2019 11:36:03 -0400
Message-ID: <20190415153603.23110-4-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190415153603.23110-1-m-karicheri2@ti.com>
References: <20190415153603.23110-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tx stats to hsr interface. Without this
ifconfig for hsr interface doesn't show tx packet stats.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_forward.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0cac992192d0..ddd9605bad04 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -359,6 +359,13 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 		goto out_drop;
 	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
 	hsr_forward_do(&frame);
+	/* Gets called for ingress frames as well as egress from master port.
+	 * So check and increment stats for master port only here.
+	 */
+	if (port->type == HSR_PT_MASTER) {
+		port->dev->stats.tx_packets++;
+		port->dev->stats.tx_bytes += skb->len;
+	}
 
 	if (frame.skb_hsr)
 		kfree_skb(frame.skb_hsr);
-- 
2.17.0

