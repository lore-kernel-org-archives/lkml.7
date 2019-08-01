Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D0DC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E6E206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GVM7VG1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbfHAHzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:55:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34215 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbfHAHzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:55:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so3010002wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/U2vfr6KpQVUGk7LGivXBjTe3cQxbkb3JGHh9Y0Z5g=;
        b=GVM7VG1fhWn1thASAa3dEu1eaGoxMvUZKilOXRoZnyn5VPQTS8oN3mtNLX1TSuHFHu
         TLyEvanhuCJR7IlVKEusnMRkhmu8iA9hYUHH+HPeJgIw4s6CZdSGNQfA7i+CkFfkok86
         RORWtqYMWlgaBN0Zm/3weiXE28vfWRwS8Uf6WvUQ8ytDbv/240yNK1IFBoMArjiUyj2x
         pATmZz2YuFfYgItWgnafvVKgU80AMkIoiKJpb7Nies3ccLwGPEjhaxGrFBh3NaJDlZfD
         eXgQjsMyYZ5ZIlSObmFtLJOu+2REVIEOQl8bkjoiLdrpl7kXhBzlsvXfwrSJ4SkiyHbu
         rC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/U2vfr6KpQVUGk7LGivXBjTe3cQxbkb3JGHh9Y0Z5g=;
        b=BZBPJYOHjyQ0enJfcaXXxNHceMj1u8PsSC2/oQorQ9e2boj12/rJJQhlp+1Gf2wRb9
         YaJMxMKfKc4BzBjcZff7Ci8zcmSgccrVUiEp3GlmT8sGJnGX1htLdiwEes2ZfVnpuJuT
         bEjj1EPJbOAQWjGKzDZn8c5rCqDDFCRCEHyssrfJxGK0+0t7BdBfUFaOk6XIqUePrsKp
         y9qWVOs8xJmI/J8D9G426fW09AerzQEbTc/pimB9NuIgtQfQSjfwgwfw7ASsMQQxsV27
         kKU3Noa1EB+uHipn9SGGxkbWlRgXnEyhtexzF9JqhFOElqIxCw0owv1+XSRw+KrIP9nz
         JvvQ==
X-Gm-Message-State: APjAAAWHNUmNmAM9rufcKPAyhR4dCl6qW/7FG4rZywd9wmVcr9e0qLW7
        z2rE3hD66k29tvRCIWa+CHeGvA==
X-Google-Smtp-Source: APXvYqx63hzIPJbnoKcosXltEPLqar2N+McXWG9ADJG7p3a1qb2nNDFC3hnrT0W0g1JeoKNM6mhzmA==
X-Received: by 2002:a1c:1a87:: with SMTP id a129mr112944890wma.21.1564646102195;
        Thu, 01 Aug 2019 00:55:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y12sm64199221wrm.79.2019.08.01.00.55.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 00:55:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] dt-bindings: reset: amlogic,meson8b-reset: update with SPDX Licence identifier
Date:   Thu,  1 Aug 2019 09:54:54 +0200
Message-Id: <20190801075454.23547-4-narmstrong@baylibre.com>
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
 .../dt-bindings/reset/amlogic,meson8b-reset.h | 51 +------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/include/dt-bindings/reset/amlogic,meson8b-reset.h b/include/dt-bindings/reset/amlogic,meson8b-reset.h
index 614aff2c7aff..c614438bcbdb 100644
--- a/include/dt-bindings/reset/amlogic,meson8b-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson8b-reset.h
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
 #ifndef _DT_BINDINGS_AMLOGIC_MESON8B_RESET_H
 #define _DT_BINDINGS_AMLOGIC_MESON8B_RESET_H
-- 
2.22.0

