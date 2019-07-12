Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB5C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 05:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB9E20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 05:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGLFQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 01:16:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfGLFQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 01:16:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92CE2308792E;
        Fri, 12 Jul 2019 05:16:24 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-115.sin2.redhat.com [10.67.116.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3CC85DE6E;
        Fri, 12 Jul 2019 05:16:14 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     dan.j.williams@intel.com
Cc:     mst@redhat.com, lcapitulino@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-nvdimm@lists.01.org, cohuck@redhat.com,
        yuval.shaia@oracle.com, linux-kernel@vger.kernel.org,
        pagupta@redhat.com
Subject: [PATCH v3] virtio_pmem: fix sparse warning
Date:   Fri, 12 Jul 2019 10:46:10 +0530
Message-Id: <20190712051610.15478-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 12 Jul 2019 05:16:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below sparse warning related to __virtio
type in virtio pmem driver. This is reported by Intel test
bot on linux-next tree.

nd_virtio.c:56:28: warning: incorrect type in assignment
                                (different base types)
nd_virtio.c:56:28:    expected unsigned int [unsigned] [usertype] type
nd_virtio.c:56:28:    got restricted __virtio32
nd_virtio.c:93:59: warning: incorrect type in argument 2
                                (different base types)
nd_virtio.c:93:59:    expected restricted __virtio32 [usertype] val
nd_virtio.c:93:59:    got unsigned int [unsigned] [usertype] ret

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
This fixes a warning, so submitting it as a separate
patch on top of virtio pmem series.

v2-> v3
 Use __le for req/resp fields - Michael

 drivers/nvdimm/nd_virtio.c       | 4 ++--
 include/uapi/linux/virtio_pmem.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 8645275c08c2..10351d5b49fa 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -53,7 +53,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	init_waitqueue_head(&req_data->host_acked);
 	init_waitqueue_head(&req_data->wq_buf);
 	INIT_LIST_HEAD(&req_data->list);
-	req_data->req.type = cpu_to_virtio32(vdev, VIRTIO_PMEM_REQ_TYPE_FLUSH);
+	req_data->req.type = cpu_to_le32(VIRTIO_PMEM_REQ_TYPE_FLUSH);
 	sg_init_one(&sg, &req_data->req, sizeof(req_data->req));
 	sgs[0] = &sg;
 	sg_init_one(&ret, &req_data->resp.ret, sizeof(req_data->resp));
@@ -90,7 +90,7 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	} else {
 		/* A host repsonse results in "host_ack" getting called */
 		wait_event(req_data->host_acked, req_data->done);
-		err = virtio32_to_cpu(vdev, req_data->resp.ret);
+		err = le32_to_cpu(req_data->resp.ret);
 	}
 
 	kfree(req_data);
diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
index efcd72f2d20d..9a63ed6d062f 100644
--- a/include/uapi/linux/virtio_pmem.h
+++ b/include/uapi/linux/virtio_pmem.h
@@ -23,12 +23,12 @@ struct virtio_pmem_config {
 
 struct virtio_pmem_resp {
 	/* Host return status corresponding to flush request */
-	__u32 ret;
+	__le32 ret;
 };
 
 struct virtio_pmem_req {
 	/* command type */
-	__u32 type;
+	__le32 type;
 };
 
 #endif
-- 
2.14.5

