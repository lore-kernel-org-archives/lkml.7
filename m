Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3696C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B02217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfCSOmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfCSOmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:42:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8945C30821FA;
        Tue, 19 Mar 2019 14:42:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2511A5C28C;
        Tue, 19 Mar 2019 14:42:01 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-nvme@lists.infradead.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney " <paulmck@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Fam Zheng <fam@euphon.net>, Amnon Ilan <ailan@redhat.com>,
        John Ferlan <jferlan@redhat.com>
Subject: [PATCH 3/9] nvme/core: add NVME_CTRL_SUSPENDED controller state
Date:   Tue, 19 Mar 2019 16:41:10 +0200
Message-Id: <20190319144116.400-4-mlevitsk@redhat.com>
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 19 Mar 2019 14:42:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This state will be used by a controller that is going to
suspended state, and will later be used by mdev
framework to detect this and flush its queues

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/nvme/host/core.c | 15 +++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a9dd68c0f4f..cf9de026cb93 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -320,6 +320,19 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
+		case NVME_CTRL_CONNECTING:
+		case NVME_CTRL_SUSPENDED:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
+	case NVME_CTRL_SUSPENDED:
+		switch (old_state) {
+		case NVME_CTRL_NEW:
+		case NVME_CTRL_LIVE:
+		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			/* FALLTHRU */
@@ -332,6 +345,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_ADMIN_ONLY:
+		case NVME_CTRL_SUSPENDED:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -354,6 +368,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_ADMIN_ONLY:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
+		case NVME_CTRL_SUSPENDED:
 			changed = true;
 			/* FALLTHRU */
 		default:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c4a1bb41abf0..9320b0a87d79 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -142,6 +142,7 @@ static inline u16 nvme_req_qid(struct request *req)
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
+	NVME_CTRL_SUSPENDED,
 	NVME_CTRL_ADMIN_ONLY,    /* Only admin queue live */
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_CONNECTING,
-- 
2.17.2

