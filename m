Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BC5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0509220679
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hwSZWxSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfE1F51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 01:57:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40947 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfE1F5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 01:57:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so10772644pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 22:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dct7sUqIN4yTDR2HFtwSyXfQaPLYionNUf3R7g65wJc=;
        b=hwSZWxSlG9xeAnA9TUeD7ON0voDdUj314TGa+yz9do/gM6mzbANrtu0Ks/sFbwBm63
         rKJQTeV99HciujXRGhmL2Z91P9RLUC5gzPp/HTBeW0iwdSsZZPNvjc3r7EbGBrX8f2mR
         1QJ1d3JZUAftEP/UEB13JiDPfSCNfe/IM6iME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dct7sUqIN4yTDR2HFtwSyXfQaPLYionNUf3R7g65wJc=;
        b=TG/kkoDr7sSNKrQDmvRcF5wnrn5PdMDbvUfAiGEMh7hI/RkWxlMBte0frjMD2e0uWc
         OUm4+EFgCpH63HbnYgW9kECdKIrogw2MxeV4eE8hweXqt4o32gJz811cPVilJhR7ldKm
         ICr1YPOmiUmVU2BwM0PfCM7oBWrK8LlCR+4W7ImIM0iyQPJP5+l9AENv+POkoQFe1/4I
         Y4/ZneoTh1DHzb6VNaa+zS5qfwRJcCPFP6Q04JIjyjG76xfCNR63+6ii69Op5c6MSf3T
         MEmscZUtSBmLfX97K+hN9OeWPmtMdyhSphUPM2rBGLNV7p0Q4fTyhI+26NBX44gFKqfT
         r6TA==
X-Gm-Message-State: APjAAAVEFw8jEfBviKPBpBele6JvCjrXyqsylMQKfhLv1Ej/lghZJaQh
        1DZO3Uto6aQfymAtq9enwZZ0DQ==
X-Google-Smtp-Source: APXvYqwgF6QrvKVy4NuktZ4Afik+l8WeNLrMISF78vUJAwwwPB3Dap6m/TxwNSRrS/H7YEFHvMRX2A==
X-Received: by 2002:a17:90a:1aa8:: with SMTP id p37mr3381669pjp.17.1559023042073;
        Mon, 27 May 2019 22:57:22 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id w1sm13950551pfg.51.2019.05.27.22.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 22:57:21 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFCv1 04/12] media: mtk-vcodec: fix copyright indent
Date:   Tue, 28 May 2019 14:56:27 +0900
Message-Id: <20190528055635.12109-5-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190528055635.12109-1-acourbot@chromium.org>
References: <20190528055635.12109-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.com>

Minor identation fix for copyright notice in a few source files.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
[acourbot: refactor, cleanup and split]
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      | 26 +++++++++----------
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 26 +++++++++----------
 .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 24 ++++++++---------
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index 109c7578a8b2..76905e2d56a7 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -1,17 +1,17 @@
 /*
-* Copyright (c) 2016 MediaTek Inc.
-* Author: PC Chen <pc.chen@mediatek.com>
-*         Tiffany Lin <tiffany.lin@mediatek.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License version 2 as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-* GNU General Public License for more details.
-*/
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: PC Chen <pc.chen@mediatek.com>
+ *         Tiffany Lin <tiffany.lin@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
 
 #ifndef _MTK_VCODEC_DRV_H_
 #define _MTK_VCODEC_DRV_H_
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 2d5a61c06287..32d8ce9c8f6e 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -1,17 +1,17 @@
 /*
-* Copyright (c) 2016 MediaTek Inc.
-* Author: PC Chen <pc.chen@mediatek.com>
-*         Tiffany Lin <tiffany.lin@mediatek.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License version 2 as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-* GNU General Public License for more details.
-*/
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: PC Chen <pc.chen@mediatek.com>
+ *         Tiffany Lin <tiffany.lin@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
 
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 39375b8ea27c..2fdae50173be 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -1,16 +1,16 @@
 /*
-* Copyright (c) 2016 MediaTek Inc.
-* Author: Tiffany Lin <tiffany.lin@mediatek.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License version 2 as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-* GNU General Public License for more details.
-*/
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: Tiffany Lin <tiffany.lin@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
 
 #include <linux/clk.h>
 #include <linux/of_address.h>
-- 
2.22.0.rc1.257.g3120a18244-goog

