Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70D4C32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE09206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IzvL6Fh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfHAHzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:55:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35454 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbfHAHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:55:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so62213019wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VDh+yTCqb2E9NnVNrkncEUqcUL07YA1bsORJMbcQ8lw=;
        b=IzvL6Fh8RsohbqMby4W0y9O0NYlulPkbH7/6/KE7ev/epMQUxqEMGoBNO7hasjRB01
         /HKKAZluufYjxDeMWVHHn/PBOC16QdfF8bFsHPAH/y0seF5aLbTFn3qY0xodZ77nucSY
         xYMW3sPy+9Q9CM6qMRRSINJH5EbEDk5vXnNhNZLhPlQpUwj+N7ffv9fojxS7O7dsAM1Q
         wmk7yQI6F4l8KrAM7trg2kTFx7sn9OQD/diXUgZ9QzkMHRXcqBM5bSemJqoYhaxQhj/7
         E9wFCTeeCCjgGVkitxS5ZV+i0H0VTV0ObPeyma9le55NMAyecpfvqWXsQP3FV+hdWzCM
         UtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDh+yTCqb2E9NnVNrkncEUqcUL07YA1bsORJMbcQ8lw=;
        b=hmJdhRP8caSaO24WxlfFpAjgamKl4Pxuc+lTIZR2DYcEqaKyv8Wb9BNHfiHDgsc2UV
         xhl2lUHuWiaLEDLxGhv4SAgmTJZw7y8rdi1rkkFTCN5tJp+fP2JvMBgnsbeIEXIUHrpc
         /W8+bJ6/RBI3F95276aC2h9oyWVPlhCarARejfu8PVyCeQ10OvUvxrdKVx4D48joygHr
         8z/16XQ6eEcoxNTW/EHT19tQsx5j38tesiCyB5tHEboo5jOGqUu7nrbTOKiQqfIJHe8w
         4x81OoDDTsJPgRXH3WlTvn9q/OY2xIDe176U04A1k6uljW1i8iuvtkQZ1D5ROIvXK0Kv
         F7eg==
X-Gm-Message-State: APjAAAVxcd3fGnV1RkyS1LwuFiuQBEsLWLqdnhzMI+DvJxN+eAywpjmo
        gPuc8cAvA+ohKLecE7caiqPi0OwtM14=
X-Google-Smtp-Source: APXvYqzGk38l6yq4GXNCBAzayn9dzPlX9QGyiHIVNo8jdmjDHvCA/27f71y7td8ETAlQCK68vOhRjA==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr34128533wmc.1.1564646100811;
        Thu, 01 Aug 2019 00:55:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y12sm64199221wrm.79.2019.08.01.00.55.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 00:55:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/3] reset: reset-meson: update with SPDX Licence identifier
Date:   Thu,  1 Aug 2019 09:54:52 +0200
Message-Id: <20190801075454.23547-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801075454.23547-1-narmstrong@baylibre.com>
References: <20190801075454.23547-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/reset/reset-meson.c | 51 +------------------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 5242e0679df7..7d05d766e1ea 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -1,58 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Amlogic Meson Reset Controller driver
  *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * Copyright (c) 2016 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- * The full GNU General Public License is included in this distribution
- * in the file called COPYING.
- *
- * BSD LICENSE
- *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *   * Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *   * Redistributions in binary form must reproduce the above copyright
- *     notice, this list of conditions and the following disclaimer in
- *     the documentation and/or other materials provided with the
- *     distribution.
- *   * Neither the name of Intel Corporation nor the names of its
- *     contributors may be used to endorse or promote products derived
- *     from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/err.h>
 #include <linux/init.h>
-- 
2.22.0

