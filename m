Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8720CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA912173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oHqucEjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391746AbfETOiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:38:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35273 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391730AbfETOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id q15so13316295wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3XiPRAq3iONjbh9isT60h9K+swEUyZx5NpuH8isn+A=;
        b=oHqucEjAN5rGyDvitqgZd0LC8uSMCUjDrBRZN2eJPKviS1qb9uPEv++ZVXEvl7uVo1
         C4S0D9mxbt9VPrRp9qMMgJc12026O9sLj3WAe+hy+o8pRy3LW/NEbK2iXRgptHeE9skm
         WDJ0eGi9vzd4WIozt6kxY8UHLa9B6j3+dTYCG1Rg9GLJAEcwwP0IXKb4MGvNEBzeTL1L
         m+lPjSS9K3DB2q/MGNe25uAFshy7uEQCRHtJwnJdZueBrnmit7SDxq/J0dYbhiQvGee7
         MJ5+z2o1GySyloJCHQC6ADThHznMW7XvT52Uy5sxAxCAOrQxfnQvq3KAC4sjkJquWBj7
         MkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3XiPRAq3iONjbh9isT60h9K+swEUyZx5NpuH8isn+A=;
        b=LWZPSycKcfWstPY5XszAIZ3mQf3WRryvOkLsFuqB9Qg8u7IZ0+HLTgeDAtfNl5tNsI
         zhLSUk1JLzHhpVlQuj9bo0UqtHZsNO03f1pm8ptbdRhnOisahCTrQNsETeEX0eTkvdoW
         z8CeQFBYI75bZtjnaIOhwFUdwp+cgMw6wXoSfak8zO5jFqHV9i7kX35nl2dxSUz03E+m
         NSQjc/cdLNIDDJMr6aMIWBoBY48I5VCgbEftFVwKcHljmyiG/UbqisIUq5g5afXxzYP/
         kQo4ToD/KRBZGwGbQit4a51pHTTceM8cn6rqd1rMJ4zVQ5AnWGzQLRUSrH1+J8xGxBPZ
         EpKw==
X-Gm-Message-State: APjAAAVDujkmHR1oX/Zn9zhw+ecZuGrFn7YsXlluJcr7WLzw60Yckorg
        2vn5lRO79HeKRTBH0wW6fCg5mw==
X-Google-Smtp-Source: APXvYqwveN2FjHNtP87z7oiJEE63JF4b4KLW1YKfeunSUmvfE+GgGL+YeURbB/vCkk+m+o4sZZmsHg==
X-Received: by 2002:a1c:c016:: with SMTP id q22mr35830816wmf.6.1558363100320;
        Mon, 20 May 2019 07:38:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 07/10] ARM: dts: meson8b-odroidc1: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:09 +0200
Message-Id: <20190520143812.2801-8-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson8b-odroidc1.dts | 42 +-------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index f3ad9397f670..27bfad138f87 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -1,47 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
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

