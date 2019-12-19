Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E128BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FFC24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GFyPrTOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLSRPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:15:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55618 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfLSRPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:15:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so6241542wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJ1Hc86CtFp5JvVjtPPv0Qcnhc2K0tENotEeuRTee3Y=;
        b=GFyPrTOcTMQoc+XjyuHIliQMC2pONC8rXCjLuJQmx5Z6xvg2pvI1EU8yVDzBfOlUSY
         4lyDvkiQTQnb/XbSm/0eDzGLFSze8x22et4J83laORhVT+JZHsAMF91fZRGvjq4tX74d
         0MZKbSziKCHqU1VDhI2tJgSVgFkJsuMrw+mUJGrjUW2EsjOOJADqUQ1JDWu6i1tR4nSW
         sWosQVUfSUm43uYc7CEHCTULkh5nZzk7uGLjw0eSvgDIjt2H7uDJH5DQAnAhk5cmcKJk
         Lbez6L9cWkguyox22iZWrlwKu7PzLy2nEeD2UK/5yZnYKmIRyWjBq24WJpQTNmP0dbFP
         1L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJ1Hc86CtFp5JvVjtPPv0Qcnhc2K0tENotEeuRTee3Y=;
        b=hG2v6QtGQN7E8FPJA93zzTLGe2Uxolyfav/AFCML8xp614bqO6Nsn2bML2Kjlf3klr
         jDTFZOm2wvDgpGso54MYz3oY2U9K+dIWdzGkPzemPWQG+qC+IbZ/r3DbH8xQnQmsnNFJ
         kJyoqIAiL/+nAPbvQFpEsyF/NPE3x86Dyq4ALCSIlf8A3aRCxWT2iGPM0I7FgYnypmoy
         DTvg7Q/5xqcrIudUfBRMGwA/3gBryw8G25qfP+NkJRTbv8vwqDBYCPlvtORjWX8ILJFZ
         Ie3lLYBs1mxAYck9t87e38qvtRMBec4xyF3sBzhz9XyZF6shMnSPav98zsiLKLGNSU89
         4KYA==
X-Gm-Message-State: APjAAAU1bUK2lfaVR2solBnO9hDS3fP+yHMvu5NqX0fPTLiQnq0bQmRf
        V4/D0xEhL9UKVjghUPKlbTdHvw==
X-Google-Smtp-Source: APXvYqwe/45hbe0F2G/DmPVoXCA3a+5VENdwJEwaaoGCb2fBYpOqVdDbSS76Jx1REhKdm6hLDRfuZg==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr10798319wmi.51.1576775734993;
        Thu, 19 Dec 2019 09:15:34 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id q6sm7401428wrx.72.2019.12.19.09.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:15:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 00/13] gpiolib: add an ioctl() for monitoring line status changes
Date:   Thu, 19 Dec 2019 18:15:15 +0100
Message-Id: <20191219171528.6348-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When discussing the recent user-space changes with Kent and while working
on dbus API for libgpiod I noticed that we really don't have any way of
keeping the line info synchronized between the kernel and user-space
processes. We can of course periodically re-read the line information or
even do it every time we want to read a property but this isn't optimal.

This series adds a new ioctl() that allows user-space to set up a watch on
the GPIO chardev file-descriptor which can then be polled for events
emitted by the kernel when the line is requested, released or its status
changed. This of course doesn't require the line to be requested. Multiple
user-space processes can watch the same lines.

This series also includes a variety of minor tweaks & fixes for problems
discovered during development. For instance it addresses a race-condition
in current line event fifo.

v1: https://lkml.org/lkml/2019/11/27/327

v1 -> v2:
- rework the main patch of the series: re-use the existing file-descriptor
  associated with an open character device
- add a patch adding a debug message when the line event kfifo is full and
  we're discarding another event
- rework the locking mechanism for lineevent kfifo: reuse the spinlock
  from the waitqueue structure
- other minor changes

v2 -> v3:
- added patches providing new implementation for some kfifo macros
- fixed a regression in the patch reworking the line event fifo: reading
  multiple events is now still possible
- reworked the structure for new ioctl: it's now padded such that there
  be no alignment issues if running a 64-bit kernel on 32-bit userspace
- fixed a bug where one process could disable the status watch of another
- use kstrtoul() instead of atoi() in gpio-watch for string validation

Bartosz Golaszewski (13):
  gpiolib: use 'unsigned int' instead of 'unsigned' in gpio_set_config()
  gpiolib: have a single place of calling set_config()
  gpiolib: convert the type of hwnum to unsigned int in
    gpiochip_get_desc()
  gpiolib: use gpiochip_get_desc() in linehandle_create()
  gpiolib: use gpiochip_get_desc() in lineevent_create()
  gpiolib: use gpiochip_get_desc() in gpio_ioctl()
  kfifo: provide noirqsave variants of spinlocked in and out helpers
  kfifo: provide kfifo_is_empty_spinlocked()
  gpiolib: rework the locking mechanism for lineevent kfifo
  gpiolib: emit a debug message when adding events to a full kfifo
  gpiolib: provide a dedicated function for setting lineinfo
  gpiolib: add new ioctl() for monitoring changes in line info
  tools: gpio: implement gpio-watch

 drivers/gpio/gpiolib.c      | 402 +++++++++++++++++++++++++++---------
 drivers/gpio/gpiolib.h      |   4 +-
 include/linux/gpio/driver.h |   3 +-
 include/linux/kfifo.h       |  73 +++++++
 include/uapi/linux/gpio.h   |  24 +++
 tools/gpio/.gitignore       |   1 +
 tools/gpio/Build            |   1 +
 tools/gpio/Makefile         |  11 +-
 tools/gpio/gpio-watch       | Bin 0 -> 26528 bytes
 tools/gpio/gpio-watch.c     |  99 +++++++++
 10 files changed, 514 insertions(+), 104 deletions(-)
 create mode 100755 tools/gpio/gpio-watch
 create mode 100644 tools/gpio/gpio-watch.c

-- 
2.23.0

