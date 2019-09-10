Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AE1C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0AF206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="foUXLvfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436706AbfIJQJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:09:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33265 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436679AbfIJQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:09:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so11807605pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIkLTnrkWt/EuuPaM/5KgusucJyV+/pu2XQTD6+l1B4=;
        b=foUXLvfXEBZ8ItH2km73P/GyOobcyj/2AlkrAl5hS06ssjzVy3VMEdus9dZJ3XfRko
         n3d1oj1yZXYkG2g88eBnSetaXilib5WWGGyXSHK7SjUDXQXeIo8DFzlrCmNLoyCGk1MI
         BMHL2SWL8Fvoc+XCOlcilC9vuG29PN8KWwjVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIkLTnrkWt/EuuPaM/5KgusucJyV+/pu2XQTD6+l1B4=;
        b=edRoGVyPXFdrfjUaniXxm+cRjpf7SvbF7+TE25uf708C4QC4bEeOPezKxv058MwDUd
         0gIU3n/jrX25zfKuYA+zY6Qo9syM4+EyF9Yz7gCyxeYCmHzAikrBHGhBegpM2i2M1Pqw
         XNohgA5f+nnPE9ggbLVIbhERhZT0O7em0lP7F0JDUSYflhqwaprlJvsesk8xUiw8ivnd
         0ke8yGryf1VvqHmDB5w5DqYP+qYAB5li6C+vZET9qMhnY8rp8UtvAVuMbaZatGZNjckd
         MUiNycy/260lJsnc21Ws2ery8Njp+5EMsZi4Njc+VoojR3u/p3HzQb5wQxCRoxMDl5TM
         K7LA==
X-Gm-Message-State: APjAAAUnoJl6zOTc8pHx7xTWBckbamlsg3J8F6PCrw9z6UpST45fU0aP
        MgTrlYF5CGxlOpSFUwVJMCtvtw==
X-Google-Smtp-Source: APXvYqxx4DKXHSRmc5pwbVIhiOSXS9FCZbm2hSlKbDrWsuFklc4KYT0VzXEO62KHo4IIpzzRXcJKAg==
X-Received: by 2002:aa7:81d1:: with SMTP id c17mr35893243pfn.219.1568131747300;
        Tue, 10 Sep 2019 09:09:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id em21sm106088pjb.31.2019.09.10.09.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 09:09:06 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 3/5] memremap: Add support for read-only memory mappings
Date:   Tue, 10 Sep 2019 09:09:01 -0700
Message-Id: <20190910160903.65694-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190910160903.65694-1-swboyd@chromium.org>
References: <20190910160903.65694-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we have memories that are supposed to be read-only, but when
we map these regions the best we can do is map them as write-back with
MEMREMAP_WB. Introduce a read-only memory mapping (MEMREMAP_RO) that
allows us to map reserved memory regions as read-only. This way, we're
less likely to see these special memory regions become corrupted by
stray writes to them.

Cc: Evan Green <evgreen@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/io.h |  1 +
 kernel/iomem.c     | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index accac822336a..15a63efcd153 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -148,6 +148,7 @@ enum {
 	MEMREMAP_WC = 1 << 2,
 	MEMREMAP_ENC = 1 << 3,
 	MEMREMAP_DEC = 1 << 4,
+	MEMREMAP_RO = 1 << 5,
 };
 
 void *memremap(resource_size_t offset, size_t size, unsigned long flags);
diff --git a/kernel/iomem.c b/kernel/iomem.c
index 62c92e43aa0d..6d76b7398714 100644
--- a/kernel/iomem.c
+++ b/kernel/iomem.c
@@ -19,6 +19,13 @@ static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
 }
 #endif
 
+#ifndef arch_memremap_ro
+static void *arch_memremap_ro(resource_size_t offset, unsigned long size)
+{
+	return NULL;
+}
+#endif
+
 #ifndef arch_memremap_can_ram_remap
 static bool arch_memremap_can_ram_remap(resource_size_t offset, size_t size,
 					unsigned long flags)
@@ -45,7 +52,7 @@ static void *try_ram_remap(resource_size_t offset, size_t size,
  * @offset: iomem resource start address
  * @size: size of remap
  * @flags: any of MEMREMAP_WB, MEMREMAP_WT, MEMREMAP_WC,
- *		  MEMREMAP_ENC, MEMREMAP_DEC
+ *		  MEMREMAP_ENC, MEMREMAP_DEC, MEMREMAP_RO
  *
  * memremap() is "ioremap" for cases where it is known that the resource
  * being mapped does not have i/o side effects and the __iomem
@@ -53,6 +60,9 @@ static void *try_ram_remap(resource_size_t offset, size_t size,
  * mapping types will be attempted in the order listed below until one of
  * them succeeds.
  *
+ * MEMREMAP_RO - establish a mapping whereby writes are ignored/rejected.
+ * Attempts to map System RAM with this mapping type will fail.
+ *
  * MEMREMAP_WB - matches the default mapping for System RAM on
  * the architecture.  This is usually a read-allocate write-back cache.
  * Moreover, if MEMREMAP_WB is specified and the requested remap region is RAM
@@ -84,7 +94,10 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 	}
 
 	/* Try all mapping types requested until one returns non-NULL */
-	if (flags & MEMREMAP_WB) {
+	if ((flags & MEMREMAP_RO) && is_ram != REGION_INTERSECTS)
+		addr = arch_memremap_ro(offset, size);
+
+	if (!addr && (flags & MEMREMAP_WB)) {
 		/*
 		 * MEMREMAP_WB is special in that it can be satisfied
 		 * from the direct map.  Some archs depend on the
@@ -103,7 +116,8 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 	 * address mapping.  Enforce that this mapping is not aliasing
 	 * System RAM.
 	 */
-	if (!addr && is_ram == REGION_INTERSECTS && flags != MEMREMAP_WB) {
+	if (!addr && is_ram == REGION_INTERSECTS &&
+	    (flags != MEMREMAP_WB || flags != MEMREMAP_RO)) {
 		WARN_ONCE(1, "memremap attempted on ram %pa size: %#lx\n",
 				&offset, (unsigned long) size);
 		return NULL;
-- 
Sent by a computer through tubes

