Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B70C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A3921920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfJBMdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:33:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:27022 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfJBMdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:33:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 05:33:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,574,1559545200"; 
   d="scan'208";a="205330028"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2019 05:33:09 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] software node: Add missing kernel-doc function descriptions
Date:   Wed,  2 Oct 2019 15:33:04 +0300
Message-Id: <20191002123305.80012-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002123305.80012-1-heikki.krogerus@linux.intel.com>
References: <20191002123305.80012-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the functions were missing kernel-doc style
descriptions.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index a1f3f0994f9f..51c9e6c56c26 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -33,6 +33,10 @@ static struct kset *swnode_kset;
 
 static const struct fwnode_operations software_node_ops;
 
+/**
+ * is_software_node - Test if fwnode handle is software node
+ * @fwnode: The fwnode handle to test
+ */
 bool is_software_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &software_node_ops;
@@ -71,6 +75,10 @@ software_node_to_swnode(const struct software_node *node)
 	return swnode;
 }
 
+/**
+ * to_software_node - Convert fwnode handle to software node
+ * @fwnode: The fwnode handle of the software node
+ */
 const struct software_node *to_software_node(struct fwnode_handle *fwnode)
 {
 	struct swnode *swnode = to_swnode(fwnode);
@@ -79,6 +87,10 @@ const struct software_node *to_software_node(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(to_software_node);
 
+/**
+ * software_node_fwnode - Convert software node to fwnode handle
+ * @swnode: The software node
+ */
 struct fwnode_handle *software_node_fwnode(const struct software_node *node)
 {
 	struct swnode *swnode = software_node_to_swnode(node);
@@ -802,6 +814,13 @@ int software_node_register(const struct software_node *node)
 }
 EXPORT_SYMBOL_GPL(software_node_register);
 
+/**
+ * fwnode_create_software_node - Create and register a software node
+ * @properties: Device properties for the software node
+ * @parent: The parent node
+ *
+ * Returnes the fwnode handle of the software node on success.
+ */
 struct fwnode_handle *
 fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent)
@@ -834,6 +853,10 @@ fwnode_create_software_node(const struct property_entry *properties,
 }
 EXPORT_SYMBOL_GPL(fwnode_create_software_node);
 
+/**
+ * fwnode_remove_software_node - Remove a software node
+ * @fwnode: The fwnode handle of the software node
+ */
 void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 {
 	struct swnode *swnode = to_swnode(fwnode);
-- 
2.23.0

