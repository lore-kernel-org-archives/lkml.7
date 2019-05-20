Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B431C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B19213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ch2584po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391639AbfETOgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:36:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34894 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbfETOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:36:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so1933560wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xr+p9+oV/45aNpqnSTpfxQs3ZF3NmaIezU85bCSPol8=;
        b=Ch2584po8Kd0TeHViJj7L0nIvT3rohiPNenEsT1/KQd2Cq+nUFmot2P1/acoSMtXZt
         ZZ1v1fIWMXGtUUgXqUhOmKFs6G7uD/oHDoFEceeJUG4DBNaEiRlYDGKTcCHYjkTmsg3E
         3jOE30AxuUojQ9wQfdLPxEf6P1JWTxYq2uedN7nf/p2PbF9oDyekGNk+DjS3GVrXWm0z
         FM06h/C/Ykt0UErAijScXMAEDedzRUTsjPtLTYz0QpbUjEnPOqMdUNLkR614+CmS08vx
         17y4i+yPTUjuSk78DZ21Ewa6UhHfqgIM/izYdsJqmWhWccbbIK+6ccT8qLVYLZlhKGgV
         AMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xr+p9+oV/45aNpqnSTpfxQs3ZF3NmaIezU85bCSPol8=;
        b=gbnAD3h5ly9kHXpdPgIALfc5J0JnccEw7/OlmvkuD+GqZVjQlOW4A1PPNCTZAKoDEY
         xrae+D76AZyZI2nIc+7AJHBzFOpGMQdaVnfRBDQP3bqJ/ykQLRCfMwUngBCitDimQMNt
         qpe2FVzuaI3HwDYDIdwS1y13axrebZx4/EXIslz54Ezk4UffGUYyTmjW/Ev9DpBMSQbc
         cGMMLs/lGBajQIckuA1BvHnMGpxK5p9wSu20TVIirGuJkaRiWJkC1W0o3qb58hgkSRt7
         /zp6n3ubUSnDM1zA61717Qjp4v2bHR93E7k8sabCt+dXQG9Q3OY6C/T06BL/7hSO9Aus
         /oUA==
X-Gm-Message-State: APjAAAXTV86aNtelRk9hFTVq4H3AkM7RCvpcVan2yFkii6W/VegLT8DX
        0pV3eAISD0gKxmkUncE96EhQ9Q==
X-Google-Smtp-Source: APXvYqzmmeDy34jQY80IKaTb1i3fodpM6cHRtDfLjCzQsNb17ZPb7mhlh0dJ7te7e7NWiXdVL2lH4Q==
X-Received: by 2002:a5d:5192:: with SMTP id k18mr32363253wrv.229.1558363012289;
        Mon, 20 May 2019 07:36:52 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a10sm20518729wrm.94.2019.05.20.07.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:36:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] mmc: meson-mx-sdio: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:36:47 +0200
Message-Id: <20190520143647.2503-3-narmstrong@baylibre.com>
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
 drivers/mmc/host/meson-mx-sdio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index b61de360f26f..b2a7288cdec8 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * meson-mx-sdio.c - Meson6, Meson8 and Meson8b SDIO/MMC Host Controller
  *
  * Copyright (C) 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
  * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
  */
 
 #include <linux/bitfield.h>
-- 
2.21.0

