Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C6EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD2820879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H5Y9KXgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfENSkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:40:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40349 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfENSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:40:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so9047344pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5lmD3O2z0vSk4VQzRzNUrXAaT7ROOc/nk13EyEk/Z8=;
        b=H5Y9KXgwnq7ezY/NEDojzcCdz/MTUU2ltKGxRIk7MI7CfJPl17Hr+/0JzOFSuTp/HD
         jDhdlTjiAgAJeyqcChsshmGOG/i6tU6ESAAdF/KguksGOcQ3RtCOJPI7Ka+mo0jFkIES
         AF5gTR+hcgOEwZCn0zjbxF+tOlJQ23fa3GyBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5lmD3O2z0vSk4VQzRzNUrXAaT7ROOc/nk13EyEk/Z8=;
        b=KIZQJ0hePxy2m0IZEp27JES9Z9GVBE9rWmWhB/CqL0cmGqWjk6HpUKDy3nrRbBQO28
         8qcuvgCgADwXX4rUtgZj3dtgPM9OHUZEy32QW5CYZz4Z+JxychRTaYcr80ySknb0oUmE
         rOAMe0XOXjjHK/GFget84ZeD+YCCYX17e5hlBeWti5O9m1t55Kk/j8etN5vgnUsh3Q0P
         8nTY3+6fy0SQOhfwysfGg7VW6pHjgrI6C0Il4AwWX4MhjSwt8oDZHSV3d+muX9MQrMPN
         Wa2rp7aMcsxMOKQCXtGCv2K2KpcbAkOxUDYiKvK6elevI6dQmmC24VPZc0k5xndqKPsA
         e8LQ==
X-Gm-Message-State: APjAAAWbc/kkuADpPuW1mOAe1MfD1rBZN8qTIviAD0rumBuPFOyMXmRh
        /Zn84jfW/tfBzNWVM8kKODtnxw==
X-Google-Smtp-Source: APXvYqzB/ncd07lY8oKwjyYs9cE0Ws3ptZ6OOxXnzgYsvm+RO6GmbunYYA6NV+JxBn4oUSn8b/7Vug==
X-Received: by 2002:a63:7909:: with SMTP id u9mr33519089pgc.223.1557859206272;
        Tue, 14 May 2019 11:40:06 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 19sm19182454pgz.24.2019.05.14.11.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:40:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 0/3] spi: A better solution for cros_ec_spi reliability
Date:   Tue, 14 May 2019 11:39:32 -0700
Message-Id: <20190514183935.143463-1-dianders@chromium.org>
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

 drivers/platform/chrome/cros_ec_spi.c | 89 +++++++++++++++++++++++----
 drivers/spi/spi.c                     | 36 +++++++++--
 include/linux/spi/spi.h               |  2 +
 3 files changed, 110 insertions(+), 17 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

