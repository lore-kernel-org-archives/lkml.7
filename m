Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF7BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB68320859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="cpkXfM1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfDVDM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 23:12:58 -0400
Received: from chill.innovation.ch ([216.218.245.220]:47494 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfDVDM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 23:12:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 063DE640143;
        Sun, 21 Apr 2019 20:12:57 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id XzU6_h9T9Oky; Sun, 21 Apr 2019 20:12:55 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch EED2E6400F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1555902775;
        bh=13r71eV9Fi2rHcGMF2vHI/dTbBjcMBYsg02e6YazHxM=;
        h=From:To:Cc:Subject:Date:From;
        b=cpkXfM1OXhhNPxX2elcs1kfClUuBDytOGQZ1OQyz8/5NJ1yl9nXb4XfLaR+s1BTaZ
         Kl8E3/j0weM0YOGu+eIeQMr7S0M/HLSpafSA4yAsslTSt2TwvsThCWlQk0GN3anEYU
         ZFCwKUO3O2v+8KlDHOySxZvtR1O8QW7TuvbJjPAAdlXN8rOPBX6kjOj77abL/srqzG
         tsph5+01QkisZbwhfD2rmY0CbrIsB26+kaSwiNyua0FigLiRRG6g1NqlkscvnxW0b2
         0JeNHlpJW6SedBr1F83/0L9XhHA4JlbB4pbaOgPB1PNzZkZAWwJzKHbUxNIB+ZdFXU
         tHYIeIvAtiPUQ==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Apple iBridge support
Date:   Sun, 21 Apr 2019 20:12:48 -0700
Message-Id: <20190422031251.11968-1-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2016 and 2017 MacBook Pro's have a T1 chip that drives the Touch Bar,
ambient light sensor, webcam, and fingerprint sensor; this shows up
as an iBridge USB device in the system. These patches provide initial
support for the Touch Bar and ALS - the webcam is already handled by
existing drivers, and no information is currently known on how to access
the fingerprint sensor (other than it's apparently via one of the extra
interfaces available in the OS X USB configuration).

One thing of note here is that both the ALS and (some of) the Touch Bar
functionality are exposed via the same USB interface (and hence same
hid_device), so both drivers need to share this device. This
necessitated creating a demux hid driver in the mfd driver to which
multiple hid devices can be attached, and implied not being able to make
use of the existing hid-sensor-als driver.

Ronald Tschalär (3):
  mfd: apple-ibridge: Add Apple iBridge MFD driver.
  HID: apple-ib-tb: Add driver for the Touch Bar on MacBook Pro's.
  iio: light: apple-ib-als: Add driver for ALS on iBridge chip.

 drivers/hid/Kconfig               |   10 +
 drivers/hid/Makefile              |    1 +
 drivers/hid/apple-ib-tb.c         | 1288 +++++++++++++++++++++++++++++
 drivers/iio/light/Kconfig         |   12 +
 drivers/iio/light/Makefile        |    1 +
 drivers/iio/light/apple-ib-als.c  |  694 ++++++++++++++++
 drivers/mfd/Kconfig               |   15 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/apple-ibridge.c       |  883 ++++++++++++++++++++
 include/linux/mfd/apple-ibridge.h |   39 +
 10 files changed, 2944 insertions(+)
 create mode 100644 drivers/hid/apple-ib-tb.c
 create mode 100644 drivers/iio/light/apple-ib-als.c
 create mode 100644 drivers/mfd/apple-ibridge.c
 create mode 100644 include/linux/mfd/apple-ibridge.h

-- 
2.20.1

