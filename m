Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EB2C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC002085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lP34r2NW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEMUVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:21:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35672 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfEMUU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:20:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id g5so7036159plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0hIvZUUUL3EyRykGBdB7l1SOet5HjIbFD3tZy1lwZw=;
        b=lP34r2NWD/uZoRd0AmHrnPVr3Iay5m0VNeOUlwc4hniFrGufSZMjFpfwGXk+W85GBs
         NfDq9Njm4nXNu8kRznt9FC3BI+msSj8YszwBXIYYOhHJZFeJJqMuE8f0NIPFLskYUPGo
         xPrwdOGYOlGlnFbS4SFxOBOcejh3pG8VoKSnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0hIvZUUUL3EyRykGBdB7l1SOet5HjIbFD3tZy1lwZw=;
        b=UM0SCgJz1sbKvV9mVUxmee6oSR8CHIiW1/Sei98vjRWlhkUYAlt2jWQ4G4UiJDTKY6
         wwAenNHloAI9LcW6+LflCIemH12OOoSh7pf3G4/bUum8Xe+zNvqZWfi50x77K65QPU/h
         s/de0O6OxEYm4eYpMVjmXq9qEOS9sop4GQJ6K09rkUVBMfu0DWblZl61NRfg1YkvrOm3
         PCdXUkOUK29By1jNNKfFXKRUBHo83v/aULCjdsJHTM/rep2i0UNDKbsv+afv0g8sId1g
         3L5X9rRUrqF0pchWOPsQnmD7nDs7StZschh+AcIwkCsYCq1UIOwfDhoaUDgGuFZwdGpw
         lFUg==
X-Gm-Message-State: APjAAAVTwqoEbMzoN2uEhxq3zDrey68hBjb4vkXhF//PPstqV64OZ/x+
        Z2s0prXRdrH7yIal+ag7swKi1A==
X-Google-Smtp-Source: APXvYqycX98I9RrS0+2PLISochd9e1uNzSdWwjsBuwDbWsmLVvAd8DTtC/KuAkigAeIT07A+gaSOGA==
X-Received: by 2002:a17:902:7b8f:: with SMTP id w15mr33608247pll.314.1557778854816;
        Mon, 13 May 2019 13:20:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s198sm26356597pfs.34.2019.05.13.13.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 13:20:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] platform/chrome: cros_ec_spi: Force transfers to realtime priority
Date:   Mon, 13 May 2019 13:18:24 -0700
Message-Id: <20190513201825.166969-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190513201825.166969-1-dianders@chromium.org>
References: <20190513201825.166969-1-dianders@chromium.org>
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

Let's use the new feature introduced in the patch ("spi: Allow SPI
devices to force transfers on a realtime thread") to specify this and
increase the success rate of our transfers.

NOTE: if future Chrome OS ECs ever fix themselves to be less sensitive
then we could consider adding a property (or compatible string) to not
set this property.  For now we need it across the board.

With this change we can revert the commit 37a186225a0c
("platform/chrome: cros_ec_spi: Transfer messages at high priority").
...and, in fact, transfers are _even more_ reliable than they were
with that commit since the SPI framework will use a higher priority
(realtime) and we no longer lose our priority when we get shunted over
to the message pumping thread (because we now always get shunted and
the thread is high priority).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v2:
- Renamed variable to "force_rt_transfers".

 drivers/platform/chrome/cros_ec_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 8e9451720e73..a2959365a870 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -703,6 +703,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 
 	spi->bits_per_word = 8;
 	spi->mode = SPI_MODE_0;
+	spi->force_rt_transfers = true;
 	err = spi_setup(spi);
 	if (err < 0)
 		return err;
-- 
2.21.0.1020.gf2820cf01a-goog

