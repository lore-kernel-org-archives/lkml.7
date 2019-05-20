Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE57C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2FE216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="awR0zC0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbfETN7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:59:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53464 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbfETN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:59:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id 198so13425843wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q5ikjbPSCHRQAZ8XpjIGvp4CtMI7esI83aWB/BOoRdA=;
        b=awR0zC0C6HFr9b+KPaXLWOpAnbu221RHYXarKhSh5QVhQCIUpOl/GvA2qPQ5L33p2P
         o5CRGqdQnMiBe5rWjcK/rDcppaRl5MlkbFNYiZ6KaYYEsLNFUxxzHUrQXFOae4LcVx2M
         PC01GUr1oAb9WU8U3d9XUUo5ShpD0g7H+HmcFkd8o72S1FIAVGAeRTOKO8CyzVcS+u4c
         55qW8yPjKPP3YV2pR6eypGCux9OJbg0jybdRC5N7JUAZ3L687pG4GyQdXV/0dRVORR+Y
         MP2ecLHwImCRUSqrQ3w7N7wtSi0GEe2K8d8Ibf5v3LczhihtxlM8neeFRX4hFgPDY22c
         o53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q5ikjbPSCHRQAZ8XpjIGvp4CtMI7esI83aWB/BOoRdA=;
        b=HldEsEbjm8G4MAJfuI1kpHzjjzsWPM4qXZIodDDTzRZhA2EPOWdasFVLS9+qS7G86m
         LgTm9Kiqd8UigZ3f5Abg0FtumxYP0T3Bujypakghl5+1nJKdycZJkoaIjsmawOq4PtGG
         14NLbFRMETJ5cxTh7HMUNAE72FsHnAVDOsYTnzwF/9ff+6/2TDsDnfSwr2hFaD8HGkDz
         mvUpzY4tULQDvAIdiPqM3+mK6QPq1axBEv8DgA7BBCGzJsraigzPZjT+dRQ/GzRr80Dv
         d4yQXD9iNlgF66bY377Um5WwXPlKT66aMyglWv3o7MtHd8dEHfApl4G9QHrv07iDBK3T
         nP3Q==
X-Gm-Message-State: APjAAAW9lvIUtwJUwVlTcLo1mXlH8TdqihSvBDNZaNBpMeLPJWrnNuZK
        1iXHvZ3p/cbjztyIKQAcBkizB57DqeuD7w==
X-Google-Smtp-Source: APXvYqwrDN1EXgltWlHOS1575AFZtbDm/X11UixJxY9eQPsiyR3/VBNmZ9AXkQgbylxOmR70AcvHyA==
X-Received: by 2002:a1c:cf4f:: with SMTP id f76mr9385856wmg.18.1558360769988;
        Mon, 20 May 2019 06:59:29 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s124sm20858819wmf.42.2019.05.20.06.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:59:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] char: hw_random: meson-rng: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 15:59:19 +0200
Message-Id: <20190520135919.28946-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/char/hw_random/meson-rng.c | 52 +-----------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/char/hw_random/meson-rng.c b/drivers/char/hw_random/meson-rng.c
index 2e23be802a62..76e693da5dde 100644
--- a/drivers/char/hw_random/meson-rng.c
+++ b/drivers/char/hw_random/meson-rng.c
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
 #include <linux/err.h>
 #include <linux/module.h>
-- 
2.21.0

