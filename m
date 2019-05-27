Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD9C072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8478420859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jIrDDMHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfE0NjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:39:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55334 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfE0NjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:39:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id u78so3358673wmu.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbnPVZJdWtdW6tki127dTtfmRwOqmvHfy23+LkQb2Hs=;
        b=jIrDDMHo45dOxUysVUWAOWMx9POubMEMDRyo9ld3jzWON5ikccg0fLSuP67/TgXdxx
         nuzmBxFXMQmp/mJlrVBo86dxs2e39dRoY8wbI7hJba6xpfHg2E/Tt61SS74hLbdYlUqg
         yT9Qhrqib7GOPmDe1jrH4pLMLcz/+3fySVhKNFNeUWgMHCrC1uSWLvbk3tVnd+0HEVeu
         DGvpoqlS5uLsrPqa83RKev/WrTjuAkBhVEjG/ym9N6dRe6NMU4yaWhsEDCTp+c90kUZE
         vgGR+y2TsC5/C6CtDVaUqCRxxET0jUvAGqTSB7d0DCEY8irPlfb57EzQE3cWO38nEOsf
         BG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbnPVZJdWtdW6tki127dTtfmRwOqmvHfy23+LkQb2Hs=;
        b=f+OaJCz7hFqweSKshX8s7OYNud/39m59WLqvVGdtZUuhr+lqXuJ6EhHa1gBSSSd3m2
         Gr5+Et3FC1DLLTsvwMCoIYYj2bsFozSChdljYBPrkF++pMMRrIYeJJddGlap9WZ07EW0
         aoEfyRJJuvYfYYwykXavruGZX8BS33wMYrID8PB710Lq6D9Lt+ysIjf6lD3ZwjCxooUf
         8cyuPD2YJ+VQ/8ANx2sqM/aKM03TC7Kth7N4UAs9TKD0q/O1TW2zhcLePJTX7NHNVCYM
         kmTRxsM+SJjoMzyHvl5fiamiNJlSepl0O+GVFzJD7er81bRqKiKjYVxRi82IrCvzTb9Q
         UM3Q==
X-Gm-Message-State: APjAAAVUnPP3Y/bXyGxZ6K6b5LvVYiwN5nacVAI7vH3c8cZUpzNZFuRS
        FCcSl1Wf8lV4WnMJyQ0jDkifzrCg3OxxwQ==
X-Google-Smtp-Source: APXvYqzu/VyF4LKbha2tnybdY20KZTdmVmXFpgEjqI4mkRxeUlHAo8gv63uF381WPDgmS0a+TpG4FQ==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr10192683wme.95.1558964344265;
        Mon, 27 May 2019 06:39:04 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a124sm7838335wmh.3.2019.05.27.06.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:39:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 04/10] ARM: dts: meson8-minix-neo-x8: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:38:51 +0200
Message-Id: <20190527133857.30108-5-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson8-minix-neo-x8.dts | 39 +----------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
index 8686abd5de7f..61ec929ab86e 100644
--- a/arch/arm/boot/dts/meson8-minix-neo-x8.dts
+++ b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
@@ -1,43 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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

