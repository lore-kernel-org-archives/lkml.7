Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF52C2D0C8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572F620684
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jAyfaPga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLWBlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:41:22 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55682 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfLWBlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577065280; x=1608601280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Lu5wUxicX2nqy1FtOE1ySeTvkT4l5dpgfpukGpnD/kE=;
  b=jAyfaPga79mQ5tV21yu3O2/5wYOdI8cmGRhL/N2wSFx8bjaV8B7ft0z0
   RtbkcliEDE0g6Fxd4x/Lodyn8ULuP/cylC+X2FuN9VnttxO6HN5H/gLNa
   e5Lql3LKrHHElUyPdqQ3FrB+zK2jYpwRx9AGv4idFfFNmqZl88dXnkMv4
   o=;
IronPort-SDR: zYXdKT9v0AfPwdhjI93YfuN2XIBjsVN3R9sI31V6oJzXsGQoh4P1AsOcDuO0OMtHvywAw3bHYb
 h+OQ3CzvZo3g==
X-IronPort-AV: E=Sophos;i="5.69,345,1571702400"; 
   d="scan'208";a="9712439"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 23 Dec 2019 01:41:18 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 9EF59222A01;
        Mon, 23 Dec 2019 01:41:17 +0000 (UTC)
Received: from EX13D11UWB002.ant.amazon.com (10.43.161.20) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:41:17 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D11UWB002.ant.amazon.com (10.43.161.20) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:41:16 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 23 Dec 2019 01:41:16 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <=linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <mst@redhat.com>, <jejb@linux.ibm.com>,
        <hch@lst.de>, <ssomesh@amazon.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [RFC PATCH 3/5] drivers/block/xen-blkfront.c: Convert to use disk_set_capacity
Date:   Mon, 23 Dec 2019 01:40:54 +0000
Message-ID: <20191223014056.17318-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20191223014056.17318-1-sblbir@amazon.com>
References: <20191223014056.17318-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

block/genhd provides disk_set_capacity() for sending
RESIZE notifications via uevents.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/block/xen-blkfront.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 23c86350a5ab..bed7050a697d 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2337,7 +2337,6 @@ static void blkfront_connect(struct blkfront_info *info)
 	unsigned long sector_size;
 	unsigned int physical_sector_size;
 	unsigned int binfo;
-	char *envp[] = { "RESIZE=1", NULL };
 	int err, i;
 
 	switch (info->connected) {
@@ -2352,10 +2351,8 @@ static void blkfront_connect(struct blkfront_info *info)
 			return;
 		printk(KERN_INFO "Setting capacity to %Lu\n",
 		       sectors);
-		set_capacity(info->gd, sectors);
+		disk_set_capacity(info->gd, sectors);
 		revalidate_disk(info->gd);
-		kobject_uevent_env(&disk_to_dev(info->gd)->kobj,
-				   KOBJ_CHANGE, envp);
 
 		return;
 	case BLKIF_STATE_SUSPENDED:
-- 
2.16.5

