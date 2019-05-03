Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B02C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5051B2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfECIpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:5545 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfECIps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811600"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:46 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 17/22] intel_th: msu: Add a sysfs attribute to trigger window switch
Date:   Fri,  3 May 2019 11:44:50 +0300
Message-Id: <20190503084455.23436-18-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the means to trigger a window switch for the MSU trace
store, add a sysfs file to allow triggering it from userspace.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 .../testing/sysfs-bus-intel_th-devices-msc    |  8 ++++++
 drivers/hwtracing/intel_th/msu.c              | 28 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc b/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
index b940c5d91cf7..f54ae244f3f1 100644
--- a/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
+++ b/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
@@ -30,4 +30,12 @@ Description:	(RW) Configure MSC buffer size for "single" or "multi" modes.
 		there are no active users and tracing is not enabled) and then
 		allocates a new one.
 
+What:		/sys/bus/intel_th/devices/<intel_th_id>-msc<msc-id>/win_switch
+Date:		May 2019
+KernelVersion:	5.2
+Contact:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
+Description:	(RW) Trigger window switch for the MSC's buffer, in
+		multi-window mode. In "multi" mode, accepts writes of "1", thereby
+		triggering a window switch for the buffer. Returns an error in any
+		other operating mode or attempts to write something other than "1".
 
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 01408a0e2458..089fd1f90a9f 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1592,10 +1592,38 @@ nr_pages_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RW(nr_pages);
 
+static ssize_t
+win_switch_store(struct device *dev, struct device_attribute *attr,
+		 const char *buf, size_t size)
+{
+	struct msc *msc = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val != 1)
+		return -EINVAL;
+
+	mutex_lock(&msc->buf_mutex);
+	if (msc->mode != MSC_MODE_MULTI)
+		ret = -ENOTSUPP;
+	else
+		ret = intel_th_trace_switch(msc->thdev);
+	mutex_unlock(&msc->buf_mutex);
+
+	return ret ? ret : size;
+}
+
+static DEVICE_ATTR_WO(win_switch);
+
 static struct attribute *msc_output_attrs[] = {
 	&dev_attr_wrap.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_nr_pages.attr,
+	&dev_attr_win_switch.attr,
 	NULL,
 };
 
-- 
2.20.1

