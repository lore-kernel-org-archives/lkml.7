Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA37C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC552087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfECIqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:46:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:5545 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfECIpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811608"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:51 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 20/22] intel_th: msu: Add a sysfs attribute showing possible modes
Date:   Fri,  3 May 2019 11:44:53 +0300
Message-Id: <20190503084455.23436-21-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of dynamically loadable buffer drivers, there needs
to be a way of knowing the currently available ones without having to
scan the list of loaded modules or trial and error.

Add a sysfs file that lists all the currently available "modes", listing
both the MSC hardware operating modes and loaded buffer drivers.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 .../testing/sysfs-bus-intel_th-devices-msc    |  8 +++++++
 drivers/hwtracing/intel_th/msu.c              | 24 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc b/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
index 7da00601afdc..a6dec69cf92e 100644
--- a/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
+++ b/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
@@ -40,3 +40,11 @@ Description:	(RW) Trigger window switch for the MSC's buffer, in
 		triggering a window switch for the buffer. Returns an error in any
 		other operating mode or attempts to write something other than "1".
 
+What:		/sys/bus/intel_th/devices/<intel_th_id>-msc<msc-id>/modes
+Date:		May 2019
+KernelVersion:	5.2
+Contact:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
+Description:	(RO) Lists all possible modes, that is, values that can be
+		written to the "mode" file described above. This includes
+		the hardware operating modes ("single", "multi", etc) and
+		all the buffer drivers that are currently loaded.
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 04bfe4dbf325..71529cd18d93 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1866,6 +1866,29 @@ mode_store(struct device *dev, struct device_attribute *attr, const char *buf,
 
 static DEVICE_ATTR_RW(mode);
 
+static ssize_t
+modes_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct msu_buffer *mbuf;
+	ssize_t ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(msc_mode); i++)
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
+				 msc_mode[i]);
+
+	mutex_lock(&msu_buffer_mutex);
+	list_for_each_entry(mbuf, &msu_buffer_list, entry) {
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
+				 mbuf->bdrv->name);
+	}
+	mutex_unlock(&msu_buffer_mutex);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(modes);
+
 static ssize_t
 nr_pages_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -1999,6 +2022,7 @@ static DEVICE_ATTR_WO(win_switch);
 static struct attribute *msc_output_attrs[] = {
 	&dev_attr_wrap.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_modes.attr,
 	&dev_attr_nr_pages.attr,
 	&dev_attr_win_switch.attr,
 	NULL,
-- 
2.20.1

