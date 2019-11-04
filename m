Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D259CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7B21D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="DzPbsaQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfKDKtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:49:41 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6428 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbfKDKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:49:41 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4AgRhm026656;
        Mon, 4 Nov 2019 11:49:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Xxv6hexlHyBK0lKPtSxLBgui2G4ceCRUWdaxJuKarqI=;
 b=DzPbsaQ02gKbFthT2ckIKDv0QcE4iwmaT42C1t4vvzjm5h44klp7iqWadNTIdx8ZN5c/
 kXE+AGwJAQiWGGV+HzILldy1tk5tJF15fjHxQ/q/4Fd0IDLEttpFGqX3/hI3QLfVqXus
 oFeo/OFW7BWPojfwqUfw9X7EnqFs+z5GKfsryAKclMnzam3Ea5cIQ/sQzj8uWhlUDlU4
 RflfAFH9hYO1/QDCxoqQLyQa07HNq6g9qkE9gjGb7zOGWdtn929lPoRYwH98qn0454O0
 C7BTdIb26+jg8Vv+PydPj0gfGhHJLXs78DFpuEgvnIpRuAwQ2nZeuHvmSX+T8MrBRLnv 5Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w0ytchma3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 11:49:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CFA0210002A;
        Mon,  4 Nov 2019 11:49:34 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BF0E62BDA87;
        Mon,  4 Nov 2019 11:49:34 +0100 (CET)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019
 11:49:34 +0100
Received: from localhost (10.201.28.45) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019 11:49:32
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <fabien.dessenne@st.com>, <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v2 1/1] remoteproc: add support for co-processor booted before kernel
Date:   Mon, 4 Nov 2019 11:49:30 +0100
Message-ID: <1572864570-10131-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.28.45]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_06:2019-11-01,2019-11-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote processor could boot independently or be started before Linux
kernel by bootloader or any firmware.
This patch introduces a new property in rproc core, named preloaded,
to be able to allocate resources and sub-devices like vdev and to
synchronize with current state without loading firmware from file system.
It is platform driver responsibility to implement the right firmware
load ops according to HW specificities.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>

---
Change from v1:
- Keep bool in struct rproc
---
 drivers/remoteproc/remoteproc_core.c | 37 +++++++++++++++++++++++++++---------
 include/linux/remoteproc.h           |  2 ++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3c5fbbbfb0f1..7eaf0f949afa 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1372,7 +1372,11 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
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
@@ -1728,7 +1732,7 @@ static void rproc_crash_handler_work(struct work_struct *work)
  */
 int rproc_boot(struct rproc *rproc)
 {
-	const struct firmware *firmware_p;
+	const struct firmware *firmware_p = NULL;
 	struct device *dev;
 	int ret;
 
@@ -1759,11 +1763,17 @@ int rproc_boot(struct rproc *rproc)
 
 	dev_info(dev, "powering up %s\n", rproc->name);
 
-	/* load firmware */
-	ret = request_firmware(&firmware_p, rproc->firmware, dev);
-	if (ret < 0) {
-		dev_err(dev, "request_firmware failed: %d\n", ret);
-		goto downref_rproc;
+	if (!rproc->preloaded) {
+		/* load firmware */
+		ret = request_firmware(&firmware_p, rproc->firmware, dev);
+		if (ret < 0) {
+			dev_err(dev, "request_firmware failed: %d\n", ret);
+			goto downref_rproc;
+		}
+	} else {
+		/* set firmware name to null as unknown */
+		kfree(rproc->firmware);
+		rproc->firmware = NULL;
 	}
 
 	ret = rproc_fw_boot(rproc, firmware_p);
@@ -1917,8 +1927,17 @@ int rproc_add(struct rproc *rproc)
 	/* create debugfs entries */
 	rproc_create_debug_dir(rproc);
 
-	/* if rproc is marked always-on, request it to boot */
-	if (rproc->auto_boot) {
+	if (rproc->preloaded) {
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
index 16ad66683ad0..b68fbd576a77 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -479,6 +479,7 @@ struct rproc_dump_segment {
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @auto_boot: flag to indicate if remote processor should be auto-started
+ * @preloaded: remote processor has been preloaded before start sequence
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
  */
@@ -512,6 +513,7 @@ struct rproc {
 	size_t table_sz;
 	bool has_iommu;
 	bool auto_boot;
+	bool preloaded;
 	struct list_head dump_segments;
 	int nb_vdev;
 };
-- 
2.7.4

