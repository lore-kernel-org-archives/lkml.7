Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AA4C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF27921721
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bdsY8zm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391798AbfETOig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:38:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34250 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391738AbfETOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so8507878wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dvB2+EbZJAEiPxI5LMXTznof0qGaQVfAy18zyWtxPt0=;
        b=bdsY8zm8d9QrdoAErzkY6w5y5GhDLd+0CM0NghfSuvmTM9QjpQxPbHHyfyvQ8nK0FL
         i/5jXsplJdCFJSss1I7KvNwT9hfFKGCILpDqGemMvH4xnUy1lZVvi8spd/dIAXGDU0iL
         9Hu5/S7UJd0Q1VsUkyXgP0uRWSqGXL6AzzPYlSL/1Xm5mkSfDflDAqhuLM7Kh026i7hz
         jAJ0Is5haokKQbWyOGtPLA1jb5O7fH++Tn2kffKk7iuYW6dGenvh5rhvfeeJR+5wU1fZ
         wEV5a+eMNVz6DkQkFaIn0r/bmANWHz6Y9Y1dv7pe/bQOnSdyom6qDqM+JaWTvu4i4BXV
         OVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvB2+EbZJAEiPxI5LMXTznof0qGaQVfAy18zyWtxPt0=;
        b=I7qjbZ6i63wOID2CSIK8UiL0yfORhont7bgzXjWVps5qI+v34LSlqJYFfAQvlD22c4
         XqMvfR46IqrctzZhyfPQ0DcHrIgBME/Gnow4VU5s2Gyo6KwNmfGnC1Ja+YTEakq3u3Rq
         W+U4G4ohPZzAXmqlnNDdXEpyAXVDx05CLvtOhXGIy3le9fCgSgFA9I4e9v7xnGNT7Tlh
         8lwrjyPFUsCqltBbVO7Qz2Ybbg+Qy6L0/jd+qgrASd+y3zq0F/5tYjxVVr6TxRPGDpWt
         hJIugHHmux8OdrWAR9HI6lVotakJL0d9B4W+FWkSsPPqbJ+GjCd/3SsP8Y+i3+F6B/BL
         DMoA==
X-Gm-Message-State: APjAAAVsaiPOu29Rgbephzugv0/3feMB4ugRsz4sLSswlj4yKr+Ujifk
        VB82bzdPZ7RXLQBPGlVnuXNFaN/1/95ocQ==
X-Google-Smtp-Source: APXvYqx5B6BX/GzQuGkYQP0Ny5r5a+UZNfs1rZNVD0lELNHvTd7wSCDsCUOigyVIJta2FxsByvsvPQ==
X-Received: by 2002:adf:f643:: with SMTP id x3mr7807032wrp.320.1558363102613;
        Mon, 20 May 2019 07:38:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 10/10] ARM: mach-meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:12 +0200
Message-Id: <20190520143812.2801-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520143812.2801-1-narmstrong@baylibre.com>
References: <20190520143812.2801-1-narmstrong@baylibre.com>
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

