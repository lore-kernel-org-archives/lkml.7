Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB0C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AF1206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JYJhZDX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfF1TRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:17:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38888 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfF1TRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:17:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so3009079pgz.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8q9yQqX5qZYX/nKn+QuYc3/3y+Tw6e7npxoxu3lD4U4=;
        b=JYJhZDX4L8FidcKCWfChOysOK0tDYUdXHFqNULJe1cx1mJ2jHtWlSYC9LvCJDM61Hp
         SkChCDVyLCWHly45CjTZ+6U5uffPfANA0U6Ibge2y2P8ELmeyql/pHqcc5aD+UgQHxpx
         LC8JubRzPLXSfHuphNKElDSjiH4ucmtHV04xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8q9yQqX5qZYX/nKn+QuYc3/3y+Tw6e7npxoxu3lD4U4=;
        b=OuZA/RNGxTK95CmuIaAz6eFsPigt2Pz9bJXsrxiEcR2tiTWxktTrQCzE+KsUzvg9y8
         CmQ5+a4mwv6RpYmYdhrcNy1C9QFAJDmhqfav0Wvja+zqYKXKivYyj+9pbnJP+CsOX3ak
         OetrxolcQewu9cH8McSUEOx3VG3ZkvTYEy5bsLt+cmN869N0BYkJhjCI+pqimtrVEnkN
         gVkzJvbpUTbVccVu/GyGok4SecTNUlYHO9PXmLnL3lpSMhWZOPURpTXapwS5QKHua+Sn
         wX15rAoJyrTw4R5POs1S3a9KbzlKNnoeOHSKVbzmorqa1JN6TYEgfg5FGl8rehOeIpkV
         19gQ==
X-Gm-Message-State: APjAAAV3zMAa752OWzQW57oPW0tfMXhk6PtBvZqC/14+cTtyo6i6HHQH
        boC9dkZjnLX3xLbgBpZAt1fq9g==
X-Google-Smtp-Source: APXvYqyQbuEulNlP6eXe4cVeX5cwXgAycVHoW9wLousAYKKfFBngw+uC5XTkOIBMOYUBg78WGwf+9g==
X-Received: by 2002:a17:90a:a008:: with SMTP id q8mr15238102pjp.114.1561749442988;
        Fri, 28 Jun 2019 12:17:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id m31sm3230830pjb.6.2019.06.28.12.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 12:17:22 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 0/4] Support accelerometers for veyron_minnie
Date:   Fri, 28 Jun 2019 12:17:07 -0700
Message-Id: <20190628191711.23584-1-gwendal@chromium.org>
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

Gwendal Grignou (4):
  iio: cros_ec: Add sign vector in core for backward compatibility
  iio: cros_ec_accel_legacy: Fix incorrect channel setting
  iio: cros_ec_accel_legacy: Use cros_ec_sensors_core
  iio: cros_ec_accel_legacy: Add support for veyron-minnie

Changes in v4:
- No change in iio/common/cros_ec_sensors
- Split cros_ec_accel_legacy code in 3:
  - fix an error in channel setting.
  - remove duplicate code in cros_ec_accel, use cros_ec_sensors_core.
  - extend cros_ec_accel to ARM device.
- Define cros_ec_accel_legacy_read_cmd() as static.

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

