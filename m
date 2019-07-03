Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E02C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 05:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2FC21871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 05:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vnx9hfTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGCFIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 01:08:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35908 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfGCFId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 01:08:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so543021plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 22:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bP96sN12+LB4G6r3Yzr2XfyFwArhE5W1JsAQXFpUTDg=;
        b=Vnx9hfTr/VWxDub2tOXOowzwiubYGn/LxBAvZqSZPPVKw4rbPpdKFBpYBOcBRRC1jl
         l1UYyXOtSNZnb1fqwnKIyPgVWGCpqOX72qkWPCbMePtTbBwe1WjVnY7frmgfEvd2Sgtn
         GqCgCU4loxPMQSzv1cdh04GnJMFKfP2pGW/lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bP96sN12+LB4G6r3Yzr2XfyFwArhE5W1JsAQXFpUTDg=;
        b=lZ9ija5LuiRhLZKB/pLZedZH3CE2YUv8XZY57hRnk7Cta1DGrcSdzZkvFsYSDbgIg2
         qs40pwxblUfTGdglrSaHRAV7NJ0nlGDTrBv31e4qtQPtZX3pJiaGaYbchWM1K8lIE+8Z
         MFWXPzsWp6RUKkazabg1q/9nY+j4jg9LlWKD3OSKTX538JsYlMyYv7lzLOZNpf7FcGDs
         dc0f1NKSiQgmGZlEkPpNl5NE78BJJb6Y8eEbVj8Iedw67WggDM42OLaOgJgjf4pUW9dp
         Oo4GEbqhtRK6zE9wNFidI4WUBkFlYqPHms8XDoIGich+Jl4KQEXu6Dpw68MCzjRBV+ga
         XWPQ==
X-Gm-Message-State: APjAAAXXH8ZBBXU6L4TNNEEsq1zKN3alQXR24uDYAmOwy9xUvJVWDFW5
        T7FAouM0R6tQeBufgboP8Y5GFg==
X-Google-Smtp-Source: APXvYqzr5qQEG/MCl44C+LlaT88NYZd1W5tF3BecvIL8q7wgcm/VpeoP8zNrKVLauTL9Ru/pegMbiQ==
X-Received: by 2002:a17:902:f301:: with SMTP id gb1mr39331452plb.292.1562130512588;
        Tue, 02 Jul 2019 22:08:32 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id v13sm803990pfe.105.2019.07.02.22.08.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 22:08:31 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ian Campbell <ian.campbell@citrix.com>,
        Grant Likely <grant.likely@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] of/fdt: Make sure no-map does not remove already reserved regions
Date:   Wed,  3 Jul 2019 13:08:27 +0800
Message-Id: <20190703050827.173284-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device tree is incorrectly configured, and attempts to
define a "no-map" reserved memory that overlaps with the kernel
data/code, the kernel would crash quickly after boot, with no
obvious clue about the nature of the issue.

For example, this would happen if we have the kernel mapped at
these addresses (from /proc/iomem):
40000000-41ffffff : System RAM
  40080000-40dfffff : Kernel code
  40e00000-411fffff : reserved
  41200000-413e0fff : Kernel data

And we declare a no-map shared-dma-pool region at a fixed address
within that range:
mem_reserved: mem_region {
	compatible = "shared-dma-pool";
	reg = <0 0x40000000 0 0x01A00000>;
	no-map;
};

To fix this, when removing memory regions at early boot (which is
what "no-map" regions do), we need to make sure that the memory
is not already reserved. If we do, __reserved_mem_reserve_reg
will throw an error:
[    0.000000] OF: fdt: Reserved memory: failed to reserve memory
   for node 'mem_region': base 0x0000000040000000, size 26 MiB
and the code that will try to use the region should also fail,
later on.

We do not do anything for non-"no-map" regions, as memblock
explicitly allows reserved regions to overlap, and the commit
that this fixes removed the check for that precise reason.

Fixes: 094cb98179f19b7 ("of/fdt: memblock_reserve /memreserve/ regions in the case of partial overlap")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/of/fdt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index cd17dc62a71980a..a1ded43fc332d0c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1138,8 +1138,16 @@ int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
 int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
 					phys_addr_t size, bool nomap)
 {
-	if (nomap)
+	if (nomap) {
+		/*
+		 * If the memory is already reserved (by another region), we
+		 * should not allow it to be removed altogether.
+		 */
+		if (memblock_is_region_reserved(base, size))
+			return -EBUSY;
+
 		return memblock_remove(base, size);
+	}
 	return memblock_reserve(base, size);
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

