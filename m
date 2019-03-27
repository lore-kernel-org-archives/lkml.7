Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B880C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF8D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfC0Qny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:43:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:62434 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfC0Qnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:43:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 09:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="158912750"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2019 09:43:48 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: typec: mux: Use the "compatible" property instead of a boolean property
Date:   Wed, 27 Mar 2019 19:43:39 +0300
Message-Id: <20190327164339.31205-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
References: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of searching for a boolean property, matching
against the "compatible" property.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 2ce54f3fc79c..9462b90f1c09 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -32,11 +32,7 @@ static void *typec_switch_match(struct device_connection *con, int ep,
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	/*
-	 * With OF graph the mux node must have a boolean device property named
-	 * "orientation-switch".
-	 */
-	if (con->id && !fwnode_property_present(con->fwnode, con->id))
+	if (con->id && !fwnode_is_compatible(con->fwnode, con->id))
 		return NULL;
 
 	list_for_each_entry(sw, &switch_list, entry)
@@ -148,7 +144,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 
 	/* Accessory Mode muxes */
 	if (!desc) {
-		match = fwnode_property_present(con->fwnode, "accessory");
+		match = fwnode_is_compatible(con->fwnode, "accessory");
 		if (match)
 			goto find_mux;
 		return NULL;
-- 
2.20.1

