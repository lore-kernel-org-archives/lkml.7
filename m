Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E891C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F73218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LldCI44X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGCMrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:47:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38660 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfGCMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:47:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id 9so1205384ple.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1ba1K9fyy+5qb8wq4Py+5mYj4w5zxZQVOLZoJxTMuo=;
        b=LldCI44X9Xgj+KQ7igQdPCvoeKY0QkFSIUlew9W5MKMM2GTLawR4+nrFnrdV8SZ9Qn
         rcORCaRaadNquMSWMLkpMiNHI1A05QbSxvlS3xUfr6fqsELlZ2grn220xNi9ijvDZ2Ok
         E5LErPRoJAdtNNWe4+Nrq/dxyRQFLp1agKtVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1ba1K9fyy+5qb8wq4Py+5mYj4w5zxZQVOLZoJxTMuo=;
        b=IerktaOE4nmgSxnellpSZ9nE07NSd+DnIwClztiYMDSqR9bmXcAjc1FcV2N0yLrR99
         isEARI5tSPlVtB1VDOM7lvCZoQVRhRBhF6EyKbDW+Z6nK/mjdtzHybFvePQS9hjt/PHv
         +qNGz/XroBYyn146NVkAqb6QD8UptMMdzR8FsERttnZTZAgt0MjxvZIwH4OYuHLJQD7Z
         5L5gprW4E4N29J1TNmzokW3KrLU0S1Ac3Am4cqZEdcGWC4i+rIrI1sP7d+pQJAASs9YL
         FKqJXJGLvBZeXDl30riLJixWxwfmgr5oh/tDhtwiSHApQZciv9ViBO4V300TZzoa0z8I
         fH3w==
X-Gm-Message-State: APjAAAUeoxMmc+qRAtI6Zfs+7JUCiDOrUONLtZkM6hZjKLHU5g4z4BQf
        yaqJhx4kIbufZt7/AHwgjPjkIg==
X-Google-Smtp-Source: APXvYqy9jbP5SSZotDo314YorMjS7X521i23RpMvXcpJM8TBaNiAnm8ovF/1KztULAYD0rntbprk1g==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr41260972plo.290.1562158055385;
        Wed, 03 Jul 2019 05:47:35 -0700 (PDT)
Received: from localhost.localdomain ([183.82.231.32])
        by smtp.gmail.com with ESMTPSA id q1sm3735890pfn.178.2019.07.03.05.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 05:47:34 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 15/25] ARM: dts: sun8i: Switch H2+ dts to use SPDX identifier
Date:   Wed,  3 Jul 2019 18:15:59 +0530
Message-Id: <20190703124609.21435-16-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190703124609.21435-1-jagan@amarulasolutions.com>
References: <20190703124609.21435-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license
compliance management on Allwinner H2+ dts files.

While the text specifies "of the GPL or the X11 license"
but the actual license text matches the MIT license as
specified at [0]

[0] https://spdx.org/licenses/MIT.html

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../boot/dts/sun8i-h2-plus-orangepi-r1.dts    | 39 +------------------
 .../boot/dts/sun8i-h2-plus-orangepi-zero.dts  | 39 +------------------
 2 files changed, 2 insertions(+), 76 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
index 3356f4210d45..ff31d817b551 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
@@ -1,43 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /* Orange Pi R1 is based on Orange Pi Zero design */
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index f19ed981da9d..c2a4d8f5f251 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -1,46 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
  *
  * Based on sun8i-h3-orangepi-one.dts, which is:
  *   Copyright (C) 2016 Hans de Goede <hdegoede@redhat.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /dts-v1/;
-- 
2.18.0.321.gffc6fa0e3

