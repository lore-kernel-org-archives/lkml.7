Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE49C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BD6216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LxgGhVu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391807AbfETOiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:38:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52280 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732877AbfETOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so13593745wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsXRVF+Q4Xl1eJydcYQleu4f8bJRfycH0peR8dxLr58=;
        b=LxgGhVu87BajYbSzmXi0IzSAiHiTAYKHLacnLWWV7vXsrDMMNhNEDTbyA84BeXaYIk
         ec/9sfy4kZ6Cw0rtYk8QKvGQnSMOlY2IWAbVGrZ10rY++c+xzDjUDtTb0uYihYzh3Ir6
         T5YcwqIS21nZgaIl0J1zc41HhzAWyCApOBXpchVLeSScvGqYikxymiUUtxTDnBpTtLL6
         ohZt7Loy1JE2i3X8uKjvCj/OK4OLMdI1TG2PeRCHYEdULKhe6t6XiNCNIFTm16kcQDbz
         svNnyMHCquBY3JcHr4OeoyQICrvktG0FjlrrbCY1kYb1kbLrmmF7iZ7aG63widp0XvUD
         zxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsXRVF+Q4Xl1eJydcYQleu4f8bJRfycH0peR8dxLr58=;
        b=Z9yT5yc8OStTAurwiCCOYuFRWQKXT7Scn10yxGvucQDBPm5hWigXxs/s5kB9VUZUkW
         yNPzkSgX2ntseKm0VwYJRdG2Z1nD+7XQkrlG5i2eUHJ8/akmS8Mqqbd0yRVXncKtuPiX
         3YgTW9agR2L+OYBtXu30WqAAAE/kudYBYlSpYc4LKHeKIjNhhEfPcr7q5k480MYAWXBQ
         SM0TPryVRx4UGfV1AgS6i/ZIY7SYToilP2faVSqNkKuYZf+HSzTjJhw+pH1WHPzOh374
         Qm0GwefHIXvxi/tiVhqlnBwK5Kp3Iee+yu3kwTCyAD5V5qDJJ8PncZrFwGNODT7xfcD1
         aBVQ==
X-Gm-Message-State: APjAAAVQTZZFzZJmz0dFyTb9ffNQalV3IPtcqc0mO3stWNnEWRKD+BEi
        Vc60ci/lfVTtg5vgJWOUHPw4PtrLa9MzeA==
X-Google-Smtp-Source: APXvYqweBWN2ESfxa4/+dEXt37jaGm0QmgzGH5jH9Agalj8dDA35BL5pOixdonfwJ0DfZHMLhn+f9A==
X-Received: by 2002:a1c:b782:: with SMTP id h124mr2889396wmf.20.1558363096676;
        Mon, 20 May 2019 07:38:16 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 02/10] ARM: dts: meson6-atv1200: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:04 +0200
Message-Id: <20190520143812.2801-3-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson6-atv1200.dts | 44 +---------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts/meson6-atv1200.dts
index 997e69c5963e..4d2a37da0161 100644
--- a/arch/arm/boot/dts/meson6-atv1200.dts
+++ b/arch/arm/boot/dts/meson6-atv1200.dts
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
 
 /dts-v1/;
-- 
2.21.0

