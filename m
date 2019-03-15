Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DA9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E540218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfCOQ6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:58:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:39359 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbfCOQ6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:58:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 09:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="155397215"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2019 09:58:11 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 05/12] ACPI / property: Don't limit named child node matching to data nodes
Date:   Fri, 15 Mar 2019 19:57:53 +0300
Message-Id: <20190315165800.5058-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315165800.5058-1-heikki.krogerus@linux.intel.com>
References: <20190315165800.5058-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason why we should limit the use of
fwnode_get_named_child_node() to data nodes only.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/property.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 77abe0ec4043..c3fb52c387a6 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -602,15 +602,29 @@ static struct fwnode_handle *
 acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 				 const char *childname)
 {
+	char name[ACPI_PATH_SEGMENT_LENGTH];
 	struct fwnode_handle *child;
+	struct acpi_buffer path;
+	acpi_status status;
 
-	/*
-	 * Find first matching named child node of this fwnode.
-	 * For ACPI this will be a data only sub-node.
-	 */
-	fwnode_for_each_child_node(fwnode, child)
-		if (acpi_data_node_match(child, childname))
+	path.length = sizeof(name);
+	path.pointer = name;
+
+	fwnode_for_each_child_node(fwnode, child) {
+		if (is_acpi_data_node(child)) {
+			if (acpi_data_node_match(child, childname))
+				return child;
+			continue;
+		}
+
+		status = acpi_get_name(ACPI_HANDLE_FWNODE(child),
+				       ACPI_SINGLE_NAME, &path);
+		if (ACPI_FAILURE(status))
+			break;
+
+		if (!strncmp(name, childname, ACPI_NAME_SIZE))
 			return child;
+	}
 
 	return NULL;
 }
-- 
2.20.1

