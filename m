Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86BCC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CE120828
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLWOSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:18:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:47069 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfLWOR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="223029911"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 06:17:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F0473A4D; Mon, 23 Dec 2019 16:17:17 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/37] platform/x86: intel_scu_ipcutil: Convert to use new SCU IPC API
Date:   Mon, 23 Dec 2019 17:16:56 +0300
Message-Id: <20191223141716.13727-18-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the IPC util to use the new SCU IPC API where the SCU IPC
instance is passed to the functions.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipcutil.c | 43 +++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x86/intel_scu_ipcutil.c
index 8afe6fa06d7b..b7c10c15a3d6 100644
--- a/drivers/platform/x86/intel_scu_ipcutil.c
+++ b/drivers/platform/x86/intel_scu_ipcutil.c
@@ -22,6 +22,9 @@
 
 static int major;
 
+struct intel_scu_ipc_dev *scu;
+static DEFINE_MUTEX(scu_lock);
+
 /* IOCTL commands */
 #define	INTE_SCU_IPC_REGISTER_READ	0
 #define INTE_SCU_IPC_REGISTER_WRITE	1
@@ -52,12 +55,12 @@ static int scu_reg_access(u32 cmd, struct scu_ipc_data  *data)
 
 	switch (cmd) {
 	case INTE_SCU_IPC_REGISTER_READ:
-		return intel_scu_ipc_readv(data->addr, data->data, count);
+		return intel_scu_ipc_dev_readv(scu, data->addr, data->data, count);
 	case INTE_SCU_IPC_REGISTER_WRITE:
-		return intel_scu_ipc_writev(data->addr, data->data, count);
+		return intel_scu_ipc_dev_writev(scu, data->addr, data->data, count);
 	case INTE_SCU_IPC_REGISTER_UPDATE:
-		return intel_scu_ipc_update_register(data->addr[0],
-						    data->data[0], data->mask);
+		return intel_scu_ipc_dev_update(scu, data->addr[0], data->data[0],
+						data->mask);
 	default:
 		return -ENOTTY;
 	}
@@ -91,8 +94,40 @@ static long scu_ipc_ioctl(struct file *fp, unsigned int cmd,
 	return 0;
 }
 
+static int scu_ipc_open(struct inode *inode, struct file *file)
+{
+	int ret = 0;
+
+	/* Only single open at the time */
+	mutex_lock(&scu_lock);
+	if (scu) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	scu = intel_scu_ipc_dev_get();
+	if (!scu)
+		ret = -ENODEV;
+
+unlock:
+	mutex_unlock(&scu_lock);
+	return ret;
+}
+
+static int scu_ipc_release(struct inode *inode, struct file *file)
+{
+	mutex_lock(&scu_lock);
+	intel_scu_ipc_dev_put(scu);
+	scu = NULL;
+	mutex_unlock(&scu_lock);
+
+	return 0;
+}
+
 static const struct file_operations scu_ipc_fops = {
 	.unlocked_ioctl = scu_ipc_ioctl,
+	.open = scu_ipc_open,
+	.release = scu_ipc_release,
 };
 
 static int __init ipc_module_init(void)
-- 
2.24.0

