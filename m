Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2778DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE471206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfGaLML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:12:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfGaLML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:12:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 698D73B71F;
        Wed, 31 Jul 2019 11:12:11 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (unknown [10.65.16.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1EAC600D1;
        Wed, 31 Jul 2019 11:12:08 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     dan.j.williams@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        keith.busch@intel.com, ira.weiny@intel.com, pagupta@redhat.com
Subject: [PATCH] libnvdimm: change disk name of virtio pmem disk
Date:   Wed, 31 Jul 2019 16:42:07 +0530
Message-Id: <20190731111207.12836-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 31 Jul 2019 11:12:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds prefix 'v' in disk name for virtio pmem.
This differentiates virtio-pmem disks from the pmem disks.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/nvdimm/namespace_devs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index a16e52251a30..8e5d29266fb0 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -182,8 +182,12 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		char *name)
 {
 	struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
+	const char *prefix = "";
 	const char *suffix = NULL;
 
+	if (!is_nvdimm_sync(nd_region))
+		prefix = "v";
+
 	if (ndns->claim && is_nd_btt(ndns->claim))
 		suffix = "s";
 
@@ -201,7 +205,7 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 			sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
 					suffix ? suffix : "");
 		else
-			sprintf(name, "pmem%d%s", nd_region->id,
+			sprintf(name, "%spmem%d%s", prefix, nd_region->id,
 					suffix ? suffix : "");
 	} else if (is_namespace_blk(&ndns->dev)) {
 		struct nd_namespace_blk *nsblk;
-- 
2.20.1

