Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964B6C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9AD218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="b0zu5dXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfGCMsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:48:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35205 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfGCMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:48:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so1207874plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6uRjcermCh0vpVDEIEhbk7Fmo6X2a/vaz5WmKDnX10=;
        b=b0zu5dXrKN9pCZXKQexawbFEbckTVyo7Y/CfUphYXkxBdh2IGsT/Jiic87Zy8Is5az
         kcSfZXgiA2mF/PXqlXlpWn1OqxsBgwmr+4kug7T0brB9AekUPJb1WqzOoXeJ9OtHcQgf
         nP0sPALi9wKcBwgWOflx1NbBZUv2KO7vIVEZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6uRjcermCh0vpVDEIEhbk7Fmo6X2a/vaz5WmKDnX10=;
        b=IzadaEMU2KAU3Ekn/VvpKS2K+IYoBaNvjEf5Z/dW3+4YmhhmHIxaYMdccHF1WWY0uc
         6+59zeZhcSYwjCEfZIXf9ITPsmIbi5hy4STrsyD8ZqdtqFufVbIeQNaEGHlN6jigr93J
         +x9L3JPk9rLeBxGotuSBcbLgptxtEGXUOjd1RvB6P/iryMjDj1e5qxpQTL9pH/OoEiDd
         Sj56euNIIA21849Au2aKDt/2mIbGWhEyEZnDOeNazQ2MLnP/vkzmMegwnbIBZSp7nQNu
         wZsXdoxViF7otBACnLUN4JrBEfsTpCVCqUacFXwuv3TW4hvSMvIX/pasiK+kRZZry0rx
         Hv4g==
X-Gm-Message-State: APjAAAXPOSgTbZ66TnH+O8+TCuW1joTRnYOMIOUGyqVPGX17BZ6oMns4
        BdEI2jkWcb9SYInZb5qzKgcl5Q==
X-Google-Smtp-Source: APXvYqzwwj7W+UdpQxGHCSMx8CuXgmzpcfjEKHlgFijFZGBYMqD+T8XyO9rvp8IZ+HN0rWDQ0Iu9EA==
X-Received: by 2002:a17:902:a60d:: with SMTP id u13mr34396176plq.144.1562158084588;
        Wed, 03 Jul 2019 05:48:04 -0700 (PDT)
Received: from localhost.localdomain ([183.82.231.32])
        by smtp.gmail.com with ESMTPSA id q1sm3735890pfn.178.2019.07.03.05.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 05:48:04 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 24/25] ARM: dts: axp809: Switch to use SPDX identifier
Date:   Wed,  3 Jul 2019 18:16:08 +0530
Message-Id: <20190703124609.21435-25-jagan@amarulasolutions.com>
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
compliance management on axp809.dtsi.

While the text specifies "of the GPL or the X11 license"
but the actual license text matches the MIT license as
specified at [0]

[0] https://spdx.org/licenses/MIT.html

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/axp809.dtsi | 39 +----------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/axp809.dtsi b/arch/arm/boot/dts/axp809.dtsi
index ab8e5f2d9246..53a902b29d6f 100644
--- a/arch/arm/boot/dts/axp809.dtsi
+++ b/arch/arm/boot/dts/axp809.dtsi
@@ -1,45 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright 2015 Chen-Yu Tsai
  *
  * Chen-Yu Tsai <wens@csie.org>
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
 
 /*
-- 
2.18.0.321.gffc6fa0e3

