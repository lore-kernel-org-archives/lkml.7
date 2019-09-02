Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032AEC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C936A21874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfIBIdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:33:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:2568 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730311AbfIBIck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:32:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 01:32:40 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="194005747"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 01:32:35 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id C102920B44;
        Mon,  2 Sep 2019 11:32:33 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i4hlQ-0005JV-6q; Mon, 02 Sep 2019 11:32:40 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v4 02/11] software node: Make argument to to_software_node const
Date:   Mon,  2 Sep 2019 11:32:31 +0300
Message-Id: <20190902083240.20367-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to_software_node() does not need to modify the fwnode_handle it operates
on; therefore make it const. This allows passing a const fwnode_handle to
to_software_node().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c    | 4 ++--
 include/linux/property.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index a7cb41812cfda..951e7efd47c23 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -71,9 +71,9 @@ software_node_to_swnode(const struct software_node *node)
 	return swnode;
 }
 
-const struct software_node *to_software_node(struct fwnode_handle *fwnode)
+const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
 {
-	struct swnode *swnode = to_swnode(fwnode);
+	const struct swnode *swnode = to_swnode(fwnode);
 
 	return swnode ? swnode->node : NULL;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 5a910ad795910..421c76e53708d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -418,7 +418,8 @@ struct software_node {
 };
 
 bool is_software_node(const struct fwnode_handle *fwnode);
-const struct software_node *to_software_node(struct fwnode_handle *fwnode);
+const struct software_node *
+to_software_node(const struct fwnode_handle *fwnode);
 struct fwnode_handle *software_node_fwnode(const struct software_node *node);
 
 int software_node_register_nodes(const struct software_node *nodes);
-- 
2.20.1

