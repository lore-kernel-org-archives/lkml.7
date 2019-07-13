Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E03C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 08:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F51F208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 08:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s3rW1GYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfGMIFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 04:05:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35309 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfGMIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 04:05:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so10795511wmg.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=crBMT3xDpFdt/DcdLHZD4Am4FS/boMU7JkN4C0dR2LU=;
        b=s3rW1GYRQVlJ8DjwhU4sZ5eQZORVIhCYzjtFCnuvllOfgOrGEW3IDL0OYFJHa9rJ6y
         C33H9tgpaCopN/NNlamYa1TA3kxaX4EUqEBVNNKvK+lEcqNMcCbuOuN0DVUcWqxwcCSn
         DVUjDDaQAi90hm8fWJv4NQoJN9mftS/2FdY5y1kuYTnQWqH0TKyTlK7vtSbdwrEsU+7P
         duv//N4FPYXg7z7nfiEri1FPPBrw8MGuPt2AMBvXhD5N2Ep99lTWHdFibiACmXHMFL3S
         GB7xtI+SmD9jt+fauKIxTBwTos/L7idUAoCn2gCv+9tA0nRmCVL+rxTBBUuWPvSVCE3d
         a2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=crBMT3xDpFdt/DcdLHZD4Am4FS/boMU7JkN4C0dR2LU=;
        b=Xecz+8fPE8y6ZT3ok27SxEzJzCbvVjHtMDSaM40ZpE2wI0V7oVmP7T+zZY1A78RQ/q
         zr5wjAxf03d2AppEC1dAtwGWDyei+0CunbEs4zZs/WRQm9+VUBLV3Auur7d2SXEjc9Cu
         7/s0ezmTG4NLPGepEjE8JYAqaXl12plNNP9InM/bITv3IC9BLvNP4h14v+e9XRdYbmbx
         yYuCQP4KssLY9V/F3aEdAm79WyQghI6JiQDHFD+6qHzZ1dEm2GNgYkQlFshEPmbjJ4ZM
         8FRJ2yn8qb6kuk4QrPFzgwg4RcqLZQzLSoQ95iDoQFCnU3DhPzYMtVGJ+J94Tub0IiQ2
         MNzg==
X-Gm-Message-State: APjAAAUcyfpCIrD4DBwC9Ij71VMM5t5zjjzUAyCOhssYPvyewECYHElt
        Jogh/G7BHup8PeOZXP4DcBazwA==
X-Google-Smtp-Source: APXvYqyh0bSoYxaglNe3o+ajqe4aEtUDwJlLfU0lqLonTie6aJIi7TQcFHgbG1pZCVAq6kcPbiJ2HA==
X-Received: by 2002:a05:600c:291:: with SMTP id 17mr13409688wmk.32.1563005103881;
        Sat, 13 Jul 2019 01:05:03 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id o26sm9621634wro.53.2019.07.13.01.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 01:05:03 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 0/3] Add PAT9125 optical tracker driver
Date:   Sat, 13 Jul 2019 10:04:52 +0200
Message-Id: <20190713080455.17513-1-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PixArt Imaging PAT9125 is a miniature low power optical navigation chip
using LASER light source enabling digital surface tracking.

This device driver use IIO API to provide punctual and/or buffered data.
The data is a relative position from where start the device on X and Y
axis, depend on CPI (Counts Per Inch) resolution setting chosen.

The device support CPI configuration through IIO interface.

This patchset :
- Update vendor prefix
- Add the bindings for this device
- Add the device driver
- Add directory for optical tracker devices

Change since v3:
- Replace delta value by relative position
- Improve write protected reg function by removing print log and obvious
  returns
- Handle error in postenable buffer function

Change since v2:
- Fix typo
- Add constructor webpage and datasheet in commit message
- Use BIT() macro for define bit mask
- Remove shift from IIO channel spec structure
- Replace IIO_LE by IIO_CPU from IIO channel spec structure
- Replace memcpy() by cast (s32)
- Rename "pat9125_trig_try_reen" to "pat9125_trig_try_reenable"
- Add carriage return (\n) at the end of each "dev_err" function
- Remove "iio_trigger_unregister" in case of "iio_trigger_register" fail,
  register function already manage it
- Remove log which print device name in case of successful initialization
- Fix enabled IRQ flag warning during nested IRQ thread
- Improve retry algo now based on status register
- Remove "ts", "motion_detected" and "buffer_mode" from pat9125_data
  structure
- Rename all "ot" directories to "position"
- Polling sample through IIO_CHAN_INFO_RAW now return position value
  (relative to the position at initialization time) instead of delta
  position
- Clean iio_buffer_setup_ops structure by removing NULL pointer.
- Use devm_iio_ function for all init functions and then delete
  "pat9125_remove"
- Move device_register at the end of probe function
- Replace MODULE_PARM_DESC by IIO_SCALE to set axis resolution (CPI)

Change since v1:
- Fix typo
- Rename some defines / variables
- Remove I2C client from driver structure
- Change type of delta_x and delta_y from s16 to s32 to simplify signed
  operations
- Add module parameter for axis resolution
- Replace "IIO_MOD_X_AND_Y" by "IIO_MOD_X" and "IIO_MOD_Y"
- Add sign extension macro
- Improve read value algorithm to avoid data loss
- Implement a trigger handler function which can work with any IIO
  trigger, independently of it own GPIO IRQ, to match with IIO
  requirement/behaviour
- Replace iio push event function by iio trigger poll in GPIO IRQ handler
- Use triggered_buffer helpers to replace kfifo use, setup buffer,
  implement enable/disable setup buffer operations, IIO trigger
  allocation and re-enable operations
- Remove useless "goto"
- Change GPIO IRQ handler from planified thread to IRQ thread
- Change GPIO IRQ trigger from low level and one shot to falling edge
- Add device unregister and buffer cleanup to driver remove function

Alexandre Mergnat (3):
  dt-bindings: Add pixart vendor
  dt-bindings: iio: position: Add docs pat9125
  iio: Add PAT9125 optical tracker sensor

 .../bindings/iio/position/pat9125.txt         |  18 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/position/Kconfig                  |  18 +
 drivers/iio/position/Makefile                 |   6 +
 drivers/iio/position/pat9125.c                | 506 ++++++++++++++++++
 7 files changed, 552 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/pat9125.txt
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/pat9125.c

-- 
2.17.1

