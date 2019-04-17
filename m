Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCB9C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5D220663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfDQSKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:10:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:37532 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfDQSKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:10:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 11:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,362,1549958400"; 
   d="scan'208";a="316802634"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga005.jf.intel.com with ESMTP; 17 Apr 2019 11:10:47 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     rjw@rjwysocki.net
Cc:     Alison Schofield <alison.schofield@intel.com>,
        robert.moore@intel.com, erik.schmauss@intel.com,
        keith.busch@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] acpi/hmat: Update acpi_hmat_type enum with ACPI_HMAT_TYPE_PROXIMITY
Date:   Wed, 17 Apr 2019 11:13:10 -0700
Message-Id: <20190417181310.27613-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI 6.3 changed the subtable "Memory Subsystem Address Range Structure"
to "Memory Proximity Domain Attributes Structure".

Updating and renaming of the structure was included in commit:
ACPICA: ACPI 6.3: HMAT updates (9a8d961f1ef835b0d338fbe13da03cb424e87ae5)

Rename the enum type to match the subtable and structure naming.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/acpi/hmat/hmat.c | 4 ++--
 include/acpi/actbl1.h    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index b7824a0309f7..3e32120e2dab 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -411,7 +411,7 @@ static int __init hmat_parse_subtable(union acpi_subtable_headers *header,
 		return -EINVAL;
 
 	switch (hdr->type) {
-	case ACPI_HMAT_TYPE_ADDRESS_RANGE:
+	case ACPI_HMAT_TYPE_PROXIMITY:
 		return hmat_parse_proximity_domain(header, end);
 	case ACPI_HMAT_TYPE_LOCALITY:
 		return hmat_parse_locality(header, end);
@@ -649,7 +649,7 @@ static __init int hmat_init(void)
 		goto out_put;
 	}
 
-	for (i = ACPI_HMAT_TYPE_ADDRESS_RANGE; i < ACPI_HMAT_TYPE_RESERVED; i++) {
+	for (i = ACPI_HMAT_TYPE_PROXIMITY; i < ACPI_HMAT_TYPE_RESERVED; i++) {
 		if (acpi_table_parse_entries(ACPI_SIG_HMAT,
 					     sizeof(struct acpi_table_hmat), i,
 					     hmat_parse_subtable, 0) < 0) {
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index d14037ddf108..22c039ebc6c5 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1395,7 +1395,7 @@ struct acpi_table_hmat {
 /* Values for HMAT structure types */
 
 enum acpi_hmat_type {
-	ACPI_HMAT_TYPE_ADDRESS_RANGE = 0,	/* Memory subsystem address range */
+	ACPI_HMAT_TYPE_PROXIMITY = 0,	/* Memory proximity domain attributes */
 	ACPI_HMAT_TYPE_LOCALITY = 1,	/* System locality latency and bandwidth information */
 	ACPI_HMAT_TYPE_CACHE = 2,	/* Memory side cache information */
 	ACPI_HMAT_TYPE_RESERVED = 3	/* 3 and greater are reserved */
-- 
2.14.1

