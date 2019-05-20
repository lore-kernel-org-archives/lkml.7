Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5936C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD3821721
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oRVC9sOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391758AbfETOi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:38:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41408 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389239AbfETOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so14621415wro.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVqgXqCRLzgJjndvfbSssXq9sPi6rcSDzSBDfSWDhDc=;
        b=oRVC9sOVqaJJ7/VIvGdz/yOhmhMuouO38MVvt9FsMEigfB4u6TYFZsxNCzy/tT7QxZ
         BH5gtZkLsm6GOm7m6uA5mZUwbR0hX3M+nuU8dMVFqLgx+7ZgxSjJhBlY0VIEH0U3o/hz
         +ogf7v6+8tA4eU6oW2zhlcO1Niz72Txg3u7NOb6B5/9ZurmxWE6YlHkzSpMdVU4H5wet
         mnPY1SbOcXHiQguasq+UYd8rqSYOvRGkQHxaeFQOahtAQaxIyAbIF2i44eP/cmi7oFTh
         skkZ6eL8D2lD5YVvsU3NMDKGESXCV1aHo8CMFBoLVSWjB/ri+FhpEaLLPJkLPn+EJkBz
         Op1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVqgXqCRLzgJjndvfbSssXq9sPi6rcSDzSBDfSWDhDc=;
        b=CJTORZIj7MueJcAJVlqUiSVsdLPZu20ZF1lM0mnfYQgOIZ10qhvIdKARWiBKF9oNxj
         RJhTDew0MmLFn1hKZlRcbAJqLtux8mBKo6Y/Xf/z9x6s9dlEUoQPqfbieQKqyyWYK1Eb
         T7LLrr5jTqXilviiFiMBE76bRhxtT/9JA26V44pV22TxeDg7kE9qSBnwkCD/8AwSCjwj
         q2F12um6VhBXjyeY+NLINBJiWHCZOMOrYiP4KCWXJMqu50Uu+AvN1MlGsvoTmlfbFQxJ
         xWOm64szuTslYgnw/BVD6zPyeJJEfUZiIKq2nI64+/Eo2Qnn8QaRq0vw9wbjEDPUupf/
         nLRA==
X-Gm-Message-State: APjAAAXVxdg+EOCvr5xQIdixe2WL/ClK+YPatj19JC40bIZGlzljbEfS
        0st8cYHoBJJ4mzweFlFgKsP6+g==
X-Google-Smtp-Source: APXvYqxn7weDR9r3Q5lHk0WD6puAQO2W9ig2A6lM4Zo14uhc1ETk74//4DY3cTMY1DYzaw61XQ7UVQ==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr6653651wrq.10.1558363098881;
        Mon, 20 May 2019 07:38:18 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 05/10] ARM: dts: meson8: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:07 +0200
Message-Id: <20190520143812.2801-6-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson8.dtsi | 42 +----------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 7ef442462ea4..fd8d57d0a3af 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -1,46 +1,6 @@
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
 
 #include <dt-bindings/clock/meson8b-clkc.h>
-- 
2.21.0

