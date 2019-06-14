Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E646AC31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0E220866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xdf26WCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfFNOcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:32:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33281 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfFNOc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:32:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so9039239wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIDNLxvx2Bg+Xgh8nVseVRfmZdFzioXB6+MHqeHMXN8=;
        b=Xdf26WClNJVQ4j+yzbieeYmXLJIS0PH9WbLs+DGLAWoHTWRqhPy+xzf0sAiW6qz7fI
         lMyhsnqPKVsVl4xQT3PU0H/7MqvtfIvML5c1GaXj1A8hj2xhE+DpGt+oE7EiXlrhY9jb
         Ec04RqaqQxXoPkZWH/5msBaG8z1jhamSOo/vK0WZdT+E+2XJsSRZS1tXKKe+rso85tIa
         gEKIHmrYCnBuLX9wRbvPtSBQ7HuqaK3KhT3d8qWk+iFtBGYL6Xy3oT36b9mslsz+Pqcj
         X6B5bdawFenfPTuGNhdoyyZT2n8s8yRFg5wnj5SfGOqyQ3qWjrfFR3BOXo+qppdN35qS
         VzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIDNLxvx2Bg+Xgh8nVseVRfmZdFzioXB6+MHqeHMXN8=;
        b=gmITRro1ZTW0ewoBBiGH6JqEO0cyQtmh6DYSynIo7KBOa0s3ekz9cHXicxhQZSi1I2
         52j0qufSbNYaDabFVN9T+yh3SniSDrqmc5tlYAGElqJxapvhWm4amwgDbzq00AxwhHJf
         qDxTr4n9zdgdRFFmBtFSu5gtp8TirSg8GyLeKfH4F3eHUHYxPbQ01cffoLVCaFQ3eBYM
         bGC5xhWUdl6SF5UjxlDPsnZIzfG52IfTbd9MnvTa37Jrh8dfvqlZSVxx3hq/gbfyok+G
         PcIjKS+9FzEf4p1qR+Fzi4ALgv8T1YiOTyJBD+Alrggd6yfzAdHjbIRxFbqBayC0caxj
         X8ig==
X-Gm-Message-State: APjAAAXqxbp4oeNltWriFTNI1nj+piOftIJzo5KJ/q5GiCh51mKXc3GM
        Tb7+C0qg/fFCwSoNjSp7S/s2jA==
X-Google-Smtp-Source: APXvYqwm3Z8NWHgBu+fES+7FIXc8nJCYY1rc/h6q7wpReBYsJoqLiHc7cIbe5Kw3GTSlmj5KQiwe+Q==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr8641809wmf.154.1560522745307;
        Fri, 14 Jun 2019 07:32:25 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t6sm4738007wmb.29.2019.06.14.07.32.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 07:32:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] nvmem: meson-mx-efuse: update with SPDX Licence identifier
Date:   Fri, 14 Jun 2019 15:32:17 +0100
Message-Id: <20190614143221.32035-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
References: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-mx-efuse.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index a085563e39e3..2976aef87c82 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson6, Meson8 and Meson8b eFuse Driver
  *
  * Copyright (c) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
  */
 
 #include <linux/bitfield.h>
-- 
2.21.0

