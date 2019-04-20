Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5875C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFD321855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfDTAlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:41:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:37994 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfDTAlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:41:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 17:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,371,1549958400"; 
   d="scan'208";a="137289259"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 19 Apr 2019 17:41:07 -0700
Subject: [PATCH] libnvdimm/namespace: Fix label tracking error
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, Jane Chu <jane.chu@oracle.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Erwin Tsaur <erwin.tsaur@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com
Date:   Fri, 19 Apr 2019 17:27:21 -0700
Message-ID: <155572004134.2603218.13620079500159805086.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users have reported intermittent occurrences of DIMM initialization
failures due to duplicate allocations of address capacity detected in
the labels, or errors of the form below, both have the same root cause.

    nd namespace1.4: failed to track label: 0
    WARNING: CPU: 17 PID: 1381 at drivers/nvdimm/label.c:863

    RIP: 0010:__pmem_label_update+0x56c/0x590 [libnvdimm]
    Call Trace:
     ? nd_pmem_namespace_label_update+0xd6/0x160 [libnvdimm]
     nd_pmem_namespace_label_update+0xd6/0x160 [libnvdimm]
     uuid_store+0x17e/0x190 [libnvdimm]
     kernfs_fop_write+0xf0/0x1a0
     vfs_write+0xb7/0x1b0
     ksys_write+0x57/0xd0
     do_syscall_64+0x60/0x210

Unfortunately those reports were typically with a busy parallel
namespace creation / destruction loop making it difficult to see the
components of the bug. However, Jane provided a simple reproducer using
the work-in-progress sub-section implementation.

When ndctl is reconfiguring a namespace it may take an existing defunct
/ disabled namespace and reconfigure it with a new uuid and other
parameters. Critically namespace_update_uuid() takes existing address
resources and renames them for the new namespace to use / reconfigure as
it sees fit. The bug is that this rename only happens in the resource
tracking tree. Existing labels with the old uuid are not reaped leading
to a scenario where multiple active labels reference the same span of
address range.

Teach namespace_update_uuid() to flag any references to the old uuid for
reaping at the next label update attempt.

Cc: <stable@vger.kernel.org>
Fixes: bf9bccc14c05 ("libnvdimm: pmem label sets and namespace instantiation")
Link: https://github.com/pmem/ndctl/issues/91
Reported-by: Jane Chu <jane.chu@oracle.com>
Reported-by: Jeff Moyer <jmoyer@redhat.com>
Reported-by: Erwin Tsaur <erwin.tsaur@oracle.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.c          |   29 ++++++++++++++++-------------
 drivers/nvdimm/namespace_devs.c |   15 +++++++++++++++
 drivers/nvdimm/nd.h             |    4 ++++
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index f3d753d3169c..2030805aa216 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -756,6 +756,17 @@ static const guid_t *to_abstraction_guid(enum nvdimm_claim_class claim_class,
 		return &guid_null;
 }
 
+static void reap_victim(struct nd_mapping *nd_mapping,
+		struct nd_label_ent *victim)
+{
+	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
+	u32 slot = to_slot(ndd, victim->label);
+
+	dev_dbg(ndd->dev, "free: %d\n", slot);
+	nd_label_free_slot(ndd, slot);
+	victim->label = NULL;
+}
+
 static int __pmem_label_update(struct nd_region *nd_region,
 		struct nd_mapping *nd_mapping, struct nd_namespace_pmem *nspm,
 		int pos, unsigned long flags)
@@ -763,9 +774,9 @@ static int __pmem_label_update(struct nd_region *nd_region,
 	struct nd_namespace_common *ndns = &nspm->nsio.common;
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
-	struct nd_label_ent *label_ent, *victim = NULL;
 	struct nd_namespace_label *nd_label;
 	struct nd_namespace_index *nsindex;
+	struct nd_label_ent *label_ent;
 	struct nd_label_id label_id;
 	struct resource *res;
 	unsigned long *free;
@@ -834,18 +845,10 @@ static int __pmem_label_update(struct nd_region *nd_region,
 	list_for_each_entry(label_ent, &nd_mapping->labels, list) {
 		if (!label_ent->label)
 			continue;
-		if (memcmp(nspm->uuid, label_ent->label->uuid,
-					NSLABEL_UUID_LEN) != 0)
-			continue;
-		victim = label_ent;
-		list_move_tail(&victim->list, &nd_mapping->labels);
-		break;
-	}
-	if (victim) {
-		dev_dbg(ndd->dev, "free: %d\n", slot);
-		slot = to_slot(ndd, victim->label);
-		nd_label_free_slot(ndd, slot);
-		victim->label = NULL;
+		if (test_and_clear_bit(ND_LABEL_REAP, &label_ent->flags)
+				|| memcmp(nspm->uuid, label_ent->label->uuid,
+					NSLABEL_UUID_LEN) == 0)
+			reap_victim(nd_mapping, label_ent);
 	}
 
 	/* update index */
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 7849bf1812c4..3e2fdfdbe7b8 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1247,12 +1247,27 @@ static int namespace_update_uuid(struct nd_region *nd_region,
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
 		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
 		struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
+		struct nd_label_ent *label_ent;
 		struct resource *res;
 
 		for_each_dpa_resource(ndd, res)
 			if (strcmp(res->name, old_label_id.id) == 0)
 				sprintf((void *) res->name, "%s",
 						new_label_id.id);
+
+		mutex_lock(&nd_mapping->lock);
+		list_for_each_entry(label_ent, &nd_mapping->labels, list) {
+			struct nd_namespace_label *nd_label = label_ent->label;
+			struct nd_label_id label_id;
+
+			if (!nd_label)
+				continue;
+			nd_label_gen_id(&label_id, nd_label->uuid,
+					__le32_to_cpu(nd_label->flags));
+			if (strcmp(old_label_id.id, label_id.id) == 0)
+				set_bit(ND_LABEL_REAP, &label_ent->flags);
+		}
+		mutex_unlock(&nd_mapping->lock);
 	}
 	kfree(*old_uuid);
  out:
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index a5ac3b240293..191d62af0e51 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -113,8 +113,12 @@ struct nd_percpu_lane {
 	spinlock_t lock;
 };
 
+enum nd_label_flags {
+	ND_LABEL_REAP,
+};
 struct nd_label_ent {
 	struct list_head list;
+	unsigned long flags;
 	struct nd_namespace_label *label;
 };
 

