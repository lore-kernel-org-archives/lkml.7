Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C159C072AD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F16216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ELBsaFN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfEQQrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:47:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45517 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfEQQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:47:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so3539037pgi.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dt/r9hghbvHRpM950rNfaqeDb6HHc3YxElzsbgb3628=;
        b=ELBsaFN8oBFo7zIK4AKnzx6dpfch/T8r5+SNxrpXpOQYdh4vleaWEpO9Y1yd1e7YpH
         v5v4iv3CmptHKW7CSR/OFrjxedmV7UdZYU0CuLLH0aHxSUHeot3mJ5kN7M5W10+7ssYv
         QR2zQxpcFQzfE91l4uLKK9N05oRfi2ZTVG+yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dt/r9hghbvHRpM950rNfaqeDb6HHc3YxElzsbgb3628=;
        b=AL52rZn6DC/65TE5YrfC1J5wpM0hil7xTb4GkJfd6Wlkt21Qypk0EPqGq5va4S1bXo
         IC8O4R91Bn8JTzR3y+OIESmO+3ZXtVAF5c7OUnAuVzafQrWXbJyfSVf/91QMGBty0AnQ
         o4YAZEMPmNsHRVuFhTGFBDTbEZcXspdib0vz8nHxF+KCQpqCxZCn76wlNXAk+w+8/2AJ
         Pbe3GTRrd8XKMZ2Ww1E7ChQ3r+QakUqCHuvB44Htu6hwfl2AO28dNiKjw1z2Ro0NkA/6
         yvlJ3sFDgxIxkXV/+3vppSgCyoB/tWK9udgJaU9h4q0BCiC5HEXSOF0UZz/NFFp0/duW
         ay2Q==
X-Gm-Message-State: APjAAAWN1XG1FK7FaIcCmDsPRehXst7HZF5ufWKKMvD4LPyKkOAXsRdh
        +l+csMcSQyNofGUEWrWySDPkzpgPi1V9zw==
X-Google-Smtp-Source: APXvYqxUOQ607cIWfGf9dbtUWQEfdBIaBbRL7/bhUOO2Fqka7KMkLhJ2lePdV2L8GZHvT7d0TjZSDg==
X-Received: by 2002:a63:4147:: with SMTP id o68mr55522959pga.76.1558111671899;
        Fri, 17 May 2019 09:47:51 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l141sm12229810pfd.24.2019.05.17.09.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 09:47:51 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC/PATCH 1/5] reserved_mem: Add a devm_memremap_reserved_mem() API
Date:   Fri, 17 May 2019 09:47:42 -0700
Message-Id: <20190517164746.110786-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190517164746.110786-1-swboyd@chromium.org>
References: <20190517164746.110786-1-swboyd@chromium.org>
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
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/of/of_reserved_mem.c    | 45 +++++++++++++++++++++++++++++++++
 include/linux/of_reserved_mem.h |  6 +++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 6a36bc0b3d64..39ab2bfd40d7 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"OF: reserved mem: " fmt
 
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
@@ -395,3 +396,47 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
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

