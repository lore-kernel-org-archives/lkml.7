Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B6CC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAA0217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GwZ+2pxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfE0Njh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:39:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52475 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfE0NjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:39:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so16230681wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOChpaEsOQLFv07SwDRnVxGpJlOXkRDlPY4sW9iIPa4=;
        b=GwZ+2pxMpQAjtt4cyGo2vJZxYSkmzjAIdxdbIgWq6MaN7THXApB04YGh6YYdtM8lpT
         nz6KJ1vSKqTmpDTANKwaDCleIek7Inve3a6rWWK4pRgDBIKd5kzSjkTvsRv6CWC1FcbU
         C51QePs+QvBrGKedh+bfmJJcIz/TlCD+G3/nBgRFEwT+cm+Fkbd9Kfr+x5MiuCTlsL1v
         I5na993FUbms1newegA2uqph28MPNOIlJ5gBgS7CgwJ2UPAwb7Ox+tV2sF+nf9GkglaK
         0HsFwfNxx67/eljpGuW4uqoMTqZNhUxcXXEj454QBji8dW0/zhqdt8fmWv/gpUdn9+P+
         OiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOChpaEsOQLFv07SwDRnVxGpJlOXkRDlPY4sW9iIPa4=;
        b=gTgjRlN8FBm9EF03r6h6X8oGaUO3HetB5YjrDtcplENyJMDelXap8DpCVV/fJfjXXT
         Us7qPbi07HUrGoiz77vtfWpHND400ItNVeH40JDMg+hC3cvqSOyQ7X8vJcT+3qQ/rypM
         92GEfWkQy6Jly8jIGLzwm7aLhKBlI0/14PKSL/4S0vg0ACJTozHU3qg3NSSeB40dzJ27
         cM54sVIXrdFX0C7kTsMFJVLV3l3pfZfTA0hMfy6cvv7c3wnj5QOKF3qOAcIcoZHKgUSb
         o7qLK5B7mFd2q9911wz8XbOSlYlCmJ8AvXyWRDQsou9OlSc1VnO7p6Z2b/JfDu1Oy4ai
         488Q==
X-Gm-Message-State: APjAAAWtGuPirs7We5Qq91W2jiVfBGPe8PQXGRHxeqZR1bce8r6uFqOS
        cOCFBkOGvl277X/IAP6mDVP3UA==
X-Google-Smtp-Source: APXvYqwi7sfSCd/vbnNO821w/TDC+t8BUGE4AWiH/oHHU4qt6i264xDT0IXdeP1lZo+hczzh2if5iA==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr10304860wmh.96.1558964348240;
        Mon, 27 May 2019 06:39:08 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a124sm7838335wmh.3.2019.05.27.06.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:39:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 07/10] ARM: dts: meson8b-odroidc1: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:38:54 +0200
Message-Id: <20190527133857.30108-8-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson8b-odroidc1.dts | 42 +-------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index f3ad9397f670..018695b2b83a 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
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

