Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4586FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAF220859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gp15NGaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfE0NjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:39:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52475 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfE0NjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:39:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so16230639wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfgebMbGwf7Q9Gr5G1WufDedu7zpTfv4Qk3723gKuHA=;
        b=gp15NGaWUqz2H0Wkd8QHPcS30em+G/Z4uhV7Kc6EttgeraQebzvBgpDe7aq7Bd2gdW
         JOnrNk5lXLAYUY7Eg/CSHEkdUUDydksAoIXicIisIHVCOLa/gr7lKFhxWJ7mz+onb9xU
         Q6k7T2RC7OatFdrQVCw9gI6WSXWrm8004fI7zpT4yreZoi2VVHDNb8TdsLjdW6HRcPge
         VlRntHyLzy73RvOwCnBj+SRH2b1B5VJA/RTxeG3i2FDso+KnefTwqAmhtc/hGnYOyuND
         M9lGcgvlMNSsm0MyO5EZUPb+G6fGKdLnW9P1KqkDIByVNEdQCO4K17g0wYA/Ys9kOUuI
         ek4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfgebMbGwf7Q9Gr5G1WufDedu7zpTfv4Qk3723gKuHA=;
        b=qSEwHV85sGASJKeyUFQQ91/nr756UKZBX2D0cWEO+KzkkmaH19nlW61iJczWcvebaD
         xdOO+lqEUekWBx+x2Gl3+gtd1c1PHnd8oRG6IGuAUPmGizZONHNC2qOyh3MmFkO5Uzdb
         +Vi6CAEKrRbi9VGLfYGirwB9mqE8Pvoq17JX5G6AuqfmlYTbtMKCzckEvUvORJuKPJMw
         uYwlLRD9fNmn02QjZT/YFPKkJxPBCDGJLGGILXm2DBWaZVOUBQjVzL6g1TWS7ZlypShE
         UI+vx4/SE9YJdsiCsqYKY504jIXDgPZgm3/HYWaE0EG3ynB5elj2EMe0jv7FFo3pB0W9
         ML+Q==
X-Gm-Message-State: APjAAAWa5x4Cy2jpH3MHLHIvyZGj2yIHH8PKRHfXBTGIc8nCiRcNRsq+
        djvSc2qIQw9VdG6sCtPSBji1gg==
X-Google-Smtp-Source: APXvYqx2n+0dCb0I4WHAGuAk60wnSXJkj1WeeLU20junP8mTXddMCQbvk4C92SqYr7SMM1YYcoD+fw==
X-Received: by 2002:a1c:ca0b:: with SMTP id a11mr27459696wmg.52.1558964347484;
        Mon, 27 May 2019 06:39:07 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a124sm7838335wmh.3.2019.05.27.06.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:39:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 06/10] ARM: dts: meson8b-mxq: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:38:53 +0200
Message-Id: <20190527133857.30108-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527133857.30108-1-narmstrong@baylibre.com>
References: <20190527133857.30108-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the text specifies "of the GPL or the X11 license" the actual
license text matches the MIT license as specified at [0]

[0] https://spdx.org/licenses/MIT.html

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson8b-mxq.dts | 42 +------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
index 08ddd7fb0bf8..784b393314a1 100644
--- a/arch/arm/boot/dts/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
@@ -1,47 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
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
- *     You should have received a copy of the GNU General Public License
- *     along with this program. If not, see <http://www.gnu.org/licenses/>.
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

