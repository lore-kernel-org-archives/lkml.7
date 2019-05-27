Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D7C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE5920859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Tb1Q6CIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfE0Njl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:39:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34742 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfE0NjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:39:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id e19so24453wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhuA4Qk1JM8R8+GoGVu3NgHcPc2TyFNVbue48QXSQ8c=;
        b=Tb1Q6CIg0cSyouTKUCRztqV5MfCVmxXuQT2HbZyTy2ZIhBON0ajN5KVXdRdukyAXyO
         L8f3sALq/EGCmUZw0l6l9l+eoKD5U8z1RiKluT7wEk/idNtSSjVGDSBF7gT/wknTRzHA
         5TwzynO+ikYlbMNw1nJyQ+EwjUxFuF7yPEy9YmvWOME0SzUBfJZPfToFFn4b+MejGmbX
         eisCrvPJpA2d/L358T1juFVLWhbsG7mIOEyZ8p/FWhPCHtbk37T7s1mwy5FC5RnDKdrv
         0RO9WI6zlw1PBgKeHgp4PvLIvZUekHebn4ZZW2KdpcdETOl+SxzywowJt+CHZE+zMKhy
         IvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhuA4Qk1JM8R8+GoGVu3NgHcPc2TyFNVbue48QXSQ8c=;
        b=YUOGNKIMD6VnugMYN+e2u++f3NokqW7/P6OV4Vjudl7uTxb5bP0qHcuo8YlitsPewn
         LipA56lTQ04zOXFpUSAoZnafvBkQ4f+m6NVDi4RCabd5GPLRA9zAOZWqy3Vq4oXpSE5t
         5H8bddqkK8iALYDUAxgnsaP3YPPEXqfoZhO16xQTJjmMeQlmneBqpl+Gwd1BkBHaPySi
         ozmLLlumbQBrioJYV1fMIYs7+v/RBcylLr7HZsvlzSeCe7QpEU0lesVI5oRf174B/W/3
         CWyQ9KTtGoOGvWus3MCqzhcEofvC1I4u5VdMSkWrOdeN25/O84iU/0bONRXjz21DkQhm
         z7nQ==
X-Gm-Message-State: APjAAAV6C2SN/DHohaAASuP/naRHSVRHe83V+96aZHfzAQe178PToozn
        4z0iDOaUTwrLr8BBsDaK/qaQaw==
X-Google-Smtp-Source: APXvYqyuX3cAW8Rw/FCEAHARS5eCeagM1dgihff84N2r7WboJAcdNwqrffgecij8XfggSeVk3z2jVw==
X-Received: by 2002:a7b:cb84:: with SMTP id m4mr14629675wmi.50.1558964346013;
        Mon, 27 May 2019 06:39:06 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a124sm7838335wmh.3.2019.05.27.06.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:39:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 05/10] ARM: dts: meson8: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:38:52 +0200
Message-Id: <20190527133857.30108-6-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson8.dtsi | 42 +----------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 7ef442462ea4..3dfc62da669e 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -1,46 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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

