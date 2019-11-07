Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF5BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82176217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbfKGELx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:11:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:53295 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733289AbfKGELw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:11:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:52 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="227707120"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:52 -0800
Subject: [PATCH 11/16] libnvdimm: Simplify root read-only definition for the
 'resource' attribute
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>, peterz@infradead.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Wed, 06 Nov 2019 19:57:35 -0800
Message-ID: <157309905534.1582359.13927459228885931097.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Rather than update the permission in ->is_visible() set the permission
directly at declaration time.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |    9 +++------
 drivers/nvdimm/pfn_devs.c       |   10 +---------
 drivers/nvdimm/region_devs.c    |   10 +++-------
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 37471a272c1a..85b553094d19 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1303,7 +1303,7 @@ static ssize_t resource_show(struct device *dev,
 		return -ENXIO;
 	return sprintf(buf, "%#llx\n", (unsigned long long) res->start);
 }
-static DEVICE_ATTR_RO(resource);
+static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
 static const unsigned long blk_lbasize_supported[] = { 512, 520, 528,
 	4096, 4104, 4160, 4224, 0 };
@@ -1619,11 +1619,8 @@ static umode_t namespace_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 
-	if (a == &dev_attr_resource.attr) {
-		if (is_namespace_blk(dev))
-			return 0;
-		return 0400;
-	}
+	if (a == &dev_attr_resource.attr && is_namespace_blk(dev))
+		return 0;
 
 	if (is_namespace_pmem(dev) || is_namespace_blk(dev)) {
 		if (a == &dev_attr_size.attr)
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index e809961e2b6f..9f9cb51301e7 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -218,7 +218,7 @@ static ssize_t resource_show(struct device *dev,
 
 	return rc;
 }
-static DEVICE_ATTR_RO(resource);
+static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
 static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -269,16 +269,8 @@ static struct attribute *nd_pfn_attributes[] = {
 	NULL,
 };
 
-static umode_t pfn_visible(struct kobject *kobj, struct attribute *a, int n)
-{
-	if (a == &dev_attr_resource.attr)
-		return 0400;
-	return a->mode;
-}
-
 static struct attribute_group nd_pfn_attribute_group = {
 	.attrs = nd_pfn_attributes,
-	.is_visible = pfn_visible,
 };
 
 const struct attribute_group *nd_pfn_attribute_groups[] = {
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0afc1973e938..be3e429e86af 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -553,7 +553,7 @@ static ssize_t resource_show(struct device *dev,
 
 	return sprintf(buf, "%#llx\n", nd_region->ndr_start);
 }
-static DEVICE_ATTR_RO(resource);
+static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
 static ssize_t persistence_domain_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -605,12 +605,8 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 	if (!is_memory(dev) && a == &dev_attr_badblocks.attr)
 		return 0;
 
-	if (a == &dev_attr_resource.attr) {
-		if (is_memory(dev))
-			return 0400;
-		else
-			return 0;
-	}
+	if (a == &dev_attr_resource.attr && !is_memory(dev))
+		return 0;
 
 	if (a == &dev_attr_deep_flush.attr) {
 		int has_flush = nvdimm_has_flush(nd_region);

