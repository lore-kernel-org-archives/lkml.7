Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDA2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962C52187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V3DnPL5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfGCMsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:48:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42157 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfGCMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:48:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so1188008plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeVp32fCyZqIo/d5l2qER2CwKv5pwBDkf2I+uhwHe8s=;
        b=V3DnPL5zk4ThmbRKSVn94ZksxfRwmk+EVcnMl4nlTJjcLknY6+1hlvBh1dwBNrzDmH
         ow6ZFZ9mcmPWii7TglC+rrCdK73BpOUrC8/anenKLMKn3oQamFdpn8xSt+5i2cd9ji2Q
         a6kCGn3aBBOHeDz1BP/vL739Wi/HVnRTxr6NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeVp32fCyZqIo/d5l2qER2CwKv5pwBDkf2I+uhwHe8s=;
        b=D6iiJKCSMTpaegg+9cQkBKDS8o0FLclbRNU0ddmnRlSK4cFhesg5rWKZjGQRhNi0Vp
         Px9I33gsTcAwgWgPHRxckfz6et/VFExZAOlykfcw/89ITyi/gwJQeZf5phtGEDtEhoPx
         TDslgRXkmKLOcscz2jd5tPD9TYWFIm7xSaMpNUomzfPAKcrgqjQmkFhLBiAyvKfjWZOu
         qDINWkKay4V0F6Jjotcqe4E+PUPftJiFwCwfEUI56q5rOx346NVStJFVUEimvNg2ayoi
         KKlyOAugxzg7DzvaK9m0dZnliem5IjDl0bqsUxnC7Cwj0/JimEc8blgeJgH+FzOL/SPZ
         Ow8w==
X-Gm-Message-State: APjAAAUDBFfQC7QllCS30hSl7rpNU3lA5iWxOszqNu33RFB/DfVxaLHE
        evGwcxys3AcGA4Fw/LPyI13wSw==
X-Google-Smtp-Source: APXvYqyl7oeWpq55E1rWzd8jsC71JAFEsVI26A8LO4PA4TcVfWTWVvZXb3P77i9AiNKVYR8cn1ZRLA==
X-Received: by 2002:a17:902:2a6b:: with SMTP id i98mr39877642plb.75.1562158087779;
        Wed, 03 Jul 2019 05:48:07 -0700 (PDT)
Received: from localhost.localdomain ([183.82.231.32])
        by smtp.gmail.com with ESMTPSA id q1sm3735890pfn.178.2019.07.03.05.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 05:48:07 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 25/25] ARM: dts: axp81x: Switch to use SPDX identifier
Date:   Wed,  3 Jul 2019 18:16:09 +0530
Message-Id: <20190703124609.21435-26-jagan@amarulasolutions.com>
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
compliance management on axp81x.dtsi.

While the text specifies "of the GPL or the X11 license"
but the actual license text matches the MIT license as
specified at [0]

[0] https://spdx.org/licenses/MIT.html

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/axp81x.dtsi | 39 +----------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 1dfeeceabf4c..83649e75f86d 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -1,45 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright 2017 Chen-Yu Tsai
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
 
 /* AXP813/818 Integrated Power Management Chip */
-- 
2.18.0.321.gffc6fa0e3

