Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD18BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEBF20803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MU1eCT8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfLDN1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:27:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37164 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfLDN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:27:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so8625000wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rsyQqCu1aUv9ntw3UAX1WSAMJmeLw7xkIDrzIKtETZ4=;
        b=MU1eCT8sFGWjc7CRq0KeHYfizNyHUoLKtwOeRdD543mFgMFGmVPnh8Y9mZwgRyFBD/
         LG5n5FMspnAvVbtwPAeZ2dK0mY3iwWkMYPt30MYG5p4mNgsZ/DzIDeHNr8DEkqVXekoc
         KY6xhMaZW6lRV1YrZZH8zS8/YMkBPTJws4pp2kRkTjXDOgu4h/cnq430ihY5MkcURqWI
         LDiIMDegYNCcgd0XJf96PHW637aBOi7xfpfYJpP6LOP83t0WNCH20SBpBss9sMy9bViX
         AjNRCE8oVnMbkhVqvV+xHK6qtzf7UoGLv8BrmmgACR1J8YkWNqa5SEHNtSV38/5dEYpV
         gNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rsyQqCu1aUv9ntw3UAX1WSAMJmeLw7xkIDrzIKtETZ4=;
        b=Y/bkx8AnzTQjn15oxlALkXdr/uJ0oJwxA2YC0BlFE5auzZsWIDSZQ+cr0DT24zXA8Z
         7BHqENl5Di1zJCiBQMyklnfzA5IDIMMbMgXjPiVUyUbovjGwOZ0BK6j9w30B4rLaZ0qK
         QR1E+UdvOh5pEWmiCLjog2h+N8kz0m/ABA1DqS2mjdJKVR7tKNZUmB01GdFiIkVSckfp
         VTAHK9UrQoe+L64/px1EzcQQiVamwJKknNAxhg5mATN8xYM/tKWureaAW6dti8WhkHeY
         WB0VrYDGmzX04+T8E68BX6srlj2tDQV3kqghX1GwbAE1KFyilIkOYckThnY1dvb1qBq6
         3Dzw==
X-Gm-Message-State: APjAAAW6Mtwpj9gPwJng7qbMYRVwWMWHdtinuUul8ewUTXYxilq/0qfZ
        jDTxJI/hE1KXrpse2DBb/lQyJA==
X-Google-Smtp-Source: APXvYqw2s2zyttj+n9kShAjj6xY9xEM3Y9PDoHEKIdHgBMiVi/KMg3tL//PdhtB8DwkoR30FpHYqVQ==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr4287802wrv.269.1575466061045;
        Wed, 04 Dec 2019 05:27:41 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c15sm8094632wrt.1.2019.12.04.05.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 05:27:40 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: add Gigadevice gd25lq128d support
Date:   Wed,  4 Dec 2019 14:27:13 +0100
Message-Id: <20191204132713.6195-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on the Amlogic aml-libretech-pc platform which does not support
dual or quad modes

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Datasheet is available here:
 http://www.elm-tech.com/en/products/spi-flash-memory/gd25lq128/gd25lq128.pdf

 drivers/mtd/spi-nor/spi-nor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1d8621d43160..d394f3861ecd 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2231,6 +2231,11 @@ static const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
+	{
+		"gd25lq128d", INFO(0xc86018, 0, 64 * 1024, 256,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
 	{
 		"gd25q256", INFO(0xc84019, 0, 64 * 1024, 512,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-- 
2.23.0

