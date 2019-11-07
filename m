Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D357C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAC6217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733279AbfKGELl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:11:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:42670 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733082AbfKGELl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:11:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:41 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="403972229"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:40 -0800
Subject: [PATCH 09/16] dax: Create a dax device_type
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>, peterz@infradead.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Wed, 06 Nov 2019 19:57:23 -0800
Message-ID: <157309904365.1582359.5451327195246651379.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the open coded release method and attribute groups to a 'struct
device_type' instance.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 8fafbeab510a..f3e6e00ece40 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -373,6 +373,11 @@ static void dev_dax_release(struct device *dev)
 	kfree(dev_dax);
 }
 
+static const struct device_type dev_dax_type = {
+	.release = dev_dax_release,
+	.groups = dax_attribute_groups,
+};
+
 static void unregister_dev_dax(void *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
@@ -430,8 +435,7 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
 	else
 		dev->class = dax_class;
 	dev->parent = parent;
-	dev->groups = dax_attribute_groups;
-	dev->release = dev_dax_release;
+	dev->type = &dev_dax_type;
 	dev_set_name(dev, "dax%d.%d", dax_region->id, id);
 
 	rc = device_add(dev);

