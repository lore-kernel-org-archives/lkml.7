Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F206C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42987218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fU2w0i8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfGCMrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:47:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45541 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfGCMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:47:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so1217485pfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNi+jgx3lQdMBEwMmP6BN4Xd0pkiX3oYg56Fvm+D/U0=;
        b=fU2w0i8/igNZZ4XzvDL6UGujBxNiSXj9kZJ5A5CJeafo4jd3Qg80YUst6aAtRnCrS3
         dEzd5z25iEVtZf7gNHPEFmOaocmwKALv40d3MALPoqJC6eFz0IS6MeAmKxeMOqe4HW6q
         CrO/Hp8IKQkzOE6F/DGYpVb01OliaiC9+DSSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNi+jgx3lQdMBEwMmP6BN4Xd0pkiX3oYg56Fvm+D/U0=;
        b=lpRswbSdV4qRHT5LAqBYDhn++0wVgO3XGijfZ3DE0iWX6otcY7MLvLvg9lubvkguwT
         j43x+3K9sxoi4v6CAZ5WnHHwAdB9gmgfBTlrtZmgba5/6M3bkuF/a4pgG8QS7yx7laVU
         flA+xOKUFLOPXtMtSfNpTMyH7IuiQPcwQeqpYw6nsLqIBtmzj+xamZGSg2nu2WekqxsV
         5YRjxEbT5g6cXeBFNpNmHNx/SWCMRGUOGVpC0F8HnjYWwKpQz6Kxg1r/QVHsb3BINcvP
         juymIlBgaRN1NmVVujoNC/MZ93rAuvJ5kB7uwKzNXiDARS7aUJSq4PrbhtrLsc2cHrI8
         XIfQ==
X-Gm-Message-State: APjAAAUND6irANjS7UOg3qgc2hoOjhRH1wiKXM6BCXsunfxzUtBXY7FM
        ee9zcXjjz5txnEAMTEPdkVRspw==
X-Google-Smtp-Source: APXvYqyP76v0X/60PBMXUNT/tKb15DU8UxzaQ3Gwk5FrUdNvWD39oKr0U4qQ4cdiev+OVYnaeTDe/A==
X-Received: by 2002:a17:90a:1904:: with SMTP id 4mr12945020pjg.116.1562158041934;
        Wed, 03 Jul 2019 05:47:21 -0700 (PDT)
Received: from localhost.localdomain ([183.82.231.32])
        by smtp.gmail.com with ESMTPSA id q1sm3735890pfn.178.2019.07.03.05.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 05:47:21 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Hao Zhang <hao5781286@gmail.com>
Subject: [PATCH 11/25] ARM: dts: sun8i: t3-cqa3t-bv3: Remove legacy license text
Date:   Wed,  3 Jul 2019 18:15:55 +0530
Message-Id: <20190703124609.21435-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190703124609.21435-1-jagan@amarulasolutions.com>
References: <20190703124609.21435-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This dts file already used SPDX Licence identifier and
forgot to drop legacy license text from

commit <382744d35916> ("ARM: dts: sun8i: Add board dts file for t3-cqa3t-bv3.")

Cc: Hao Zhang <hao5781286@gmail.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts | 38 ------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
index 6931aaab2382..cf35c0b930ee 100644
--- a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
+++ b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
@@ -3,44 +3,6 @@
  * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
  * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
  * Copyright (C) 2018 Hao Zhang <hao5781286@gmail.com>
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

