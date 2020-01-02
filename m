Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A62CC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE9621655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7I8i4xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgABKDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:03:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37374 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgABKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:02:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so26077851wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 02:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/h6NXyD6aVKL5bx8Xk7zLnuH4ugoW90Sl0nahNHK5jE=;
        b=U7I8i4xeYif2uypX4KDfROp0j+MUuq0bTvsx90CwzEy0ej2aUbqTEzGTDGoDoD1lMl
         EEnplWcR3tc6csYkgiVANSuMEQfq1kG4GbnD2/dagsGEVaOrcAkj5ZJ6E6GwL9xeW6k/
         Uk13PISUdBZjY57xpw9gNHeTnZ5hzRWLqb9KbOKtz9iV+I8Uren4+8xzmr39BHHt6/uC
         IJpRohJROAaQGvSBADPoUyyjfkO4A+BxMPCuWTc8I/nr2cj5v6Lo7LeIRDuCq4zLH5hR
         26om24StYh/dVw2/hjo1FHaDkKpNAhOKsIDXgRS1DIsKTw4F9uXApP9x/WO2YO96BHQF
         oOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/h6NXyD6aVKL5bx8Xk7zLnuH4ugoW90Sl0nahNHK5jE=;
        b=QiTElaGysNgFd/3qFmCrFfR6hXJYs6FgWgWRbD3bX5m2unk4mkPkuEOrZCyiqeJJL9
         LVuE1MvXRplKmz4aMjfkU72dUwO2fytWxhrGG5kYqQZjnTVntxhJeULoFkn4IDUjpgB8
         DKhs2oDDs+r7sm4p6QsRDPqKL/1gBrDKbGGeYseCiqFaQlQOetoNiBPACtDwUcI/G7RP
         bYZ/JTexYtsHn4est83p85ZEk5SnNfaXORCVwcq0GUGdbsVNqMJNqtaKYWFOlJtCBuJp
         t519asVrqNcoLb+PcwMadmJ+uG9diJrRVH2FMbPoE/3e+k1/EYMxuuqFWfqY2Zo8dX3r
         QIfQ==
X-Gm-Message-State: APjAAAUTG1LH+IqGNIXh1uJJNiU9QmfJa7GaTZWRLaO+3kXb+tZozdyO
        ZYPEJ0+hFHDDk0y3kDUzqpgPMBS49cU=
X-Google-Smtp-Source: APXvYqwuWzsCGpjQcNQa5lHuh7FuWlPCZt+dlf5F5Z/vvbfkuGlWFhtrM+c4T01AWO6cbZ1Pxh7SVw==
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr84428535wrm.262.1577959377141;
        Thu, 02 Jan 2020 02:02:57 -0800 (PST)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id r6sm55418683wrq.92.2020.01.02.02.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 02:02:56 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 6/6] drm/etnaviv: add hwdb entry for gc400 found in STM32
Date:   Thu,  2 Jan 2020 11:02:20 +0100
Message-Id: <20200102100230.420009-7-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102100230.420009-1-christian.gmeiner@gmail.com>
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The information was taken from STM32 glacore driver hw database.
The entry is named as gc7000nano_0x4652.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index d1744f1b44b1..8495b041a3b7 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -6,6 +6,37 @@
 #include "etnaviv_gpu.h"
 
 static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
+	{
+		.model = 0x400,
+		.revision = 0x4652,
+		.product_id = 0x70001,
+		.customer_id = 0x100,
+		.eco_id = 0,
+		.stream_count = 4,
+		.register_max = 64,
+		.thread_count = 128,
+		.shader_core_count = 1,
+		.vertex_cache_size = 8,
+		.vertex_output_buffer_size = 1024,
+		.pixel_pipes = 1,
+		.instruction_count = 256,
+		.num_constants = 320,
+		.buffer_size = 0,
+		.varyings_count = 8,
+		.features = 0xa0e9e004,
+		.minor_features0 = 0xe1299fff,
+		.minor_features1 = 0xbe13b219,
+		.minor_features2 = 0xce110010,
+		.minor_features3 = 0x8000001,
+		.minor_features4 = 0x20102,
+		.minor_features5 = 0x120000,
+		.minor_features6 = 0x0,
+		.minor_features7 = 0x0,
+		.minor_features8 = 0x0,
+		.minor_features9 = 0x0,
+		.minor_features10 = 0x0,
+		.minor_features11 = 0x0,
+	},
 	{
 		.model = 0x7000,
 		.revision = 0x6214,
-- 
2.24.1

