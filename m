Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E0AC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23E22464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RVgbpOdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfLEOCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:02:01 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:22558 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLEOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575554519; x=1607090519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1WJZpOjGUIHVRhgcjBz3yJxjB5haQQg6kXg1z4d6ets=;
  b=RVgbpOdgiK+xSOiR47dMVbre1KMRaE2eEKkTFpLw1YeGKnqHpq2ccnmG
   4RUJvkwiv6mB5cKWf+VFQiGZRYTleuH0w2s55RIBZbnxtyQclCl0rFbAD
   X6nj8G9gKjxrKmoAdxYNlgy4Mn9dx6VWm3x/8W8Fo7ecsYugILbM94qin
   E=;
IronPort-SDR: loNKSiQNwG75LMDfydCOTefyzN9ieNk12e8ueIaZsuDiGfR+2DLVXIwfiA2ChyEQXKkm9x/Dym
 IWYCNYTcFGTg==
X-IronPort-AV: E=Sophos;i="5.69,281,1571702400"; 
   d="scan'208";a="6345518"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 05 Dec 2019 14:01:58 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id 04AB0A2A13;
        Thu,  5 Dec 2019 14:01:55 +0000 (UTC)
Received: from EX13D32EUC001.ant.amazon.com (10.43.164.159) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 14:01:46 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D32EUC001.ant.amazon.com (10.43.164.159) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 14:01:43 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 14:01:40 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH 4/4] xen-blkback: support dynamic unbind/bind
Date:   Thu, 5 Dec 2019 14:01:23 +0000
Message-ID: <20191205140123.3817-5-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205140123.3817-1-pdurrant@amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
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

while true; do dd if=/dev/urandom of=test.img bs=1M count=1024; done

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
---
 drivers/block/xen-blkback/xenbus.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index e8c5c54e1d26..0b82740c4a9d 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -196,24 +196,24 @@ static int xen_blkif_map(struct xen_blkif_ring *ring, grant_ref_t *gref,
 	{
 		struct blkif_sring *sring;
 		sring = (struct blkif_sring *)ring->blk_ring;
-		BACK_RING_INIT(&ring->blk_rings.native, sring,
-			       XEN_PAGE_SIZE * nr_grefs);
+		BACK_RING_ATTACH(&ring->blk_rings.native, sring,
+				 XEN_PAGE_SIZE * nr_grefs);
 		break;
 	}
 	case BLKIF_PROTOCOL_X86_32:
 	{
 		struct blkif_x86_32_sring *sring_x86_32;
 		sring_x86_32 = (struct blkif_x86_32_sring *)ring->blk_ring;
-		BACK_RING_INIT(&ring->blk_rings.x86_32, sring_x86_32,
-			       XEN_PAGE_SIZE * nr_grefs);
+		BACK_RING_ATTACH(&ring->blk_rings.x86_32, sring_x86_32,
+				 XEN_PAGE_SIZE * nr_grefs);
 		break;
 	}
 	case BLKIF_PROTOCOL_X86_64:
 	{
 		struct blkif_x86_64_sring *sring_x86_64;
 		sring_x86_64 = (struct blkif_x86_64_sring *)ring->blk_ring;
-		BACK_RING_INIT(&ring->blk_rings.x86_64, sring_x86_64,
-			       XEN_PAGE_SIZE * nr_grefs);
+		BACK_RING_ATTACH(&ring->blk_rings.x86_64, sring_x86_64,
+				 XEN_PAGE_SIZE * nr_grefs);
 		break;
 	}
 	default:
-- 
2.20.1

