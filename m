Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567EEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C89C21848
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566712506;
	bh=iFQQ8QesHQ/6dGBjornBDY2YtXJ+3wlgKPrjgvZIzOA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MtQhA8DSFOc8gZsXG4aCw1TTHqU+thFM3LDv6ws5hfvlQVzewznVb+hn6IyztBepc
	 UWf0e91MRpjgsxDw8Yun1nIUefB0Uj0ohvfLhh3HpAgW2W1t9gN0AGT/w6wusuDlee
	 deHhNoOTS4AbqmzjKjMTn5GXe+fSc03h1pfyjZZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfHYFyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 01:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfHYFyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 01:54:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0709C2173E;
        Sun, 25 Aug 2019 05:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566712490;
        bh=iFQQ8QesHQ/6dGBjornBDY2YtXJ+3wlgKPrjgvZIzOA=;
        h=From:To:Cc:Subject:Date:From;
        b=WVa1uq452BmJ0A9K6xB1hS5m4JfVTwbE/D4HLd5rNa8NbbrFx53hD76oxSA7bkEcn
         pVQRrzYLfwSkpcnxFGmZyJPgFqmBqA+OxlfVHgRumRUYagqIPGK+Y/mVn2yi7v3iSJ
         LKdqyIyUlRLxQZ58dAm7J1mAGde3CkK8khkrY4VQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/9] staging: move greybus core out of staging
Date:   Sun, 25 Aug 2019 07:54:20 +0200
Message-Id: <20190825055429.18547-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Greybus code has long been "stable" but was living in the
drivers/staging/ directory to see if there really was going to be
devices using this protocol over the long-term.  With the success of
millions of phones with this hardware and code in it, and the recent
Google Summer of Code project, and a number of of new devices in the
works from various companies, it is time to finally move this code out
of staging into the "real" portion of the kernel so that people know
they can rely on it.

This series first does a little bit of checkpatch cleanups for some
basic remaining issues in the greybus files, and then moves the include
directory, the greybus core code, and the es2 greybus host controller
driver into drivers/greybus.

To come after this is the movement of the Documentation entries and a
number of the module drivers that are stable.

