Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D84C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F060520828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfCRG4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:56:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbfCRG4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 02:56:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E47DF308A959;
        Mon, 18 Mar 2019 06:56:13 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA93660FAB;
        Mon, 18 Mar 2019 06:56:07 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH] virtio_net: remove hcpu from virtnet_clean_affinity
Date:   Mon, 18 Mar 2019 14:56:06 +0800
Message-Id: <20190318065606.17100-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 18 Mar 2019 06:56:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable is never used.

CC: Michael S. Tsirkin <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: virtualization@lists.linux-foundation.org
CC: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7eb38ea9ba56..1b03c4b6ebff 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1925,7 +1925,7 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
 	return 0;
 }
 
-static void virtnet_clean_affinity(struct virtnet_info *vi, long hcpu)
+static void virtnet_clean_affinity(struct virtnet_info *vi)
 {
 	int i;
 
@@ -1949,7 +1949,7 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
 	int stride;
 
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
-		virtnet_clean_affinity(vi, -1);
+		virtnet_clean_affinity(vi);
 		return;
 	}
 
@@ -1999,7 +1999,7 @@ static int virtnet_cpu_down_prep(unsigned int cpu, struct hlist_node *node)
 	struct virtnet_info *vi = hlist_entry_safe(node, struct virtnet_info,
 						   node);
 
-	virtnet_clean_affinity(vi, cpu);
+	virtnet_clean_affinity(vi);
 	return 0;
 }
 
@@ -2735,7 +2735,7 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
 {
 	struct virtio_device *vdev = vi->vdev;
 
-	virtnet_clean_affinity(vi, -1);
+	virtnet_clean_affinity(vi);
 
 	vdev->config->del_vqs(vdev);
 
-- 
2.17.1

