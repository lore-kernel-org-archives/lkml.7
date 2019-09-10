Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B39C49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0835C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbfIJIrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:47:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:55647 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfIJIrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:47:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 01:47:09 -0700
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="191753377"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 01:47:07 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id A04D020AC3;
        Tue, 10 Sep 2019 11:47:05 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i7bnn-0004nW-An; Tue, 10 Sep 2019 11:47:07 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v6 04/12] device property: Move fwnode_get_parent() up
Date:   Tue, 10 Sep 2019 11:46:59 +0300
Message-Id: <20190910084707.18380-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move fwnode_get_parent() above fwnode_get_next_parent(), making the order
the same as in the header file.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 81bd01ed40427..3d9dffbe96378 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -556,6 +556,19 @@ int device_add_properties(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(device_add_properties);
 
+/**
+ * fwnode_get_parent - Return parent firwmare node
+ * @fwnode: Firmware whose parent is retrieved
+ *
+ * Return parent firmware node of the given node if possible or %NULL if no
+ * parent was available.
+ */
+struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
+{
+	return fwnode_call_ptr_op(fwnode, get_parent);
+}
+EXPORT_SYMBOL_GPL(fwnode_get_parent);
+
 /**
  * fwnode_get_next_parent - Iterate to the node's parent
  * @fwnode: Firmware whose parent is retrieved
@@ -577,19 +590,6 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
 
-/**
- * fwnode_get_parent - Return parent firwmare node
- * @fwnode: Firmware whose parent is retrieved
- *
- * Return parent firmware node of the given node if possible or %NULL if no
- * parent was available.
- */
-struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
-{
-	return fwnode_call_ptr_op(fwnode, get_parent);
-}
-EXPORT_SYMBOL_GPL(fwnode_get_parent);
-
 /**
  * fwnode_get_next_child_node - Return the next child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
-- 
2.20.1

