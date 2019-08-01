Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78CBC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BEB206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kk4EI62G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfHAHzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:55:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54351 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbfHAHzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:55:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so63516726wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2WiU/DsLe1wMNodqzZLwpA1aNczN5SEyIJEg5xWVGI=;
        b=kk4EI62G9gnoZqd97Z0u+DSm5SF9LFtmVoaZYg15h2QPorIngSPSqD+Npc3qeC0Da1
         eGOmkbCRmOYxun5Mj9FlyliH0lzbmVCCGsIDdYSKYou3lebc/3Wlk2+N93/+3mR0ogRa
         iBwn/rcDy2MKfCbEVAJe7cwGPs587ieLtDMax2zYs+DatDFsbBhBqoGnnfPhmAwxHlzm
         5dpGUoGnX77XJcDZRZPblQaQ/1kqCf9281rApakQNjJlDwfNUmzkLrb2XZHonlbgbdp/
         NQpl0PAbjp0BqZfMq5lB/PHJH0xG3FpBP/K5jG1CeiEvHzZWtzY/1FzczcmbmekYKDUG
         cDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2WiU/DsLe1wMNodqzZLwpA1aNczN5SEyIJEg5xWVGI=;
        b=rCnbZAFQUX/nKMaVJWCrDTJZaaAG526+shEUTTamsGfq75zI2Z3udmkpDQdSxlKFfZ
         Qk+lfeuNh2cHoOJqmhOKi5EwhdoZvtWo6/5ILPjPFudZrvhU3OW4NnsKQDNl070W3ECC
         4iEO6p6z21iSXCNE/4I/h9prqIpQxo7/5TpY73jwfViPTFwNVMB4wiCLEOS6t1qnFLpa
         q1dWO2BJ/WHvjA3FlTLtj2gk4FZ/09ROuJamccCdOfQSEE3Eiei8OICR0m/UA1miJ7Xx
         ijbAsucvBocgp3XFSexacoTxjhfD0YBx7Sh+6f8Kfrc1naoZV9zMHRGPctwCCZARe8T2
         E7Kw==
X-Gm-Message-State: APjAAAXzHNPEkKH9oAWn/nRuiYPzB/KD+9nr0B5dQTLMlLJWbfgizgJO
        YMt76NObnufNRiBznxVxLzz77w==
X-Google-Smtp-Source: APXvYqyIkpvceBqFHAuhL6SK/XlbkFXZgpPhOoIlOhD+7y54rr6VzOLrLtQGkX0yCQiCqFHg5dmNFg==
X-Received: by 2002:a1c:7a02:: with SMTP id v2mr114218798wmc.159.1564646101566;
        Thu, 01 Aug 2019 00:55:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y12sm64199221wrm.79.2019.08.01.00.55.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 00:55:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/3] dt-bindings: reset: amlogic,meson-gxbb-reset: update with SPDX Licence identifier
Date:   Thu,  1 Aug 2019 09:54:53 +0200
Message-Id: <20190801075454.23547-3-narmstrong@baylibre.com>
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
 .../reset/amlogic,meson-gxbb-reset.h          | 51 +------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
index 524d6077ac1b..ea5058618863 100644
--- a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
@@ -1,56 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Neil Armstrong <narmstrong@baylibre.com>
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
 #ifndef _DT_BINDINGS_AMLOGIC_MESON_GXBB_RESET_H
 #define _DT_BINDINGS_AMLOGIC_MESON_GXBB_RESET_H
-- 
2.22.0

