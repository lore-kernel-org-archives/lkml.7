Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE372C3436B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BBC24755
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="q+yFsIPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLMNUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:20:51 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:41412 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfLMNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576243250; x=1607779250;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tFySCLGtPwSbxUYEux7/p0Qq1N3sbGfPAhYwtPWA8rI=;
  b=q+yFsIPL9vjV7Vk8SVEayXkaH+KzTUeReqwRvOFeNS/hB2HWIKZ12k1U
   iu1yQG7MkOIFrMQmSTlWEqsHAO+ihcF6cijHLC6QLcfTd/1Vwp1+M4jEv
   VNUV/SMdSTB+K8S1R80jvVX4TjM1kzeXAU1RpYgXxqdNuDQTsAqkXCaD/
   8=;
IronPort-SDR: O0jhjvelAXfwKAOT+PVxdrI3ucPHYGBWbSCbkKO9chIdq5QSf3fZxfvnAusUejisOvPnXz7Kg1
 G9cNGYjF/sKQ==
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="7497894"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 13 Dec 2019 13:20:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 181C5A1B8E;
        Fri, 13 Dec 2019 13:20:47 +0000 (UTC)
Received: from EX13D32EUB002.ant.amazon.com (10.43.166.114) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Dec 2019 13:20:46 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D32EUB002.ant.amazon.com (10.43.166.114) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Dec 2019 13:20:45 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 13 Dec 2019 13:20:43 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Juergen Gross <jgross@suse.com>,
        "Jakub Kicinski" <jakub.kicinski@netronome.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH net v2] xen-netback: avoid race that can lead to NULL pointer dereference
Date:   Fri, 13 Dec 2019 13:20:40 +0000
Message-ID: <20191213132040.21446-1-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function xenvif_disconnect_queue(), the value of queue->rx_irq is
zeroed *before* queue->task is stopped. Unfortunately that task may call
notify_remote_via_irq(queue->rx_irq) and calling that function with a
zero value results in a NULL pointer dereference in evtchn_from_irq().

This patch simply re-orders things, stopping all tasks before zero-ing the
irq values, thereby avoiding the possibility of the race.

Fixes: 2ac061ce97f4 ("xen/netback: cleanup init and deinit code")
Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Juergen Gross <jgross@suse.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>

v2:
 - Add 'Fixes' tag and re-work commit comment
---
 drivers/net/xen-netback/interface.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 68dd7bb07ca6..f15ba3de6195 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -628,18 +628,6 @@ int xenvif_connect_ctrl(struct xenvif *vif, grant_ref_t ring_ref,
 
 static void xenvif_disconnect_queue(struct xenvif_queue *queue)
 {
-	if (queue->tx_irq) {
-		unbind_from_irqhandler(queue->tx_irq, queue);
-		if (queue->tx_irq == queue->rx_irq)
-			queue->rx_irq = 0;
-		queue->tx_irq = 0;
-	}
-
-	if (queue->rx_irq) {
-		unbind_from_irqhandler(queue->rx_irq, queue);
-		queue->rx_irq = 0;
-	}
-
 	if (queue->task) {
 		kthread_stop(queue->task);
 		queue->task = NULL;
@@ -655,6 +643,18 @@ static void xenvif_disconnect_queue(struct xenvif_queue *queue)
 		queue->napi.poll = NULL;
 	}
 
+	if (queue->tx_irq) {
+		unbind_from_irqhandler(queue->tx_irq, queue);
+		if (queue->tx_irq == queue->rx_irq)
+			queue->rx_irq = 0;
+		queue->tx_irq = 0;
+	}
+
+	if (queue->rx_irq) {
+		unbind_from_irqhandler(queue->rx_irq, queue);
+		queue->rx_irq = 0;
+	}
+
 	xenvif_unmap_frontend_data_rings(queue);
 }
 
-- 
2.20.1

