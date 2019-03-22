Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEFAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E04521939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256134;
	bh=OKgyMZ6HFYx0T1yPu2Y5f+e5WbY96YoQ0O9kiIi+bOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2vrPAJzZkQdeRR7qV0RdZkkBR/VJTKTqxXBEd3mv2Y/dDGvFPRvxoKKF7QAKUNdB9
	 1wlQEbP1NOt2I770zEk0d3E8FyEbyMqnkiLtW8FE8LFlpx5PnUIVy3jzbKwgJwAB0G
	 /gnfgYNJoun8pp4S9+E0J8ReKUWfrhqJrnNARjo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbfCVMCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388320AbfCVMCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65441204FD;
        Fri, 22 Mar 2019 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256128;
        bh=OKgyMZ6HFYx0T1yPu2Y5f+e5WbY96YoQ0O9kiIi+bOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHT+Rdf+3pwEZmSGdgitGluiPKdhlK2NMRNBmHpqtRp+AWkBYtRRBbp1ESVY2Zfum
         L9PaWpYDTSqKKdQsNMC9aNOvK/blGjeeun5Y7E68pG3PjHGMj4O2MEC9rexK1aM06d
         wuTXemAx7n7IhQNRtn4I/ypfvLbZzfd5JtNOMjBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kelly Couch <kelly.j.couch@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.19 117/280] libnvdimm/label: Clear updating flag after label-set update
Date:   Fri, 22 Mar 2019 12:14:30 +0100
Message-Id: <20190322111314.486436353@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 966d23a006ca7b44ac8cf4d0c96b19785e0c3da0 upstream.

The UEFI 2.7 specification sets expectations that the 'updating' flag is
eventually cleared. To date, the libnvdimm core has never adhered to
that protocol. The policy of the core matches the policy of other
multi-device info-block formats like MD-Software-RAID that expect
administrator intervention on inconsistent info-blocks, not automatic
invalidation.

However, some pre-boot environments may unfortunately attempt to "clean
up" the labels and invalidate a set when it fails to find at least one
"non-updating" label in the set. Clear the updating flag after set
updates to minimize the window of vulnerability to aggressive pre-boot
environments.

Ideally implementations would not write to the label area outside of
creating namespaces.

Note that this only minimizes the window, it does not close it as the
system can still crash while clearing the flag and the set can be
subsequently deleted / invalidated by the pre-boot environment.

Fixes: f524bf271a5c ("libnvdimm: write pmem label set")
Cc: <stable@vger.kernel.org>
Cc: Kelly Couch <kelly.j.couch@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/label.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -625,7 +625,7 @@ static const guid_t *to_abstraction_guid
 
 static int __pmem_label_update(struct nd_region *nd_region,
 		struct nd_mapping *nd_mapping, struct nd_namespace_pmem *nspm,
-		int pos)
+		int pos, unsigned long flags)
 {
 	struct nd_namespace_common *ndns = &nspm->nsio.common;
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
@@ -666,7 +666,7 @@ static int __pmem_label_update(struct nd
 	memcpy(nd_label->uuid, nspm->uuid, NSLABEL_UUID_LEN);
 	if (nspm->alt_name)
 		memcpy(nd_label->name, nspm->alt_name, NSLABEL_NAME_LEN);
-	nd_label->flags = __cpu_to_le32(NSLABEL_FLAG_UPDATING);
+	nd_label->flags = __cpu_to_le32(flags);
 	nd_label->nlabel = __cpu_to_le16(nd_region->ndr_mappings);
 	nd_label->position = __cpu_to_le16(pos);
 	nd_label->isetcookie = __cpu_to_le64(cookie);
@@ -1120,13 +1120,13 @@ static int del_labels(struct nd_mapping
 int nd_pmem_namespace_label_update(struct nd_region *nd_region,
 		struct nd_namespace_pmem *nspm, resource_size_t size)
 {
-	int i;
+	int i, rc;
 
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
 		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
 		struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 		struct resource *res;
-		int rc, count = 0;
+		int count = 0;
 
 		if (size == 0) {
 			rc = del_labels(nd_mapping, nspm->uuid);
@@ -1144,7 +1144,20 @@ int nd_pmem_namespace_label_update(struc
 		if (rc < 0)
 			return rc;
 
-		rc = __pmem_label_update(nd_region, nd_mapping, nspm, i);
+		rc = __pmem_label_update(nd_region, nd_mapping, nspm, i,
+				NSLABEL_FLAG_UPDATING);
+		if (rc)
+			return rc;
+	}
+
+	if (size == 0)
+		return 0;
+
+	/* Clear the UPDATING flag per UEFI 2.7 expectations */
+	for (i = 0; i < nd_region->ndr_mappings; i++) {
+		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
+
+		rc = __pmem_label_update(nd_region, nd_mapping, nspm, i, 0);
 		if (rc)
 			return rc;
 	}


