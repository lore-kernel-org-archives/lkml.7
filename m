Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCA5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFF0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="kgzuzisJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfDPK1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:27:03 -0400
Received: from chill.innovation.ch ([216.218.245.220]:43072 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfDPK1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:27:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 8FEB964013E;
        Tue, 16 Apr 2019 03:27:02 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id N_yNE6Z2vlJF; Tue, 16 Apr 2019 03:27:00 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 1BA806400F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1555410420;
        bh=11k9bId4T3Lx+vaTmr6MgTFJkMXztyuQ8jAbM6K5H9s=;
        h=From:To:Cc:Subject:Date:From;
        b=kgzuzisJCZrk5YYF67vAAGyUg/XSqeulkuaOVkXSVi5nWTixjOGLAxUXoadg5tAO5
         ksNstZgIqSejwHVwpPWIHvZQf4lxq2Gjt56i6dvYb21WRqVG9GyUWLVajMz9KXaL9i
         kpWcqf8yT3SA058fMK2kXEpBe/UadEWuYiujKu8ZlqaLsjsVrh3U2dqc8cWusYIljE
         xw/sdigNbndnqF+6aKztWay8/r/VUg0QQE+PjhXQ/wRCuLciSWwefUSAFI3xOsApBj
         gKUGZZNQKTKip8JMGEmnLXJKgUxoTcd5y+krYpcRFLfX583bfBODGbK9cwWrw3s4Zd
         uJZpLjPJVK2tg==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] Add Apple SPI keyboard and trackpad driver
Date:   Tue, 16 Apr 2019 03:26:45 -0700
Message-Id: <20190416102647.5602-1-ronald@innovation.ch>
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

The first patch fixes a problem during config. While it affects the drm
tree, Andrzej Hajda has given his ok for this patch to be taken via the
input tree because the second patch here depends on it.

The second patch contains the new applespi driver.

Changes in v6:
  Applied all feedback from review by Andy Shevchenko:
  - use memchr() and friends instead of hand-rolled loops
  - minor code tweak
  The full set of changes to applespi can be viewed at
  https://github.com/roadrunner2/macbook12-spi-driver/ as individual
  commits 36afd70..fa81d40 in the upstreaming-review branch.

Ronald Tschalär (2):
  drm/bridge: sil_sii8620: make remote control optional.
  Input: add Apple SPI keyboard and trackpad driver.

 drivers/gpu/drm/bridge/Kconfig          |    3 +-
 drivers/gpu/drm/bridge/sil-sii8620.c    |   10 +-
 drivers/input/keyboard/Kconfig          |   15 +
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/applespi.c       | 1975 +++++++++++++++++++++++
 drivers/input/keyboard/applespi.h       |   29 +
 drivers/input/keyboard/applespi_trace.h |   94 ++
 7 files changed, 2122 insertions(+), 5 deletions(-)
 create mode 100644 drivers/input/keyboard/applespi.c
 create mode 100644 drivers/input/keyboard/applespi.h
 create mode 100644 drivers/input/keyboard/applespi_trace.h

-- 
2.20.1

