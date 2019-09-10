Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E92C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A002089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393414AbfIJGTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:19:37 -0400
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:31811 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730336AbfIJGTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:19:37 -0400
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7ZUw-000CyG-0M; Tue, 10 Sep 2019 08:19:30 +0200
Received: from 8.28.150.83.ftth.ewwwb.as8758.net ([83.150.28.8] helo=volery)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7ZUv-000IZx-TV; Tue, 10 Sep 2019 08:19:29 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Date:   Tue, 10 Sep 2019 08:19:28 +0200
From:   Sandro Volery <sandro@volery.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     joe@perches.com
Subject: [PATCH v3] Staging: gasket: Use temporaries to reduce line length.
Message-ID: <20190910061928.GA9623@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using temporaries for gasket_page_table entries to remove scnprintf()
statements and reduce line length, as suggested by Joe Perches. Thanks!

Signed-off-by: Sandro Volery <sandro@volery.com>
---
v3: Fixed faulty copy/paste of function
v2: Attempt to fix
v1: Original patch


 drivers/staging/gasket/apex_driver.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 2973bb920a26..46199c8ca441 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -509,6 +509,8 @@ static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
 	struct gasket_dev *gasket_dev;
 	struct gasket_sysfs_attribute *gasket_attr;
 	enum sysfs_attribute_type type;
+	struct gasket_page_table *gpt;
+	uint val;
 
 	gasket_dev = gasket_sysfs_get_device_data(device);
 	if (!gasket_dev) {
@@ -524,29 +526,25 @@ static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
 	}
 
 	type = (enum sysfs_attribute_type)gasket_attr->data.attr_type;
+	gpt = gasket_dev->page_table[0];
 	switch (type) {
 	case ATTR_KERNEL_HIB_PAGE_TABLE_SIZE:
-		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
-				gasket_page_table_num_entries(
-					gasket_dev->page_table[0]));
+		val = gasket_page_table_num_entries(gpt);
 		break;
 	case ATTR_KERNEL_HIB_SIMPLE_PAGE_TABLE_SIZE:
-		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
-				gasket_page_table_num_simple_entries(
-					gasket_dev->page_table[0]));
+		val = gasket_page_table_num_simple_entries(gpt);
 		break;
 	case ATTR_KERNEL_HIB_NUM_ACTIVE_PAGES:
-		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
-				gasket_page_table_num_active_pages(
-					gasket_dev->page_table[0]));
+		val = gasket_page_table_num_active_pages(gpt);
 		break;
 	default:
 		dev_dbg(gasket_dev->dev, "Unknown attribute: %s\n",
 			attr->attr.name);
 		ret = 0;
-		break;
+		goto exit;
 	}
-
+	ret = scnprintf(buf, PAGE_SIZE, "%u\n", val);
+exit:
 	gasket_sysfs_put_attr(device, gasket_attr);
 	gasket_sysfs_put_device_data(device, gasket_dev);
 	return ret;
-- 
2.23.0

