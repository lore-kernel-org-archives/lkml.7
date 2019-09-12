Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D40C49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A052085B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfILCza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:55:30 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:52748 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729585AbfILCz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:55:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 50123180A68D6;
        Thu, 12 Sep 2019 02:55:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: farm24_86bb032e81406
X-Filterd-Recvd-Size: 7399
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 02:55:25 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] nvdimm: Use more common logic testing styles and bare ; positions
Date:   Wed, 11 Sep 2019 19:54:41 -0700
Message-Id: <d6aa5b66936f2e0f132e893e10494aae6b74e886.1568256708.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1568256705.git.joe@perches.com>
References: <cover.1568256705.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using uncommon logic testing styles to make the code a
bit more like other kernel code.

e.g.:
	if (foo) {
		;
	} else {
		<code>
	}

is typically written

	if (!foo) {
		<code>
	}

Also put bare semicolons before the comment not after the comment

e.g.:

	if (foo) {
		/* comment */;
	} else if (bar) {
		<code>
	} else {
		baz;
	}

is typically written

	if (foo) {
		;	/* comment */
	} else if (bar) {
		<code>
	} else {
		baz;
	}

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/claim.c          |  4 +---
 drivers/nvdimm/dimm_devs.c      | 11 ++++------
 drivers/nvdimm/label.c          |  4 +---
 drivers/nvdimm/namespace_devs.c | 46 +++++++++++++++++++----------------------
 drivers/nvdimm/region_devs.c    |  4 +---
 5 files changed, 28 insertions(+), 41 deletions(-)

diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 3732925aadb8..244631f5308c 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -149,9 +149,7 @@ ssize_t nd_namespace_store(struct device *dev,
 		return -ENOMEM;
 	strim(name);
 
-	if (strncmp(name, "namespace", 9) == 0 || strcmp(name, "") == 0) {
-		/* pass */;
-	} else {
+	if (!(strncmp(name, "namespace", 9) == 0 || strcmp(name, "") == 0)) {
 		len = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 4df85dd72682..cac62bb726bb 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -593,13 +593,10 @@ int alias_dpa_busy(struct device *dev, void *data)
 	 * looking to validate against PMEM aliasing collision rules
 	 * (i.e. BLK is allocated after all aliased PMEM).
 	 */
-	if (info->res) {
-		if (info->res->start >= nd_mapping->start &&
-		    info->res->start < map_end)
-			/* pass */;
-		else
-			return 0;
-	}
+	if (info->res &&
+	    (info->res->start < nd_mapping->start ||
+	     info->res->start >= map_end))
+		return 0;
 
 retry:
 	/*
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index e4632dbebead..ae466c6faa90 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -1180,9 +1180,7 @@ static int init_labels(struct nd_mapping *nd_mapping, int num_labels)
 		mutex_unlock(&nd_mapping->lock);
 	}
 
-	if (ndd->ns_current == -1 || ndd->ns_next == -1)
-		/* pass */;
-	else
+	if (ndd->ns_current != -1 && ndd->ns_next != -1)
 		return max(num_labels, old_num_labels);
 
 	nsindex = to_namespace_index(ndd, 0);
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 8c75ef84bad7..7a16340f9853 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -162,7 +162,7 @@ unsigned int pmem_sector_size(struct nd_namespace_common *ndns)
 
 		nspm = to_nd_namespace_pmem(&ndns->dev);
 		if (nspm->lbasize == 0 || nspm->lbasize == 512)
-			/* default */;
+			;	/* default */
 		else if (nspm->lbasize == 4096)
 			return 4096;
 		else
@@ -387,7 +387,7 @@ static int nd_namespace_label_update(struct nd_region *nd_region,
 		resource_size_t size = resource_size(&nspm->nsio.res);
 
 		if (size == 0 && nspm->uuid)
-			/* delete allocation */;
+			;	/* delete allocation */
 		else if (!nspm->uuid)
 			return 0;
 
@@ -398,7 +398,7 @@ static int nd_namespace_label_update(struct nd_region *nd_region,
 		resource_size_t size = nd_namespace_blk_size(nsblk);
 
 		if (size == 0 && nsblk->uuid)
-			/* delete allocation */;
+			;	/* delete allocation */
 		else if (!nsblk->uuid || !nsblk->lbasize)
 			return 0;
 
@@ -1900,10 +1900,8 @@ static int select_pmem_id(struct nd_region *nd_region, u8 *pmem_id)
 		hw_end = hw_start + nd_mapping->size;
 		pmem_start = __le64_to_cpu(nd_label->dpa);
 		pmem_end = pmem_start + __le64_to_cpu(nd_label->rawsize);
-		if (pmem_start >= hw_start && pmem_start < hw_end &&
-		    pmem_end <= hw_end && pmem_end > hw_start) {
-			/* pass */;
-		} else {
+		if (!(pmem_start >= hw_start && pmem_start < hw_end &&
+		      pmem_end <= hw_end && pmem_end > hw_start)) {
 			dev_dbg(&nd_region->dev, "%s invalid label for %pUb\n",
 				dev_name(ndd->dev), nd_label->uuid);
 			return -EINVAL;
@@ -2326,15 +2324,12 @@ static struct device **scan_labels(struct nd_region *nd_region)
 	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
 		struct nd_namespace_label *nd_label = label_ent->label;
 		struct device **__devs;
-		u32 flags;
+		bool localflag;
 
 		if (!nd_label)
 			continue;
-		flags = __le32_to_cpu(nd_label->flags);
-		if (is_nd_blk(&nd_region->dev)
-		    == !!(flags & NSLABEL_FLAG_LOCAL))
-			/* pass, region matches label type */;
-		else
+		localflag = __le32_to_cpu(nd_label->flags) & NSLABEL_FLAG_LOCAL;
+		if (is_nd_blk(&nd_region->dev) != localflag)
 			continue;
 
 		/* skip labels that describe extents outside of the region */
@@ -2494,19 +2489,20 @@ static int init_active_labels(struct nd_region *nd_region)
 		 * the region from being activated.
 		 */
 		if (!ndd) {
-			if (test_bit(NDD_LOCKED, &nvdimm->flags))
-				/* fail, label data may be unreadable */;
-			else if (test_bit(NDD_ALIASING, &nvdimm->flags))
-				/* fail, labels needed to disambiguate dpa */;
-			else
-				return 0;
-
-			dev_err(&nd_region->dev, "%s: is %s, failing probe\n",
-				dev_name(&nd_mapping->nvdimm->dev),
-				test_bit(NDD_LOCKED, &nvdimm->flags)
-				? "locked" : "disabled");
-			return -ENXIO;
+			if (test_bit(NDD_LOCKED, &nvdimm->flags) ||
+					/* label data may be unreadable */
+			    test_bit(NDD_ALIASING, &nvdimm->flags)) {
+					/* labels needed to disambiguate dpa */
+
+				dev_err(&nd_region->dev, "%s: is %s, failing probe\n",
+					dev_name(&nd_mapping->nvdimm->dev),
+					test_bit(NDD_LOCKED, &nvdimm->flags)
+					? "locked" : "disabled");
+				return -ENXIO;
+			}
+			return 0;
 		}
+
 		nd_mapping->ndd = ndd;
 		atomic_inc(&nvdimm->busy);
 		get_ndd(ndd);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 65df07481909..6861e0997d21 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -320,9 +320,7 @@ static ssize_t set_cookie_show(struct device *dev,
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
 	ssize_t rc = 0;
 
-	if (is_memory(dev) && nd_set)
-		/* pass, should be precluded by region_visible */;
-	else
+	if (!(is_memory(dev) && nd_set))
 		return -ENXIO;
 
 	/*
-- 
2.15.0

