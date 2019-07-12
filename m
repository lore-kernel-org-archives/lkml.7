Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA59C742B1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109E02084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="A3mrdWov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfGLJlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:41:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55677 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGLJlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:41:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so8264442wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=crBMT3xDpFdt/DcdLHZD4Am4FS/boMU7JkN4C0dR2LU=;
        b=A3mrdWovnpW3j5o1VzHKvoG0yI1duoPhVVW6JaOjBHnesZdvPRyNyKLD1ww/Wnny5x
         HAbMekUmPyFbC1ABm2hJGDkWSN/lu+G3+2gzs3U6PFbWeo2NeWDQaUH+aijPpJKsWtlI
         ZWIAoqnfyxyYZ6psddSURxj1IDfJtAkePG0mzc4TFELzIFuCRJKp6PVnYcHtkJM+xLIN
         ZeFDk/Hv84tpi7oxhPfI779cWYi49REL/RDbDdAgrx3C8TH1UnBaFrY5AyxMwoJY8WAD
         qMCx0eg6qKjWe+ZJaldSUfbVHDSpYwXXbhdtTeVKXZYxTXE/oT7b6Am9fFSFH55hH2Ao
         LZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=crBMT3xDpFdt/DcdLHZD4Am4FS/boMU7JkN4C0dR2LU=;
        b=Rge1/ZZlWIxhqzkHpxUXEpyN+ZBSsBT+9KHPChrD0I6dItCDsap8StlriCpd3xg1ZV
         ZhXc6yEYCKgPJoDHWM5DD3TnhdnmHaDwYr6Yzx64N1Jw601poxmV6Yx6I0+RFmvVO/Y5
         o9UnJXbAP+5EZsOpFY0/w8g1PZSjy9s/9JuzYFQlw0TdpT+4SPQxC+FpD+JAAsWzitQp
         Y16y+VsfygOWfa7PXei1mN7qAyImzV2v/nXUZAZ3qQEOpUMS7+YvFYXsxIHhyHooOMYE
         tn+WXjSGCtPnrhGPbnJLbSRryH3no+x4kp1c0wO9TAPrEfw/9s6ce5Cbo1B1i7DTp763
         V7cg==
X-Gm-Message-State: APjAAAX56uesXYorRg1n1YWwSyZX720a4mf57yZKTBnqJ4R5h/IJ4O0a
        H6uNP12HsLRyq/IvyQDRUMDXnA==
X-Google-Smtp-Source: APXvYqwCpixGmJMBiTRtGB84DQj+1xZVpJZkCed5cgcKDFeu8bX7SzPEiD9xCthjAezxXIQbz0CAVw==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr9045751wmj.89.1562924480413;
        Fri, 12 Jul 2019 02:41:20 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id p18sm7310891wrm.16.2019.07.12.02.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 02:41:13 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 0/3] Add PAT9125 optical tracker driver
Date:   Fri, 12 Jul 2019 11:40:47 +0200
Message-Id: <20190712094050.17432-1-amergnat@baylibre.com>
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

