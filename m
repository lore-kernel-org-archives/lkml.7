Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12576C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D012178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbfKGELa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:11:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:4380 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733136AbfKGELa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:11:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:29 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="200923745"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:29 -0800
Subject: [PATCH 07/16] libnvdimm: Move nvdimm_attribute_group to device_type
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 06 Nov 2019 19:57:12 -0800
Message-ID: <157309903201.1582359.10966209746585062329.stgit@dwillia2-desk3.amr.corp.intel.com>
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

A 'struct device_type' instance can carry default attributes for the
device. Use this facility to remove the export of
nvdimm_attribute_group and put the responsibility on the core rather
than leaf implementations to define this attribute.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c |    9 ++-----
 drivers/acpi/nfit/core.c                  |    1 -
 drivers/nvdimm/dimm_devs.c                |   36 +++++++++++++++--------------
 include/linux/libnvdimm.h                 |    1 -
 4 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 0405fb769336..8354737ac340 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -289,11 +289,6 @@ static const struct attribute_group *bus_attr_groups[] = {
 	NULL,
 };
 
-static const struct attribute_group *papr_scm_dimm_groups[] = {
-	&nvdimm_attribute_group,
-	NULL,
-};
-
 static inline int papr_scm_node(int node)
 {
 	int min_dist = INT_MAX, dist;
@@ -339,8 +334,8 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	dimm_flags = 0;
 	set_bit(NDD_ALIASING, &dimm_flags);
 
-	p->nvdimm = nvdimm_create(p->bus, p, papr_scm_dimm_groups,
-				dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
+	p->nvdimm = nvdimm_create(p->bus, p, NULL, dimm_flags,
+				  PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
 	if (!p->nvdimm) {
 		dev_err(dev, "Error creating DIMM object for %pOF\n", p->dn);
 		goto err;
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 69c406ecc3a6..84fc1f865802 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1698,7 +1698,6 @@ static const struct attribute_group acpi_nfit_dimm_attribute_group = {
 };
 
 static const struct attribute_group *acpi_nfit_dimm_attribute_groups[] = {
-	&nvdimm_attribute_group,
 	&acpi_nfit_dimm_attribute_group,
 	NULL,
 };
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 278867c68682..94ea6dba6b4f 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -202,22 +202,6 @@ static void nvdimm_release(struct device *dev)
 	kfree(nvdimm);
 }
 
-static const struct attribute_group *nvdimm_attribute_groups[] = {
-	&nd_device_attribute_group,
-	NULL,
-};
-
-static const struct device_type nvdimm_device_type = {
-	.name = "nvdimm",
-	.release = nvdimm_release,
-	.groups = nvdimm_attribute_groups,
-};
-
-bool is_nvdimm(struct device *dev)
-{
-	return dev->type == &nvdimm_device_type;
-}
-
 struct nvdimm *to_nvdimm(struct device *dev)
 {
 	struct nvdimm *nvdimm = container_of(dev, struct nvdimm, dev);
@@ -456,11 +440,27 @@ static umode_t nvdimm_visible(struct kobject *kobj, struct attribute *a, int n)
 	return 0;
 }
 
-struct attribute_group nvdimm_attribute_group = {
+static const struct attribute_group nvdimm_attribute_group = {
 	.attrs = nvdimm_attributes,
 	.is_visible = nvdimm_visible,
 };
-EXPORT_SYMBOL_GPL(nvdimm_attribute_group);
+
+static const struct attribute_group *nvdimm_attribute_groups[] = {
+	&nd_device_attribute_group,
+	&nvdimm_attribute_group,
+	NULL,
+};
+
+static const struct device_type nvdimm_device_type = {
+	.name = "nvdimm",
+	.release = nvdimm_release,
+	.groups = nvdimm_attribute_groups,
+};
+
+bool is_nvdimm(struct device *dev)
+{
+	return dev->type == &nvdimm_device_type;
+}
 
 struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 		void *provider_data, const struct attribute_group **groups,
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index eb597d1cb891..3644af97bcb4 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -66,7 +66,6 @@ enum {
 };
 
 extern struct attribute_group nvdimm_bus_attribute_group;
-extern struct attribute_group nvdimm_attribute_group;
 
 struct nvdimm;
 struct nvdimm_bus_descriptor;

