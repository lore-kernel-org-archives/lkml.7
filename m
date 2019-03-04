Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E39206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCDU0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:26:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:40746 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfCDU0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:26:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 12:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,441,1544515200"; 
   d="scan'208";a="138012247"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Mar 2019 12:26:42 -0800
Subject: [PATCH] libnvdimm/namespace: Clean up holder_class_store()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Date:   Mon, 04 Mar 2019 12:14:04 -0800
Message-ID: <155173044436.4154095.17954771880753980013.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sysfs_streq() in place of open-coded strcmp()'s that check for an
optional "\n" at the end of the input.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 3677b0c4a33d..17fb7f931f0c 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1506,13 +1506,13 @@ static ssize_t __holder_class_store(struct device *dev, const char *buf)
 	if (dev->driver || ndns->claim)
 		return -EBUSY;
 
-	if (strcmp(buf, "btt") == 0 || strcmp(buf, "btt\n") == 0)
+	if (sysfs_streq(buf, "btt"))
 		ndns->claim_class = btt_claim_class(dev);
-	else if (strcmp(buf, "pfn") == 0 || strcmp(buf, "pfn\n") == 0)
+	else if (sysfs_streq(buf, "pfn"))
 		ndns->claim_class = NVDIMM_CCLASS_PFN;
-	else if (strcmp(buf, "dax") == 0 || strcmp(buf, "dax\n") == 0)
+	else if (sysfs_streq(buf, "dax"))
 		ndns->claim_class = NVDIMM_CCLASS_DAX;
-	else if (strcmp(buf, "") == 0 || strcmp(buf, "\n") == 0)
+	else if (sysfs_streq(buf, ""))
 		ndns->claim_class = NVDIMM_CCLASS_NONE;
 	else
 		return -EINVAL;

