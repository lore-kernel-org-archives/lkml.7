Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6E9C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0BE20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfGJR7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:59:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfGJR7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83E8330C1D17;
        Wed, 10 Jul 2019 17:59:16 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-55.sin2.redhat.com [10.67.116.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCDAA60148;
        Wed, 10 Jul 2019 17:59:03 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     virtualization@lists.linux-foundation.org, dan.j.williams@intel.com
Cc:     yuval.shaia@oracle.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com, mst@redhat.com,
        lcapitulino@redhat.com, pagupta@redhat.com
Subject: [PATCH v2] virtio_pmem: fix sparse warning
Date:   Wed, 10 Jul 2019 23:28:32 +0530
Message-Id: <20190710175832.17252-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 10 Jul 2019 17:59:16 +0000 (UTC)
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

 include/uapi/linux/virtio_pmem.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
index efcd72f2d20d..7a7435281362 100644
--- a/include/uapi/linux/virtio_pmem.h
+++ b/include/uapi/linux/virtio_pmem.h
@@ -10,7 +10,7 @@
 #ifndef _UAPI_LINUX_VIRTIO_PMEM_H
 #define _UAPI_LINUX_VIRTIO_PMEM_H
 
-#include <linux/types.h>
+#include <linux/virtio_types.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 
@@ -23,12 +23,12 @@ struct virtio_pmem_config {
 
 struct virtio_pmem_resp {
 	/* Host return status corresponding to flush request */
-	__u32 ret;
+	__virtio32 ret;
 };
 
 struct virtio_pmem_req {
 	/* command type */
-	__u32 type;
+	__virtio32 type;
 };
 
 #endif
-- 
2.20.1

