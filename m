Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87526C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAE221897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z47PlhiQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T034DQ0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbfIRSre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:47:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfIRSre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:47:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 996B3602DB; Wed, 18 Sep 2019 18:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568832453;
        bh=5oS7pWst8ob1JtyReeLEB0WMmJKEh6kxEfBnEFKFVE0=;
        h=From:To:Cc:Subject:Date:From;
        b=Z47PlhiQ1VQ0yvvQ5HzdI7NbB6BLbGtFf/1xyomqQLLCyeaGRIHJN4efPfou8GDme
         sHZdc8tPrn0CStN1WsKOlqohHEa0XrwgN/7Y1ufc9iIVsM6U359JWVs1TJRxXgqYJ4
         2wJxgSOH4JD+lszdyvPCvXt+M74LGOeG3uZKg28w=
Received: from rananta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rananta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8920060252;
        Wed, 18 Sep 2019 18:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568832452;
        bh=5oS7pWst8ob1JtyReeLEB0WMmJKEh6kxEfBnEFKFVE0=;
        h=From:To:Cc:Subject:Date:From;
        b=T034DQ0x0R1exTeJt37DGcybgX0iMkpaOvNCDUmDo0An2yMmSuUmAfBb4xqrtvD8d
         RGlE1Op66HU192SCaE1Bbaqv8mLizOX3fKpm6pAKm6lwT6BK4iao2x8x9yqZFFQXgT
         3z87qq4vGadDHjniXeyDztUdpZwVTWZ03B9ICorg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8920060252
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rananta@codeaurora.org
From:   Raghavendra Rao Ananta <rananta@codeaurora.org>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     tsoni@codeaurora.org, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raghavendra Rao Ananta <rananta@codeaurora.org>
Subject: [PATCH] of: Add of_get_memory_prop()
Date:   Wed, 18 Sep 2019 11:46:56 -0700
Message-Id: <20190918184656.7633-1-rananta@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some embedded systems, the '/memory' dt-property gets updated
by the bootloader (for example, the DDR configuration) and then
gets passed onto the kernel. The device drivers may have to read
the properties at runtime to make decisions. Hence, add
of_get_memory_prop() for the device drivers to query the requested
properties.

Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
---
 drivers/of/fdt.c       | 27 +++++++++++++++++++++++++++
 include/linux/of_fdt.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 223d617ecfe1..925cf2852433 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -79,6 +79,33 @@ void __init of_fdt_limit_memory(int limit)
 	}
 }
 
+/**
+ * of_fdt_get_memory_prop - Return the requested property from the /memory node
+ *
+ * On match, returns a non-zero positive value which represents the property
+ * value. Otherwise returns -ENOENT.
+ */
+int of_fdt_get_memory_prop(const char *pname)
+{
+	int memory;
+	int len;
+	fdt32_t *prop = NULL;
+
+	if (!pname)
+		return -EINVAL;
+
+	memory = fdt_path_offset(initial_boot_params, "/memory");
+	if (memory > 0)
+		prop = fdt_getprop_w(initial_boot_params, memory,
+				  pname, &len);
+
+	if (!prop || len != sizeof(u32))
+		return -ENOENT;
+
+	return fdt32_to_cpu(*prop);
+}
+EXPORT_SYMBOL_GPL(of_fdt_get_memory_prop);
+
 static bool of_fdt_device_is_available(const void *blob, unsigned long node)
 {
 	const char *status = fdt_getprop(blob, node, "status", NULL);
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index acf820e88952..537f29373358 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -38,6 +38,7 @@ extern char __dtb_end[];
 /* Other Prototypes */
 extern u64 of_flat_dt_translate_address(unsigned long node);
 extern void of_fdt_limit_memory(int limit);
+extern int of_fdt_get_memory_prop(const char *pname);
 #endif /* CONFIG_OF_FLATTREE */
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

