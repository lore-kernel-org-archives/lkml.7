Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FEAC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D89120726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B6QAkM6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfLJLen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:34:43 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62301 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfLJLen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575977682; x=1607513682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKPqIf9U+emKxRr0L9uELmQeeXO75kuyRnRZTLa/FT0=;
  b=B6QAkM6FGHQK+n6JqFEeRTZju5qA/KxiwVuWojs9ZS6EgCdlj8os6X3q
   3oWZe06vFo5KVf3KW9blCVq08eNXxpm6N5l5iF4xpgNVDFOmk5lRz6xgf
   OsNpom3Oydt9AAgyYyI/sOiHZ8DnCGMs1hxTlTbOpPYWg8bhFYeCClb8O
   k=;
IronPort-SDR: pAKF5MoAr76J9iO89BZo3uc8b1Jq1EE0fQSdRsliBQFEAmOwujQiv6pHuhrAy/NjYWjuvaYCSe
 xQd6Q8GGdWnQ==
X-IronPort-AV: E=Sophos;i="5.69,299,1571702400"; 
   d="scan'208";a="12635074"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Dec 2019 11:34:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 26633A192C;
        Tue, 10 Dec 2019 11:34:41 +0000 (UTC)
Received: from EX13D32EUC001.ant.amazon.com (10.43.164.159) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 11:34:13 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D32EUC001.ant.amazon.com (10.43.164.159) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 11:34:12 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 10 Dec 2019 11:34:11 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH v2 4/4] xen-blkback: support dynamic unbind/bind
Date:   Tue, 10 Dec 2019 11:33:47 +0000
Message-ID: <20191210113347.3404-5-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210113347.3404-1-pdurrant@amazon.com>
References: <20191210113347.3404-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By simply re-attaching to shared rings during connect_ring() rather than
assuming they are freshly allocated (i.e assuming the counters are zero)
it is possible for vbd instances to be unbound and re-bound from and to
(respectively) a running guest.

This has been tested by running:

while true;
  do fio --name=randwrite --ioengine=libaio --iodepth=16 \
  --rw=randwrite --bs=4k --direct=1 --size=1G --verify=crc32;
  done

in a PV guest whilst running:

while true;
  do echo vbd-$DOMID-$VBD >unbind;
  echo unbound;
  sleep 5;
  echo vbd-$DOMID-$VBD >bind;
  echo bound;
  sleep 3;
  done

in dom0 from /sys/bus/xen-backend/drivers/vbd to continuously unbind and
re-bind its system disk image.

This is a highly useful feature for a backend module as it allows it to be
unloaded and re-loaded (i.e. updated) without requiring domUs to be halted.
This was also tested by running:

while true;
  do echo vbd-$DOMID-$VBD >unbind;
  echo unbound;
  sleep 5;
  rmmod xen-blkback;
  echo unloaded;
  sleep 1;
  modprobe xen-blkback;
  echo bound;
  cd $(pwd);
  sleep 3;
  done

in dom0 whilst running the same loop as above in the (single) PV guest.

Some (less stressful) testing has also been done using a Windows HVM guest
with the latest 9.0 PV drivers installed.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

v2:
 - Apply a sanity check to the value of rsp_prod and fail the re-attach
   if it is implausible
 - Set allow_rebind to prevent ring from being closed on unbind
 - Update test workload from dd to fio (with verification)
