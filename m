Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1944C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6907E2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdLcW4tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfDMKeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:34:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41680 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfDMKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so15095880wrq.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=susrZ/t6ndqXD8gtL1bPnnTkE0wp/sBtA8tijngjVXE=;
        b=rdLcW4txUmwM07tUHPT2l3M+l+eVZcPG/na6ShUXFajhnSMt2eiekl30h1qy1i30T6
         AsUa8twbaAjzvT21dRHaYu2W3BTGKvkkQRSGBnxGyOtzI7QcUSEcuPEkQ7spBR5nBFh8
         6cipjcQvTbdYihOZb9xFpR9MTS+po5v3hqgFY4EAckXeOy4oC9R84gVAnnYAzxBznt/W
         wmebPIinsysxPhwkPK85tpfpBCl9gKQAyXJWkes3pYRKC0t+Zft5n1EusCaBdN9mkvTJ
         6PyC6nVzySr4UNx6X0/183vGY186BTD1jb6PxK3l76B9fiDiEP9actBps1lsfjSlG+k/
         Bg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=susrZ/t6ndqXD8gtL1bPnnTkE0wp/sBtA8tijngjVXE=;
        b=CVGZfC0UhOWS655Z49wTDgky3UNNjazTIbn5K1uwJ4m5R5cuq0V8NvE5FjcbvsnKTS
         KyhRAaN2XUDj3QeSMmHYb69egoQcc/QtAhFTrKNV77P+SXs/RZoyrgOZX2QRYTe6ToWy
         F4ajWJFTWNwIAWncHDLIYUBmPvhcMPfBw6mgzj1ez87OPeKV79DTSO30Mt06MXx6qY+Z
         3oNk0jOt9EJZFcHXKTstQE4Z18XEWP6jPIMELhrM6+kecx5UIVFWWnyeWAw4dVIdlLgT
         t1YvLd45YkqQBEenvNc+jxvZfMvpbjN/XrdBXx/yABM45+rL/lk8LpYdxwIjDYZuNgk9
         dIbQ==
X-Gm-Message-State: APjAAAVf3qbAyuMBPJpw1MYpXMsZ25lGC3d6oBrTPkhMq/Dh5jowKIi/
        CO9iV7TEGa5UY9KyR8tz0tKq+A==
X-Google-Smtp-Source: APXvYqzrsMkG/DCCra1JVb+pu5YvF6NnlYujwqN9NUsl/WAnu6hjaQ86nwM7JK+chN+zdgQ4iHYROQ==
X-Received: by 2002:adf:b60a:: with SMTP id f10mr8879614wre.116.1555151600081;
        Sat, 13 Apr 2019 03:33:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 12/20] nvmem: core: add nvmem_cell_read_u16
Date:   Sat, 13 Apr 2019 11:32:57 +0100
Message-Id: <20190413103305.9576-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

Add nvmem_cell_read_u16() helper to ease read of an u16 value on consumer
side. This is inspired by nvmem_cell_read_u32() function.
This helper is useful on stm32 that has 16 bits data cells stored in non
volatile memory.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 37 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |  7 +++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f24008b66826..1d00f5671368 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1334,6 +1334,43 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
+/**
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
 /**
  * nvmem_cell_read_u32() - Read a cell value as an u32
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 312bfa5efd80..8f8be5b00060 100644
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
2.21.0

