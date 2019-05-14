Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B13DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2F420879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oRNJMjbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfENSkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:40:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44998 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfENSkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:40:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so9035179pgv.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcHRjuNh3iuHe2OOeqLEpCHwon6We01Vth7kruZts9w=;
        b=oRNJMjbZONAB6lTSayFLjDb64FvQxZvxjxGC6/CKO2ajYShAfTvLkD9w9PaWC6ZucH
         +vlA7pUNbPaEblItuWqIla63p71/OmY69f1MIUvfvk80kREbcjkIS13egnrTlu4hXU6D
         sHLU9Ehp5dF7P7mVXByw/aPdWAuH6bb8FrmT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcHRjuNh3iuHe2OOeqLEpCHwon6We01Vth7kruZts9w=;
        b=GVT589b/q+GAhitmcR5vKbNw192gjNdaTPHyXwlriqgx0gxKoVI36HDoNzc8FnPG+S
         7GBkIsBQ6rIkqdL1vxj3vF6DXE5QEIQm6qvEJoLYKIouk1wEvcLgyWMkVQuvWyhaDl59
         1KRYizave1Gj/Iynz5PDoeCkZ3vPQ4N4VKUgrEFHkNVkwV9hRiiqDY3gN/1gFtM6K1+d
         DDfYZdB4Ea6P6evJo+qY3j2VUyGIpuqH0y2I4d59izPBMPp7NzaOtHLw3A/6Hd9kcjiQ
         rFC1gZsf7Zvh8476NWmZkTo1aizZcGPpAzG7aUiKTdynLXT9TXCKzI1YroSssvjh0PEs
         buGA==
X-Gm-Message-State: APjAAAXGSUM1wCEYEx4EueGy5lfGJR6qwZeFf/lIGHe7lEzUMh9/WJmy
        pqCn6yxLLUlv0lYg7wiOknDjSA==
X-Google-Smtp-Source: APXvYqyBf7wHRsbXM+g3mGM7sD2OHe50LO7O4N+pmTyuoJhSbjvQ0kDIHiQ/Be7y7EsTGEMCDe3euQ==
X-Received: by 2002:a63:5516:: with SMTP id j22mr37051377pgb.370.1557859209357;
        Tue, 14 May 2019 11:40:09 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 19sm19182454pgz.24.2019.05.14.11.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:40:08 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] platform/chrome: cros_ec_spi: Request the SPI thread be realtime
Date:   Tue, 14 May 2019 11:39:35 -0700
Message-Id: <20190514183935.143463-4-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190514183935.143463-1-dianders@chromium.org>
References: <20190514183935.143463-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All currently known ECs in the wild are very sensitive to timing.
Specifically the ECs are known to drop a transfer if more than 8 ms
passes from the assertion of the chip select until the transfer
finishes.

Let's use the new feature introduced in the patch (spi: Allow SPI
devices to request the pumping thread be realtime") to request the SPI
pumping thread be realtime.  This means that if we get shunted off to
the SPI thread for whatever reason we won't get downgraded to low
priority.

NOTES:
- We still need to keep ourselves as high priority since the SPI core
  doesn't guarantee that all transfers end up on the pumping thread
  (in fact, it tries pretty hard to do them in the calling context).
- If future Chrome OS ECs ever fix themselves to be less sensitive
  then we could consider adding a property (or compatible string) to
  not set this property.  For now we need it across the board.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v3:
- Updated description and variable name since we no longer force.

Changes in v2:
- Renamed variable to "force_rt_transfers".

 drivers/platform/chrome/cros_ec_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index b89bf11dda64..4f34e2215884 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -765,6 +765,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 
 	spi->bits_per_word = 8;
 	spi->mode = SPI_MODE_0;
+	spi->rt = true;
 	err = spi_setup(spi);
 	if (err < 0)
 		return err;
-- 
2.21.0.1020.gf2820cf01a-goog