---
 drivers/block/xen-blkback/xenbus.c | 59 +++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index e8c5c54e1d26..13d09630b237 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -181,6 +181,8 @@ static int xen_blkif_map(struct xen_blkif_ring *ring, grant_ref_t *gref,
 {
 	int err;
 	struct xen_blkif *blkif = ring->blkif;
+	struct blkif_common_sring *sring_common;
+	RING_IDX rsp_prod, req_prod;
 
 	/* Already connected through? */
 	if (ring->irq)
@@ -191,46 +193,66 @@ static int xen_blkif_map(struct xen_blkif_ring *ring, grant_ref_t *gref,
 	if (err < 0)
 		return err;
 
+	sring_common = (struct blkif_common_sring *)ring->blk_ring;
+	rsp_prod = READ_ONCE(sring_common->rsp_prod);
+	req_prod = READ_ONCE(sring_common->req_prod);
+
 	switch (blkif->blk_protocol) {
 	case BLKIF_PROTOCOL_NATIVE:
 	{
-		struct blkif_sring *sring;
-		sring = (struct blkif_sring *)ring->blk_ring;
-		BACK_RING_INIT(&ring->blk_rings.native, sring,
-			       XEN_PAGE_SIZE * nr_grefs);
+		struct blkif_sring *sring_native =
+			(struct blkif_sring *)ring->blk_ring;
+		unsigned int size = __RING_SIZE(sring_native,
+						XEN_PAGE_SIZE * nr_grefs);
+
+		BACK_RING_ATTACH(&ring->blk_rings.native, sring_native,
+				 rsp_prod, XEN_PAGE_SIZE * nr_grefs);
+		err = (req_prod - rsp_prod > size) ? -EIO : 0;
 		break;
 	}
 	case BLKIF_PROTOCOL_X86_32:
 	{
-		struct blkif_x86_32_sring *sring_x86_32;
-		sring_x86_32 = (struct blkif_x86_32_sring *)ring->blk_ring;
-		BACK_RING_INIT(&ring->blk_rings.x86_32, sring_x86_32,
-			       XEN_PAGE_SIZE * nr_grefs);
+		struct blkif_x86_32_sring *sring_x86_32 =
+			(struct blkif_x86_32_sring *)ring->blk_ring;
+		unsigned int size = __RING_SIZE(sring_x86_32,
+						XEN_PAGE_SIZE * nr_grefs);
+
+		BACK_RING_ATTACH(&ring->blk_rings.x86_32, sring_x86_32,
+				 rsp_prod, XEN_PAGE_SIZE * nr_grefs);
+		err = (req_prod - rsp_prod > size) ? -EIO : 0;
 		break;
 	}
 	case BLKIF_PROTOCOL_X86_64:
 	{
-		struct blkif_x86_64_sring *sring_x86_64;
-		sring_x86_64 = (struct blkif_x86_64_sring *)ring->blk_ring;
-		BACK_RING_INIT(&ring->blk_rings.x86_64, sring_x86_64,
-			       XEN_PAGE_SIZE * nr_grefs);
+		struct blkif_x86_64_sring *sring_x86_64 =
+			(struct blkif_x86_64_sring *)ring->blk_ring;
+		unsigned int size = __RING_SIZE(sring_x86_64,
+						XEN_PAGE_SIZE * nr_grefs);
+
+		BACK_RING_ATTACH(&ring->blk_rings.x86_64, sring_x86_64,
+				 rsp_prod, XEN_PAGE_SIZE * nr_grefs);
+		err = (req_prod - rsp_prod > size) ? -EIO : 0;
 		break;
 	}
 	default:
 		BUG();
 	}
+	if (err < 0)
+		goto fail;
 
 	err = bind_interdomain_evtchn_to_irqhandler(blkif->domid, evtchn,
 						    xen_blkif_be_int, 0,
 						    "blkif-backend", ring);
-	if (err < 0) {
-		xenbus_unmap_ring_vfree(blkif->be->dev, ring->blk_ring);
-		ring->blk_rings.common.sring = NULL;
-		return err;
-	}
+	if (err < 0)
+		goto fail;
 	ring->irq = err;
 
 	return 0;
+
+fail:
+	xenbus_unmap_ring_vfree(blkif->be->dev, ring->blk_ring);
+	ring->blk_rings.common.sring = NULL;
+	return err;
 }
 
 static int xen_blkif_disconnect(struct xen_blkif *blkif)
@@ -1121,7 +1143,8 @@ static struct xenbus_driver xen_blkbk_driver = {
 	.ids  = xen_blkbk_ids,
 	.probe = xen_blkbk_probe,
 	.remove = xen_blkbk_remove,
-	.otherend_changed = frontend_changed
+	.otherend_changed = frontend_changed,
+	.allow_rebind = true,
 };
 
 int xen_blkif_xenbus_init(void)
-- 
2.20.1

