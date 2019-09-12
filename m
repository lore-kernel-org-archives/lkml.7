Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0633C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B2B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfILCz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:55:27 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:51632 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729489AbfILCz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:55:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E907C100E86C4;
        Thu, 12 Sep 2019 02:55:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: girls87_86643b0d66e00
X-Filterd-Recvd-Size: 2319
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 02:55:23 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] nvdimm: namespace_devs: Move assignment operators
Date:   Wed, 11 Sep 2019 19:54:40 -0700
Message-Id: <95bbd3ef7a6b06384d1ec6f5bfd691a728b31831.1568256708.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1568256705.git.joe@perches.com>
References: <cover.1568256705.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel code uses assignment operators where the statement is split
on multiple lines on the first line.

Move 2 unusual uses.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/namespace_devs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 70e1d752c12c..8c75ef84bad7 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2023,8 +2023,8 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 		nspm->lbasize = __le64_to_cpu(label0->lbasize);
 		ndd = to_ndd(nd_mapping);
 		if (namespace_label_has(ndd, abstraction_guid))
-			nspm->nsio.common.claim_class
-				= to_nvdimm_cclass(&label0->abstraction_guid);
+			nspm->nsio.common.claim_class =
+				to_nvdimm_cclass(&label0->abstraction_guid);
 	}
 
 	if (!nspm->alt_name || !nspm->uuid) {
@@ -2267,8 +2267,8 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 	nsblk->uuid = kmemdup(nd_label->uuid, NSLABEL_UUID_LEN,
 			      GFP_KERNEL);
 	if (namespace_label_has(ndd, abstraction_guid))
-		nsblk->common.claim_class
-			= to_nvdimm_cclass(&nd_label->abstraction_guid);
+		nsblk->common.claim_class =
+			to_nvdimm_cclass(&nd_label->abstraction_guid);
 	if (!nsblk->uuid)
 		goto blk_err;
 	memcpy(name, nd_label->name, NSLABEL_NAME_LEN);
-- 
2.15.0

