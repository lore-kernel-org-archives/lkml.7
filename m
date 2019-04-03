Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4732082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfDCQqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:46:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:21215 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbfDCQp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:45:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 09:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,305,1549958400"; 
   d="scan'208";a="161077405"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2019 09:45:53 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 06/11] device connection: Find connections also by checking the references
Date:   Wed,  3 Apr 2019 19:45:32 +0300
Message-Id: <20190403164537.24643-7-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can also use this API to find named references that the
device nodes have by using fwnode_property_get_reference_args()
function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/devcon.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 04db9ae235e4..4cdf95532b63 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -38,6 +38,30 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+static void *
+fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
+		    void *data, devcon_match_fn_t match)
+{
+	struct device_connection con = { };
+	struct fwnode_reference_args args;
+	void *ret;
+	int i;
+
+	for (i = 0; ; i++) {
+		if (fwnode_property_get_reference_args(fwnode, con_id, NULL, 0,
+						       i, &args))
+			break;
+
+		con.fwnode = args.fwnode;
+		ret = match(&con, -1, data);
+		fwnode_handle_put(args.fwnode);
+		if (ret)
+			return ret;
+	}
+
+	return NULL;
+}
+
 /**
  * device_connection_find_match - Find physical connection to a device
  * @dev: Device with the connection
@@ -65,6 +89,10 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 		ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
 		if (ret)
 			return ret;
+
+		ret = fwnode_devcon_match(fwnode, con_id, data, match);
+		if (ret)
+			return ret;
 	}
 
 	mutex_lock(&devcon_lock);
-- 
2.20.1

