Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ADBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8537A206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbpCQ7R9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfDDSxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:53:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41446 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDSxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:53:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so1602273plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLJbPseiuwJMFgFq/I1rSNLfkEyC4GN/4UjOVN+taJE=;
        b=XbpCQ7R9G/L06gwnGkqKpfRKIDJwHuCCUtccBEQ5UP6UwqcfMxH88cSwT/be3deJ3X
         7ODLdAAnPzeQRs75fzPfdHkPCiEld8EDKD9vCgnJfMYDgOXGH8GdFD48m39aZB/dDu11
         dgKJuSiqaHeJ7ouaYPmMbLASvKaKVDXzMEEzXVBla/+KoOaRLIOmY79CBh+v0pmr30Vp
         eF13PQBo5UjNww1HGcMfptRJGa8c8oflw+kV8JWggJhAfGsrNpoABpN4cux8GRsO/bGj
         KbMpEXNZ/mHwvZxqZTBhcxnRCY23xLX2XQbOsgkHLy8vF7q0WZxHVi9hGPqkyPc+URdO
         OseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLJbPseiuwJMFgFq/I1rSNLfkEyC4GN/4UjOVN+taJE=;
        b=I10pHSaat59V2wzuRaB364hg6yrY6YKgvYTnt9gDM47gJD0ucEQegvf4agnKj1f3tw
         4Xwi15Ie2Sm8+O58oGyF8RMrP0g5fojcIj3zS0OEiDs5i7Xe7X4VpZLq5iGPJ0+gaZhd
         eXv5L7XrsgjMHss+dK1RylpULiJbrWURYsB6jnvaDsVRdUuUTVoHZpCKD1aQ3EKBv2dp
         dlDcJ6W6O2N9IyG1b4U4yzR+40dXO+cjmPV5kH4cmZVpkvH6i6PgbHgq7vITD3F4usD6
         ZA+cZe3E94ByZ9EGuAQP3Rrgw6/zjjCCKFLlpe+voKM7eIFAxTViJ5Mwu5FiFOElCusH
         S4fA==
X-Gm-Message-State: APjAAAV7drQhcGR0wuuvs2+LWURcgQ6lwG29T+x1IZM9v60WkBo4dyTJ
        IYjJ3FP8bKproIoAHzh3dKY=
X-Google-Smtp-Source: APXvYqw60AjqzTrVwpqBOt5T3fr1w65Pz/oY02Skk5Pys5qAxEmcvmtgkURB2piIxKdgQ4feSDcNQA==
X-Received: by 2002:a17:902:868e:: with SMTP id g14mr8104501plo.183.1554404011273;
        Thu, 04 Apr 2019 11:53:31 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:9681:c7ba:deef:ba65:b868:9005])
        by smtp.gmail.com with ESMTPSA id u20sm10185056pfh.112.2019.04.04.11.53.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 11:53:30 -0700 (PDT)
From:   Nilesh Hase <nilhase25@gmail.com>
To:     matthias.bgg@gmail.com
Cc:     gregkh@linuxfoundation.org, neil@brown.name, sr@denx.de,
        sankalpnegi2310@gmail.com, gch981213@gmail.com,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nilesh Hase <nilhase25@gmail.com>
Subject: [PATCH] MT7621-SPI: spi-mt7621: Fix alignment and style problems     Fixed Coding function and style issues
Date:   Fri,  5 Apr 2019 00:22:36 +0530
Message-Id: <20190404185235.5257-1-nilhase25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch issues: "CHECK: Alignment should match open parenthesis" 

Signed-off-by: Nilesh Hase <nilhase25@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index b509f9fe3346..6fa9876f5a92 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -303,7 +303,7 @@ static int mt7621_spi_setup(struct spi_device *spi)
 	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
 
 	if ((spi->max_speed_hz == 0) ||
-		(spi->max_speed_hz > (rs->sys_freq / 2)))
+	    (spi->max_speed_hz > (rs->sys_freq / 2)))
 		spi->max_speed_hz = (rs->sys_freq / 2);
 
 	if (spi->max_speed_hz < (rs->sys_freq / 4097)) {
-- 
2.20.1

