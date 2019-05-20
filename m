Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE2AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECA9216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KW11kZMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbfETOE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:04:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50374 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732855AbfETOEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:04:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so13476962wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wZpcedj0usuNnQQe4hSwoGa27U3KI1NBMOLWj/UNRC0=;
        b=KW11kZMRVXs4raFGQTEwJgJ0jnGGEBCREFbR1yhqhZobC8ZIER22VyXV2kmejPd8cu
         P4Mi7yK+EkWwcaUch7S62P1OdrjOz5cxZMxywZBlIVq/fZyKHWrX/6ytzeIC429eEFVb
         QfPa5n1hcfVyvTvxuy47siQ6HD+Hj96d0myIwOEThjRO7j58/CKzLddK4EY/0X1gOMBp
         HD8SjLLNXc+pukPSTwp0vrUx3IAfwh2lJGt2p47Ic0CG1TvG8eAOogRkzugWhpkfYqwo
         KgO2RKJtbYWmysT4ooHtBwoAYP1XxXmKs0g/5w1hf4Sg6s+Fl0Hd+10BXodeidFWVFIR
         Pspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wZpcedj0usuNnQQe4hSwoGa27U3KI1NBMOLWj/UNRC0=;
        b=OadhPLIn7uXlu2+cxe9M5Mrt3LbVccUnD+co5+oF+JwZIjjhM4Qr2qp9xLvM+VKC17
         OzOvYZv1Og5/L+RGaY0Z3cUe3XDaFE0C5p4xWFQOvWvpuXiImx0MeSsFHdjvnPP4fjru
         AjI1+HaOw1tH2wX7DBXnj3mJAajZxvjIaS9PLePLVxC8sFiYVNncvDoVNTNTgyp8KzhA
         jdiNwsWlZKpkC87Oe4g+oCvF6LxlwzQYchs8yd1RnHj51+vnkJyzd7YRgziR/AJCa5RO
         2oQaKPG4LdioQ7mh5RH6QSau3aFwJZOoiyE7X85YyLcachCDUK/JxECnPBV5k5oRHpEh
         iazA==
X-Gm-Message-State: APjAAAXEnlZfqK44f2SiZqxSSft0hrTW7Y8nQLZGk4u3pXVCjQj3n/5+
        262Pmqq6qpcvqd/Ck4fy4OXFLA==
X-Google-Smtp-Source: APXvYqxKM4u75H/WX5/D4Xu3uAIucU2k0DuLBgRqDfQN8DywNO7NTSwNq3BbTLlSpamGImB/4UMr4Q==
X-Received: by 2002:a1c:e708:: with SMTP id e8mr30285399wmh.11.1558361063451;
        Mon, 20 May 2019 07:04:23 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q11sm1207286wmc.15.2019.05.20.07.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:04:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] pwm: pwm-meson: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:04:21 +0200
Message-Id: <20190520140421.30074-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 52 +----------------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index fb5a369b1a8d..5fef7e925282 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -1,58 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  * Copyright (C) 2014 Amlogic, Inc.
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
- * Copyright (c) 2016 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- * Copyright (C) 2014 Amlogic, Inc.
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
 
 #include <linux/clk.h>
-- 
2.21.0

