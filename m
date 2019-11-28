Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA42C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED8021741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="BUmfz3aL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK1LeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:34:23 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22458 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbfK1LeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:34:23 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASBRQXs001753;
        Thu, 28 Nov 2019 12:34:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=vcru8Yw5xoPG8rIOJUSk+LjLaSpyvHCsGnBcaiG0UXs=;
 b=BUmfz3aLsGtIMdxzjllOfORoAqCvdHX/pbe4Y9wp1txnkXB4v+FlmqmOSec+50gtVfxJ
 rr7QJzuM7iCp77a4vH062kg5Eg42MBxJVV7k9Yk0uoShOYtuBYcjHF0M0GtVOqz0NIxw
 fSiknbLvVPinYBn0TMy/I1aUenbESRFtQH2JNxv4WIF0gyrkKiKZXqE5JoxV5jdRF5ZO
 R36NN+KAEhKfLnVrAP9XQ4ygZCqNYYHZHhxnPdnFauMY1GwsushClUOW2KGQdcR/QOZ3
 wREuol3lx7/EG8o2L6hAmIm9jbDCfLIZn8s4c8oe2LDQunJjBYXKAMDi37SjATQfIy1X eQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxshrhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 12:34:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8131F100038;
        Thu, 28 Nov 2019 12:34:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 72FC32B1882;
        Thu, 28 Nov 2019 12:34:18 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Nov 2019 12:34:17
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <fabien.dessenne@st.com>, <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 1/1] remoteproc: add support for co-processor loaded and booted before kernel
Date:   Thu, 28 Nov 2019 12:33:51 +0100
Message-ID: <1574940831-7433-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote processor could boot independently or be loaded/started before
Linux kernel by bootloader or any firmware.
This patch introduces a new property in rproc core, named skip_fw_load,
to be able to allocate resources and sub-devices like vdev and to
synchronize with current state without loading firmware from file system.
It is platform driver responsibility to implement the right firmware
load ops according to HW specificities.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

---
Change from v3:
- add comment about firmware NULL pointer
- add Mathieu Poirier Ack
Change from v2:
- rename property into skip_fw_load
- update rproc_boot and rproc_fw_boot description
- update commit message
Change from v1:
- Keep bool in struct rproc
---
 drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++++++++++--------
 include/linux/remoteproc.h           |  2 ++
 2 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 307df98347ba..367a7929b7a0 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1358,8 +1358,19 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
-/*
- * take a firmware and boot a remote processor with it.
+/**
+ * rproc_fw_boot() - boot specified remote processor according to specified
+ * firmware
+ * @rproc: handle of a remote processor
+ * @fw: pointer on firmware to handle
+ *
+ * Handle resources defined in resource table, load firmware and
+ * start remote processor.
+ *
+ * If firmware pointer fw is NULL, firmware is not handled by remoteproc
+ * core, but under the responsibility of platform driver.
+ *
+ * Returns 0 on success, and an appropriate error value otherwise.
  */
 static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 {
@@ -1371,7 +1382,11 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	if (ret)
 		return ret;
 
-	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
+	if (fw)
+		dev_info(dev, "Booting fw image %s, size %zd\n", name,
+			 fw->size);
+	else
+		dev_info(dev, "Synchronizing with preloaded co-processor\n");
 
 	/*
 	 * if enabling an IOMMU isn't relevant for this rproc, this is
@@ -1718,16 +1733,22 @@ static void rproc_crash_handler_work(struct work_struct *work)
  * rproc_boot() - boot a remote processor
  * @rproc: handle of a remote processor
  *
- * Boot a remote processor (i.e. load its firmware, power it on, ...).
+ * Boot a remote processor (i.e. load its firmware, power it on, ...) from
+ * different contexts:
+ * - power off
+ * - preloaded firmware
+ * - started before kernel execution
+ * The different operations are selected thanks to properties defined by
+ * platform driver.
  *
- * If the remote processor is already powered on, this function immediately
- * returns (successfully).
+ * If the remote processor is already powered on at rproc level, this function
+ * immediately returns (successfully).
  *
  * Returns 0 on success, and an appropriate error value otherwise.
  */
 int rproc_boot(struct rproc *rproc)
 {
-	const struct firmware *firmware_p;
+	const struct firmware *firmware_p = NULL;
 	struct device *dev;
 	int ret;
 
@@ -1758,11 +1779,20 @@ int rproc_boot(struct rproc *rproc)
 
 	dev_info(dev, "powering up %s\n", rproc->name);
 
-	/* load firmware */
-	ret = request_firmware(&firmware_p, rproc->firmware, dev);
-	if (ret < 0) {
-		dev_err(dev, "request_firmware failed: %d\n", ret);
-		goto downref_rproc;
+	if (!rproc->skip_fw_load) {
+		/* load firmware */
+		ret = request_firmware(&firmware_p, rproc->firmware, dev);
+		if (ret < 0) {
+			dev_err(dev, "request_firmware failed: %d\n", ret);
+			goto downref_rproc;
+		}
+	} else {
+		/*
+		 * Set firmware name pointer to null as remoteproc core is not
+		 * in charge of firmware loading
+		 */
+		kfree(rproc->firmware);
+		rproc->firmware = NULL;
 	}
 
 	ret = rproc_fw_boot(rproc, firmware_p);
@@ -1916,8 +1946,17 @@ int rproc_add(struct rproc *rproc)
 	/* create debugfs entries */
 	rproc_create_debug_dir(rproc);
 
-	/* if rproc is marked always-on, request it to boot */
-	if (rproc->auto_boot) {
+	if (rproc->skip_fw_load) {
+		/*
+		 * If rproc is marked already booted, no need to wait
+		 * for firmware.
+		 * Just handle associated resources and start sub devices
+		 */
+		ret = rproc_boot(rproc);
+		if (ret < 0)
+			return ret;
+	} else if (rproc->auto_boot) {
+		/* if rproc is marked always-on, request it to boot */
 		ret = rproc_trigger_auto_boot(rproc);
 		if (ret < 0)
 			return ret;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad66683ad0..4fd5bedab4fa 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -479,6 +479,7 @@ struct rproc_dump_segment {
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @auto_boot: flag to indicate if remote processor should be auto-started
+ * @skip_fw_load: remote processor has been preloaded before start sequence
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
  */
@@ -512,6 +513,7 @@ struct rproc {
 	size_t table_sz;
 	bool has_iommu;
 	bool auto_boot;
+	bool skip_fw_load;
 	struct list_head dump_segments;
 	int nb_vdev;
 };
-- 
2.7.4

