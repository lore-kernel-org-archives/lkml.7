Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CB4C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634B420859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WtFYkrtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfE0Nj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:39:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35806 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfE0NjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:39:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so9778854wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dvB2+EbZJAEiPxI5LMXTznof0qGaQVfAy18zyWtxPt0=;
        b=WtFYkrtFYIRoQD5BySh2Q4euh/1w/73nMtXzlp6fOr4QdtCp67NecdupuFYep2yx+o
         bXdszZLxCNU0cXnVp5weVpCI+5Webe1BRaI8zeO2VS5lFgBDHc5HugKN/h5oa/+rr13j
         l0p5hkbf7W02oisR6u47h+JmtThsqB2DcRyw5fePoD+/UK0sP5PzTpT7DP+TzwhF7Hzr
         fLlphusxj+e4iY5eMC82Iab9unBz3wTBbrYvHB8cRilF0YwYYBxGdZK9TkP+EmtG4obw
         A0oakQ1AsejJ5bZlLAXZ/Sxhc5qsO3A15kFhtQH1KUxLTIFxGjnnq6xN/Bzr8o3/n4Q7
         i+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvB2+EbZJAEiPxI5LMXTznof0qGaQVfAy18zyWtxPt0=;
        b=hH34hTwTyS+qysHI5SP8owlNUqFW0voQDT8fmPJZmtNWbtDDaJsOI9TN6E1xW4nubN
         uuk5BGbJBtfNGhfnXb8J4wxNkm+AgXDQXrysyPfXGL3UFpdWnINDVSoviBp5efbfRPtz
         2jeuWAIOKir9ifIuhY51F3ZQ1cV+MjBx+oViSb4WeCgf3h3+wVZH6MF/fpavz3yrfpZ2
         NjcH3F0vIigHiDZDt3m8PBZJdT85A4dJCGCUUwwHtGxnpfTmesgpJcy+8TBPomO+KK0p
         qNln6455mRrPP0a9P5ps1AjTMCgjAsjRor/NFnSr7bFNka3Pn9IzM7wKCHSrcGTs6wBx
         DwdQ==
X-Gm-Message-State: APjAAAW9wLwqsgJ5AahnvBPkWk4NW04K8pU0y2sHflXeue0wqUyNuq4D
        O+7+LeAYnmqQSuv1L0M4BtVnVTnLUZkk0g==
X-Google-Smtp-Source: APXvYqzKBKq2uRyEn9/t3GONp1WVHuQyd/kWy1EzaqK5fAviCM453t6ahqnjUeVYqdyG5IZiryic+w==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr6568223wml.164.1558964351405;
        Mon, 27 May 2019 06:39:11 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a124sm7838335wmh.3.2019.05.27.06.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:39:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 10/10] ARM: mach-meson: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:38:57 +0200
Message-Id: <20190527133857.30108-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527133857.30108-1-narmstrong@baylibre.com>
References: <20190527133857.30108-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/meson.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
index c8d99df32f9b..04ae414d88c9 100644
--- a/arch/arm/mach-meson/meson.c
+++ b/arch/arm/mach-meson/meson.c
@@ -1,16 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2014 Carlo Caione <carlo@caione.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  */
 
 #include <linux/of_platform.h>
-- 
2.21.0

