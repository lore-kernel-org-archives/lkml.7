Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8357EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B1E216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Gn8uBGli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391732AbfETOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:38:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40266 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391707AbfETOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so9265428wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7fXId43znoURHIEgvEgBbx6jyFkNkDQCOlHnOrw38gs=;
        b=Gn8uBGli1Sc6+GDVYqZjvexihUGvjpyt1WZ3EKCrkBTa+bdMmS6tukhn+bn+0qpQFj
         0W10CLWrVu8rodRqQDmD8jaTM6J4bm7B+N1mWZUGOjV2Xcvr6huKJLCVuh5nNGJTASqz
         3kmd8CQIce55JjTegyK/KzioLwviWkCI14eY/fDXJD5gmrUcfNuP0FhqjPybeWJK8Jfr
         pnzxGchj2BGuGPYa1X/vI4NwVUwZ0Zh95/sVMF/zMGnrRziDyJ5BPxoKxUwfRlvXsJwi
         rq7YwoNWGnLkf2IQumU2oBVGdqo7mwNrYbCF8JvNHNsDg/0/8Xg9ImSXw+FQvbFtDMPe
         5vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7fXId43znoURHIEgvEgBbx6jyFkNkDQCOlHnOrw38gs=;
        b=N1INL11fRLzl8D710ZoMGP9rYT8WUPR489fE5wtImCEdDcHBikdWTcsNgNdSa3iD0S
         1fXxDlXEZUU0q1YAzrye8zF5qk2CsMFMtAhJ+IlgeAec1qnLRroA0M6drc12BcBdJjYO
         uMFQkFHduTLHZYTbQ6G8TmiK29apKKyWxLk2+HpfDutwi3/WMqdy2b5JUtn54eOwtsZ0
         VM36Zbyy2/Nw89ybP1/GA3L5ro8g/W4kjInnmOK30AK88vZd1IfwNtTkoQjBeUnRuJuO
         /EqT6ceh8Ex7BJPDjTfNOGR7RrHh6S/wKCovJDNZW0VI13mM+CFGxZZaz7qkKa+pPKsj
         FtqQ==
X-Gm-Message-State: APjAAAWpYtUw1kPM+1Gl0KQJx96ObicNH0s8B2M0HvmZ5rHq8JsmI2ud
        9dDa0y5aSW7CA/lqE6+og35Bxg==
X-Google-Smtp-Source: APXvYqzpwGJ0wgU381MFS7JmTq3cw/qfDdbTQ68HoDgqrF9UUoAXStgMXCv+xWG+2+c4G4nQV3F7Ow==
X-Received: by 2002:a1c:be0b:: with SMTP id o11mr12604576wmf.63.1558363097439;
        Mon, 20 May 2019 07:38:17 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 03/10] ARM: dts: meson6: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:05 +0200
Message-Id: <20190520143812.2801-4-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson6.dtsi | 44 +----------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index 65585255910a..39903172ea7c 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -1,48 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
 /*
  * Copyright 2014 Carlo Caione <carlo@caione.org>
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
- *     You should have received a copy of the GNU General Public
- *     License along with this library; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
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
 
 #include "meson.dtsi"
-- 
2.21.0

