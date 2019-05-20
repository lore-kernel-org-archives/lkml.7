Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483E2C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D621216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZRfoMlzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391568AbfETOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:36:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38420 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388920AbfETOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:36:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so14911517wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4npsL1gYy3DFnvEepqLNlJ3V1RQHIdG7lq5wqMtTwM0=;
        b=ZRfoMlzMEhDw3sGXZxEs18iVoc5lXxuYdnqjiUL552hHvl5ayEwePUV/ntxl3EHA9/
         igU8mLm9/JFKs3iOuTeOvOdVGXdVR+sZH5LFf25ifq1bE4IpB6E08k7345p8TLG1otDL
         Hk0nlU7QUlGpBc8Bt7k8Fm4lCphc1g1XsD3uscsRO/8++4gBqnF6bmlNA3BDz22w2aa2
         aHPTwt9YN8Rc/9Ujl7EJA4POTcaUq+APg9ap5q1rWqtUZDYlrrRxgjv9Lb+Jmu1SVfHL
         A7bDta7ZN1JG/bkFLy+xMUizuCEATNztLoihLU659lDE5kBr0fs5aWo1cRRknisoqnQj
         lGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4npsL1gYy3DFnvEepqLNlJ3V1RQHIdG7lq5wqMtTwM0=;
        b=iiQOqO45bCfDUJBu2c9GmQ9x4Aqba1az0/Jjrm8tYpff1mKFGUVUwu/PB83TcfQHyz
         5Ov9pRNhTHwYsrfDw13ozIHdjUKzJ2EVwW/S0fVGmg4fr6aeNRsnBoxnIJ28yqcEpgLk
         8rt6IWc0qKPK/HILqqX5hzg6YzoYyUMfrup78Ay5N4QSVQHY3gkFkfqAOBYGmv+NeMXu
         eqJ9MEhW2h7F/mtqPEYPp9GKoECRtopssvIF6CcI215LiiNbCwdf5c39kxipism7sl6P
         V3eyfSlkb+Ou7xaUYbQwiY8xIZE5nPMkDHJgxrY4uty6B/MWSIZRd6zuTNN9O0vrY90t
         CP9g==
X-Gm-Message-State: APjAAAUs5Dl5EgjfX4AJQDnCU2wYZ+WKDrKz9o9TQwrUZUm+BNP/8aXV
        FaGlq/ZPbI5/b0u/5P+lmuecNg==
X-Google-Smtp-Source: APXvYqxKsltkR7WZxpYrM3u00RJA0YEAGaWz0c/nIe/fO+ZdbSL3eXm1IP7pth6VLC2j2O/fPC247Q==
X-Received: by 2002:a05:6000:43:: with SMTP id k3mr45874502wrx.234.1558363011204;
        Mon, 20 May 2019 07:36:51 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a10sm20518729wrm.94.2019.05.20.07.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:36:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] mmc: meson-gx-mmc: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:36:46 +0200
Message-Id: <20190520143647.2503-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520143647.2503-1-narmstrong@baylibre.com>
References: <20190520143647.2503-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c5a8af4ca76b..e27e272b54d5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic SD/eMMC driver for the GX/S905 family SoCs
  *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Kevin Hilman <khilman@baylibre.com>
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
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.21.0

