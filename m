Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44116C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153672073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfKZJon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:44:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:61239 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfKZJom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:44:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 01:44:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="220576352"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga002.jf.intel.com with ESMTP; 26 Nov 2019 01:44:40 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: bus: use simple sprintf for sysfs
Date:   Tue, 26 Nov 2019 14:30:02 +0200
Message-Id: <20191126123002.4835-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace scnprintf with simple sprintf for sysfs files.
it is implicitly known that the buffer is big enough
for the variables to fit in.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index a0a495c95e3c..8d468e0a950a 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -765,7 +765,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *a,
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	const uuid_le *uuid = mei_me_cl_uuid(cldev->me_cl);
 
-	return scnprintf(buf, PAGE_SIZE, "%pUl", uuid);
+	return sprintf(buf, "%pUl", uuid);
 }
 static DEVICE_ATTR_RO(uuid);
 
@@ -775,7 +775,7 @@ static ssize_t version_show(struct device *dev, struct device_attribute *a,
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	u8 version = mei_me_cl_ver(cldev->me_cl);
 
-	return scnprintf(buf, PAGE_SIZE, "%02X", version);
+	return sprintf(buf, "%02X", version);
 }
 static DEVICE_ATTR_RO(version);
 
@@ -797,7 +797,7 @@ static ssize_t max_conn_show(struct device *dev, struct device_attribute *a,
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	u8 maxconn = mei_me_cl_max_conn(cldev->me_cl);
 
-	return scnprintf(buf, PAGE_SIZE, "%d", maxconn);
+	return sprintf(buf, "%d", maxconn);
 }
 static DEVICE_ATTR_RO(max_conn);
 
@@ -807,7 +807,7 @@ static ssize_t fixed_show(struct device *dev, struct device_attribute *a,
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	u8 fixed = mei_me_cl_fixed(cldev->me_cl);
 
-	return scnprintf(buf, PAGE_SIZE, "%d", fixed);
+	return sprintf(buf, "%d", fixed);
 }
 static DEVICE_ATTR_RO(fixed);
 
@@ -817,7 +817,7 @@ static ssize_t max_len_show(struct device *dev, struct device_attribute *a,
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	u32 maxlen = mei_me_cl_max_len(cldev->me_cl);
 
-	return scnprintf(buf, PAGE_SIZE, "%u", maxlen);
+	return sprintf(buf, "%u", maxlen);
 }
 static DEVICE_ATTR_RO(max_len);
 
-- 
2.21.0

