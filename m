Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF11FC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B4E2235B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vFUrTqeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfHGJlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:41:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58002 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728464AbfHGJlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:41:32 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x779bJlx019514;
        Wed, 7 Aug 2019 11:41:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=NDTphXUxNX0A0wt98y+fvx9xGASfAZu3dV5v6VBAlYA=;
 b=vFUrTqeTvTsLMweXVCQmQJ2Uig4BcKud93Z1awHvfMg5WZ4GJKMgnIiy3SsY7v9vCcjK
 njO0IyXXTEpSc8CJq+ppwDy0sCDmuW69vJUpK0CIdcnu8yeWn9bu+yaDYpYeUZN4Cu7N
 +0U3VUgsam3BMT3JTo2g1n8DQv0LfORx/cjcQMAn8i1YGYsoHkSMADw/MapM94lKyB6K
 1FuTX8CUPS3p6WnGcAr+l9ksbd6sFcu47DqmJVySGjSMXcnduh8kzmoZRKMgnBPxOdSi
 aSzHobDA6zvWPDb9lE3Ve43Yozy01JGWc9QLZhfcsc5B+fMf6ToBfxge6uMfGJnXWCkk JQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u515mp677-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 07 Aug 2019 11:41:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 69C2231;
        Wed,  7 Aug 2019 09:41:27 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F9482DD398;
        Wed,  7 Aug 2019 11:41:27 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 7 Aug 2019
 11:41:27 +0200
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 7 Aug 2019 11:41:26
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <fabien.dessenne@st.com>, <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [RESEND 2/2] remoteproc: add support for co-processor booted before kernel
Date:   Wed, 7 Aug 2019 11:41:19 +0200
Message-ID: <1565170879-3185-3-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565170879-3185-1-git-send-email-loic.pallardy@st.com>
References: <1565170879-3185-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_02:,,
 signatures=0
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
index 8cd22fecea61..27f0dfdd3837 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -481,6 +481,7 @@ struct rproc_dump_segment {
  * @recovery_disabled: flag that state if recovery was disabled
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @auto_boot: flag to indicate if remote processor should be auto-started
+ * @preloaded: remote processor has been preloaded before start sequence
  */
 struct rproc {
 	struct list_head node;
@@ -514,6 +515,7 @@ struct rproc {
 	u8 recovery_disabled;
 	u8 has_iommu;
 	u8 auto_boot;
+	u8 preloaded;
 };
 
 /**
-- 
2.7.4

