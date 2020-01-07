Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B61C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5814C2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UjOs0ZWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgAGK2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:28:25 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10430 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGK2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:28:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e145d180000>; Tue, 07 Jan 2020 02:27:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 02:28:24 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 02:28:24 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 10:28:23 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 7 Jan 2020 10:28:23 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e145d460001>; Tue, 07 Jan 2020 02:28:23 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>
CC:     <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] regmap: add iopoll-like atomic polling macro
Date:   Tue, 7 Jan 2020 15:58:09 +0530
Message-ID: <1578392889-16587-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578392856; bh=S+Ht3MbadCSLbxXXJdn3e/AfaXQFOU7+B9gzKSIzMZI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=UjOs0ZWtDhZsHs9ih5QZRIdJwuuO/L+L47nIIcNmPCk86liAs2iR4ntfb+tq7gr5Z
         bZ81NNQf3u59bZTV5OoZAOcPITbklP8aTCC49//H5TRx/dXcuUO8O2Linq/6Weprc7
         UuP1kNd7gF643vqUqkN5ABmzFrDsUSu5gAW1KupDgJsfuEE2Xp48kJ58weux3/KpV/
         ntsQHSRHkSqH60BWlL5w+K2sBi1rBC7EOC6EY8gqnbKjlWyqvMsZvJNv9OGB65KRuh
         sAUINbr5mdJyebFfWNg9j9+3zx1WKzZb/c6G3+7DLevwEpSmKugg38KCjYJcwSFLrh
         abnPOoBYXwkMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a macro 'regmap_read_poll_timeout_atomic' that works
similar to 'readx_poll_timeout_atomic' defined in linux/iopoll.h; This
is atomic version of already available 'regmap_read_poll_timeout' macro.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 include/linux/regmap.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index dfe493a..09d79ea 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -145,6 +145,47 @@ struct reg_sequence {
 })
 
 /**
+ * regmap_read_poll_timeout_atomic - Poll until a condition is met or a timeout occurs
+ *
+ * @map: Regmap to read from
+ * @addr: Address to poll
+ * @val: Unsigned integer variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @delay_us: Time to udelay between reads in us (0 tight-loops).
+ *            Should be less than ~10us since udelay is used
+ *            (see Documentation/timers/timers-howto.rst).
+ * @timeout_us: Timeout in us, 0 means never timeout
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
+ * error return value in case of a error read. In the two former cases,
+ * the last read value at @addr is stored in @val.
+ *
+ * This is modelled after the readx_poll_timeout_atomic macros in linux/iopoll.h.
+ */
+#define regmap_read_poll_timeout_atomic(map, addr, val, cond, delay_us, timeout_us) \
+({ \
+	u64 __timeout_us = (timeout_us); \
+	unsigned long __delay_us = (delay_us); \
+	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
+	int __ret; \
+	for (;;) { \
+		__ret = regmap_read((map), (addr), &(val)); \
+		if (__ret) \
+			break; \
+		if (cond) \
+			break; \
+		if ((__timeout_us) && \
+		    ktime_compare(ktime_get(), __timeout) > 0) { \
+			__ret = regmap_read((map), (addr), &(val)); \
+			break; \
+		} \
+		if (__delay_us) \
+			udelay(__delay_us); \
+	} \
+	__ret ?: ((cond) ? 0 : -ETIMEDOUT); \
+})
+
+/**
  * regmap_field_read_poll_timeout - Poll until a condition is met or timeout
  *
  * @field: Regmap field to read from
-- 
2.7.4

