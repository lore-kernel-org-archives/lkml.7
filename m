Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9116AC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BF020707
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTTYJKT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgAFPRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:17:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54634 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgAFPRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:17:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so15287398wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pUtO+zfkq/xek1f3bH27+DPV8k2ximGVGaU/9KafJH0=;
        b=XTTYJKT4BhxUENbB1bJpDezEokEgz7EvtXnUvZCuliLResJdPZeDfRCQKevvDaUL/t
         v4XReeszIRlSuC2F9BfJkihW3wNtxKQBePKriCrtxJV26VIAXb8xn+VcHu2269wsq6CW
         ENjOFrG3aJ6beMBG6gPLlBDKKycEJt7PRovRIB744LdYkSlnXqbhtZx9CgAaqY5hPh01
         CXpC41kARMiZmqWAcw/gV9Cb1CYKKGMmUL4ISciRaxQx29IyYe3BlpDQO8UcixpRwLwM
         EiNNiB30YO0mWN0piyv+1BZnscBeIbzyOSzYQaJBFa22OCrPCdrLMcw1PTNUZG62G1uM
         LxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUtO+zfkq/xek1f3bH27+DPV8k2ximGVGaU/9KafJH0=;
        b=IL8+bRihs3mUdZN8AUdOXzNPNOYD4ImI9MLscEN8qeaRwWhFoIRWWIoPNP8HannodK
         nL4vDnr97K2l+0TX+PY+ZuvuTh0vhw7xaKCai4FGDJ/iNHGPhEOAUK7zkD7GyUQZSBaw
         /Hgw40cINdObnBxVCibGyFnfvXND6l/czXW0ToJGDFVMWsNYNm5IYzrxvYBe/Bg83DjP
         4NGbW7aLEbiju6/W7bWLvEsytFkyQo5G9W4ylu6tLd9nlvmkM1Z0UxydAseV+Yn1ngpA
         JpeSS5Fe6J2c/57Qfga85+tZWAyAggDwgSLwiB7/50x/5y02vBm3p8C+ZC0tFtEH3III
         hxEg==
X-Gm-Message-State: APjAAAW8BcdysNO3jRk634UFviy0jK45B9L/cLmkSSEs8+UrZz3Q5fhl
        FF4WMasA5fSKbG6mulPBGt+NR1NyOiGbEA==
X-Google-Smtp-Source: APXvYqwsQT394RlJuINUB+uKLmcbP1C4/aQR0TEdQ+tH37E1WPzngyosxD5K4zHwRHh2xFuLqNWXJg==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr33755601wma.95.1578323838278;
        Mon, 06 Jan 2020 07:17:18 -0800 (PST)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id l3sm72122463wrt.29.2020.01.06.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:17:17 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 6/6] drm/etnaviv: add hwdb entry for gc400 found in STM32
Date:   Mon,  6 Jan 2020 16:16:51 +0100
Message-Id: <20200106151655.311413-7-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106151655.311413-1-christian.gmeiner@gmail.com>
References: <20200106151655.311413-1-christian.gmeiner@gmail.com>
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
index cf3bb26e2e43..167971a09be7 100644
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

