Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E04C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F125221924
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390565AbfIFUza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:55:30 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:43837 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387845AbfIFUz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:55:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 16215182CF669;
        Fri,  6 Sep 2019 20:55:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crib41_2f8de0bcaf609
X-Filterd-Recvd-Size: 3286
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Sep 2019 20:55:26 +0000 (UTC)
Message-ID: <f64f4ccd12ac9de5368a2d312751d7afae45f824.camel@perches.com>
Subject: Re: [PATCH] Fixed parentheses malpractice in apex_driver.c
From:   Joe Perches <joe@perches.com>
To:     volery <sandro@volery.com>, rspringer@google.com,
        toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 06 Sep 2019 13:55:24 -0700
In-Reply-To: <20190906183801.GA2456@volery>
References: <20190906183801.GA2456@volery>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-06 at 20:38 +0200, volery wrote:
> There were some parentheses at the end of lines, which I took care of.

Not every instance of this checkpatch warning should be changed.

This specific instance is because it uses very long identifiers
and really maybe should just be left alone.

> This is my first patch.

Welcome, try again though.

If you really want to do something here maybe do something like
use temporaries to reduce line length and remove multiple
scnprintf statements.  This would also reduce object size.

---
 drivers/staging/gasket/apex_driver.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 2973bb920a26..ae1a3a14dde6 100644
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
@@ -524,29 +526,27 @@ static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
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
 
+	ret = scnprintf(buf, PAGE_SIZE, "%u\n", val);
+
+exit:
 	gasket_sysfs_put_attr(device, gasket_attr);
 	gasket_sysfs_put_device_data(device, gasket_dev);
 	return ret;


