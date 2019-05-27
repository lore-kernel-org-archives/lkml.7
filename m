Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00008C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC75120859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eVukzGrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfE0NjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:39:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52470 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfE0NjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:39:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so16230463wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2pg5paT/NJchnflVcngAWtfEGRymEZdlataY0CHUZw=;
        b=eVukzGrxWUEJgBgKeB+1eaDG/bMmY2r8B155esC2L2uBBIKAo4AGvBo5xUUeF8LMYS
         uaxxzHGyuHkQLCwuIfb0Dh8kPvTa7sqzffPgnzYJmgJQHfNzARkmeFjxdBgssUHUXPLF
         AzQlKLk011U4caTcLLoCClButslRe00h4mxreHxgIuoLSdJot76DA6bY/sQqfMC96yKH
         OCfh5MSvHcELZ5UeCAgObU/PWBnoghR+Xyv/iBByuvIWyQiQ0S1k8yTP6ORhOgOMv+aZ
         wEgMRjnZYlpQCEuQYva9qcoJbjOkw0M6JG7dSGBBzTwTmUAzfK9KJZz6LgTOuBiTFHpP
         oD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2pg5paT/NJchnflVcngAWtfEGRymEZdlataY0CHUZw=;
        b=Fjec8iTmGVBp6iN665pn6K1HJOyvedFiWbXkrybdqlcQg8LwB33TvCsTAGwvLTR4HN
         JsVFlyrBtoiq2DU+eXX3iQRzSmpu0wyo34czeDYbBswroeytCSX+fK5s0eeBuZ/WHJnq
         4kNcY+iROUpoJTPj3uZZ1kRXfu8VGzBYEWuMR0dWMLxiU7J0gOZO29Lz4XDH2oUCzWb6
         65FNuf5IkT/aXuLP76NUZMLjykvpfLLqZqDwOe2Am420V1aK8bRbgmm+l4+QiadGH9tO
         UeCcGwInDloTkGPmoo+EXQ7EVD+V7FibgKP6wvH/Hclyn1o1h3D9faoHoYTmwNMGfQq0
         cYtA==
X-Gm-Message-State: APjAAAXSj15zSlaq5XJne4gLEBOJ27lrOLkwD0udUpNFUxeIsxikggp6
        9hzKb18eIUwWJEEN3A62+zEHtQ==
X-Google-Smtp-Source: APXvYqxn8322bf6sVLBtVz4d2LHcCB4QKIBLtHdJ4g/LP8MtYxyRXjJOanxd6XGYP3q1hJDkydzK1Q==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr26129097wmk.114.1558964343555;
        Mon, 27 May 2019 06:39:03 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a124sm7838335wmh.3.2019.05.27.06.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:39:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 03/10] ARM: dts: meson6: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:38:50 +0200
Message-Id: <20190527133857.30108-4-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson6.dtsi | 44 +----------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index 65585255910a..2d31b7ce3f8c 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -1,48 +1,6 @@
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

