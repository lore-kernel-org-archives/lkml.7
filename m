Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA4C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1806520663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AMhKC6x3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFXWxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:53:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35245 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfFXWxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:53:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so8340112pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8X4a2I3UEAgfVulSk9qJJZ9XdiWRbXBIr75xQcaE5hI=;
        b=AMhKC6x3EncwHOdUsPX6znX/UxTD43Z1udgsicNyhnNgZrqgCp4Tlzho0B1NyzEMKv
         mCgHH4O0YzT0SDYHSn8/gWK+hcY1q66l/UUNPNHcbLRg9/dACJGAXYkf244aSMpkOtcD
         4NptKtuYUBurwqHlqa0KI9JblX1A8RSSMZMak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8X4a2I3UEAgfVulSk9qJJZ9XdiWRbXBIr75xQcaE5hI=;
        b=qhRUE7e2ZemD6NPAwI+z5h41WFTC78f25GvrkMvkbRWpZ6BQKfqO11acya1NsdVZ8E
         /If0ct87y+mLI4YrdgrbrQMswfzpVsbgyJfUV80IumP/g5IwRQ8tjl2/MIgCbdny02B5
         6rKNyN4lqi6dkrcuez47F/N2vDBPDx9RTZ1qzcgUBJi+ROzX6qOjqZr7zh9A/9SjrDDw
         Em32UMK/EQqBwdHLwhUZJUGUPxk6GrakM76EyPNMrl3ThHWuj6s0UJGfZi564PS5U24y
         7BgZKhmyZSXA9j+ij7wkVDpy+eHveXvak1ZIAed54jG7qWKa3KphBg7CyCz8PqQE1oVs
         fCbw==
X-Gm-Message-State: APjAAAWuylCZp5l5Gv1SHMRV3+zqiQozPvvLaoiV2bP3GxadQcxVOw/W
        VRHC4XWn5+g4p7LC4o7UwguhbA==
X-Google-Smtp-Source: APXvYqwiQ/ya2iveU/sGnXXcnpD7Bx0CBHuWR/TAmPUUgoL2DmJqioivzjHHoe37CenjlNIdwYOiQQ==
X-Received: by 2002:a17:90a:62cb:: with SMTP id k11mr26468906pjs.26.1561416800005;
        Mon, 24 Jun 2019 15:53:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id n184sm12038681pfn.21.2019.06.24.15.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 15:53:19 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/2] Support accelerometers for veyron_minnie
Date:   Mon, 24 Jun 2019 15:53:10 -0700
Message-Id: <20190624225312.131745-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

veyron_minnie - ASUS Chromebook Flip C100PA - embedded controller
controls two accelerometers, one in the lid, one in the base.
However, the EC firmware does not follow the new interface that
cros_ec_accel driver use.
Extend the legacy driver used on glimmer - Lenovo ThinkPad 11e
Chromebook - to veyron_minnie.
veyron_minnie being ARM based, issue command over the I2C bus to the EC
instead of relying on the shared registers over LPC.

Gwendal Grignou (2):
  iio: cros_ec: Add sign vector in core for backward compatibility
  iio: cros_ec: Extend legacy support to ARM device

Changes in v3:
- Fix commit message, add reviewed-by for first patch.

Changes in v2:
- Readd empty line to reduce amount of change in patch.
- Remove Keywords used by ChromeOS commit queue.

 drivers/iio/accel/Kconfig                     |   4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c      | 350 ++++--------------
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
 4 files changed, 84 insertions(+), 275 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

