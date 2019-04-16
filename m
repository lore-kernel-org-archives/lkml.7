Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63571C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B85B2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfDPKr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:47:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfDPKr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:47:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B531A368B3;
        Tue, 16 Apr 2019 10:47:56 +0000 (UTC)
Received: from localhost (ovpn-117-202.ams2.redhat.com [10.36.117.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD1901001E8C;
        Tue, 16 Apr 2019 10:47:49 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     kvm@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] vhost/scsi: drop unnecessary smp_mb__after_atomic()
Date:   Tue, 16 Apr 2019 11:47:48 +0100
Message-Id: <20190416104748.26942-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 16 Apr 2019 10:47:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vhost_scsi.ko code used several atomic variables at one point.
Later they were dropped or converted to regular ints protected by a
mutex.

The commit that made these changes left an unused smp_mb__after_atomic()
in vhost_scsi_set_endpoint().  It was previously used after incrementing
vhost_scsi->vhost_ref_cnt but this field has been dropped:

  -     atomic_inc(&vs->vhost_ref_cnt);
        smp_mb__after_atomic_inc();

Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Fixes: 101998f6fcd680 ("tcm_vhost: Post-merge review changes requested by MST")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 618fb6461017..c090d177bd75 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1443,7 +1443,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 			tpg->tv_tpg_vhost_count++;
 			tpg->vhost_scsi = vs;
 			vs_tpg[tpg->tport_tpgt] = tpg;
-			smp_mb__after_atomic();
 			match = true;
 		}
 		mutex_unlock(&tpg->tv_tpg_mutex);
-- 
2.20.1

