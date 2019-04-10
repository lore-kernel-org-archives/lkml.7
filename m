Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48DAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A383120830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="V3Jh78HT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbfDJO2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:28:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18993 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbfDJO2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:28:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cadfd870000>; Wed, 10 Apr 2019 07:28:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 10 Apr 2019 07:28:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 10 Apr 2019 07:28:38 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Apr
 2019 14:28:38 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Apr 2019 14:28:38 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.42.162]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cadfd930001>; Wed, 10 Apr 2019 07:28:37 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <sakari.ailus@linux.intel.com>, <paul.kocialkowski@bootlin.com>,
        <tfiga@chromium.org>, <keiichiw@chromium.org>, <sumitg@nvidia.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] [media] v4l2-core: fix use-after-free error
Date:   Wed, 10 Apr 2019 19:58:28 +0530
Message-ID: <1554906508-17192-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554906503; bh=+vYP8mBHqgdcUcxnaIdUwSHPv0Nf2tTiLmWUBPgwwX0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=V3Jh78HT57lZyZ30HnfCYfGPLCNsMsRAdhPcyR8MWJhsBbUQTT49ShectSSJIyGv7
         6NiZ1vPccotyHzbW2vupZykxrM3cPFSJNlpPG1bkj508inCE/an1szFxf2NIny/L5k
         D4uGVSBiEZ0CjTKWNQh/BGL14AuZharmXDE5tujY0m1/KZnMCQj6zDW0J5uEMag2+8
         pGxDDPcsM0Ada34si6Yxd4A0ikiGgimq+yqZxseAsiG68u1q++hxq1xLsJzzNpUROE
         RphQh2wxUIaSbYnSmRbzRo5cWopNyyG9jMP1jCXbVeGdQU67rlACiVGgphh7Z1kEdY
         xgQ0As6jdBUzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sumitg <sumitg@nvidia.com>

Fixing use-after-free within __v4l2_ctrl_handler_setup().
Memory is being freed with kfree(new_ref) for duplicate
control reference entry but cluster is still referring
to the duplicate entry. Change done to point cluster to
original reference instead of duplicate which is freed.

 ==================================================================
 BUG: KASAN: use-after-free in __v4l2_ctrl_handler_setup+0x388/0x428
 Read of size 8 at addr ffffffc324e78618 by task systemd-udevd/312

 Allocated by task 312:

 Freed by task 312:

 The buggy address belongs to the object at ffffffc324e78600
  which belongs to the cache kmalloc-64 of size 64
 The buggy address is located 24 bytes inside of
  64-byte region [ffffffc324e78600, ffffffc324e78640)
 The buggy address belongs to the page:
 page:ffffffbf0c939e00 count:1 mapcount:0 mapping:
					(null) index:0xffffffc324e78f80
 flags: 0x4000000000000100(slab)
 raw: 4000000000000100 0000000000000000 ffffffc324e78f80 000000018020001a
 raw: 0000000000000000 0000000100000001 ffffffc37040fb80 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffffffc324e78500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffffffc324e78580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 >ffffffc324e78600: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                             ^
  ffffffc324e78680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
  ffffffc324e78700: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
 ==================================================================

Signed-off-by: sumitg <sumitg@nvidia.com>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 5e3806f..e971bab 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2182,6 +2182,7 @@ static int handler_new_ref(struct v4l2_ctrl_handler *hdl,
 			continue;
 		/* Don't add duplicates */
 		if (ref->ctrl->id == id) {
+			ctrl->cluster = &ref->ctrl;
 			kfree(new_ref);
 			goto unlock;
 		}
-- 
2.7.4

