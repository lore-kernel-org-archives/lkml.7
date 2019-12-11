Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C31CC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ED8205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hEC1fcDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfLKSCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:02:49 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:56730 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbfLKSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:02:48 -0500
Received: by mail-wm1-f73.google.com with SMTP id g26so1968297wmk.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sLn1RzN3MzIkubbF75sxXqKNycW/RmLmMWiDiI+hnxM=;
        b=hEC1fcDXnyqL/XYiJQhw7lfkKjoeTRhLDHBMALHzORBEe9uuMNK101CeKVYTICmCAE
         SI6+OPlpiRxJbnQdJca0rjbrnjy1owjs7R1UEOyOK9n+0tCTqPdMiEdRHBZ7OqCX1HR1
         mp/kOlGpVQjsOzlOH0cxRGCZQoRorsFMVbYCWSfbx1DYzLlsOFItWt3zM9gJx7TvY4ao
         0qUP4uWLPskya/UmJiKdXJ3udCEBr/s5A95ipsKEYvotSoCrrauD+043eWPiQcArBPgr
         gGQkTXX0Y7GOYmpKqGwh8PyQdWlwHiD2rr31jxT4AMl+AaKOJQTNZ9dVMM90jwahJo7m
         uB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sLn1RzN3MzIkubbF75sxXqKNycW/RmLmMWiDiI+hnxM=;
        b=Bp5Fe4ZsQvKxQLnmbyr4ZbWxdiCVIOKss6kZwAT9rqsQ/sSaGvVicWtBow9DsYNGOO
         aOCk5eqDGuIMOW+qHmZ9oEoP9/zUfRqgzXQ83xpD8gnH1+ey+tmyqvSNMiXqH1x0UttI
         XzDHJP1K2Ry31BLLsp8Cn20ATkBUid4ESFtDl4USkOWfQGOxPCp/sn9wlxuaKuTEnEHa
         y5HCvvFcAAXLFeCmCDC2xKsGlM1CiPvriQ3NDkBj3gMnplgTl/N7y+I5l2oSgTp/B1cR
         /nW+dTceoaRnREhjGMA12ZDW5ZqFUGkaaevQv1AZlkg0JXIfZ0cbPHoB8qBV5NwZVYXt
         HYeA==
X-Gm-Message-State: APjAAAVOvhfOpY3fe7MWCXhLIA5LMYk+6KdKUpHkjbg8aauWFHoaPTiq
        cBFQejDwRx9U8X9B9j9NwYHV2/iOv5Aa8nO0
X-Google-Smtp-Source: APXvYqyGi5BwTZYH3Ri2cMx7/FAUbaOuYm2sD00S1W75J+bpaZrv7tI2ix0vjhwMYEaKG7C7h5RQwjmqQ/bsUmT8
X-Received: by 2002:a5d:480f:: with SMTP id l15mr1124364wrq.305.1576087365834;
 Wed, 11 Dec 2019 10:02:45 -0800 (PST)
Date:   Wed, 11 Dec 2019 19:02:40 +0100
Message-Id: <cover.1576087039.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 0/1] usb: gadget: add raw-gadget interface
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset (currently a single patch) adds a new userspace interface
for the USB Gadget subsystem called USB Raw Gadget (I don't mind changing
the name to something else if there are better ideas). This is what
currently being used to enable coverage-buided USB fuzzing with syzkaller:

https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md

Initially I was using GadgetFS (together with the Dummy HCD/UDC module)
to perform emulation of USB devices for fuzzing, but later switched to a
custom written interface. The incentive to implement a different interface
was to provide a somewhat raw and direct access to the USB Gadget layer
for the userspace, where every USB request is passed to the userspace to
get a response. See documentation for the list of differences between
Raw Gadget and GadgetFS.

This patchset has been pushed to the public Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2144

Changes v2 -> v3:
- Updated device path in documentation.
- Changed usb_raw_init struct layout to make it the same for 32 bit compat
  mode.
- Added compat_ioctl to raw_fops.
- Changed raw_ioctl_init() to return EINVAL for invalid USB speeds, except
  for USB_SPEED_UNKNOWN, which defaults to USB_SPEED_HIGH.
- Reject endpoints with maxpacket = 0 in raw_ioctl_ep_enable().

Changes v1 -> v2:
- Moved raw.c to legacy/.
- Changed uapi header to use __u* types.
- Switched from debugfs entry to a misc device.
- Changed raw_dev from refcount to kref.
- Moved UDC_NAME_LENGTH_MAX to uapi headers.
- Used usb_endpoint_type() and usb_endpoint_dir_in/out() functions instead
  of open coding them.
- Added "WITH Linux-syscall-note" to SPDX id in the uapi header.
- Removed pr_err() if case dev_new() fails.
- Reduced the number of debugging messages.

Andrey Konovalov (1):
  usb: gadget: add raw-gadget interface

 Documentation/usb/index.rst         |    1 +
 Documentation/usb/raw-gadget.rst    |   59 ++
 drivers/usb/gadget/legacy/Kconfig   |    8 +
 drivers/usb/gadget/legacy/Makefile  |    1 +
 drivers/usb/gadget/legacy/raw.c     | 1070 +++++++++++++++++++++++++++
 include/uapi/linux/usb/raw_gadget.h |  167 +++++
 6 files changed, 1306 insertions(+)
 create mode 100644 Documentation/usb/raw-gadget.rst
 create mode 100644 drivers/usb/gadget/legacy/raw.c
 create mode 100644 include/uapi/linux/usb/raw_gadget.h

-- 
2.24.1.735.g03f4e72817-goog

