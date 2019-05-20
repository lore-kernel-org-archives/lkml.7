Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0A8C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8E121721
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="k4NzsdZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391719AbfETOiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:38:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37579 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732930AbfETOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id e15so14914284wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9U9UFxewhzgfdgHobwlemQkQvapoJUzpG7DyO7HNN0=;
        b=k4NzsdZWw7F3mbMtriap8qmSsAr/E5Fom1fD7BsuJEUZ5gEsCldI4enocXYFcNvnlL
         MxBWCCmDp2GcUiDKY6jjA40Lz+/63YhXoJLO/1Cs7YAU1KvvAizLFmrekcdREQPFjSN7
         KPezATZpwdkAUy0fPHxrD294tpuUYUCzp8EIdsN0uvegUsQtnt/32P0ESrmZxrVZfaHX
         FGxwrQ/dtu46WZUhTWgWFs2wJaYBo7a5+qcR28oUosOoZU/KsSJBgNp+9QFby9Y4bLQJ
         GvYj1DqkWymR+OOZ9KGRRZBrC4s3bU64R0OKHJh6hLqMOY+gcdakF/p5rO/TDtkCYwII
         wMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9U9UFxewhzgfdgHobwlemQkQvapoJUzpG7DyO7HNN0=;
        b=lgNQYsU7Zim8Mr5RlXpjpNfjF6MhkKGoyJkxpqWfxlj6TVQU8Pl2qCGpvjB+3Lu+M4
         0MrMA7ehxwmSmZP56OeuYFms47az7Vz9a4l5vWVO8c3yXZLQVz21kazqYADWDqXuRBaP
         8g3OzMjxRLnp42fg9XtA8S0uiYKW0oMBsw4BjvX0vuLn/6KTrkMvRp2C1NXxFr5scos2
         O2Qk417c8Isghul/yha1eHPvN1Hgc7GtDtPi4fOD5UgYAS1E1J6BB69C1vOJanq5JpxI
         T1TXqIoBEeDT6Glbwl1TN21GiEIhnrK/51yqIaakMWULIN7j6eQ3CaP5JBt4uKDUEUzg
         b/Aw==
X-Gm-Message-State: APjAAAVBPFbOlXT7zWL59QFSc3av0H/bXfWScFZ/MvOgRMMOmnyj6OiF
        qF57uBHZ4AsTvigkOYcoa3+2+Q==
X-Google-Smtp-Source: APXvYqxhH4U5Wn9b4ZaRUOkvitSAEMC4SBP5q+SbWgFqVIcYcMlMhG5xdnJZXUxqMdLgouERAcWGhw==
X-Received: by 2002:a05:6000:10c7:: with SMTP id b7mr14036103wrx.288.1558363095957;
        Mon, 20 May 2019 07:38:15 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 01/10] ARM: dts: meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:03 +0200
Message-Id: <20190520143812.2801-2-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson.dtsi | 44 +-----------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 8841783aceec..6e59894bc6c6 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
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
 
 #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.21.0

