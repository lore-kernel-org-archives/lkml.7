Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49391C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E2220674
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="Vpb3a7f0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDOINI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:13:08 -0400
Received: from chill.innovation.ch ([216.218.245.220]:38382 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOINI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:13:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 52FBE640134;
        Mon, 15 Apr 2019 01:13:07 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id T8u5JXzAAAQc; Mon, 15 Apr 2019 01:13:05 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 05814640107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1555315985;
        bh=2IQu8zfqg1Euw8IMduUWgjQe6T8fG/mvle0mtYyDdIU=;
        h=From:To:Cc:Subject:Date:From;
        b=Vpb3a7f0SUkNgyMXvF9c2bmKEGkEOkXSR7lnMfLvb/pPE7vPhvMaUNDZ4chFVTYaG
         GQ4w7mingLiis+r36rUENgRhyoj2S835hC4icNI+JcEDENSaGCkVWs5ysDUNfXH0Q4
         ktZ6OCW/pQFbCtqQTEhe3SCDczkde0upMNY4QBpRRwrfWZ2r0X2PpuyT5/P5qbRv26
         QI6BWrGoYox+o6bQdeeqpGDtwAGz9ENjYTYFwoc/i2Y3H3wGwGImW+ppezbrceYPA9
         j5Hds4jtNd2YCr2KcWk4Lat57Jofvl7i3gTz3zUGetskguIpxWMTL/ifCy4ibeb8AT
         SUnpHzidw7y/w==
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
Subject: [PATCH v5 0/2] Add Apple SPI keyboard and trackpad driver
Date:   Mon, 15 Apr 2019 01:12:58 -0700
Message-Id: <20190415081300.24831-1-ronald@innovation.ch>
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

The first patch fixes a problem during config.

The second patch contains the new applespi driver.

Changes in v5:
  Applied all feedback from review by Andy Shevchenko (applespi) and
  Andrzej Hajda (sil-sii8620), including:
  - (sil_sii8620) use 'if (IS_DEFINED(...))' instead of conditional
    compilation to handle RC_CORE being undefined
  - (applespi) a number of cleanups of leftovers from changes to earlier
    versions
  - (applespi) replace some bool flags with loop-end detection
  - (applespi) improve error reporting in a couple places
  The full set of changes to applespi can be viewed at
  https://github.com/roadrunner2/macbook12-spi-driver/ as individual
  commits daf60f8..36afd70 in the upstreaming-review branch.

Ronald Tschalär (2):
  drm/bridge: sil_sii8620: make remote control optional.
  Input: add Apple SPI keyboard and trackpad driver.

 drivers/gpu/drm/bridge/Kconfig          |    3 +-
 drivers/gpu/drm/bridge/sil-sii8620.c    |   10 +-
 drivers/input/keyboard/Kconfig          |   15 +
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/applespi.c       | 1985 +++++++++++++++++++++++
 drivers/input/keyboard/applespi.h       |   29 +
 drivers/input/keyboard/applespi_trace.h |   94 ++
 7 files changed, 2132 insertions(+), 5 deletions(-)
 create mode 100644 drivers/input/keyboard/applespi.c
 create mode 100644 drivers/input/keyboard/applespi.h
 create mode 100644 drivers/input/keyboard/applespi_trace.h

-- 
2.20.1

