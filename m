Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA69C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C528216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kVZUlP82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391818AbfETOiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:38:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35070 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391710AbfETOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so1939118wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjBhuWUBVlc7dSbIXQ9In2EP/rViqYs/vCz1OGKxCCo=;
        b=kVZUlP82EkRSrN6VcYSVwKkCxt7PQ+zs5bUwr53RfYDV8HJjP8vQeRIVC6cGuccADJ
         waEJK9ExJy1eXBNoALtXkEN7prV90JuQVLK5scVl3Q069iV720hh5xzXYvuFMkAoSisY
         dQzR/WvbC32ZkTFNbzgPGrpdw88bl5qHequC/Sa200KSqJZHjyGulR8gL+v4A2nb/aQR
         v7tS1uUrzJOF7f5TFRV0NnOGUwyAl0YW7zd6g0Mn/ub0kZtikmcyig7X4gHdehPpQ9Pi
         fRZ1ZX1GMHwWds7s2Zx7Dxq1lOAXVd4Ym+QY1HAJ8YrqMQMnnLoCpIGWD+breSORZlUz
         6Ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjBhuWUBVlc7dSbIXQ9In2EP/rViqYs/vCz1OGKxCCo=;
        b=S8b7qAgO4psWumkfolOsxQtSSXE+yyZSlj10jM3MgrVMDr/f3E4o9K3O0kryPMD57G
         cgeSXigfQd6+fouMVSg0dWc6Gw5l87WSCzZGpO3NMn3dWZqsRpI1M3a0o1S6YCF4Y7Sq
         fOlAHS4ZzyaASMYI4Vuaa4RjBNFuB7zxxBjbtmH2xi4dYZ+BybuLIckUy5hcGj4mbGcj
         ETUOXUn+URRKqKnIOv7J3fGWxLbn8GRDPNIH3eT0p5Ro92MO/DEB/GYp4diej6E0K1y2
         RswFia+kD7boYg7RkGN9oqqRdKZFTen3ClcWm7XEQZdXLgU7USOA3pY/1VhMLB5sRIma
         t/aQ==
X-Gm-Message-State: APjAAAXnsFBvb/xaK9SdWt3N4cvc50+tZNz88c8dFg5h6XtoFCWOhoqy
        8XBzzNZjmSforoFam0AuRswihA==
X-Google-Smtp-Source: APXvYqwXaHdBxpngufWJn9Ad2Me+6dkJb3DeeqhmezZE29Zs8eIpl6gaJ/UafZXChQA7a+09VlyOHA==
X-Received: by 2002:adf:f3ca:: with SMTP id g10mr21281688wrp.249.1558363098166;
        Mon, 20 May 2019 07:38:18 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 04/10] ARM: dts: meson8-minix-neo-x8: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:06 +0200
Message-Id: <20190520143812.2801-5-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson8-minix-neo-x8.dts | 39 +----------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
index 8686abd5de7f..2e669455a12d 100644
--- a/arch/arm/boot/dts/meson8-minix-neo-x8.dts
+++ b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
@@ -1,43 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
 /*
  * Copyright 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
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
2.21.0

