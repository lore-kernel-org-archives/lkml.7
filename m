Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1CEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4576216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rMnhpsSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391767AbfETOib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:38:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56003 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391723AbfETOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:38:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so13556394wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y20ylLT7P1j2zmS/M8TRrFaoBlL2u1wlYokCGcGh9bE=;
        b=rMnhpsSWW4eRlpukLPrOxf9e2lOvWhDWWqoNIrIJsKSY9pa62Xd4kQ0067q8W6AqU+
         C0vBXtulNvGfxVCB92NgU70uoex4gAS8ulWkeTi+JvE59Tn6YEJ9T+nQwSTD0ggL4Kbm
         y8kibu3FRZvgd5mgK0gaBa0gg5FnAcx5lI63OWn0m4/eMXjcEZSXZhpkJwmtQhcNmK7i
         src4owHkRNPgxx3MDcsSdRe2wgCb0m4rOOtQElpkK7Y5J1nnJe9lIF4FcI3xvS3Nn65C
         n8A4MMuTe5mntQixwL2tzdxx7fhytPnwlDHmcENvc8c396+FjzfMA2bJB9eqF0OQIduw
         KzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y20ylLT7P1j2zmS/M8TRrFaoBlL2u1wlYokCGcGh9bE=;
        b=aAc2RSGH7+MTA6mIlBaayK8xCh38K7ZlSCMfUPv4W+1uDxqVRk9DvfrGJGI6NWiwTN
         H02trwmLCdzqeaj5TwtQ7YKDuhN5rm+JKzS4zCnGv2R/i6wRsr42/sfcxyyvvdDV9sGR
         UB3NIrT6wlzGjuojC5CJquX3ZpZjERKsx7xnkq0caPHX/eaAXll2zmNRQfVXhyn3fPGv
         jKGSncXQbyiEAk9U+w3TOHBblMr8uKoi+ByBrgnZYhd5D6Jgt//FfW90rPRIFStgHDx2
         Hl35GYw1AIZ90wVtGXx6Avyz7bBfQ9OoBoi+hR1tSLJTmVxhFcD0DGGu7DkDPbE8QPDD
         4Wzg==
X-Gm-Message-State: APjAAAUNoNyZAdQKr5JrTosEXYrCeyfxeJL52LiXEfEhA0+jxa89xxqW
        FFMBbxIyxEkcCzAEyimMFl3MHQ==
X-Google-Smtp-Source: APXvYqzkyDsfvC4aDIGmJFB8DXem17t7gLF+Y5FHN3d5fniARXq66Nn0EJfaJJP7Vc3hqFTucUPhbg==
X-Received: by 2002:a1c:63d5:: with SMTP id x204mr12488176wmb.3.1558363099620;
        Mon, 20 May 2019 07:38:19 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y4sm12505976wmj.20.2019.05.20.07.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:38:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 06/10] ARM: dts: meson8b-mxq: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:38:08 +0200
Message-Id: <20190520143812.2801-7-narmstrong@baylibre.com>
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
 arch/arm/boot/dts/meson8b-mxq.dts | 42 +------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
index 08ddd7fb0bf8..bb9a96c09f69 100644
--- a/arch/arm/boot/dts/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
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

