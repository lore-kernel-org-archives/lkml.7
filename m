Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E968C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 05:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C77B20880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 05:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="EIx7KjDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfDGFEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 01:04:07 -0400
Received: from chill.innovation.ch ([216.218.245.220]:46068 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfDGFEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 01:04:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 486BA64019C;
        Sat,  6 Apr 2019 22:04:06 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id m9bCm_cogEzt; Sat,  6 Apr 2019 22:04:04 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 1FBA16400FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1554613444;
        bh=AxWRtrYijEt930XJaBKgDJnaZbAqWCp8GlZ8nYkx2Oc=;
        h=From:To:Cc:Subject:Date:From;
        b=EIx7KjDAkTeiDj0jeARz66uz3u5Z0PCVLFeZgvbc02lAitLCJNza2lZMNGKcwGRKO
         582hJ49xDfrltJF6Geu8I5va/RT8tZG1WGQhYvhO4/lf2H4mmmhXf810sODv4A5PJZ
         qIZ1UtmWOatcsVyjMK6F2sgsSHcUGay+roJ4mPBmN5uWbGXex6PDsFFHANDIDlIwPO
         3D/7Vzp0xNhZnKsEBnZne3hC/uuYlLvYpJwwS076DoyT3OnvJVR0YW9wGwxG/+fX/W
         lFUy27TvDOaZLZbC+cn7TDgMcLrrNtcXJjKu3k2DkHWqwVfbDfzJspaGrk6QuxZ6s7
         Ssd3M8Yx50xxA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add Apple SPI keyboard and trackpad driver
Date:   Sat,  6 Apr 2019 22:03:56 -0700
Message-Id: <20190407050358.2976-1-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset adds a driver for the SPI keyboard and trackpad on recent
MacBook's and MacBook Pro's. The driver has seen a fair amount of use
over the last 2 years (basically anybody running linux on these
machines), with only relatively small changes in the last year or so.
For those interested, the driver development has been hosted at
https://github.com/cb22/macbook12-spi-driver/ (as well as my clone at
https://github.com/roadrunner2/macbook12-spi-driver/).

The first patch fixes a problem during config and is provided for
anybody wanting to compile the driver while it's being reviewed here.
The patch is the latest version that has been submitted for review
at dri-devel; the intent is to get an Ack and permission to merge it
through the input subsystem tree here as part of this patch series.

The second patch contains the new applespi driver.

Changes in v4:
  Applied all feedback from review by Andy Shevchenko and Greg
  Kroah-Hartman, including:
  - minor include path fix
  - moved debug logging to debugfs and tracepoints
  The full set of changes to applespi can be viewed at
  https://github.com/roadrunner2/macbook12-spi-driver/ as individual
  commits 3a6262e..daf60f8 in the upstreaming-review branch.

Ronald Tschalär (2):
  drm/bridge: sil_sii8620: make remote control optional.
  Input: add Apple SPI keyboard and trackpad driver.

 drivers/gpu/drm/bridge/Kconfig          |    3 +-
 drivers/gpu/drm/bridge/sil-sii8620.c    |   21 +
 drivers/input/keyboard/Kconfig          |   15 +
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/applespi.c       | 1999 +++++++++++++++++++++++
 drivers/input/keyboard/applespi.h       |   29 +
 drivers/input/keyboard/applespi_trace.h |   94 ++
 7 files changed, 2160 insertions(+), 2 deletions(-)
 create mode 100644 drivers/input/keyboard/applespi.c
 create mode 100644 drivers/input/keyboard/applespi.h
 create mode 100644 drivers/input/keyboard/applespi_trace.h

-- 
2.20.1