Greg Kroah-Hartman (9):
  staging: greybus: fix up SPDX comment in .h files
  staging: greybus: remove license "boilerplate"
  staging: greybus: hd: Fix up some alignment checkpatch issues
  staging: greybus: manifest: Fix up some alignment checkpatch issues
  staging: greybus: log: Fix up some alignment checkpatch issues
  staging: greybus: loopback: Fix up some alignment checkpatch issues
  staging: greybus: move core include files to include/linux/greybus/
  staging: greybus: move the greybus core to drivers/greybus
  staging: greybus: move es2 to drivers/greybus/

 MAINTAINERS                                   |   3 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/greybus/Kconfig                       |  32 +++++
 drivers/greybus/Makefile                      |  26 +++++
 drivers/greybus/arpc.h                        |  63 ++++++++++
 drivers/{staging => }/greybus/bundle.c        |   2 +-
 drivers/{staging => }/greybus/connection.c    |   2 +-
 drivers/{staging => }/greybus/control.c       |   2 +-
 drivers/{staging => }/greybus/core.c          |   2 +-
 drivers/{staging => }/greybus/debugfs.c       |   3 +-
 drivers/{staging => }/greybus/es2.c           |   3 +-
 drivers/{staging => }/greybus/greybus_trace.h |   2 +-
 drivers/{staging => }/greybus/hd.c            |  12 +-
 drivers/{staging => }/greybus/interface.c     |   2 +-
 drivers/{staging => }/greybus/manifest.c      |  41 ++++---
 drivers/{staging => }/greybus/module.c        |   2 +-
 drivers/{staging => }/greybus/operation.c     |   2 +-
 drivers/{staging => }/greybus/svc.c           |   3 +-
 drivers/{staging => }/greybus/svc_watchdog.c  |   2 +-
 .../Documentation/firmware/authenticate.c     |  46 --------
 .../greybus/Documentation/firmware/firmware.c |  46 --------
 drivers/staging/greybus/Kconfig               |  27 -----
 drivers/staging/greybus/Makefile              |  22 ----
 drivers/staging/greybus/arche-platform.c      |   2 +-
 drivers/staging/greybus/arpc.h                | 109 ------------------
 drivers/staging/greybus/audio_apbridgea.c     |   3 +-
 drivers/staging/greybus/audio_apbridgea.h     |  26 +----
 drivers/staging/greybus/audio_codec.h         |   4 +-
 drivers/staging/greybus/audio_gb.c            |   4 +-
 drivers/staging/greybus/authentication.c      |   3 +-
 drivers/staging/greybus/bootrom.c             |   2 +-
 drivers/staging/greybus/camera.c              |   2 +-
 drivers/staging/greybus/firmware.h            |   4 +-
 drivers/staging/greybus/fw-core.c             |   2 +-
 drivers/staging/greybus/fw-download.c         |   2 +-
 drivers/staging/greybus/fw-management.c       |   2 +-
 drivers/staging/greybus/gb-camera.h           |   2 +-
 drivers/staging/greybus/gbphy.c               |   2 +-
 drivers/staging/greybus/gbphy.h               |   2 +-
 drivers/staging/greybus/gpio.c                |   2 +-
 .../staging/greybus/greybus_authentication.h  |  48 +-------
 drivers/staging/greybus/greybus_firmware.h    |  48 +-------
 drivers/staging/greybus/hid.c                 |   3 +-
 drivers/staging/greybus/i2c.c                 |   2 +-
 drivers/staging/greybus/light.c               |   4 +-
 drivers/staging/greybus/log.c                 |   9 +-
 drivers/staging/greybus/loopback.c            |   9 +-
 drivers/staging/greybus/power_supply.c        |   3 +-
 drivers/staging/greybus/pwm.c                 |   2 +-
 drivers/staging/greybus/raw.c                 |   3 +-
 drivers/staging/greybus/sdio.c                |   2 +-
 drivers/staging/greybus/spi.c                 |   2 +-
 drivers/staging/greybus/spilib.c              |   2 +-
 drivers/staging/greybus/spilib.h              |   2 +-
 drivers/staging/greybus/tools/loopback_test.c |   2 -
 drivers/staging/greybus/uart.c                |   2 +-
 drivers/staging/greybus/usb.c                 |   2 +-
 drivers/staging/greybus/vibrator.c            |   3 +-
 .../greybus => include/linux}/greybus.h       |  26 ++---
 .../linux}/greybus/bundle.h                   |   0
 .../linux}/greybus/connection.h               |   0
 .../linux}/greybus/control.h                  |   0
 .../linux}/greybus/greybus_id.h               |   0
 .../linux}/greybus/greybus_manifest.h         |   2 +-
 .../linux}/greybus/greybus_protocols.h        |  48 +-------
 .../staging => include/linux}/greybus/hd.h    |   2 +-
 .../linux}/greybus/interface.h                |   2 +-
 .../linux}/greybus/manifest.h                 |   2 +-
 .../linux}/greybus/module.h                   |   2 +-
 .../linux}/greybus/operation.h                |   2 +-
 .../staging => include/linux}/greybus/svc.h   |   2 +-
 72 files changed, 225 insertions(+), 532 deletions(-)
 create mode 100644 drivers/greybus/Kconfig
 create mode 100644 drivers/greybus/Makefile
 create mode 100644 drivers/greybus/arpc.h
 rename drivers/{staging => }/greybus/bundle.c (99%)
 rename drivers/{staging => }/greybus/connection.c (99%)
 rename drivers/{staging => }/greybus/control.c (99%)
 rename drivers/{staging => }/greybus/core.c (99%)
 rename drivers/{staging => }/greybus/debugfs.c (94%)
 rename drivers/{staging => }/greybus/es2.c (99%)
 rename drivers/{staging => }/greybus/greybus_trace.h (99%)
 rename drivers/{staging => }/greybus/hd.c (96%)
 rename drivers/{staging => }/greybus/interface.c (99%)
 rename drivers/{staging => }/greybus/manifest.c (95%)
 rename drivers/{staging => }/greybus/module.c (99%)
 rename drivers/{staging => }/greybus/operation.c (99%)
 rename drivers/{staging => }/greybus/svc.c (99%)
 rename drivers/{staging => }/greybus/svc_watchdog.c (99%)
 delete mode 100644 drivers/staging/greybus/arpc.h
 rename {drivers/staging/greybus => include/linux}/greybus.h (88%)
 rename {drivers/staging => include/linux}/greybus/bundle.h (100%)
 rename {drivers/staging => include/linux}/greybus/connection.h (100%)
 rename {drivers/staging => include/linux}/greybus/control.h (100%)
 rename {drivers/staging => include/linux}/greybus/greybus_id.h (100%)
 rename {drivers/staging => include/linux}/greybus/greybus_manifest.h (99%)
 rename {drivers/staging => include/linux}/greybus/greybus_protocols.h (96%)
 rename {drivers/staging => include/linux}/greybus/hd.h (98%)
 rename {drivers/staging => include/linux}/greybus/interface.h (98%)
 rename {drivers/staging => include/linux}/greybus/manifest.h (87%)
 rename {drivers/staging => include/linux}/greybus/module.h (94%)
 rename {drivers/staging => include/linux}/greybus/operation.h (99%)
 rename {drivers/staging => include/linux}/greybus/svc.h (98%)

-- 
2.23.0

