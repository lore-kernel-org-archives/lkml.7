Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1566BC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A3522CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619810;
	bh=KVlaFagqVKPSKJMKy/m2KeR5io/rpt98DlbyUuvRHKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AfdYo0K/w8YCFo8u8ZGu1LoACkhvAVY4mDqPgHu+ZNghy5gBpSrh3Xq+OZPmVxZgk
	 2Ixe+0HTKFU7nNPYFq9WjIC5Rd4NNUO0OEjxfFVooOYGi7el1UZ0H71jfGm8W47DJq
	 0KDm3ZBPjA5hAZV2ipZb303Skh3Qzc5IgGV6Zt0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbfIDR4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387711AbfIDR4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:56:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5F622CF5;
        Wed,  4 Sep 2019 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619807;
        bh=KVlaFagqVKPSKJMKy/m2KeR5io/rpt98DlbyUuvRHKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1iJZ3pv7Ac54kl257zpEr7hDMy7alRxln7PG9GNHnLH+tIrpx+QnkKUnQZFuMZWv
         HIvm2pb+D4HBmCoHXk11GRov6KR5kDLvdqgIGC+bGuiYCUIHnlE4bki4MImtBsIOWQ
         dR5bvtPv35FvLgToSIU9/LHu3kK1lHAl95geh6X0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 41/77] vhost: scsi: add weight support
Date:   Wed,  4 Sep 2019 19:53:28 +0200
Message-Id: <20190904175307.385317204@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.317468926@linuxfoundation.org>
References: <20190904175303.317468926@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit c1ea02f15ab5efb3e93fc3144d895410bf79fcf2 upstream.

This patch will check the weight and exit the loop if we exceeds the
weight. This is useful for preventing scsi kthread from hogging cpu
which is guest triggerable.

This addresses CVE-2019-3900.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
[bwh: Backported to 4.4:
 - Drop changes in vhost_scsi_ctl_handle_vq()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 47e659eacf17e..269cfdd2958de 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -861,7 +861,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 	u64 tag;
 	u32 exp_data_len, data_direction;
 	unsigned out, in;
-	int head, ret, prot_bytes;
+	int head, ret, prot_bytes, c = 0;
 	size_t req_size, rsp_size = sizeof(struct virtio_scsi_cmd_resp);
 	size_t out_size, in_size;
 	u16 lun;
@@ -880,7 +880,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 
 	vhost_disable_notify(&vs->dev, vq);
 
-	for (;;) {
+	do {
 		head = vhost_get_vq_desc(vq, vq->iov,
 					 ARRAY_SIZE(vq->iov), &out, &in,
 					 NULL, NULL);
@@ -1096,7 +1096,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		 */
 		INIT_WORK(&cmd->work, vhost_scsi_submission_work);
 		queue_work(vhost_scsi_workqueue, &cmd->work);
-	}
+	} while (likely(!vhost_exceeds_weight(vq, ++c, 0)));
 out:
 	mutex_unlock(&vq->mutex);
 }
-- 
2.20.1



