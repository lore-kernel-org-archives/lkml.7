Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66FCC49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD95021670
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WgGiFGhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436686AbfIJQJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:09:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39296 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436534AbfIJQJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:09:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so9977582pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUiGHkQMIXTru33NEpbepH3aRpqrcccJiliaWHN/NLg=;
        b=WgGiFGhC0+fEZ7JT0OjNHDyPLtBG3IXaHE9JpZEtRV2XqVoXUnKBH4yKD0ALDyd9ck
         2OM4E+GQhSWHovAAda2EVwo5DBAambJGR6Ru/sygZR/+5MmXPszT57QDh4A2TkuPw88h
         HrfbDrERmKljT3OSSYd7McTkRH1e1rZdAj67s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUiGHkQMIXTru33NEpbepH3aRpqrcccJiliaWHN/NLg=;
        b=U+yQ/X+J8uweClLQj8rEx28PQauKVgdY1+tkU52rvLmCYc6DxFkyjE0nAsnyK6xoxz
         JjBdG2eh97mlz2nQ0uSOOTILKelKfKqrZY9D2BikrNIFxPz62RuuRlhdqgw3zHDmpbu+
         x/g7YXpP1BEd9sqD0ATGyw0f9HBDut8DOhGyrowKWkPzZmDA4dk5sfVjWCvBOyet7Lsf
         HD6J6qgTLwOp8dmXjZeQBmpgnsLon8Qgp6Q/ryAgfye4fNUraZRR793o9+aurcxN9TYT
         Ll+U/FAIEQejMr5aTeyysThOB8sLpuUAuJFCMtHDVzp3d7srIv7x03Qe0tU++T8VP1O0
         h+Kg==
X-Gm-Message-State: APjAAAW7tpdAkYVPAMxf3QFfHR2Xx8mjXXcJXP9QIhp72fyMmLRv5GGY
        B7E2/Je0KW/XaWZGYRD0EyIjAw==
X-Google-Smtp-Source: APXvYqwEeEfNXla76FaGP5TGBYBOatyT898AHWyJZN2OgmIQpcAR1+y4Xp5qzzvgO8bXi6iPgi7SEA==
X-Received: by 2002:a63:f04:: with SMTP id e4mr27801248pgl.38.1568131745594;
        Tue, 10 Sep 2019 09:09:05 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id em21sm106088pjb.31.2019.09.10.09.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 09:09:05 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/5] reserved_mem: Add a devm_memremap_reserved_mem() API
Date:   Tue, 10 Sep 2019 09:08:59 -0700
Message-Id: <20190910160903.65694-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190910160903.65694-1-swboyd@chromium.org>
References: <20190910160903.65694-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a few drivers that need to get a reserved memory region, request
the region, and map the reserved memory with memremap(). Add an API to
do this all in one function call.

Cc: Evan Green <evgreen@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/of/of_reserved_mem.c    | 45 +++++++++++++++++++++++++++++++++
 include/linux/of_reserved_mem.h |  6 +++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7989703b883c..b3899a2c74c4 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"OF: reserved mem: " fmt
 
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
@@ -410,3 +411,47 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
+
+/**
+ * devm_memremap_reserved_mem() - acquire reserved_mem from a device node,
+ *                                request and memremap it
+ * @dev: device with node pointer of the desired reserved-memory region
+ * @flags: flags to pass to memremap()
+ *
+ * This function allows drivers to acquire a reference to the reserved_mem
+ * struct based on the device's device_node handle, request it and then
+ * memremap() it.
+ *
+ * Returns: A remapped reserved memory region, or an error pointer on failure.
+ */
+void *devm_memremap_reserved_mem(struct device *dev, unsigned long flags)
+{
+	void *dest_ptr;
+	struct reserved_mem *rmem;
+	struct resource *res;
+	const char *name;
+
+	rmem = of_reserved_mem_lookup(dev->of_node);
+	if (!rmem) {
+		dev_err(dev, "failed to acquire memory region\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	name = rmem->name ? : dev_name(dev);
+
+	res = devm_request_mem_region(dev, rmem->base, rmem->size, name);
+	if (!res) {
+		dev_err(dev, "can't request region for reserved memory\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	dest_ptr = devm_memremap(dev, rmem->base, rmem->size, flags);
+	if (!dest_ptr) {
+		dev_err(dev, "memremap failed for reserved memory\n");
+		devm_release_mem_region(dev, rmem->base, rmem->size);
+		dest_ptr = ERR_PTR(-ENOMEM);
+	}
+
+	return dest_ptr;
+}
+EXPORT_SYMBOL_GPL(devm_memremap_reserved_mem);
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 60f541912ccf..a36be60ef67c 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -39,6 +39,7 @@ void fdt_init_reserved_mem(void);
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 			       phys_addr_t base, phys_addr_t size);
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
+void *devm_memremap_reserved_mem(struct device *dev, unsigned long flags);
 #else
 static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
 					struct device_node *np, int idx)
@@ -54,6 +55,11 @@ static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np
 {
 	return NULL;
 }
+static inline void *devm_memremap_reserved_mem(struct device *dev,
+					       unsigned long flags)
+{
+	return NULL;
+}
 #endif
 
 /**
-- 
Sent by a computer through tubes

