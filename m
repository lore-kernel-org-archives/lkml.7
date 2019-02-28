Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A058FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1E621850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbfB1KWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:22:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36482 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732285AbfB1KWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:22:47 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SAHtTx007035;
        Thu, 28 Feb 2019 11:20:08 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtwxpcm7w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 11:20:08 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B3A241;
        Thu, 28 Feb 2019 10:20:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC3B62C4A;
        Thu, 28 Feb 2019 10:20:06 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Feb 2019 11:20:06
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <lionel.debieve@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/6] nvmem: core: add nvmem_cell_read_u16
Date:   Thu, 28 Feb 2019 11:19:54 +0100
Message-ID: <1551349196-8956-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
References: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nvmem_cell_read_u16() helper to ease read of an u16 value on consumer
side. This is inspired by nvmem_cell_read_u32() function.
This helper is useful on stm32 that has 16 bits data cells stored in non
volatile memory.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/nvmem/core.c           | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |  7 +++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f7301bb..5bd48ed 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1331,6 +1331,43 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
 /**
+ * nvmem_cell_read_u16() - Read a cell value as an u16
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @cell_id: Name of nvmem cell to read.
+ * @val: pointer to output value.
+ *
+ * Return: 0 on success or negative errno.
+ */
+int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	size_t len;
+
+	cell = nvmem_cell_get(dev, cell_id);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	if (IS_ERR(buf)) {
+		nvmem_cell_put(cell);
+		return PTR_ERR(buf);
+	}
+	if (len != sizeof(*val)) {
+		kfree(buf);
+		nvmem_cell_put(cell);
+		return -EINVAL;
+	}
+	memcpy(val, buf, sizeof(*val));
+	kfree(buf);
+	nvmem_cell_put(cell);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_read_u16);
+
+/**
  * nvmem_cell_read_u32() - Read a cell value as an u32
  *
  * @dev: Device that requests the nvmem cell.
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 312bfa5..8f8be5b 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -61,6 +61,7 @@ void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
+int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
 int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
 
 /* direct nvmem device read/write interface */
@@ -122,6 +123,12 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
 	return -EOPNOTSUPP;
 }
 
+static inline int nvmem_cell_read_u16(struct device *dev,
+				      const char *cell_id, u16 *val)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int nvmem_cell_read_u32(struct device *dev,
 				      const char *cell_id, u32 *val)
 {
-- 
2.7.4

