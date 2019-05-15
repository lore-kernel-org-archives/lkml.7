Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6970CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C8420873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F2kO3Zsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfEOQsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:48:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39983 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfEOQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:48:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id g69so144524plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21QkJe/2Ia3CukPow+HU/kJ5AbEkblcvaIotDZqjXzA=;
        b=F2kO3ZszvamvWVf9qDt95LSKsm3+VbzShvOGjnxWuGUkK6Qq/rXjTzV2gAovo5j8Cu
         wBzQDkqh9BhxdTamZIxGc0gf4BKHPvsWy8nOxB8mRGj0b8LZaHm2+45EW9QR4JP/lkg0
         uzT4J1rwxTOuzk/z8DnlmUj77asFnfyN42hKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21QkJe/2Ia3CukPow+HU/kJ5AbEkblcvaIotDZqjXzA=;
        b=fiTro3FfYi8E/s/E6qpIWDTXp2R7beTo5bTddepSjwvcZvIav6qCrQZVeNOJaE0qz7
         y2TZ7JfPp+HbrlGoWl4Mmta+BoV/0ZGFfGtQEIRtAw2oITwmnFTcBi6c9lwsarwAr0dx
         jtkW+ErGAB+rM2jDj/h6PsGGa2KIge37g4HOBCQ4FyKpqgWzWYNIfyNI4n5hD4+eZ3hv
         8aSgWoDFN0yIIC985WCXqPk5KWAn1aK3cG5wX2eMiLeayXlmIj3fZmAFcxS+cX47pgst
         d1DjvGY3v7gbRu1jTTBiFbZHQBqUxvzzu6+jVe64lNKldmoofP1Y7DzneTSMxOggMhaS
         LBEA==
X-Gm-Message-State: APjAAAVB1OYzIultu60Keqq1XU/EvP1qPo0kfWZ+azYIPOkv0syqJPpS
        MxWfFTiJh4UqaPbi/FTKn7yDYw==
X-Google-Smtp-Source: APXvYqys5Q93YZ8pN7HdCJeSsFEq2sN4lDTJwQVRf0ernGwmzM6CRgYvXoFmn1BXw1O1PGqD1bXs9Q==
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr19940884plb.111.1557938921011;
        Wed, 15 May 2019 09:48:41 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id h16sm6914595pfj.114.2019.05.15.09.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 09:48:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v4 0/3] spi: A better solution for cros_ec_spi reliability
Date:   Wed, 15 May 2019 09:48:10 -0700
Message-Id: <20190515164814.258898-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a much better solution for getting the Chrome OS EC to
talk reliably.

Patch #1 in this series is the most important.  It can land any time.

Patch #2 in this series (a SPI framework patch) needs to land before
patch #3.  Note that patches #2 and #3 really just fix a corner case
and just having patch #1 is the most important.  We don't end up on
the pumping thread very often.

Note:
- If you want some history on investigation done here, feel free to
  peruse the Chrome OS bug: <https://crbug.com/948742>.

Changes in v4:
- No needless init of err in cros_ec_spi_devm_high_pri_alloc (Guenter).
- Removed blank lines near #includes (Guenter).
- Switch to kthread_create_worker() and fix error handling (Guenter).
- Cleaner devm code (Guenter).

Changes in v3:
- cros_ec realtime patch replaces revert; now patch #1
- SPI core change now like patch v1 patch #2 (with name "rt").
- Updated description and variable name since we no longer force.

Changes in v2:
- Now only force transfers to the thread for devices that want it.
- Squashed patch #1 and #2 together.
- Renamed variable to "force_rt_transfers".
- Renamed variable to "force_rt_transfers".

Douglas Anderson (3):
  platform/chrome: cros_ec_spi: Move to real time priority for transfers
  spi: Allow SPI devices to request the pumping thread be realtime
  platform/chrome: cros_ec_spi: Request the SPI thread be realtime

 drivers/platform/chrome/cros_ec_spi.c | 66 ++++++++++++++++++++++-----
 drivers/spi/spi.c                     | 36 ++++++++++++---
 include/linux/spi/spi.h               |  2 +
 3 files changed, 86 insertions(+), 18 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

