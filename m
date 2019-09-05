Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F78BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACA2206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403992AbfIETuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:50:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732721AbfIETt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 581453082E03;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BC1360C18;
        Thu,  5 Sep 2019 19:49:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BD853220CEE; Thu,  5 Sep 2019 15:49:17 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 01/18] virtiofs: Remove request from processing list before calling end
Date:   Thu,  5 Sep 2019 15:48:42 -0400
Message-Id: <20190905194859.16219-2-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 05 Sep 2019 19:49:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In error path we are calling fuse_request_end() but we need to clear
FR_SENT bit as well as remove request from processing queue. Otherwise
fuse_request_end() triggers a warning as well as other issues show up.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 197e79e536f9..a708ccb65662 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -826,6 +826,10 @@ __releases(fiq->waitq.lock)
 		}
 		req->out.h.error = ret;
 		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
+		spin_lock(&fpq->lock);
+		clear_bit(FR_SENT, &req->flags);
+		list_del_init(&req->list);
+		spin_unlock(&fpq->lock);
 		fuse_request_end(fc, req);
 		return;
 	}
-- 
2.20.1

